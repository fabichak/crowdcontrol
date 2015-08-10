class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!, :except => [:create, :destroy]
  respond_to :json
  skip_before_action :verify_authenticity_token
  
  def create
    
    email = params[:email]
    password = params[:password]
  
    
    resource = User.find_for_database_authentication(:email => email)
    return invalid_login_attempt unless resource

    if resource.valid_password?(password)
      sign_in(:user, resource)
      respond_to do |format|
          format.html {redirect_to admin_root_path}
          format.json { render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email} }
      end
      
      return
    end
    invalid_login_attempt
  end

  def destroy
    if(params[:user_email])
      resource = User.find_for_database_authentication(:email => params[:user_email])
    else  
      resource = current_user
      sign_out current_user
    end
    resource.authentication_token = nil
    resource.save
    respond_to do |format|
          format.html {redirect_to admin_root_path}
          format.json { render :json=> {:success=>true} }
      end
    
  end

  protected

  def invalid_login_attempt
    respond_to do |format|
      format.html {
        flash[:alert] = "Erro de autenticação"
        redirect_to new_user_session_path
      }
      format.json { render :json=> {:success=>false, :message=>"Erro de autenticação"}, :status=>401 }
    end
  end
end