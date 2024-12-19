import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    toggleDarkModeClass() {
      if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark')
      } else {
        localStorage.theme = 'dark'
      }
      this.initialize()
      this.toggleDarkModeClass()
    }
  }
}
