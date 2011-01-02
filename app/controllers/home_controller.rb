require 'indextank'

class HomeController < ApplicationController

  def home
      api = IndexTank::Client.new your_api_url
      index = api.indexes your_index_name
      @query = params[:query]
      print @query
      if @query and @query != ''
          @res = index.search(@query, :snippet=>'text', :fetch=>'thumbnail_url,screen_name,plixi_id,timestamp')
      else
          @res = {'results' => []}
      end
  end


end
