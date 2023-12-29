import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: .zero,
            styleMask: [.borderless, .hudWindow, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        #if DEBUG
        window.isMovableByWindowBackground = true
        #endif

        window.hasShadow = false
        window.collectionBehavior = [.auxiliary, .stationary, .transient, .fullScreenNone, .ignoresCycle]
        window.level = .statusBar
        window.contentView = ContentView()
        window.backgroundColor = .clear

        // Brow size is 184x32

        let screenSize = NSScreen.main?.frame.size ?? .zero
        let size = CGSize(width: 192, height: 36)
        let origin = NSPoint(x: (screenSize.width - size.width) / 2, y: screenSize.height - size.height)
        window.setFrame(NSRect(origin: origin, size: size), display: true)

        window.orderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}

private final class ContentView: NSView {
    private var trackingArea: NSTrackingArea?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        wantsLayer = true
        layer?.cornerRadius = 14
        layer?.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if let trackingArea {
            removeTrackingArea(trackingArea)
        }

        let trackingArea = makeTrackingArea()
        addTrackingArea(trackingArea)
        self.trackingArea = trackingArea
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)

        layer?.backgroundColor = NSColor.controlAccentColor.cgColor
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)

        layer?.backgroundColor = nil
    }

    private func makeTrackingArea() -> NSTrackingArea {
        NSTrackingArea(
            rect: bounds,
            options: [.activeAlways, .mouseEnteredAndExited],
            owner: self
        )
    }
}
