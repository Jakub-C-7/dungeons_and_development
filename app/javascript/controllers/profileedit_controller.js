import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
    static targets = [ "editContainer" , "editableField"]

    connect(){
        var toggleEditBtn = document.getElementById("toggleEdit")
        toggleEditBtn.addEventListener('click', () => {
            if(this.editContainerTarget.classList.contains("edit")){
                this.editContainerTarget.classList.remove("edit")
            }else{
                this.editContainerTarget.classList.add("edit")
            }
            this.editableFieldTargets.forEach((target) =>{
                target.disabled = ! target.disabled
            }); 
            toggleEditBtn.classList.add("hidden")   
        })

       
     
    }


    hello(){
        console.log("okay")
    }
}