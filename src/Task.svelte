<script>

    import { fireEvent, EVENTS } from "./EventManager";
    import { statuses , columns ,getStatusClass } from "./constants";
    import Input from "./utility/Input.svelte";
    import Button from "./utility/Button.svelte";
    export let task;
    
    let updated_task = {...task};

    const handleChange = (e) => {
        updated_task[e.target.dataset.field] = e.target.value;
        fireEvent(EVENTS.UPDATE_TASK,updated_task);
    }

    const sendOpenTaskDetailEvent = () => {
        fireEvent(EVENTS.OPEN_TASK_DETAIL,task.task_id);
    }
    
</script>

<li class="columns text-primary flex justify-space-between align-center border-box">
    {#each columns as column}
        {#if column.show_in_list}
            <span class="column flex justify-center border-box text-bold pointer {column.key} {column.key == 'task_name' ? 'justify-start' : 'justify-center'} {column.field_type == 'select' ? 'align-stretch' : 'align-center'}">
                {#if column.allow_inline_edit}
                    {#if column.field_type !== 'select'}
                        <Input type={column.field_type} classes="bg-transparent" value={task[column.key]} onChange={handleChange} data_field={column.key} />
                        {:else}
                        <Input type={column.field_type} classes={getStatusClass(updated_task[column.key])} value={updated_task[column.key]} onChange={handleChange} data_field={column.key} options={statuses}/>
                    {/if}
                    {:else}
                    
                    <span>{task[column.key]}</span>
                    <span class="row-action">
                        <Button onClick={sendOpenTaskDetailEvent} label="Edit" type="link"/>
                    </span>
                {/if}
            </span>    
        {/if}
    {/each}
</li>

<style>

    .columns{
        width: 100%;
        list-style: none;
        background-color: #f5f6f8;
        border-bottom: 2px solid white;
        padding-left: 1rem;
    }

    .column{
        height: 40px;
    }

    .column-padding-around{
        padding: 0.5rem;
    }

    .row-action{
        padding-left: 2rem;
        display: none;
    }

    li.columns:hover{
        background-color : #cce5ff;
    }

    li.columns:hover .row-action{
        display: inherit;
    }


</style>