import sql from "$lib/db.js"
import {fail} from '@sveltejs/kit'

async function getUsers(limit, skip) {
	return sql`
        select name, email, id
        from users 
        ${limit ? sql`LIMIT ${limit}` : sql``} OFFSET ${skip}`
}

/** @type {import('./$types').PageServerLoad} **/
export async function load({ url }) {
	const limit = Number(url.searchParams.get("limit")) || 20
	const skip = Number(url.searchParams.get("skip")) || 0
	return {
		promise: { users: getUsers(limit, skip) },
	}
}
