class Api::V1::Accounts::AiAgent::CopilotThreadsController < Api::V1::Accounts::BaseController
  before_action :current_account
  before_action -> { check_authorization(AiAgent::Topic) }

  def index
    @copilot_threads = Current.account.copilot_threads
                              .where(user_id: Current.user.id)
                              .includes(:user)
                              .order(created_at: :desc)
                              .page(permitted_params[:page] || 1)
                              .per(5)
  end

  private

  def permitted_params
    params.permit(:page)
  end
end
