import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-post"
export default class extends Controller {
  static targets = ["audio", "playIcon"]

  connect() {
    this.playing = false
  }

  togglePlay() {
    const audio = this.audioTarget
    const icon = this.playIconTarget

    if (this.playing) {
      audio.pause()
      icon.innerHTML = `
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
      `
    } else {
      audio.play()
      icon.innerHTML = `
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 9v6m4-6v6m7-3a9 9 0 11-18 0 9 9 0 0118 0z" />
      `
    }

    this.playing = !this.playing
  }

  disconnect() {
    if (this.hasAudioTarget) {
      this.audioTarget.pause()
    }
  }
}
