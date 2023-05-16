import postgres from 'postgres'

const sql = postgres({ database: "YouthCouncil", password: "anubis512", user: "postgres" }) // will use psql environment variables

export default sql
