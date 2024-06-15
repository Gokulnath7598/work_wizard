import Cocoa
import FlutterMacOS
import SwiftUI
import Lottie

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
    let closeOverlay: () -> Void

    init(closeOverlay: @escaping () -> Void) {
        self.closeOverlay = closeOverlay
    }

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                closeOverlay()
            }) {
                if #available(macOS 11.0, *) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .font(.title)
                } else {
                    
                }
            }
            .padding()
        }
        VStack {
            LottieView(filename: "cat_wizard_150.json")
        }
    }
}

    struct LottieView: NSViewRepresentable {
        var filename: String

        func makeNSView(context: Context) -> NSView {
            let view = NSView()

            let animationView = LottieAnimationView(name: filename)
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()

            animationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(animationView)

            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])

            return view
        }

        func updateNSView(_ nsView: NSView, context: Context) {
            
        }
    }


