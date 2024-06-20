import Cocoa
import FlutterMacOS
import SwiftUI

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    var overlayWindow: NSWindow?

    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        let flutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "overlay_channel", binaryMessenger: flutterViewController.engine.binaryMessenger)
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "showOverlay" {
                self.showOverlay()
                result(nil)
            } else if call.method == "closeOverlay" {
                self.closeOverlay()
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        // Ensure the main window supports fullscreen
        if let window = mainFlutterWindow {
            window.styleMask.insert([.titled, .closable, .resizable, .miniaturizable, .fullSizeContentView])
            window.collectionBehavior.insert(.fullScreenPrimary)
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true

            // Automatically enter fullscreen
            window.toggleFullScreen(nil)
        }

        super.applicationDidFinishLaunching(aNotification)
    }

    func showOverlay() {
        if overlayWindow == nil {
            let overlayContentRect = NSRect(x: 100, y: 100, width: 200, height: 150) // Adjusted height for the close button
            overlayWindow = NSWindow(contentRect: overlayContentRect,
                                     styleMask: [.borderless],
                                     backing: .buffered, defer: false)
            overlayWindow?.isOpaque = false
            overlayWindow?.backgroundColor = NSColor.clear
            overlayWindow?.level = .floating
            overlayWindow?.ignoresMouseEvents = false
            overlayWindow?.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

            let draggableView = DraggableNSView(frame: overlayContentRect)
            let contentView = NSHostingView(rootView: OverlayContentView(closeOverlay: closeOverlay))
            contentView.frame = draggableView.bounds
            contentView.autoresizingMask = [.width, .height]

            draggableView.addSubview(contentView)
            overlayWindow?.contentView = draggableView
        }

        overlayWindow?.makeKeyAndOrderFront(nil)
        overlayWindow?.orderFrontRegardless()
    }

    func closeOverlay() {
        overlayWindow?.orderOut(nil)
        overlayWindow = nil
    }
}

struct OverlayContentView: View {
    let closeOverlay: () -> Void // Callback to close the overlay

    init(closeOverlay: @escaping () -> Void) {
        self.closeOverlay = closeOverlay
    }

    var body: some View {
        VStack {
            Text("Overlay Widget")
                .foregroundColor(.white)
                .frame(width: 200, height: 100)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
        }
    }
}

class DraggableNSView: NSView {
    var initialLocation: NSPoint?

    override func mouseDown(with event: NSEvent) {
        initialLocation = event.locationInWindow
    }

    override func mouseDragged(with event: NSEvent) {
        guard let window = self.window, let initialLocation = self.initialLocation else { return }
        
        let currentLocation = event.locationInWindow
        let newOrigin = NSPoint(
            x: window.frame.origin.x + (currentLocation.x - initialLocation.x),
            y: window.frame.origin.y + (currentLocation.y - initialLocation.y)
        )

        window.setFrameOrigin(newOrigin)
    }
}