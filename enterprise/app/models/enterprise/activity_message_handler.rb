module Enterprise::ActivityMessageHandler
  def automation_status_change_activity_content
    if Current.executed_by.instance_of?(AIAgent::Topic)
      locale = Current.executed_by.account.locale
      if resolved?
        I18n.t(
          'conversations.activity.aiAgent.resolved',
          user_name: Current.executed_by.name,
          locale: locale
        )
      elsif open?
        I18n.t(
          'conversations.activity.aiAgent.open',
          user_name: Current.executed_by.name,
          locale: locale
        )
      end
    else
      super
    end
  end
end
