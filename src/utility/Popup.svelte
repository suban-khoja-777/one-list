<script>

    import Button from "../utility/Button.svelte";
    import { fireEvent,EVENTS } from "../EventManager";
    
    export let header;
    export let closeLabel = "Close";
    export let showClose = true;
    export let OnClose = fireClosePopupEvent;

    const fireClosePopupEvent = () => {
        fireEvent(EVENTS.CLOSE_POPUP,{});
    }

</script>

<div class="modal-container fixed bg-transparent">
    <div class="modal bg-secondary absolute border-primary">
        <div class="modal-content relative">
            <div class="modal-header flex justify-space-between text-primary">
                {#if header}
                    <span class="task-name text-bold text-primary">{header}</span>
                {/if}
            </div>    
            <slot />
            {#if showClose}
                <div class="modal-footer flex justify-center absolute">
                    <Button onClick={OnClose} label={closeLabel} type="link"/>
                </div>
            {/if}
        </div>
    </div>
</div>

<style>

    .modal-container{
        inset: 0px;
    }

    .modal{
        inset: 10% auto 10% 50%;
        overflow: hidden auto;
        transform: translate(-50%, 0px);
        transition: all 0.3s ease 0s;
        will-change: width;
        box-shadow: rgb(0 0 0 / 70%) 0 25px 50px -15px !important;
        height: auto;
        outline: none;
        width : 50vw;
        max-height: 75vh;
        padding: 20px;
    }

    .modal-header{
        margin-bottom: 16px;
    }

    .modal-header > .task-name {
        font-size: 1.25rem;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .modal-footer{
        top: 0;
        right: 0;
    }

</style>