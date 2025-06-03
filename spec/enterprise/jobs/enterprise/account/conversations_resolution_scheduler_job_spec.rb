require 'rails_helper'

RSpec.describe Account::ConversationsResolutionSchedulerJob, type: :job do
  let(:account) { create(:account) }
  let(:assistant) { create(:aiAgent_assistant, account: account) }

  describe '#perform - aiAgent resolutions' do
    context 'when handling different inbox types' do
      let!(:regular_inbox) { create(:inbox, account: account) }
      let!(:email_inbox) { create(:inbox, :with_email, account: account) }

      before do
        create(:aiAgent_inbox, aiAgent_assistant: assistant, inbox: regular_inbox)
        create(:aiAgent_inbox, aiAgent_assistant: assistant, inbox: email_inbox)
      end

      it 'enqueues resolution jobs only for non-email inboxes with aiAgent enabled' do
        expect do
          described_class.perform_now
        end.to have_enqueued_job(AIAgent::InboxPendingConversationsResolutionJob)
          .with(regular_inbox)
          .exactly(:once)
      end

      it 'does not enqueue resolution jobs for email inboxes even with aiAgent enabled' do
        expect do
          described_class.perform_now
        end.not_to have_enqueued_job(AIAgent::InboxPendingConversationsResolutionJob)
          .with(email_inbox)
      end
    end

    context 'when inbox has no aiAgent enabled' do
      let!(:inbox_without_aiAgent) { create(:inbox, account: create(:account)) }

      it 'does not enqueue resolution jobs' do
        expect do
          described_class.perform_now
        end.not_to have_enqueued_job(AIAgent::InboxPendingConversationsResolutionJob)
          .with(inbox_without_aiAgent)
      end
    end
  end
end
