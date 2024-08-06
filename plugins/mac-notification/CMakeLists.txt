find_packages(MAC_NOTIFICATION_PACKAGES REQUIRED
    Gee
    GLib
    GModule
    GObject
    GDKPixbuf2
)

vala_precompile(MAC_NOTIFICATION_VALA_C
SOURCES
    src/plugin.vala
    src/mac_notification_provider.vala
    src/register_plugin.vala
CUSTOM_VAPIS
    ${CMAKE_BINARY_DIR}/exports/xmpp-vala.vapi
    ${CMAKE_BINARY_DIR}/exports/dino.vapi
    ${CMAKE_BINARY_DIR}/exports/qlite.vapi
PACKAGES
    ${MAC_NOTIFICATION_PACKAGES}
)

add_definitions(${VALA_CFLAGS})
add_library(mac-notification SHARED ${MAC_NOTIFICATION_VALA_C})
target_link_libraries(mac-notification libdino ${MAC_NOTIFICATION_PACKAGES})
set_target_properties(mac-notification PROPERTIES PREFIX "")
set_target_properties(mac-notification PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/plugins/)

install(TARGETS mac-notification ${PLUGIN_INSTALL})
