import Foundation

class ApiService {
    static let host: String = "https://354242ec-53f0-43bd-bbc0-30472b1e3181.mock.pstmn.io"
    static let scope: String = "api/v1"
    static let baseUrl: String = host + "/" + scope
    static var authorizationToken: String = ""

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
