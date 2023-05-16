<script>
	export let data;
</script>
<h1>Welcome to SvelteKit</h1>
<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>
{#await data.promise.users}
	<p>Loading users...</p>
{:then users}
	{#each users as {username}}
		<p>{username}</p>
	{/each}
{:catch error}
	<p>{error.message}</p>
{/await}
