import { writable } from "svelte/store";

export const modalStore = writable({
    showModal: false,
    component: null
});