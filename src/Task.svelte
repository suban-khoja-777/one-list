<script>

    import { fireEvent, EVENTS } from "./EventManager";
    import Button from "./utility/Button.svelte";
    export let task_name;
    export let task_id;
    export let task_status;

    const sendUpdateStatusEvent = (_evt) => {
        fireEvent(EVENTS.UPDATE_STATUS,{
            task_id,
            task_status : _evt.target.checked
        });
    }

    const sendDeleteEvent = () => {
        const sure = confirm('Are you sure?');
        sure &&
        fireEvent(EVENTS.DELETE_TASK,{
            task_id
        });
    }

    const sendOpenTaskDetailEvent = () => {
        fireEvent(EVENTS.OPEN_TASK_DETAIL,task_id);
    }

</script>

<li class="task" id={task_id} >
    <div class="data-container">
        <input type="checkbox" on:change={sendUpdateStatusEvent} checked={task_status}/>
        <span class="task-label">{task_name}</span>
    </div>
    <div class="action-container">
        <Button onClick={sendDeleteEvent} label="delete" type="link"/>&nbsp;|&nbsp; 
        <Button onClick={sendOpenTaskDetailEvent} label="open" type="link"/>
    </div>
    
</li>

<style>
    .task{
        display: flex;
        align-items: center;
        margin: 0.5em 0;
        background-color: #ffffff1a;
        padding: 10px;
        border-radius: 3px;
        color: #ffffff5c;
        width: 80%;
        cursor: pointer;
    }

    input[type=checkbox]{
        width: 20px;
        height: 20px;
        margin: 0;
        padding: 0;
        border: 2px solid var(--secondary-color);
    }

    input[type=checkbox]:checked + .task-label {
        color: #ffffff5c;
        text-decoration: line-through;
    }

    .task-label{
        padding-left: 1em;
        font-family: normal;
        max-width: 85%;
        overflow-wrap: break-word;
        cursor: pointer;
    }

    .data-container{
        width: 90%;
        display: flex;
        justify-content: flex-start;
        align-items: center;
    }

    .action-container{
        width: 10%;
        display: flex;
        justify-content: flex-end;
        align-items: center;
    }

</style>