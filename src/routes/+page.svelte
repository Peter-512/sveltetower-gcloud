<script>
  import User from "./User.svelte"
  import LoadingUser from "./LoadingUser.svelte"
  export let data
</script>

<h1 class="text-3xl m-8 text-center">Blazingly fast 🚀</h1>
{#await data.promise.users}
  <div class="flex flex-wrap">
    <LoadingUser />
    <LoadingUser />
    <LoadingUser />
    <LoadingUser />
  </div>
{:then users}
  <div class="flex flex-wrap">
    {#each users as user}
      <User {user} />
    {/each}
  </div>
{:catch error}
  <div class="text-3xl">Oops, something went wrong...</div>
  <p class="text-red-500 m-2 text-2xl">{error.message}</p>
{/await}
