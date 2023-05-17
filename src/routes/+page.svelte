<script>
	import User from "./User.svelte"
	export let data
	const randomNumberOfLoadingUsers = Math.floor(Math.random() * 10) + 5
</script>

<h1 class="text-3xl m-8 text-center">Blazingly fast 🚀</h1>
{#await data.promise.users}
	<div class="flex flex-wrap">
		{#each Array(randomNumberOfLoadingUsers) as _}
			<User />
		{/each}
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
