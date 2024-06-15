import Cocoa
import FlutterMacOS
import SwiftUI

var windowController: WindowController?

func showOverlay() {
    if windowController == nil {
        windowController = WindowController()
        windowController?.window?.makeKeyAndOrderFront(nil)
        windowController?.window?.orderFrontRegardless()
    }
}

func closeOverlay() {
    if windowController != nil {
        windowController?.window?.orderOut(nil)
        windowController?.window?.close()
        windowController = nil
    }
}

struct ContentView: View {
    @State private var taskDescription: String = ""
    @State private var selectedProject: Int?
    @State private var isTaskCompleted: Bool = false
    @State private var taskDurationInHrs: String = ""
    
    @State private var projectsResult: Projects?
    @State private var fetchAllProductsLoading: Bool?
    @State private var createTaskLoading: Bool?

    var body: some View {
        ZStack {
            Image("OverlayBackground")
                .frame(maxWidth: 400, maxHeight: 400, alignment: .topLeading)
            ScrollView(.vertical) {
                Rectangle().fill(Color.clear).frame(height: 36)
                
                DropdownFieldView(prompt: "Projects", dropDownOptions: projectsResult?.projects?.compactMap { $0.name } ?? [], isLoading: fetchAllProductsLoading, selectedItemIndex: $selectedProject).padding(.bottom, 12.0).padding(.horizontal, 40.0).task {
                    do{
                        fetchAllProductsLoading = true
                        print("----> FETCH ALL PROJECTS LOADING")
                        projectsResult = try await ApiService.getAllProjects()
                        print("----> FETCH ALL PROJECTS SUCCESS")
                        fetchAllProductsLoading = false
                    } catch {
                        print("----> FETCH ALL PROJECTS ERROR")
                        fetchAllProductsLoading = false
                    }
                }
                
                TextFieldView(value: $taskDescription, placeHolder: "Task").padding(.horizontal, 40.0).padding(.vertical, 12.0)
                
                HStack (spacing: 24, content: {
                    CustomButton(
                        buttonThemeColor: Color(hex: "#00A4EF"), label: "In Progress", isFilled: !isTaskCompleted, isLoading: nil
                    ) {
                        isTaskCompleted = false
                    }
                    
                    CustomButton(
                        buttonThemeColor: Color(hex: "#00A4EF"), label: " Completed", isFilled: isTaskCompleted, isLoading: nil
                    ) {
                        isTaskCompleted = true
                    }
                }).padding(.horizontal, 40.0).padding(.vertical, 12.0)
                
                NumericFieldView(
                    placeholder: "ETA", value: $taskDurationInHrs
                ).padding(.horizontal, 40.0).padding(.vertical, 12.0)
                
                CustomButton(
                    buttonThemeColor: Color(hex: "#00A4EF"), label: "Done", isFilled: true, isLoading: createTaskLoading
                ) {
                    Task{
                        if selectedProject != nil && !taskDescription.isEmpty && !taskDurationInHrs.isEmpty {
                            do{
                                let data = TaskData(
                                    projectId: selectedProject!,
                                    description: taskDescription,
                                    status: isTaskCompleted ? "completed" :"in_progress",
                                    duration: taskDurationInHrs
                                )
                                print("----> CREATE TASK LOADING")
                                createTaskLoading = true
                                let _ = try await ApiService.createTask(data: data)
                                print("----> CREATE TASK SUCCESS")
                                createTaskLoading = false
                                closeOverlay()
                            } catch {
                                print("----> CREATE TASK ERROR")
                                print(error)
                                createTaskLoading = false
                            }
                        }
                    }
                }.padding(.horizontal, 40)
                
                Rectangle().fill(Color.clear).frame(height: 36)
            }
        }
    }
}

class WindowController: NSWindowController {
    convenience init() {
        let contentView = ContentView()
        let hostingView = NSHostingView(rootView: contentView)
        let window = NSWindow(contentViewController: NSViewController())
        window.contentViewController?.view = hostingView
        window.backgroundColor = NSColor.white
        window.setContentSize(NSSize(width: 465, height: 410))
        window.setFrameOrigin(NSPoint(x: 0, y: 0))
        window.styleMask = [.titled]
        window.title = "Work Wizard"
        window.isOpaque = false
        window.level = .floating
        window.ignoresMouseEvents = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        self.init(window: window)
    }
}

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        let flutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "overlay_channel", binaryMessenger: flutterViewController.engine.binaryMessenger)
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "showOverlay" {
                showOverlay()
                result(nil)
            } else if call.method == "closeOverlay" {
                closeOverlay()
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        super.applicationDidFinishLaunching(aNotification)
    }
}

#Preview{
    ContentView()
}
