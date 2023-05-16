import sql from "$lib/db.js";

async function getUsers() {
	return sql`
        select username
        from platform_users`;
}


/** @type {import('./$types').PageServerLoad} */
export async function load() {
	const users = await getUsers()
	return {
		users
	};
}
