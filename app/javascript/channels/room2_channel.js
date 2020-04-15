import consumer from "./consumer"

consumer.subscriptions.create("Room2Channel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the room2!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    var senderr = '<div class="send-mess-wrap">'
            + '<span class="mess-time">' + data.content.created_at
            + '</span><div class="send-mess__inner">'
            + '<div class="send-mess-list">'
            + '<div class="send-mess">' + data.content.msg
            + '</div></div></div></div>'

    var receiverr = '<div class="recei-mess-wrap">'
              + '<span class="mess-time">' + data.content.created_at
              + '</span><div class="recei-mess__inner">'
              + '<div class="recei-mess-list">'
              + '<div class="recei-mess">' + data.content.msg
              + '</div></div></div></div>'
    
    if(data.content.user_id == null){
      $('#chattings').append(senderr);
      $('#chattings_admin').append(receiverr);
    }else{
      $('#chattings').append(receiverr);
      $('#chattings_admin').append(senderr);
    }

    var element = document.getElementById("scroll_div");
    $('#scroll_div').animate({scrollTop: (element.scrollHeight-element.clientHeight)},"fast");

    
  
    // Called when there's incoming data on the websocket for this channel
    // $('#chattings').html("<%= j render 'messages/message_list' %>");
    // $('#chattings_admin').html("<%= j render 'messages/admin_message_list' %>");
    // location.reload();
  }
});
