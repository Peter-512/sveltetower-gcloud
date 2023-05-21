import { browser } from "$app/environment"
import { writable } from "svelte/store"

const defaultValue = "dark"
const initialValue = browser
	? window.localStorage.getItem("theme") ||
	  (!("theme" in localStorage) &&
	  window.matchMedia("(prefers-color-scheme: dark)").matches
			? "dark"
			: "light")
	: defaultValue

const theme = writable(initialValue)

theme.subscribe(value => {
	if (browser) {
		window.localStorage.setItem("theme", value)
	}
})

export default theme
