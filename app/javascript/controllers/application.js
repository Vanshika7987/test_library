import { Application } from "@hotwired/stimulus"

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
