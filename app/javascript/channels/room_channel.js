import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the room!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Recieving:")
    console.log(data.content)
    $('#clist').append('<tr><td>' + data.content.name
    + '</td><td><a href="/super_admins/1/companies/'+data.content.id
    + '/approve_company">Approve</a></td><td><a href="/super_admins/1/companies/'
    + data.content.id+'/reject_company">Reject</a></td></tr>')
    $('#no_request').remove()
  }
});
