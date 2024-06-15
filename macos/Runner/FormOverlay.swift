import SwiftUI

struct FormOverlay: View {
    @State private var taskDescription: String = ""
    @State private var selectedProject: Int?
    @State private var isTaskCompleted: Bool = false
    @State private var taskDurationInHrs: String = ""

    @State private var projectsResult: Projects?
    @State private var fetchAllProductsLoading: Bool?
    @State private var createTaskLoading: Bool?

    let closeOverlay: () -> Void

    var body: some View {
        ZStack {
            Image("OverlayBackground")
                .frame(maxWidth: 400, maxHeight: 400, alignment: .topLeading)
            ScrollView(.vertical) {
                Rectangle().fill(Color.clear).frame(height: 36)

                if #available(macOS 12.0, *) {
                    DropdownFieldView(prompt: "Projects", dropDownOptions: projectsResult?.projects?.compactMap { $0.name } ?? [], isLoading: fetchAllProductsLoading, selectedItemIndex: $selectedProject).padding(.bottom, 12.0).padding(.horizontal, 40.0).task {
                        do {
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
                } else {
                    DropdownFieldView(
                                           prompt: "Projects",
                                           dropDownOptions: projectsResult?.projects?.compactMap { $0.name } ?? [],
                                           isLoading: fetchAllProductsLoading,
                                           selectedItemIndex: $selectedProject
                                       )
                                       .padding(.bottom, 12.0)
                                       .padding(.horizontal, 40.0)
                                       .onAppear {
                                           fetchAllProductsLoading = true
                                           DispatchQueue.global().async {
                                               do {
                                                   let result = try ApiService.getAllProjectsSync()
                                                   DispatchQueue.main.async {
                                                       self.projectsResult = result
                                                       self.fetchAllProductsLoading = false
                                                       print("----> FETCH ALL PROJECTS SUCCESS")
                                                   }
                                               } catch {
                                                   DispatchQueue.main.async {
                                                       self.fetchAllProductsLoading = false
                                                       print("----> FETCH ALL PROJECTS ERROR")
                                                   }
                                               }
                                           }
                                       }
                }

                TextFieldView(value: $taskDescription, placeHolder: "Task").padding(.horizontal, 40.0).padding(.vertical, 12.0)

                HStack(spacing: 24, content: {
                    CustomButton(
                        buttonThemeColor: Color(hex: "#00A4EF"), label: "In Progress", isFilled: !isTaskCompleted, isLoading: nil
                    ) {
                        isTaskCompleted = false
                    }

                    CustomButton(
                        buttonThemeColor: Color(hex: "#00A4EF"), label: "Completed", isFilled: isTaskCompleted, isLoading: nil
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
                    Task {
                        if selectedProject != nil && !taskDescription.isEmpty && !taskDurationInHrs.isEmpty {
                            do {
                                let data = TaskData(
                                    projectId: selectedProject!,
                                    description: taskDescription,
                                    status: isTaskCompleted ? "completed" : "in_progress",
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
    convenience init(closeOverlay: @escaping () -> Void) {
        let contentView = NSHostingView(rootView: FormOverlay(closeOverlay: closeOverlay))
        let window = NSWindow(contentViewController: NSViewController())
        window.contentViewController?.view = contentView
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
