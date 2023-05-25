import sql from "$lib/db.js"

async function getUsers(limit, skip) {
	return sql`
        select name, email, id
        from users 
        ${limit ? sql`LIMIT ${limit}` : sql``} OFFSET ${skip}`
}

async function emailExists(email) {
	const result = sql`
		select count(*) as count
		from users
		where email = ${email}`
	return (await result)[0].count > 0
}

async function addUser(email) {
	const name = email.split("@")[0].replace('.', ' ')
	if (await emailExists(email)) return
	return sql`
		insert into users (name, email)
		values (${name}, ${email})`
}

/** @type {import('./$types').PageServerLoad} **/
export async function load({ url }) {
	const limit = Number(url.searchParams.get("limit")) || 20
	const skip = Number(url.searchParams.get("skip")) || 0
	return {
		promise: { users: getUsers(limit, skip) },
	}
}

/** @type {import('./$types').Actions} */
export const actions = {
	default: async ({request}) => {
		const data = await request.formData()
		const email = data.get("email")
		await addUser(email)
	}
};
