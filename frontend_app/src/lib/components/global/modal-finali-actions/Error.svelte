<script>
    import { fade } from "svelte/transition";
    export const isOpen = false;
    export let titulo = null;

</script>

<div class="card" transition:fade={{duration:2000}}>
    <div class="header">
        <div class="image">
            <svg
                xmlns="http://www.w3.org/2000/svg"
                class="icon icon-tabler icon-tabler-exclamation-circle"
                width="44"
                height="44"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="#000000"
                fill="none"
                stroke-linecap="round"
                stroke-linejoin="round"
            >
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0" />
                <path d="M12 9v4" />
                <path d="M12 16v.01" />
            </svg>
        </div>
        <div class="content">
            <span class="title">Error</span>
            <p class="message">{titulo}</p>
        </div>
    </div>
</div>

<style>
    .card {
        overflow: hidden;
        position: relative;
        text-align: left;
        border-radius: 0.5rem;
        max-width: 290px;
        box-shadow:
            0 20px 25px -5px rgba(0, 0, 0, 0.1),
            0 10px 10px -5px rgba(0, 0, 0, 0.04);
        background-color: #fff;
    }

    .header {
        padding: 1.25rem 1rem 1rem 1rem;
    }

    .image {
        display: flex;
        margin-left: auto;
        margin-right: auto;
        background-color: #e2feee;
        flex-shrink: 0;
        justify-content: center;
        align-items: center;
        width: 3rem;
        height: 3rem;
        border-radius: 9999px;
        animation: animate 0.6s linear alternate-reverse infinite;
        transition: 0.6s ease;
    }

    .image svg {
        color: red;
        width: 2rem;
        height: 2rem;
    }

    .content {
        margin-top: 0.75rem;
        text-align: center;
    }

    .title {
        color: rgb(252, 87, 87)a(255, 0, 0, 0.795);
        font-size: 1rem;
        font-weight: 600;
        line-height: 1.5rem;
    }

    .message {
        margin-top: 0.5rem;
        color: #595b5f;
        font-size: 0.875rem;
        line-height: 1.25rem;
    }

    @keyframes animate {
        from {
            transform: scale(1);
        }

        to {
            transform: scale(1.09);
        }
    }
</style>
