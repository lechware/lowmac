class Users::BaseController < ApplicationController

  # helper_method :current_account

  # Skip the before filter so we can insert it in the correctly place to preserve order.
  # skip_around_filter :audit_trail

  # FIXME: Enable Authentication for admin
  before_action :authenticate_user!
  before_filter :initialise_current_user
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referrer, alert: ::I18n.t('cancan.access.denied')
  end
  
  # around_filter :audit_trail

  # before_filter :setup_account!, :except => [:edit,:update,:create,:new]

  layout 'users'

  #
  # Public Class Methods
  #
  public

  #
  # Public Instance Methods
  #
  public

  #
  # Protected Instance Methods
  #
  protected
  
  #
  # Private Instance Methods
  #
  private

  def initialise_current_user
    return unless user_signed_in?
    User.current = current_user
  end

  # def current_account
  #   User.current.account
  # end

  # Check resource params are present based on the current controller name.
  def check_resource_params(options = {})

    # Determine the name based on the current controller if not specified.
    resource_name = options[:name] || controller_name.singularize

    # Determine the class based on the resource name if not provided.
    resource_class = options[:class] || resource_name.classify.constantize

    unless params.key?(resource_name)
      notify :error, ::I18n.t('messages.resource.missing_parameters',
        :type     => resource_class.model_name.human
      )

      case action_name.to_sym
      when :create
        redirect_to :action => :new
      when :update
        redirect_to :action => :edit, :id => params[:id]
      else
        redirect_to :action => :index
      end
    end
  end

  # Load the relevant resource based on the current controller name.
  def load_resource(options = {})

    # Determine the name based on the current controller if not specified.
    resource_name = options[:name] || controller_name.singularize
    logger.debug "Loading Resource for #{resource_name}"

    # Determine the class based on the resource name if not provided.
    resource_class = options[:class] || resource_name.classify.constantize
    logger.debug "Loading Resource for resource class - #{resource_class}"

    resource = resource_class.find(params[:id] || params[:format])
    logger.debug "Resource found for #{resource_name} - #{resource}"
    
    # # Confirm current user has permission to view resource.
    # unless resource.account == current_account
    #   # TODO: log an audit event.

    #   # SECURITY RISK: The user should not be able to distinguish between a
    #   # non-existant resource and another user's resource. This way you can't
    #   # probe to the system and determine another account's data.
    #   raise Mongoid::Errors::DocumentNotFound.new(resource_class, :id => params[:id])
    # end

    # Set an instance variable @resource_name to the resource.
    instance_variable_set("@#{resource_name}", resource)

    rescue Mongoid::Errors::DocumentNotFound => e
    notify :error, ::I18n.t('messages.resource.not_found',
      :type     => resource_class.model_name.human,
      :criteria => resource_class.human_attribute_name(:id),
      :value    => params[:id]
    )
    redirect_to :action => :index
  end

  # Load all relevant resources based on the current controller name.
  def load_resources(options = {})

    # Determine the name based on the current controller if not specified.
    resource_name = options[:name] || controller_name.pluralize

    # Set an instance variable @name to contain the names for this user.
    instance_variable_set("@#{resource_name}", resource_name.singularize.camelize.constantize.all)
  end

  # def setup_account!
  #   case 
  #   when current_user.account.nil?
  #     if current_user.sign_in_count == 1
  #       logger.debug "Account not present, first login so show edit account page."
  #       notify :success, "Almost done! Please complete #{Account.model_name.human.downcase} setup before proceeding."
  #       redirect_to new_users_settings_account_path # if current_user.account.nil?
  #     else
  #       logger.debug "Account not present, returning user so show edit account page."
  #       notify :warning, "Please complete #{Account.model_name.human.downcase} setup before proceeding."
  #       redirect_to (current_user.account.nil? ? new_users_settings_account_path : edit_users_settings_account_path) # if current_user.account.nil?
  #     end
  #   when Subscriber.by_account(current_user.account).count > current_user.account.allowance
  #     logger.debug "Allowance Breached. Current allowance = #{current_user.account.allowance} & Subscriber count = #{Subscriber.by_account(current_user.account).count}"
  #     notify :error, "You have more subscribers in your database than allowed under your plan. Please update subscription before proceeding."
  #     redirect_to edit_users_settings_account_path # if current_user.account.nil?
  #   end
  

  #   # if current_user.account.nil? or (Subscriber.by_account(current_user.account).count > current_user.account.allowance)
  #   #   if current_user.sign_in_count == 1
  #   #     notify :success, "Almost done! Please complete #{Account.model_name.human.downcase} setup before proceeding."
  #   #     redirect_to new_users_settings_account_path # if current_user.account.nil?
  #   #   elsif Subscriber.by_account(current_user.account).count > current_user.account.allowance
  #   #     notify :error, "You have more subscribers in your database than allowed under your plan. Please update subscription before proceeding."
  #   #     redirect_to edit_users_settings_account_path # if current_user.account.nil?
  #   #   else
  #   #     notify :warning, "Please complete #{Account.model_name.human.downcase} setup before proceeding."
  #   #     redirect_to edit_users_settings_account_path # if current_user.account.nil?
  #   #   end
      
  #   # end
  # end

  # FIXME: CSRF token authenticity should not be overridden for JSON anymore in Rails 4?
  # This is to avoid warning - Can't verify CSRF token authenticity.
  # def verified_request?
  #   if request.content_type == "application/json"
  #     true
  #   else
  #     super()
  #   end
  # end

end
