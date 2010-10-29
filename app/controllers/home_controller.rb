require 'indextank_client'

class HomeController < ApplicationController

  def home
      index = IndexTank::HerokuClient.new.get_index "YOUR INDEX NAME"
      @query = params[:query]
      print @query
      if @query and @query != ''
          @res = index.search(@query, :snippet=>'text', :fetch=>'thumbnail_url,screen_name,plixi_id,timestamp')
      else
          @res = {'results' => []}
      end
  end


end
