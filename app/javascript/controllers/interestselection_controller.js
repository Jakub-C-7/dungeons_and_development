import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
    connect(){
        console.log("hello")

        new MultiSelectTag('interests',{
            rounded: true,    // default true
            shadow: true,      // default false
            placeholder: 'Search',  // default Search...
            onChange: function(values) {
                console.log(values)
        }})  
    }
}