import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
    static targets = [ "selectField"]
    connect(){
        console.log("icon select")
            this.selectFieldTargets.forEach((selectField) =>{
                var e = $('#' + selectField.id)
                e.select2({
                    templateResult: formatState
                });
                e[0].previousElementSibling.src = e[0].options[e[0].selectedIndex].dataset.icon
                e.on("change", () =>{
                    e[0].previousElementSibling.src = e[0].options[e[0].selectedIndex].dataset.icon
                })
               nextElementSibling.addEventListener("click", (() => updateImage(e[0])))

            })
           
           function formatState (state) {
            if (!state.id) { return state.text; }
            var $state = $(
             '<span ><img style="display: inline-block;" src="' + state.element.dataset.icon + '" /> ' + state.text + '</span>'
            );
            return $state;
           }

           function updateImage(el){
            console.log(el)
           }


        
    }

    
}