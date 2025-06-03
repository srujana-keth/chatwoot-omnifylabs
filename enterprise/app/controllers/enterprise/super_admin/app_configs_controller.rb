module Enterprise::SuperAdmin::AppConfigsController
  private

  def allowed_configs
    return super if ChatwootHub.pricing_plan == 'community'

    case @config
    when 'custom_branding'
      @allowed_configs = custom_branding_options
    when 'internal'
      @allowed_configs = internal_config_options
    when 'aiAgent'
      @allowed_configs = %w[AI_AGENT_OPEN_AI_API_KEY AI_AGENT_OPEN_AI_MODEL AI_AGENT_FIRECRAWL_API_KEY]
    else
      super
    end
  end

  def custom_branding_options
    %w[
      LOGO_THUMBNAIL
      LOGO
      LOGO_DARK
      BRAND_NAME
      INSTALLATION_NAME
      BRAND_URL
      WIDGET_BRAND_URL
      TERMS_URL
      PRIVACY_URL
      DISPLAY_MANIFEST
    ]
  end

  def internal_config_options
    %w[CHATWOOT_INBOX_TOKEN CHATWOOT_INBOX_HMAC_KEY ANALYTICS_TOKEN CLEARBIT_API_KEY DASHBOARD_SCRIPTS INACTIVE_WHATSAPP_NUMBERS BLOCKED_EMAIL_DOMAINS
       AI_AGENT_CLOUD_PLAN_LIMITS ACCOUNT_SECURITY_NOTIFICATION_WEBHOOK_URL]
  end
end
