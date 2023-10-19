import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
    static targets = [ "editContainer" ]

    connect(){
        console.log(this.editContainerTarget)
        var toggleEditBtn = document.getElementById("toggleEdit")
        toggleEditBtn.addEventListener('click', () => {
            if(this.editContainerTarget.classList.contains("edit")){
                this.editContainerTarget.classList.remove("edit")
            }else{
                this.editContainerTarget.classList.add("edit")
            }    
        })
    }


    hello(){
        console.log("okay")
    }
}