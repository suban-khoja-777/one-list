<script>
    export let show;
</script>

{#if show}
    <div class="main-container flex align-center flex-column justify-center bg-secondary">
        <div class="flex align-center text-primary">
            <img class="logo" src="./logo.svg" alt="oneList"/>
        </div>
    </div>
{/if}


<style>
    
    .logo {
        width: 5.8em;
        height: 5.8em;
    }

    .main-container{
        margin:0;
        padding: 0;
        height: 100vh;
    }

</style>