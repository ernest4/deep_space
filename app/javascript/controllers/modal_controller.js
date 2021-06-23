import { ApplicationController } from "stimulus-use";

export default class extends ApplicationController {
  static targets = ["content"];
  static values = { contentId: String };

  connect() {}

  show() {
    const modalContentElement = document.getElementById(this.contentIdValue);
    modalContentElement.classList.remove("hidden");

    // position at end for Z ordering
    document.body.insertAdjacentElement("beforeend", modalContentElement);
  }

  close() {
    document.getElementById(this.contentIdValue).classList.add("hidden");
  }
}
