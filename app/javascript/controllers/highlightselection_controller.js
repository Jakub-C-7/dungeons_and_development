import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
    static targets = [ "pathway","section"]
    connect(){
        this.pathwayTargets.forEach(pathwayTarget => {
            pathwayTarget.addEventListener('click', () => {
                this.pathwayTargets.forEach(pathwayBtn => { 
                    pathwayBtn.classList.remove("active-pathway")
                });
                pathwayTarget.classList.add("active-pathway")
            });
        });

        this.sectionTargets.forEach(sectionTarget => {
            sectionTarget.addEventListener('click', () => {
                this.sectionTargets.forEach(sectionBtn => { 
                    sectionBtn.classList.remove("active-section")
                });
                sectionTarget.classList.add("active-section")
            });
        });
       
    }
}