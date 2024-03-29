//
//  AddTaskStructure.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/20.
//

import Foundation
import SwiftUI
import CoreLocation

struct AddTaskStructure : Hashable, Codable, Identifiable {
    var id : UUID
    var creatorid : UUID
    var title: String
    var description: String
    var duration: Int
    var remaintime: Int
    var typestr: String
    var isfinish: Bool
    var isgrouptask: Bool
    var member: [String]
    
    init(){
        title = ""
        creatorid = localUserData.id
        id = UUID()
        description = ""
        duration = 60
        remaintime = 60
        typestr = ""
        isfinish = false
        isgrouptask = false
        member = []
    }
}
