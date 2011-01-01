require 'indextank_client'


class HomeController < ApplicationController

  def home
      api_url = 'Your api url'
      index_name = 'your index name'
      index = IndexTank::ApiClient.new(api_url).get_index index_name
      @query = params[:query]
      print @query
      if @query and @query != ''
          @res = index.search(@query, :snippet=>'text', :fetch=>'thumbnail_url,screen_name,plixi_id,timestamp')
      else
          @res = {'results' => []}
      end
  end


end
