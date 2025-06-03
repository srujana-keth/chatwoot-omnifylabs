/* global axios */
import ApiClient from '../ApiClient';

class AIAgentDocument extends ApiClient {
  constructor() {
    super('aiAgent/documents', { accountScoped: true });
  }

  get({ page = 1, searchKey, topicId } = {}) {
    return axios.get(this.url, {
      params: {
        page,
        searchKey,
        topic_id: topicId,
      },
    });
  }
}

export default new AIAgentDocument();
