import { ApplicationController } from "stimulus-use";

export default class extends ApplicationController {
  static targets = ["content"];
  static values = { contentId: String };

  connect() {}

  show(event) {
    const hoverContentElement = document.getElementById(this.contentIdValue);
    hoverContentElement.style.top = `${event.y}px`;
    hoverContentElement.style.left = `${event.x}px`;

    if (Array.from(hoverContentElement.classList).indexOf("hidden") !== -1) {
      hoverContentElement.classList.remove("hidden");
      // position at end for Z ordering
      document.body.insertAdjacentElement("beforeend", hoverContentElement);
    }

    // TODO: position at the cursor location and away from screen bounds
    // 1. determine where the trigger element / mouse is in relation to the window quadrants
    // (upper left, upper right, bottom left, bottom right)
    // 2. apply the style to the hover to be away from window edges
  }

  hide(event) {
    // debugger;

    // if (event.toElement.offsetParent.id == this.contentIdValue) return;
    document.getElementById(this.contentIdValue).classList.add("hidden");
  }
}

// this.element.getBoundingClientRect()
// DOMRect {x: 16, y: 216, width: 459, height: 68, top: 216, …}
// bottom: 284
// height: 68
// left: 16
// right: 475
// top: 216
// width: 459
// x: 16
// y: 216

// altKey: false
// bubbles: true
// button: 0
// buttons: 0
// cancelBubble: false
// cancelable: true
// clientX: 344
// clientY: 270
// composed: true
// ctrlKey: false
// currentTarget: div
// defaultPrevented: false
// detail: 0
// eventPhase: 3
// fromElement: div.pt-2
// immediatePropagationStopped: false
// isTrusted: true
// layerX: 45
// layerY: 270
// metaKey: false
// movementX: 0
// movementY: 0
// offsetX: 9
// offsetY: -0
// pageX: 344
// pageY: 764
// path: (15) [div.g-button-secondary.g-button-small, div, div, div.flex.justify-between, div.g-container, div.g-text, div, div, div.flex, div.overflow-scroll.h-screen, div#cda0fcdf-acaa-4b4e-a108-cd74ca08b059.fixed.w-screen.h-screen.top-0.flex.justify-center.items-ce…, body.g-bg-deep-space-blue, html, document, Window]
// relatedTarget: div.pt-2
// returnValue: true
// screenX: 344
// screenY: 349
// shiftKey: false
// sourceCapabilities: InputDeviceCapabilities {firesTouchEvents: false}
// srcElement: div.g-button-secondary.g-button-small
// stopImmediatePropagation: ƒ stopImmediatePropagation()
// target: div.g-button-secondary.g-button-small
// timeStamp: 20355.574999935925
// toElement: div.g-button-secondary.g-button-small
// type: "mouseover"
// view: Window {window: Window, self: Window, document: document, name: "", location: Location, …}
// which: 0
// x: 344
// y: 270
