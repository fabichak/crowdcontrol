class FailureApp < Devise::FailureApp
  def respond
    #p request.format.to_s
    if request.format == :json
      json_failure
    else
      super
    end
  end

  def json_failure
    self.status = 401
    self.content_type = 'application/json'
    self.headers['Access-Control-Allow-Origin'] = '*'
    self.headers['Access-Control-Request-Method'] = '*' 
    self.response_body = '{"error" : "auth error"}'
  end
end