import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landingpage"
export default class extends Controller {
static targets = [ "toggleButton", "toggledElement"]

  connect() {
    console.log("connected to togglehidden")
    this.toggleButtonTarget.addEventListener('click', () => {
        console.log("click")
        this.toggledElementTargets.forEach(toggledElement => {
            if(toggledElement.classList.contains("hidden")){
                toggledElement.classList.remove("hidden")
            }else{
                toggledElement.classList.add("hidden")
            }
        });
    });
  }
}