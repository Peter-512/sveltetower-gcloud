import sql from "$lib/db.js";

async function getUsers() {
	return sql`
        select name
        from users`;
}


/** @type {import('./$types').PageServerLoad} */
export async function load() {
	const users = await getUsers()
	return {
		users
	};
}
