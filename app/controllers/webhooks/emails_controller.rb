require 'mail'

class Webhooks::EmailsController < BaseController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    message = Mail.new(params[:message])
    Rails.logger.log Logger::INFO, message.subject #print the subject to the logs
    Rails.logger.log Logger::INFO, message.body.decoded #print the decoded body to the logs

    Delayed::Job.enqueue( WebHook::HandlerJob.new( params )) if (params.has_key?(:plain) or params.has_key?(:html))
  
    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
end