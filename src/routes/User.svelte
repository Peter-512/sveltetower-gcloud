<script>
	import { fly, fade } from "svelte/transition"
	/**@type {Record<string, string | number> | undefined}*/
	export let user = undefined
	export let number = 0
</script>

{#if !user}
	<div
		role="status"
		class="m-8 max-w-md p-6 space-y-4 bg-blue-50 rounded-lg flex-1 drop-shadow-lg animate-pulse"
	>
		<div class="flex justify-between items-center">
			<div>
				<div
					class="h-3 bg-gray-200 rounded-full dark:bg-gray-400 w-24 mb-4"
				/>
				<div
					class="w-32 h-2 bg-gray-100 rounded-full dark:bg-gray-300"
				/>
			</div>
		</div>
		<span class="sr-only">Loading...</span>
	</div>
{:else}
	<div
		in:fly={{ y: 50, duration: 750, delay: number * 150 }}
		out:fade
		class="bg-blue-50 m-8 p-4 rounded-lg flex-1 drop-shadow-lg relative"
	>
		<p class="text-xl">{user.name}</p>
		<p class="text-gray-600">{user.email}</p>
	</div>
{/if}
