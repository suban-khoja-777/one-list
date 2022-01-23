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
</script>

{#if hasLabel}
    <label for={name}>{label}</label>    
{/if}

<input class="{width_class}" {type} {name} on:change={onChange} on:keyup={onKeyUp} {value} {placeholder}/>

<style>

    input{
        padding: 0.5em;
        border-radius: 3px;
        outline: none;
        border: none;
        box-sizing: border-box;
    }

    label {
        color: white;
        font-family: normal;
        font-weight: 600;
        margin: 1em 0 0 0;
    }

    .width-half{
        width: 50%;
    }

    .width-full{
        width: 100%;
    }

</style>