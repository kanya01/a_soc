import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    autoDismiss: Number,
    animationDuration: { type: Number, default: 300 }
  }

  connect() {
    if (this.hasAutoDismissValue) {
      this.autoDismissTimeout = setTimeout(() => {
        this.dismiss()
      }, this.autoDismissValue)
    }

    this.element.style.transition = `opacity ${this.animationDurationValue}ms ease-out`
    this.element.style.opacity = '1'
  }

  disconnect() {
    if (this.autoDismissTimeout) {
      clearTimeout(this.autoDismissTimeout)
    }
  }

  dismiss() {
    if (this.isDismissing) return
    this.isDismissing = true

    this.element.style.opacity = '0'

    setTimeout(() => {
      this.element.remove()
    }, this.animationDurationValue)
  }
}