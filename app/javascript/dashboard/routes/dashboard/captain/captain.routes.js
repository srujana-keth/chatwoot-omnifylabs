import { FEATURE_FLAGS } from 'dashboard/featureFlags';
import { INSTALLATION_TYPES } from 'dashboard/constants/installationTypes';
import { frontendURL } from '../../../helper/URLHelper';
import AssistantIndex from './assistants/Index.vue';
import AssistantEdit from './assistants/Edit.vue';
import AssistantInboxesIndex from './assistants/inboxes/Index.vue';
import DocumentsIndex from './documents/Index.vue';
import ResponsesIndex from './responses/Index.vue';

export const routes = [
  {
    path: frontendURL('accounts/:accountId/aiAgent/assistants'),
    component: AssistantIndex,
    name: 'aiAgent_assistants_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL('accounts/:accountId/aiAgent/assistants/:assistantId'),
    component: AssistantEdit,
    name: 'aiAgent_assistants_edit',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL(
      'accounts/:accountId/aiAgent/assistants/:assistantId/inboxes'
    ),
    component: AssistantInboxesIndex,
    name: 'aiAgent_assistants_inboxes_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL('accounts/:accountId/aiAgent/documents'),
    component: DocumentsIndex,
    name: 'aiAgent_documents_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL('accounts/:accountId/aiAgent/responses'),
    component: ResponsesIndex,
    name: 'aiAgent_responses_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
];
