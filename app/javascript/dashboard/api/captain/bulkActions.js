import ApiClient from '../ApiClient';

class AIAgentBulkActionsAPI extends ApiClient {
  constructor() {
    super('aiAgent/bulk_actions', { accountScoped: true });
  }
}

export default new AIAgentBulkActionsAPI();
