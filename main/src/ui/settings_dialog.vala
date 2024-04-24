using Gtk;
using Dino.Entities;

namespace Dino.Ui {

[GtkTemplate (ui = "/im/dino/Dino/settings_dialog.ui")]
class SettingsDialog : Adw.PreferencesWindow {

    [GtkChild] private unowned Switch typing_switch;
    [GtkChild] private unowned Switch marker_switch;
    [GtkChild] private unowned Switch notification_switch;
    [GtkChild] private unowned Switch emoji_switch;
    [GtkChild] private unowned CheckButton encryption_radio_undecided;
    [GtkChild] private unowned CheckButton encryption_radio_omemo;
    [GtkChild] private unowned CheckButton encryption_radio_openpgp;
    [GtkChild] private unowned Switch send_button_switch;
    [GtkChild] private unowned Switch enter_newline_switch;
#if ENABLE_SELECT_LANG
    [GtkChild] private unowned Adw.ComboRow select_lang_comborow;
    [GtkChild] private unowned Adw.PreferencesGroup select_lang_group;
#endif

    Dino.Entities.Settings settings = Dino.Application.get_default().settings;

    public SettingsDialog() {
        Object();

        typing_switch.active = settings.send_typing;
        marker_switch.active = settings.send_marker;
        notification_switch.active = settings.notifications;
        emoji_switch.active = settings.convert_utf8_smileys;
        encryption_radio_undecided.active = settings.default_encryption == Encryption.UNKNOWN;
        encryption_radio_omemo.active = settings.default_encryption == Encryption.OMEMO;
        encryption_radio_openpgp.active = settings.default_encryption == Encryption.PGP;

        send_button_switch.active = settings.send_button;
        enter_newline_switch.active = settings.enter_newline;
        enter_newline_switch.sensitive = settings.send_button;

        typing_switch.notify["active"].connect(() => { settings.send_typing = typing_switch.active; } );
        marker_switch.notify["active"].connect(() => { settings.send_marker = marker_switch.active; } );
        notification_switch.notify["active"].connect(() => { settings.notifications = notification_switch.active; } );
        emoji_switch.notify["active"].connect(() => { settings.convert_utf8_smileys = emoji_switch.active; });

        encryption_radio_undecided.notify["active"].connect(() => {
            if (encryption_radio_undecided.active) {
                settings.default_encryption = Encryption.UNKNOWN;
            }
        });

        encryption_radio_omemo.notify["active"].connect(() => {
            if (encryption_radio_omemo.active) {
                settings.default_encryption = Encryption.OMEMO;
            }
        });

        encryption_radio_openpgp.notify["active"].connect(() => {
            if (encryption_radio_openpgp.active) {
                settings.default_encryption = Encryption.PGP;
            }
        });

        send_button_switch.notify["active"].connect(() => { settings.send_button = send_button_switch.active; });
        enter_newline_switch.notify["active"].connect(() => { settings.enter_newline = enter_newline_switch.active; });
        settings.send_button_update.connect((visible) => {
            enter_newline_switch.sensitive = visible;

            if (visible == false) {
                enter_newline_switch.active = visible;
            }
        });

#if ENABLE_SELECT_LANG
        var lang_short_list = new Gee.ArrayList<string>();
        lang_short_list.add("en");
        lang_short_list.add("ru");

        select_lang_comborow.set_selected(lang_short_list.index_of(settings.ui_language));

        select_lang_comborow.notify["selected-item"].connect(() => {
            settings.ui_language = lang_short_list.get((int)select_lang_comborow.get_selected());
        });

        select_lang_group.visible = true;
#endif

    }
}

}
