<script setup>
import { computed, onBeforeMount, onMounted, ref, nextTick } from 'vue';
import {
  useMapGetter,
  useStore,
  useStoreGetters,
} from 'dashboard/composables/store';
import { useRoute } from 'vue-router';
import { FEATURE_FLAGS } from 'dashboard/featureFlags';

import BackButton from 'dashboard/components/widgets/BackButton.vue';
import DeleteDialog from 'dashboard/components-next/aiAgent/pageComponents/DeleteDialog.vue';
import PageLayout from 'dashboard/components-next/aiAgent/PageLayout.vue';
import ConnectInboxDialog from 'dashboard/components-next/aiAgent/pageComponents/inbox/ConnectInboxDialog.vue';
import InboxCard from 'dashboard/components-next/aiAgent/assistant/InboxCard.vue';
import InboxPageEmptyState from 'dashboard/components-next/aiAgent/pageComponents/emptyStates/InboxPageEmptyState.vue';

const store = useStore();
const dialogType = ref('');
const route = useRoute();
const assistantUiFlags = useMapGetter('aiAgentAssistants/getUIFlags');
const uiFlags = useMapGetter('aiAgentInboxes/getUIFlags');
const isFetchingAssistant = computed(() => assistantUiFlags.value.fetchingItem);
const isFetching = computed(() => uiFlags.value.fetchingList);

const aiAgentInboxes = useMapGetter('aiAgentInboxes/getRecords');

const selectedInbox = ref(null);
const disconnectInboxDialog = ref(null);

const handleDelete = () => {
  disconnectInboxDialog.value.dialogRef.open();
};

const connectInboxDialog = ref(null);

const handleCreate = () => {
  dialogType.value = 'create';
  nextTick(() => connectInboxDialog.value.dialogRef.open());
};
const handleAction = ({ action, id }) => {
  selectedInbox.value = aiAgentInboxes.value.find(inbox => id === inbox.id);
  nextTick(() => {
    if (action === 'delete') {
      handleDelete();
    }
  });
};

const handleCreateClose = () => {
  dialogType.value = '';
  selectedInbox.value = null;
};

const getters = useStoreGetters();
const assistantId = Number(route.params.assistantId);
const assistant = computed(() =>
  getters['aiAgentAssistants/getRecord'].value(assistantId)
);
onBeforeMount(() => store.dispatch('aiAgentAssistants/show', assistantId));

onMounted(() =>
  store.dispatch('aiAgentInboxes/get', {
    assistantId: assistantId,
  })
);
</script>

<template>
  <PageLayout
    :button-label="$t('AI_AGENT.INBOXES.ADD_NEW')"
    :button-policy="['administrator']"
    :is-fetching="isFetchingAssistant || isFetching"
    :is-empty="!aiAgentInboxes.length"
    :show-pagination-footer="false"
    :feature-flag="FEATURE_FLAGS.AI_AGENT"
    @click="handleCreate"
  >
    <template v-if="!isFetchingAssistant" #headerTitle>
      <div class="flex flex-row items-center gap-4">
        <BackButton compact />
        <span
          class="flex items-center gap-1 text-lg font-medium text-n-slate-12"
        >
          {{ assistant.name }}
          <span class="i-lucide-chevron-right text-xl text-n-slate-10" />
          {{ $t('AI_AGENT.INBOXES.HEADER') }}
        </span>
      </div>
    </template>

    <template #emptyState>
      <InboxPageEmptyState @click="handleCreate" />
    </template>

    <template #body>
      <div class="flex flex-col gap-4">
        <InboxCard
          v-for="aiAgentInbox in aiAgentInboxes"
          :id="aiAgentInbox.id"
          :key="aiAgentInbox.id"
          :inbox="aiAgentInbox"
          @action="handleAction"
        />
      </div>
    </template>

    <DeleteDialog
      v-if="selectedInbox"
      ref="disconnectInboxDialog"
      :entity="selectedInbox"
      :delete-payload="{
        assistantId: assistantId,
        inboxId: selectedInbox.id,
      }"
      type="Inboxes"
    />

    <ConnectInboxDialog
      v-if="dialogType"
      ref="connectInboxDialog"
      :assistant-id="assistantId"
      :type="dialogType"
      @close="handleCreateClose"
    />
  </PageLayout>
</template>
