class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_permitted_params

  #around_filter :audit_trail
  before_filter :initialise_locale

  helper_method :app_name

  #
  # Constants
  #

  FLASH_TYPES = [
    :debug,
    :error,
    :notice,
    :alert,
    :success,
    :warning,
  ]

  #
  # Public Class Methods
  #
  public

  #
  # Public Instance Methods
  #
  public

  def after_sign_in_path_for(resource)
    return request.env['omniauth.origin'] || stored_location_for(resource) || users_root_path
  end

  # Generate a notification message.
  def notify(type, message, options = {})
    options[:now] ||= false

    # Convert and cleanup.
    type = type.to_s.downcase.to_sym

    # Sanity check for type.
    unless FLASH_TYPES.include?(type)
      raise ArgumentError, "Invalid value for argument type: #{type}, expected one of: #{FLASH_TYPES.to_sentence}."
    end

    logger.info("FLASH (#{options.inspect}) #{type.to_s.upcase}: #{message}")

    if options[:now] == true
      flash.now[type] ||= []
      flash.now[type] << message
    else
      flash[type] ||= []
      flash[type] << message
    end

    logger.debug("DEBUG: FLASH #{flash.inspect}")

    return true
  end

  def notify_now(type, message, options = {})
    options[:now] = true
    notify(type, message, options)
  end

  #
  # Protected Instance Methods
  #
  protected

  #
  # Private Instance Methods
  #
  private

  def app_name
    Rails.application.class.to_s.split("::").first
  end

  def action_controller_helpers
    return ActionController::Base.helpers
  end

  def audit_trail
    # Create a shallow copy only so be careful.
    local_params = params.clone

    # Strip out redundant, useless or other unwanted parameters.
    local_params.reject!{ |k,v| %w(action authenticity_token eid controller).include?(k) }

    # Filter sensitive and/or useless parameters.
    %w(password password_confirmation).each do |k|
      local_params[k] = '***' if local_params.has_key?(k)
    end

    # Filter sensitive and/or useless parameters.
    %w(user).each do |j|
      if local_params.has_key?(j)
        local_params[j] = local_params[j].clone
        %w(password password_confirmation).each do |k|
          local_params[j][k] = '***' if local_params[j].has_key?(k)
        end
      end
    end

    # Create an audit trail for the request.
    # AUDIT_LOG.info("ACCESS") { "REQUEST::#{request.method}::#{params[:controller]}##{params[:action]}::#{request.remote_ip}::#{request.fullpath.split('?')[0]}::#{local_params.inspect}" }

    # Proceed as normal.
    yield

    # Create an audit trail for the response.
    # AUDIT_LOG.info("ACCESS") { "RESPONSE::#{request.method}::#{params[:controller]}##{params[:action]}::#{response.status}::#{response.content_type}::#{response.location || '-'}" }

  rescue => e
    # Log the exception and then re-raise so it can be handled as normal.
    # AUDIT_LOG.error("EXCEPTION") { "#{request.remote_ip}::#{request.method}::#{params[:controller]}##{params[:action]}::#{e.class.to_s}::#{e.message}::#{e.backtrace[0...5]}" }
    raise
  end

  def initialise_locale
    # if params[:locale] is nil then I18n.default_locale will be used.
    I18n.locale = params[:locale]
  end

  def respond(http_status, response, options = {})
    respond_to do |format|
      format.json { render json: response, status: http_status }
      format.xml  { render xml:  response, root: :response, status: http_status }
    end
  end

  def respond_with_success(options = {})
    http_status = options[:http_status] || :ok

    response = {}
    response[:status] = options[:status] || 'OK'
    response.merge!(options[:response]) if options.has_key?(:response)

    respond(http_status, response)
  end

  def respond_with_error(http_status, options = {})
    response = {}
    response[:status] = options[:status] || 'ERROR'
    response[:error] = {}
    response[:error][:code] = options[:code] || http_status.to_s.dasherize
    response[:error][:message] = options[:message]
    response.merge!(options[:response]) if options.has_key?(:response)

    respond(http_status, response)
  end

  protected

  def configure_devise_permitted_params
    unless params
      devise_parameter_sanitizer.for(:sign_up) << :name if params[:controller].include? 'devise'
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email) } if params[:controller].include? 'devise'
    end
  end
end
