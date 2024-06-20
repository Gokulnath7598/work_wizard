import Cocoa
import FirebaseAuth
import FlutterMacOS
import SwiftUI
import FirebaseCore

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
      
    super.applicationDidFinishLaunching(aNotification)
  }

  func showOverlay() {
    if overlayWindow == nil {
      let overlayContentRect = NSRect(x: 100, y: 100, width: 200, height: 100)
      overlayWindow = NSWindow(contentRect: overlayContentRect,
                               styleMask: [.borderless],
                               backing: .buffered, defer: false)
      overlayWindow?.isOpaque = false
      overlayWindow?.backgroundColor = NSColor.clear
      overlayWindow?.level = .floating
      overlayWindow?.ignoresMouseEvents = false
      overlayWindow?.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
      
      let contentView = NSHostingView(rootView: OverlayContentView(closeOverlay: closeOverlay))
      overlayWindow?.contentView = contentView
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
      HStack {
                      Spacer()
                      Button(action: {
                          closeOverlay()
                      }) {
                          Image(systemName: "xmark.circle")
                              .foregroundColor(.white)
                              .font(.title)
                      }
                      .padding()
                  }
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
