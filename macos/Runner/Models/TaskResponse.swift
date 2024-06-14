import Foundation

class TaskResponseModel: Decodable {
    let task: TaskResponse?
}

class TaskResponse : Decodable{
    let id: Int?
    let projectId: Int?
    let description: String?
    let status: String?
    let duration: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case projectId
        case description = "task"
        case status
        case duration
    }
}
