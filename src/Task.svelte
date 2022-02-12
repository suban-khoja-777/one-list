<script>

    import { fireEvent, EVENTS } from "./EventManager";
    import { statuses , columns ,getStatusClass } from "./constants";
    import Input from "./utility/Input.svelte";
    export let task;
    
    const handleChange = (e) => {
        task[e.target.dataset.field] = e.target.value;
        fireEvent(EVENTS.UPDATE_TASK,task);
    }

    const sendOpenTaskDetailEvent = () => {
        fireEvent(EVENTS.OPEN_TASK_DETAIL,task.task_id);
    }
    
</script>

<li class="columns text-primary flex justify-space-between align-center border-box">
    {#each columns as column}
        {#if column.show_in_list}
            <span class="column flex justify-center border-box text-bold pointer {column.key}">
                {#if column.allow_inline_edit}
                    {#if column.field_type !== 'select'}
                        <Input type={column.field_type} classes="bg-transparent" value={task[column.key]} onChange={handleChange} data_field={column.key} />
                        {:else}
                        <Input type={column.field_type} classes="bg-transparent {getStatusClass(task[column.key])}" value={task[column.key]} onChange={handleChange} data_field={column.key} options={statuses}/>
                    {/if}
                    {:else}
                    <span on:click={sendOpenTaskDetailEvent}>{task[column.key]}</span>
                {/if}
            </span>    
        {/if}
    {/each}
</li>

<style>

    .columns{
        width: 100%;
        list-style: none;
    }

    .column{
        padding: 0.5rem;
        height: 40px;
    }


</style>