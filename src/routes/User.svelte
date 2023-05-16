<script>
	export let user;
	const { name, email } = user;
</script>

<div>
	<p class="name">{name}</p>
	<p class="email">{email}</p>
</div>

<style>
	div {
		background: aliceblue;
		margin: 2rem;
		padding: 1rem;
		border-radius: 10px;
		box-shadow: #d6ebfb 0 0 15px;
		flex: 1;
	}
	.name {
		color: black;
	}
	.email {
		color: slategray;
	}
</style>
