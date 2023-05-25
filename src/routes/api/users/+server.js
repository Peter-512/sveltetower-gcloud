import {error, fail, json} from "@sveltejs/kit";
import sql from "$lib/db.js"


export async function POST({request}) {
	const data = await request.json();
	const user = await addUser(data.email, data.name)
	if (user.data?.emailAlreadyExists) {
		throw error(400, {message: "Email already exists"})
	}
	return json(data)
}

async function emailExists(email) {
	const result = sql`
		select count(*) as count
		from users
		where email = ${email}`
	return (await result)[0].count > 0
}

async function addUser(email, name) {
	if (await emailExists(email)) {
		return fail(400, {email, emailAlreadyExists: true})
	}
	return sql`
		insert into users (name, email)
		values (${name}, ${email})`
}
