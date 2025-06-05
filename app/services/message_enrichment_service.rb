class MessageEnrichmentService
  def initialize(message)
    @message = message
  end

  def perform
    enrichment = SentimentAnalyzerService.new(@message.content).analyze
    update_conversation_content_attributes(enrichment)
  end

  private

  def update_conversation_content_attributes(enrichment)
    return unless @message.conversation

    @message.conversation.update(content_attributes: enrichment)
  end
end
