<script>

    import Button from "../utility/Button.svelte";
    import { fireEvent,EVENTS } from "../EventManager";
    
    export let name;
    export let header;
    export let closeLabel = "X";
    export let showClose = true;
    

    const fireClosePopupEvent = () => {
        fireEvent(EVENTS.CLOSE_POPUP,name);
    }
    
    export let OnClose = fireClosePopupEvent;

</script>
<div class="modal-backdrop fixed"></div>
<div class="modal-container fixed flex justify-center align-center bg-transparent">
    <div class="modal border-primary">
        <header class="modal-header flex justify-space-between">
            {#if header}
                <span class="task-name text-bold text-primary">{header}</span>
            {/if}
            {#if showClose}
                <div class="modal-footer flex justify-center absolute">
                    <Button onClick={OnClose} label={closeLabel} type="primary"/>
                </div>
            {/if}
        </header>
        <div class="modal-body">
            <slot/>
        </div>
    </div>
</div>

<style>

    .modal-backdrop{
        height: 100vh;
        width: 100vw;
        left: 0;
        top: 0;
        background: #242a38;
        opacity: .75;
        z-index: 3;
    }

    .modal-container{
        height: 100vh;
        width: 100vw;
        left: 0;
        top: 0;
        z-index: 5;
        
    }

    .modal{
        width: 40vw;
        height: auto;
        background-color: var(--secondary-color);
        z-index: 9;
        position: relative;
    }

    .modal-header{
        background-color: var(--quaternary-color);
        padding: 1rem;
        color: var(--text-secondary-color);
    }

    .modal-header > .task-name {
        font-size: 1.07rem;
        margin: 0;
    }

    .modal-body{
        padding: 1rem;
    }

    .modal-footer{
        top: 0;
        right: 0;
    }

</style>
