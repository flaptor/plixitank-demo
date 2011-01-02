require 'indextank_client'


class HomeController < ApplicationController

  def home
#index = IndexTank::ApiClient.new(api_url).indexes index_name
      api_url = 'http://:kwZhE6Rdw1bquV@8k1if.api.indextank.com'
      index_name = 'herokutest'
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
