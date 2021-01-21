//
//  UserDataStructure.swift
//  TodoList2
//
//  Created by 陈子迪 on 2020/12/30.
//

import Foundation
import SwiftUI
import CoreLocation

struct UserDataStructure : Hashable, Codable, Identifiable {
    var id : Int
    var name: String
    var email: String
    var passwd: String
//    var totalFocusTime: Int
//    var friends: [Int]
    
    //FIXME: 
    init(){
        id      = 0;
        name    = "Jobs"
        email   = "jobs@apple.com"
        passwd  = "apple123"
    }
}