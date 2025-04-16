class ApplicationController < ActionController::API # Ou ActionController::Base
    include ActionController::MimeResponds
    respond_to :json
    
    before_action :cors_preflight_check
    after_action :cors_set_access_control_headers
  
    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = 'https://to-do-frontend-iztg.onrender.com'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept'
      headers['Access-Control-Max-Age'] = '1728000'
    end
  
    def cors_preflight_check
      if request.method == 'OPTIONS'
        headers['Access-Control-Allow-Origin'] = 'https://to-do-frontend-iztg.onrender.com'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Content-Type'
        render plain: '', content_type: 'text/plain'
      end
    end
  end