//
//  TaskData.swift
//  Runner
//
//  Created by Joshua Henry Sahayam S on 14/06/24.
//

import Foundation

struct TaskData : Codable{
    let projectId: Int
    let description: String
    let status: String
    let duration: String
    
    enum CodingKeys: String, CodingKey {
        case projectId
        case description = "task"
        case status
        case duration
    }
}
