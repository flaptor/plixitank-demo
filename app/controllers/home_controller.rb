require 'indextank_client'


class HomeController < ApplicationController

  def home
      index = IndexTank::ApiClient.new('your api url').get_index 'your index name'
      @query = params[:query]
      print @query
      if @query and @query != ''
          @res = index.search(@query, :snippet=>'text', :fetch=>'thumbnail_url,screen_name,plixi_id,timestamp')
      else
          @res = {'results' => []}
      end
  end


end
