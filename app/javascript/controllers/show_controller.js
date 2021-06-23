import { ApplicationController } from "stimulus-use";

export default class extends ApplicationController {
  static targets = ["content"];
  static values = { contentId: String, groupId: String };

  connect() {}

  show() {
    document
      .querySelectorAll(`[data-show-group-id-value=${this.groupIdValue}]`)
      .forEach(contentElement => {
        contentElement.classList.add("hidden");
      });

    const modalContentElement = document.getElementById(this.contentIdValue);
    modalContentElement.classList.remove("hidden");

    // position at end for Z ordering
    document.body.insertAdjacentElement("beforeend", modalContentElement);
  }
}
