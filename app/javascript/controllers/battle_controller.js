import { ApplicationController } from "stimulus-use";
// import consumer from "../channels/consumer";

export default class extends ApplicationController {
  static targets = ["footer", "ship:container", "ship"];
  // static values = { contentId: String, groupId: String };
  static values = { battleId: Number };

  // connect() {
  //   const channelParams = {
  //     channel: "BattleChannel",
  //     // stream: this.data.get("conversation-id"),
  //     // observer: true,
  //     battle_id: this.battleIdValue,
  //   };

  //   this.stream = consumer.subscriptions.create(channelParams, {
  //     connected: () => {
  //       // Called when the subscription is ready for use on the server
  //       console.log("connected BattleChannel");
  //     },
  //     disconnected: () => {
  //       // Called when the subscription has been terminated by the server
  //       console.log("disconnected BattleChannel");
  //     },
  //     received: data => {
  //       console.log("data BattleChannel");
  //       console.log(data);

  //       // if (data.redirect) window.location.replace(`${window.location.origin}${data.redirect}`);
  //     },
  //     dispatch(msg) {
  //       // this.perform("dispatch", msg);
  //       this.perform("testy", "extra");
  //     },
  //   });

  //   // this.stream.dispatch();
  // }

  // disconnect = () => {
  //   this.stream.unsubscribe();
  // };

  shipClick() {
    // const response = fetch()
    // this.footerTarget.innerHtml = response.data;
    // this.footerTarget.innerHtml = `<div data-controller="async" data-async-url-value="/battle/${this.battleIdValue}/footer"></div>`;
  }

  // show() {
  //   document
  //     .querySelectorAll(`[data-show-group-id-value=${this.groupIdValue}]`)
  //     .forEach(contentElement => {
  //       contentElement.classList.add("hidden");
  //     });

  //   const modalContentElement = document.getElementById(this.contentIdValue);
  //   modalContentElement.classList.remove("hidden");

  //   // position at end for Z ordering
  //   document.body.insertAdjacentElement("beforeend", modalContentElement);
  // }
}
