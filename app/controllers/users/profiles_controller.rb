class Users::ProfilesController < Users::BaseController

  before_action except: [:create, :index, :new] do
    load_resource(name: 'user')
  end

  # Must be called after load_recource filter.
  before_filter :only => [:create,:update] do
    check_resource_params(name: 'user')
  end

  def edit
  end

  def show
  end

  def update
    @user.update_attributes(profile_params)
    @user.save!

    notify :notice, ::I18n.t('messages.resource.updated',
      :type       => User.model_name.human,
      :resource   => @user.name
    )
    render action: :show, format: @user
  rescue Mongoid::Errors::Validations => e
    notify_now :error, ::I18n.t('messages.resource.not_valid',
      :type     => User.model_name.human,
      :errors   => @user.errors.full_messages.to_sentence
    )
    render action: :edit, format: @user, :status => 422
  end

  private

  def profile_params
    params.require(:user).permit(:name, profile_attributes: [:phone, :avatar])
  end

end
