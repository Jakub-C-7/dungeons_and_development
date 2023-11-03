import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggledContainer"];

  connect() {
    console.log("connected");
    var toggleMapBtn = document.getElementById("toggleMap");
    toggleMapBtn.addEventListener("click", () => {
      this.toggledContainerTargets.forEach((target) => {
        if (target.classList.contains("hidden")) {
          target.classList.remove("hidden");
        } else {
          target.classList.add("hidden");
        }
      });
    });
  }
}
