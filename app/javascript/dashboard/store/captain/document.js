import AIAgentDocumentAPI from 'dashboard/api/aiAgent/document';
import { createStore } from './storeFactory';

export default createStore({
  name: 'AIAgentDocument',
  API: AIAgentDocumentAPI,
});
