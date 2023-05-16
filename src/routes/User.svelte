<script>
  export let user
  const { name, email } = user
</script>

<div class="bg-blue-50 m-8 p-4 rounded-lg flex-1 drop-shadow-lg relative">
  <p class="text-xl">{name}</p>
  <p class="text-gray-400 relative right-0">{email}</p>
</div>
