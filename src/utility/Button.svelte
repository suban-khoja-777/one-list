<script>

    export let label;
    export let onClick;
    export let type;

</script>


<button class="pointer text-bold" data-type={type} on:click={onClick}>{label}</button>

<style>
    button{
        border: none;
        outline: none;
        padding : 10px;
    }

    button[data-type="primary"]{
        background-color: var(--primary-color);
        color: white;
        border : 2px solid var(--primary-color);
    }

    button[data-type="secondary"]{
        background-color: var(--dark-color);
        border : 2px solid var(--dark-color);
        color: white;
    }

    button[data-type="link"]{
        color: var(--primary-color);
        text-decoration: underline;
        font-weight: 600;
        padding: 0;
        background-color: transparent;
    }
    
</style>