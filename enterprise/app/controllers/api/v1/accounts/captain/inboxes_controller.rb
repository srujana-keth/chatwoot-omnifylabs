class Api::V1::Accounts::AIAgent::InboxesController < Api::V1::Accounts::BaseController
  before_action :current_account
  before_action -> { check_authorization(AIAgent::Topic) }

  before_action :set_topic
  def index
    @inboxes = @topic.inboxes
  end

  def create
    inbox = Current.account.inboxes.find(topic_params[:inbox_id])
    @aiAgent_inbox = @topic.aiAgent_inboxes.build(inbox: inbox)
    @aiAgent_inbox.save!
  end

  def destroy
    @aiAgent_inbox = @topic.aiAgent_inboxes.find_by!(inbox_id: permitted_params[:inbox_id])
    @aiAgent_inbox.destroy!
    head :no_content
  end

  private

  def set_topic
    @topic = account_topics.find(permitted_params[:topic_id])
  end

  def account_topics
    @account_topics ||= Current.account.aiAgent_topics
  end

  def permitted_params
    params.permit(:topic_id, :id, :account_id, :inbox_id)
  end

  def topic_params
    params.require(:inbox).permit(:inbox_id)
  end
end
