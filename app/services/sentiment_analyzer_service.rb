class SentimentAnalyzerService
  POSITIVE_KEYWORDS = ['thank you', 'great', 'awesome', 'good', 'love', 'amazing', 'perfect', 'resolved'].freeze
  NEGATIVE_KEYWORDS = ['issue', 'problem', 'bad', 'not working', 'hate', 'angry', 'broken', 'complaint'].freeze

  def initialize(text)
    @text = text.to_s.downcase
  end

  def analyze
    {
      sentiment: detect_sentiment,
      language: detect_language
    }
  end

  private

  def detect_sentiment
    return 'positive' if POSITIVE_KEYWORDS.any? { |word| @text.include?(word) }
    return 'negative' if NEGATIVE_KEYWORDS.any? { |word| @text.include?(word) }

    'neutral'
  end

  def detect_language
    'en'
  end
end
