import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import consumer from "../channels/consumer";

Rails.start()
Turbolinks.start()
ActiveStorage.start()


$(document).on('turbolinks:load', function () {
    console.log("V");

    $(".materialert > .close-alert").on('click', function () {
        $(this).parent().hide('fade-out');
    });

    $('.tooltipped').tooltip();

    $('.dropdown-trigger').dropdown();

    $(function() {
        $('#new_room_message').on('ajax:success', function(a, b, c) {
            $(this).find('input[type="text"]').val('');
        });
    });

    $(function() {
        $('[data-channel-subscribe="room"]').each(function(index, element) {
            var $element = $(element),
                room_id = $element.data('room-id')
            var messageTemplate = $('[data-role="message-template"]');
            var nameChannel = "RoomChannel";
            $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)
            console.log("Privet pk");
            consumer.subscriptions.create({ channel: nameChannel, room: room_id },{
                connected() {
                    console.log("Connected..");
                    console.log(room_id);
                },
                //Called when there's incoming data on the websocket for this channel
                received(data) {
                    console.log(data.content);
                    console.log('Received');
                    var content = messageTemplate.children().clone(true, true);
                    content.find('[data-role="name"]').text(data.name);
                    content.find('[data-role="message-text"]').text(data.content.message);
                    content.find('[data-role="message-date"]').text(data.content.updated_at);
                    $element.append(content);
                    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
                }
            });
        })
    })
});
