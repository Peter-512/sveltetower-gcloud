<script>
	import User from "./User.svelte";
	export let data;
	const loadingUser = {
		name: "Loading...",
		email: "Loading...",
	};
</script>

<h1>Welcome to SvelteKit</h1>
<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>
{#await data.promise.users}
	<p class="loading">Loading users...</p>
	<div class="container">
		<User user={loadingUser}></User>
		<User user={loadingUser}></User>
		<User user={loadingUser}></User>
		<User user={loadingUser}></User>
	</div>
{:then users}
	<div class="container">
		{#each users as user}
			<User user={user}></User>
		{/each}
	</div>
{:catch error}
	<p class="error">{error.message}</p>
{/await}

<style>
	.container {
		display: flex;
		flex-wrap: wrap;
	}

	.error {
		color: red;
		margin: 2rem;
		font-size: 2rem;
	}

	.loading {
		margin: 2rem;
		font-size: 2rem;
	}
</style>
