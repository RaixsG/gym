import { writable } from "svelte/store";

export const modalStore = writable({
    showModal: false,
    // userData: null
});