import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
    static targets = [ "selectField"]
    connect(){
        console.log("icon select")
            this.selectFieldTargets.forEach((selectField) =>{
                var e = $('#' + selectField.id)
                if(e[0].nextElementSibling?.classList.contains("select2") ){
                    e[0].nextElementSibling?.remove()
                }
                e.select2({
                    templateResult: formatState
                });
                console.log(e[0].nextElementSibling?.classList.contains("select2") )
                if(e[0].selectedIndex != -1){
                    e[0].previousElementSibling.src = e[0].options[e[0].selectedIndex].dataset.icon
                }
                
                e.on("change", () =>{
                    e[0].previousElementSibling.src = e[0].options[e[0].selectedIndex].dataset.icon
                })

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