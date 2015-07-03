class Users::AccountsController < Users::BaseController

  before_action except: [:create, :index, :new] do
    load_resource(name: 'account')
  end

  # Must be called after load_recource filter.
  before_filter :only => [:create,:update] do
    check_resource_params(name: 'account')
  end

  def create
    @account = Account.new account_params
    @account.save!

    current_user.update_attribute(:account, @account)

    respond_to do |format|
      notify :notice, ::I18n.t('messages.resource.created',
        :type       => Account.model_name.human,
        :resource   => @account
      )
      format.html { redirect_to action: :index, controller: :areas }
    end
  rescue Mongoid::Errors::Validations => e
    respond_to do |format|
      notify_now :error, ::I18n.t('messages.resource.not_valid',
        :type     => Account.model_name.human,
        :errors   => @account.errors.full_messages.to_sentence
      )
      format.html { render action: :new, id: @account, :status => 422 }
    end
  end

  def new
    if current_user.account.nil?
      notify :notice, ::I18n.t('messages.resource.create_account',
        :type       => Account.model_name.human,
      )
    else
      redirect_to action: :show, id: current_user.account
    end
  end

  def update
    @account.update_attributes account_params
    @account.save!

    notify :notice, ::I18n.t('messages.resource.updated',
      :type       => Account.model_name.human,
      :resource   => @account
    )
    render action: :show, id: @account
  rescue Mongoid::Errors::Validations => e
    notify_now :error, ::I18n.t('messages.resource.not_valid',
      :type     => Account.model_name.human,
      :errors   => @account.errors.full_messages.to_sentence
    )
    render action: :edit, id: @account, :status => 422
  end

  private

  def account_params
    params.require(:account).permit(:name, :address, :company_number, :phone, :email) 
  end
end
