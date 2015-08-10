class BaseController < ApplicationController

  # around_filter :audit_trail

  layout 'application'

  #
  private

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

    # Determine the class based on the resource name if not provided.
    resource_class = options[:class] || resource_name.classify.constantize

    resource = resource_class.find(params[:id])

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

  rescue ActiveRecord::RecordNotFound => e
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
end
