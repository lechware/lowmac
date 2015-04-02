module ApplicationHelper

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
