<script>
    export let show = true;
</script>

{#if show}
    <div class="spinner-container">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: rgb(241, 242, 243 / 0%); display: block;" width="100px" height="100px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
            <circle cx="50" cy="50" r="16" stroke-width="4" stroke="#f48668" stroke-dasharray="50.26548245743669 50.26548245743669" fill="none" stroke-linecap="round">
              <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0 50 50;360 50 50"></animateTransform>
            </circle>
        </svg>
    </div>
{/if}

<style>
    .spinner-container{
        display: flex;
        justify-content: center;
        align-items: center;
        position: fixed;
        z-index: 1;
        flex-direction: column;
        width: 100%;
        height: 100%;
    }
</style>