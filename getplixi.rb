require 'lib/indextank_client'
require 'json'
require 'net/http'

plixi_url='http://api.plixi.com/api/tpapi.svc/json/photos?getuser=true'

api = IndexTank::ApiClient.new 'http://:Az8QXRhHLzMRiJ@d24bu.api.indextank.com'
index = api.get_index 'herokutest'
if not index.exists?
    index.create_index
end
while not index.running?
    puts 'waiting for index...'
    sleep 3
end
        

#limit the index size
MAXDOCS = 25000

interval = 10
time_first = 0
seq = 0
lastHighest = 0

if ARGV.length > 0
    seq = Integer ARGV[0]
end

while true
    begin
        photos = JSON.parse(Net::HTTP.get_response(URI.parse(plixi_url)).body)
        count, list = photos['Count'], photos['List']

        time_last = Integer(list.last['UploadDate'])

        #adjust the interval for minimal or no overlap
        #we may lose some, but this is a demo.
        if time_last < time_first
            interval += 1
        end
        if time_last > time_first and interval > 0
            interval -= 1
        end
        
        time_first = Integer(list[0]['UploadDate'])
        highestSeen = Integer(list[0]['GdAlias'])
        list.each do |p|
            u = p['User']
            #only index photos that come with some text
            if p.has_key?('Message')
                id = p['GdAlias']
                #avoid duplicates from overlap
                if Integer(id) < lastHighest
                    print 'dropping duplicate:', id
                    continue 
                end
                text = p['Message']
                timestamp = Integer(p['UploadDate'])
                screen_name = u['ScreenName']
                thumbnail_url = p['ThumbnailUrl']
                index.add_document(seq.to_s, {:plixi_id => id, :text => text, :timestamp => timestamp, :screen_name => screen_name, :thumbnail_url => thumbnail_url})
                printf "%s,%s,%s\n", id, screen_name, text
                seq = (seq + 1) % MAXDOCS
                STDOUT.flush
            end
        end
    rescue Exception => e
        puts e
    end
    lastHighest = highestSeen
    sleep interval
end
