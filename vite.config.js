import { sveltekit } from "@sveltejs/kit/vite"
import { defineConfig } from "vite"
import mkcert from "vite-plugin-mkcert"
import fs from "fs"

export default defineConfig({
	server: {
		https: true,
	},
	https: {
		key: fs.readFileSync(
			"/etc/letsencrypt/live/sveltetower.tech/privkey.pem"
		),
		cert: fs.readFileSync(
			"/etc/letsencrypt/live/sveltetower.tech/cert.pem"
		),
	},
	plugins: [sveltekit(), mkcert()],
})
