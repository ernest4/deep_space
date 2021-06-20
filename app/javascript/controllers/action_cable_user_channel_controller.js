import { ApplicationController } from "stimulus-use";
import consumer from "../channels/consumer";
// import _ from "lodash";

export default class extends ApplicationController {
  initialize = () => {};

  connect = () => {
    const channelParams = {
      channel: "UserChannel",
      // stream: this.data.get("conversation-id"),
      // observer: true,
    };

    this.stream = consumer.subscriptions.create(channelParams, {
      connected: () => {
        // Called when the subscription is ready for use on the server
        console.log("connected UserChannel");
      },
      disconnected: () => {
        // Called when the subscription has been terminated by the server
        console.log("disconnected UserChannel");
      },
      received: data => {
        console.log("data UserChannel");
        console.log(data);

        if (data.redirect) window.location.replace(`${window.location.origin}${data.redirect}`);
      },
      dispatch(msg) {
        // this.perform("dispatch", msg);
      },
    });
  };

  disconnect = () => {
    this.stream.unsubscribe();
  };

  // private

  // conversationSeen = _.throttle(
  //   () => {
  //     if (!this.seen) {
  //       if (this.debugLog) console.log(`seen: ${this.seen}`);
  //       this.stream.dispatch({
  //         event: "SEEN",
  //         payload: { conversation_id: this.data.get("conversation-id") },
  //       });
  //       // getAction(this, "cable-listener", "execute")({ action: "resetCount", payload: this.unseenCount });
  //       this.cableListener.execute({ action: "resetCount", payload: this.unseenCount });
  //       // this.cableListener.execute({ action: "hide" });
  //       this.unseenCount = 0;
  //     }
  //   },
  //   1000,
  //   { trailing: true, leading: true }
  // );
}
