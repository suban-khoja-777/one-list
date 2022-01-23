<script>

    export let label;
    export let onClick;
    export let type;

</script>


<button data-type={type} on:click={onClick}>{label}</button>

<style>
    button{
        border: none;
        outline: none;
        padding : 10px;
        border-radius: 3px;
        cursor: pointer;
        color: white;
        font-weight: 600;
    }

    button[data-type="primary"]{
        background-color: var(--primary-color);
    }

    button[data-type="secondary"]{
        background-color: var(--secondary-color);
    }

    button[data-type="link"]{
        color: var(--secondary-color);
        text-decoration: underline;
        font-weight: 600;
        padding: 0;
        background-color: transparent;
    }
    
</style>