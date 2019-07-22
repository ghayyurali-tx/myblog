class WelcomeController < ApplicationController
  #layout "for_login"
  def index
    if current_user
    render layout: 'articles_index'
    else render layout: 'for_login'
      end
  end
end
