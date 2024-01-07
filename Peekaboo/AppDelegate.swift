import Cocoa
import ServiceManagement

private enum Constant {
    static let browSize = CGSize(width: 184, height: 32)
    static let browCornerRadius: CGFloat = 10
    static let borderThickness: CGFloat = 4
    static let borderRadius = browCornerRadius + borderThickness

    static let windowSize = CGSize(
        width: browSize.width + borderThickness * 2,
        height: browSize.height + borderThickness
    )
}

class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Private Properties

    private var window: NSWindow!
    private let startAtLoginService = StartAtLoginService()

    // MARK: - Internal Methods

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupWindow()
        startAtLoginService.enableStartAtLogin()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }

    // MARK: - Private Methods

    private func setupWindow() {
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
        window.collectionBehavior = [.stationary, .transient, .fullScreenAuxiliary, .ignoresCycle, .canJoinAllSpaces]

        if #available(macOS 13.0, *) {
            window.collectionBehavior.insert(.auxiliary)
        }

        window.level = .statusBar
        window.contentView = ContentView()
        window.backgroundColor = .clear

        // Brow size is 184x32

        let screenSize = NSScreen.main?.frame.size ?? .zero
        let size = Constant.windowSize
        let origin = NSPoint(x: (screenSize.width - size.width) / 2, y: screenSize.height - size.height)
        window.setFrame(NSRect(origin: origin, size: size), display: true)

        window.orderFront(nil)
    }

}

private final class ContentView: NSView {
    private var trackingArea: NSTrackingArea?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        wantsLayer = true
        layer?.cornerRadius = Constant.borderRadius
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
