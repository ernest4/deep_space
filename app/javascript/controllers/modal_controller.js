import { ApplicationController } from "stimulus-use";

export default class extends ApplicationController {
  static targets = ["content"];
  static values = { contentId: String };

  connect() {
    // this.outputTarget.textContent = "Hello, Stimulus!";
  }

  show() {
    const modalContentElement = document.getElementById(this.contentIdValue);
    modalContentElement.classList.remove("hidden");
    // document.body.innerHTML += '<div class="modal-backdrop fade show"></div>';
    document.body.insertAdjacentElement("beforeend", modalContentElement);
  }

  close() {
    document.getElementById(this.contentIdValue).classList.add("hidden");
  }
}
