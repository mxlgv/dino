using Dino;
using Dino.Entities;
using Xmpp;

namespace Dino.Plugins.MacNotification {

public class MacNotificationProvider : NotificationProvider, Object {
    private StreamInteractor stream_interactor;
    private Dino.Application app;

    public MacNotificationProvider(Dino.Application app) {
        this.stream_interactor = app.stream_interactor;
        this.app = app;
    }

    private void send_notification(string? message) {
        if (message == null) {
            return;
        }

        try {
            // FIXME: unsafe
            string[] spawn_args = {"terminal-notifier", "-title", "Dino", "-message", message, "-sound", "default"};
            string[] spawn_env = Environ.get ();
            Pid child_pid;
    
            Process.spawn_async ("/",
                spawn_args,
                spawn_env,
                SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
                null,
                out child_pid);
    
            ChildWatch.add (child_pid, (pid, status) => {
                // Triggered when the child indicated by child_pid exits
                Process.close_pid (pid);
            });
    
        } catch (SpawnError e) {
            print ("Error: %s\n", e.message);
        }
    }

    public double get_priority() {
        return 2.0;
    }

    public async void notify_message(Message message, Conversation conversation,
        string conversation_display_name, string? participant_display_name) {
        // FIXME: unsafe
        // send_notification(message.body);
        send_notification("New message");
    }

    public async void notify_file(FileTransfer file_transfer, Conversation conversation, bool is_image, string conversation_display_name, string? participant_display_name) {
        warning("TODO: notify file");
    }

    public async void notify_call(Call call, Conversation conversation, bool video, bool multiparty, string conversation_display_name) {
        // FIXME: unsafe
        //  send_notification("Call from " + conversation_display_name);
        send_notification("New call");
    }

    public async void retract_call_notification(Call call, Conversation conversation) {
        warning("TODO: retract call notification");
    }

    public async void notify_dialing() {
        warning("TODO: notify dialing");
    }

    public async void retract_dialing() {
        warning("TODO: retract dialing");
    }

    public async void notify_subscription_request(Conversation conversation) {
        // FIXME: unsafe
        // send_notification("New contact request from " + conversation.counterpart.to_string());
        send_notification("New contact request");
    }

    public async void notify_connection_error(Account account, ConnectionManager.ConnectionError error) {
        warning("TODO: notify connection error");
    }

    public async void notify_muc_invite(Account account, Jid room_jid, Jid from_jid, string inviter_display_name) {
        string display_room = room_jid.bare_jid.to_string();

        // FIXME: unsafe
        // string body = inviter_display_name + " invited you to " + display_room;
        send_notification("New invite");

        Conversation group_conversation = stream_interactor.get_module(ConversationManager.IDENTITY).create_conversation(
            room_jid, account, Conversation.Type.GROUPCHAT);
        GLib.Application.get_default().activate_action("open-muc-join", new Variant.int32(group_conversation.id));
    }

    public async void notify_voice_request(Conversation conversation, Jid from_jid) {
        warning("TODO: notify voice request");
    }

    public async void retract_content_item_notifications() {
        warning("TODO: retract content item notifications");
    }

    public async void retract_conversation_notifications(Conversation conversation) {
        warning("TODO: retract conversation notifications");
    }
}

}