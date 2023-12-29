import AppKit

final class PeekabooWindow: NSWindow {
    override init(
        contentRect: NSRect,
        styleMask style: NSWindow.StyleMask,
        backing backingStoreType: NSWindow.BackingStoreType,
        defer flag: Bool
    ) {
        let style: NSWindow.StyleMask = [.borderless, .hudWindow, .nonactivatingPanel]

        super.init(
            contentRect: contentRect,
            styleMask: style,
            backing: backingStoreType,
            defer: flag
        )

        isMovableByWindowBackground = true
        hasShadow = false
        collectionBehavior = [.auxiliary, .stationary, .transient, .fullScreenNone, .ignoresCycle]
        level = .statusBar
    }
}
