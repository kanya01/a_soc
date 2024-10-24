import { Application } from "@hotwired/stimulus"
import FlashController from "../../../app/javascript/controllers/flash_controller"

describe("FlashController", () => {
    let application

    beforeEach(() => {
        document.body.innerHTML = `
      <div 
        data-controller="flash"
        data-flash-animation-duration-value="300"
        data-flash-auto-dismiss-value="5000"
      >
        Test Flash Message
        <button data-action="flash#dismiss">&times;</button>
      </div>
    `

        application = Application.start()
        application.register("flash", FlashController)
    })

    afterEach(() => {
        application.stop()
        document.body.innerHTML = ""
    })

    it("initializes with correct values", () => {
        const element = document.querySelector("[data-controller='flash']")
        expect(element).toBeTruthy()
        expect(element.dataset.flashAnimationDurationValue).toBe("300")
        expect(element.dataset.flashAutoDismissValue).toBe("5000")
    })

    it("removes the message when dismiss button is clicked", async () => {
        const element = document.querySelector("[data-controller='flash']")
        const button = element.querySelector("button")

        button.click()
        expect(element.style.opacity).toBe("0")

        await new Promise(resolve => setTimeout(resolve, 300))
        expect(document.body.contains(element)).toBeFalsy()
    })

    // it("auto-dismisses after specified timeout", async () => {
    //     const element = document.querySelector("[data-controller='flash']")
    //
    //     await new Promise(resolve => setTimeout(resolve, 5000))
    //     expect(document.body.contains(element)).toBeFalsy()
    // })

    it("cleans up timeouts on disconnect", () => {
        const element = document.querySelector("[data-controller='flash']")
        const controller = application.getControllerForElementAndIdentifier(element, "flash")

        jest.spyOn(window, "clearTimeout")
        controller.disconnect()

        expect(clearTimeout).toHaveBeenCalled()
    })
})