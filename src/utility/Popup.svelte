<script>
    import Button from "../utility/Button.svelte";
    
    import { fireEvent,EVENTS } from "../EventManager";
    
    export let header;
    export let closeLabel = "Close";
    export let showClose = true;
    
    export let data;

    const fireClosePopupEvent = () => {
        fireEvent(EVENTS.CLOSE_POPUP,{});
    }

    export let OnClose = fireClosePopupEvent;

</script>

<div class="modal-container fixed">
    <div class="modal">
        <div class="modal-content">
            <div class="modal-header">
                {#if header}
                    <span class="task-name">{header}</span>
                {/if}

                {#if data}
                    <span class="task-status {data.checked ? 'completed' : 'not-completed'}">{data.checked ? 'Completed' : 'Not Completed'}</span>
                {/if}
            </div>    
            
            <slot />
            {#if showClose}
                <div class="modal-footer flex justify-center">
                    <Button onClick={OnClose} label={closeLabel} type="link"/>
                </div>
            {/if}
            
        </div>
    </div>
</div>

<style>

    .modal-container{
        inset: 0px;
        background: rgba(41,47,76,0.7);
        position: fixed;
    }

    .modal{
        inset: 10% auto 15% 50%;
        overflow: hidden auto;
        transform: translate(-50%, 0px);
        transition: all 0.3s ease 0s;
        will-change: width;
        box-shadow: rgb(0 0 0 / 70%) 0 25px 50px -15px !important;
        background-color: var(--primary-color);
        position: absolute;
        height: auto;
        outline: none;
        width : 50vw;
        max-height: 75vh;
        padding: 20px;
        border-radius: 5px;
    }

    .modal-content{
        position: relative;
    }

    .modal-header{
        margin-bottom: 16px;
        display: flex;
        justify-content: space-between;
        color: white;
    }

    .modal-header > .task-status {
        padding: 1px 3px;
        display: flex;
        align-items: center;
        justify-content: center;
        width: max-content;
    }

    .completed{
        background-color: #4BCC73;
    }

    .not-completed{
        background-color: var(--secondary-color);
    }

    .modal-header > .task-name {
        font-size: 1.25rem;
        font-weight: 600;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .modal-footer{
        display: flex;
        justify-content: center;
    }

</style>