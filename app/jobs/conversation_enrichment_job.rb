# app/jobs/conversation_enrichment_job.rb

class ConversationEnrichmentJob < ApplicationJob
  queue_as :default

  def perform(conversation_id)
    conversation = Conversation.find_by(id: conversation_id)
    return unless conversation

    # Skip enrichment if already enriched
    return if conversation.content_attributes.present? && conversation.content_attributes['sentiment'].present?

    message_content = conversation.additional_attributes&.dig('message')

    enrichment =
      if message_content.present?
        SentimentAnalyzerService.new(message_content).analyze
      else
        { sentiment: 'neutral', language: 'en' }
      end

    conversation.update(content_attributes: enrichment)
  end
end
