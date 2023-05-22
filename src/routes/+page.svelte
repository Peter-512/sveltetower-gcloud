<script>
	import User from "./User.svelte"
	export let data
	const randomNumberOfLoadingUsers = Math.floor(Math.random() * 10) + 5
</script>

<svelte:head>
	<title>SvelteTower</title>
	<meta
		name="description"
		content="This is a blazingly fast homepage, showcasing the strength of Svelte x Postgres"
	/>
	<meta
		property="og:image"
		content="https://storage.googleapis.com/infra-bucket-230516/static/logo.png"
	/>
	<script>
		// On page load or when changing themes, best to add inline in `head` to avoid FOUC (flash of unstyled content)
		if (
			localStorage.getItem("theme") === "dark" ||
			(!("theme" in localStorage) &&
				window.matchMedia("(prefers-color-scheme: dark)").matches)
		) {
			document.documentElement.classList.add("dark")
		} else {
			document.documentElement.classList.remove("dark")
		}
	</script>
</svelte:head>

<h1 class="text-6xl md:text-9xl m-8 text-center">
	<span
		class="bg-gradient-to-br font-bold from-red-600 to-yellow-500 bg-clip-text text-transparent box-decoration-clone"
		>Blazingly fast</span
	> 🚀
</h1>

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
