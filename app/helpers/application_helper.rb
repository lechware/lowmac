module ApplicationHelper

  def heading
    if current_page?(action: :new)
      'New'
    elsif controller_name.eql?('profiles')
      controller_name.singularize.camelize
    else
      instance_variable_get("@#{controller_name.singularize}") || controller_name.camelize
    end
  end

  def subheading
    return current_user.name if controller_name.eql?('profiles')
    controller_name.singularize.camelize unless current_page?(action: :index)
  end

  def breadcrumbs
    return [] if controller_name.eql?('profiles')
    case
    when current_page?(action: :index)
      { controller_name.camelize => {path: nil, active: true} }
    when current_page?(action: :new)
      {
        controller_name.camelize => {path: url_for(controller: controller_name, action: :index), active: false},
        'New' => {path: nil, active: true}
      }
    else # show & edit
      {
        controller_name.camelize => {path: url_for(controller: controller_name, action: :index), active: false},
        instance_variable_get("@#{controller_name.singularize}") => {path: nil, active: true}
      }
    end
  end

  def active?(options = {})
    logger.debug "Setting active class for div with paths - #{options}"

    options.each do |o|
      case
      when current_page?(o)
        return :active
      end
    end

  end

  def sidebar_class(action, model, options = {})
    case action
    when :edit, :new
      current_page?(eval("#{action}_users_#{model}_path")) ? :active : nil rescue nil # for edit
    when :index
      current_page?(eval("users_#{model.to_s.pluralize}_path")) ? :active : nil
    when :show
      if options.nil?
        current_page?(eval("users_#{model}_path")) ? :active : nil rescue nil
      else
        current_page?(eval("users_#{model}_path(options)")) ? :active : nil rescue nil
      end
    else
      nil
    end
  end

end
