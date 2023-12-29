import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 300),
            styleMask: [.borderless, .hudWindow, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        window.isMovableByWindowBackground = true
        window.hasShadow = false
        window.collectionBehavior = [.auxiliary, .stationary, .transient, .fullScreenNone, .ignoresCycle]
        window.level = .statusBar
        window.backgroundColor = .magenta
        window.center()
        window.orderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}
