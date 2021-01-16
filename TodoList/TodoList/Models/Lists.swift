//
//  Lists.swift
//  TodoList
//
//  Created by Xizhen Huang on 16.01.21.
//

import Foundation

struct UserList: Decodable {
    var userResults: [UserDataStructure]
}

struct AllTaskList: Decodable{
    var taskResults: [TaskDataStructure]
}
