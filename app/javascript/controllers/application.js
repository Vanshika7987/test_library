import { Application } from "@hotwired/stimulus"

// import "jquery"
// import "jquery_ujs"
import "@popperjs/core";
import "bootstrap";
import "./channels"
// import "@fortawesome/fontawesome-free";
// import "my_script";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
// $(document).ready(function(){
//     $('.approve').on('click',function(){
//         $.ajax({
//             url: '/librarians/' + this.parentElement.id + '/approve',
//             type: 'GET',
//             success: function(r){

//             }
//         });
//     });
// });
