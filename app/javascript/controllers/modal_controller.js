import { ApplicationController } from "stimulus-use";

export default class extends ApplicationController {
  static targets = ["content"];

  connect() {
    // this.outputTarget.textContent = "Hello, Stimulus!";
  }

  // TODO: on show
  // 1. need to take copy content and place it at bottom of body
  // 2. display => block
  // 3. position middle screen

  show() {
    const modalContent = this.contentTarget;
    modalContent.classList.remove("hidden");
    // document.body.innerHTML += '<div class="modal-backdrop fade show"></div>';
    document.body.insertAdjacentElement("beforeend", modalContent);
  }

  close() {
    document.getElementById(this.contentTarget.id).remove();
  }
}
