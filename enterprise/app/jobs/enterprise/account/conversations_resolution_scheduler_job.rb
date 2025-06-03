module Enterprise::Account::ConversationsResolutionSchedulerJob
  def perform
    super

    resolve_aiAgent_conversations
  end

  private

  def resolve_aiAgent_conversations
    AIAgentInbox.all.find_each(batch_size: 100) do |aiAgent_inbox|
      inbox = aiAgent_inbox.inbox

      next if inbox.email?

      AIAgent::InboxPendingConversationsResolutionJob.perform_later(
        inbox
      )
    end
  end
end
