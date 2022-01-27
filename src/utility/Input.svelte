<script>

    export let hasLabel = false;
    export let type;
    export let name;
    export let label;
    export let placeholder;
    export let onChange;
    export let onKeyUp;
    export let value = "";
    export let width_class;
    export let label_class = 'dark';
    export let classes;
    export let data_field;
    export let options;
</script>

{#if hasLabel}
    <label class="text-bold {label_class}" for={name}>{label}</label>    
{/if}

{#if type === 'select'}
    <select class="column flex grow border-bottom-primary text-primary bg-secondary text-center pointer border-box justify-center status-column" {value} {name} on:change={onChange} data-field={data_field}>
        {#each options as status}
            <option value={status} class="option bg-transparent">{status}</option>
        {/each}
    </select>
    {:else if type === "text-long"}
        <textarea class="border-primary text-primary border-box bg-white {width_class}" rows="10" on:change={onChange} data-field={data_field} {value}></textarea>
    {:else}
        <input class="{classes} border-primary border-box {width_class}" {type} {name} on:change={onChange} on:keyup={onKeyUp} {value} {placeholder} data-field={data_field}/>
{/if}


<style>

    input{
        padding: 0.5em;
        outline: none;
    }

    label {
        font-family: normal;
        margin: 1em 0 0 0;
    }

    .width-half{
        width: 50%;
    }

    .width-full{
        width: 100%;
    }

    label.dark{
        color: var(--primary-color);
    }
    
    label.light{
        color: white;
    }

    input[type="date"]{
        border: none;
        outline: none;
    }

    select{
        border: none;
        outline: none;
    }

</style>