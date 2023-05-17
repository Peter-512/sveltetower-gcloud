import sql from "$lib/db.js"

async function getUsers() {
	return sql`
        select name, email, id
        from users`
}

/** @type {import('./$types').PageServerLoad} */
export async function load() {
	return {
		promise: { users: getUsers() },
	}
}
