import postgres from 'postgres'
import {POSTGRES_PASSWORD, DATABASE, POSTGRES_USER, SQL_INSTANCE_IP} from '$env/static/private'

const sql = postgres({ database: DATABASE, password: POSTGRES_PASSWORD, user: POSTGRES_USER, host: SQL_INSTANCE_IP }) // will use psql environment variables

export default sql
