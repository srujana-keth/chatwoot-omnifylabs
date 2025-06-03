import AIAgentTopicAPI from 'dashboard/api/aiAgent/topic';
import { createStore } from './storeFactory';

export default createStore({
  name: 'AIAgentTopic',
  API: AIAgentTopicAPI,
});
