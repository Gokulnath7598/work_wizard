import Foundation

class ApiService {
    static let host: String = "https://rnnmj-106-195-37-59.a.free.pinggy.link"
    static let scope: String = "api/v1"
    static let baseUrl: String = host + "/" + scope
    static var authorizationToken: String = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImRmOGIxNTFiY2Q5MGQ1YjMwMjBlNTNhMzYyZTRiMzA3NTYzMzdhNjEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiWWF6aGluaSBNYWxhciBQYXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dvcmstd2l6YXJkLWJmOTc5IiwiYXVkIjoid29yay13aXphcmQtYmY5NzkiLCJhdXRoX3RpbWUiOjE3MTg4ODE5MTIsInVzZXJfaWQiOiJvRnR2RjZlcUtsWkZwak1UTkd3N0JsTEI2TDgyIiwic3ViIjoib0Z0dkY2ZXFLbFpGcGpNVE5HdzdCbExCNkw4MiIsImlhdCI6MTcxODg4MTkxMiwiZXhwIjoxNzE4ODg1NTEyLCJlbWFpbCI6InlhemhpbmkubWFsYXJAcm9vdHF1b3RpZW50LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJtaWNyb3NvZnQuY29tIjpbImE1ZDIxMWQ2LWJjNTgtNDcwOS1iZmIzLTI4MWMwZWU4NzFkMCJdLCJlbWFpbCI6WyJ5YXpoaW5pLm1hbGFyQHJvb3RxdW90aWVudC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJtaWNyb3NvZnQuY29tIn19.FhukiFygrGKWZTFYZXysZOcQL1pYJmoW3OZ4FXN1LsC36QnzaNkp3hCABivt4KU5oi58jgbf5-Hmb-SWg2__G7pFgpG2fQc-j6eB4HYzYFdvAnuS1ENqbqNLvG7xYGYGACSv2QpMdjZO4Z-gjyRjbDWFke7F-Yf6wYEdUgPph1xMvRa2ZMKDQMTpFCOqHTvEP6I9BTxjEqHyUOSYUNneY5_MJ3rpOMup8KovqPG2l1-0QoEFC1NzD9WF7wF4RMYzh02tnoG0joLB-H1HKyg7KaUXjC-G9vAJjJgd4-tRpGBw1Tc2HL0Tk4u0587JRCJOKDepKW8vpxAg4qM-r4zl5Q"

    static func getAllProjects() async throws -> Projects? {
        let url = URL(string: baseUrl + "/project_management/all_projects")
        if url != nil {
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.setValue("Basic \(authorizationToken)", forHTTPHeaderField: "Authorization")

            let (data, _) = try await URLSession.shared.data(for: request)

            return try JSONDecoder().decode(Projects.self, from: data)
        }
        return nil
    }

    // Synchronous version for macOS 10.15
    static func getAllProjectsSync() throws -> Projects? {
        let url = URL(string: baseUrl + "/project_management/all_projects")
        if url != nil {
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.setValue("Basic \(authorizationToken)", forHTTPHeaderField: "Authorization")

            let (data, response, error) = URLSession.shared.syncRequest(with: request)

            if let error = error {
                throw error
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }

            return try JSONDecoder().decode(Projects.self, from: data)
        }
        return nil
    }

    static func createTask(data: TaskData) async throws -> TaskResponseModel? {
        let url = URL(string: baseUrl + "/task_management/task")
        if url != nil {
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = try JSONEncoder().encode(data)
            request.setValue("Basic \(authorizationToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(TaskResponseModel.self, from: data)
        }
        return nil
    }
}

// Extension to add synchronous request capability to URLSession
extension URLSession {
    func syncRequest(with request: URLRequest) -> (Data, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)

        let task = self.dataTask(with: request) { (responseData, urlResponse, responseError) in
            data = responseData
            response = urlResponse
            error = responseError
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        return (data ?? Data(), response, error)
    }
}
