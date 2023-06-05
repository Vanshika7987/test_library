import consumer from "./consumer"
var std= document.getElementById("student");
if(std){
consumer.subscriptions.create("ChatChannel", {
  connected() {
    alert("connected");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    alert(data)
  }

});
}