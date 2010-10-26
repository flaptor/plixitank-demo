require 'lib/indextank_client'

class HomeController < ApplicationController

  def home
      index = IndexTank::ApiClient.new("http://:1ZyO79E4UQSlht@dctgg.api.indextank.com").get_index "plixidemo"
      @query = params[:query]
      print @query
      if @query != ''
          @res = index.search(@query, :snippet=>'text', :fetch=>'thumbnail_url,screen_name,plixi_id,timestamp')
      else
          @res = {'results' => []}
      end
  end


end
