namespace Dino.Plugins.MacNotification {

public class Plugin : RootInterface, Object {

    public Dino.Application app;

    public void registered(Dino.Application app) {
        this.app = app;

        app.stream_interactor.get_module(NotificationEvents.IDENTITY)
            .register_notification_provider(new MacNotificationProvider(app));
        info("Registered Mac Notification Provider plugin");
    }

    public void shutdown() { }
}

}
