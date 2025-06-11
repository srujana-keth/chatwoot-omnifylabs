class SentimentAnalyzerService
  def initialize(text)
    @text = text
  end

  def analyze
    sentiment = run_sentiment_analysis
    sentiment = adjust_for_negation(@text, sentiment)
    { sentiment: sentiment, language: detect_language }
  end

  private

  def run_sentiment_analysis
    analyzer = Sentimental.new
    analyzer.load_defaults
    analyzer.sentiment(@text).to_s
  end

  def detect_language
    'en'
  end

  # Simple negation handling patch
  def adjust_for_negation(text, sentiment)
    negation_words = %w[not don't never isn't wasn't no hardly scarcely barely doesn't didn't won't can't couldn't]

    if negation_words.any? { |word| text.downcase.include?(word) }
      return 'negative' if sentiment == 'positive'
      return 'neutral' if sentiment == 'neutral'
    end

    sentiment
  end
end
