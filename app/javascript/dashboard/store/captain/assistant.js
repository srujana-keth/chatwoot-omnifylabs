import AIAgentAssistantAPI from 'dashboard/api/aiAgent/assistant';
import { createStore } from './storeFactory';

export default createStore({
  name: 'AIAgentAssistant',
  API: AIAgentAssistantAPI,
});
