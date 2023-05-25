<script>
	import User from "./User.svelte"
	export let data
	const randomNumberOfLoadingUsers = Math.floor(Math.random() * 10) + 5

	let emailInput = ""
	let newUsers = []
	let resMessage = ""
	let status
	const addUser = async (email) => {
		if (!email) return

		const name = email.split("@")[0].replace('.', ' ')

		const res = await fetch("/api/users", {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
				"Accept": "application/json"
			},
			body: JSON.stringify({email, name})
		});
		status = res.status
		if (!res.ok) {
			const data = await res.json()
			resMessage = data.message
			return
		}

		newUsers = [...newUsers, {email, name}]
		emailInput = ""
		resMessage = ""
	}
</script>

<svelte:head>
	<title>SvelteTower</title>
	<meta
		name="description"
		content="This is a blazingly fast homepage, showcasing the strength of SvelteKit x Tailwind x Postgres"
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

<div>
	<div class="mt-8 mx-8 flex flex-col sm:flex-row gap-4">
		<div class="relative flex-1">
			<div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
				<svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"></path><path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"></path></svg>
			</div>
			<input bind:value={emailInput} name="email" aria-label="email input" type="text" id="email-address-icon" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="name@email.com">
		</div>
		<button on:click={() => addUser(emailInput)} type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Submit</button>
	</div>
	{#if status === 400}
		<div class="mx-8 mt-4 p-4 text-sm text-red-800 rounded-lg bg-red-50 dark:bg-red-900 dark:text-red-300" role="alert">
			<em class="font-medium">Aww snap!</em> Someone already added that email.
		</div>
	{:else if status >= 500}
		<div class="mx-8 mt-4 p-4 text-sm text-red-800 rounded-lg bg-red-50 dark:bg-red-900 dark:text-red-300" role="alert">
			<em class="font-medium">Oh oh!</em> Something went wrong, please try again later.
		</div>
	{/if}
</div>


{#await data.promise.users}
	<div class="flex flex-wrap">
		{#each {length: randomNumberOfLoadingUsers} as _}
			<User />
		{/each}
	</div>
{:then users}
	<div class="flex flex-wrap">
		{#each users as user, i}
			<User {user} number={i} />
		{/each}
	</div>
{:catch error}
	<div class="text-3xl">Oops, something went wrong...</div>
	<p class="text-red-500 m-2 text-2xl">{error.message}</p>
{/await}

{#each newUsers as user, i}
	<User {user} number={i} />
{/each}
