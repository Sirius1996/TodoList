//
//  AddTask.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/9.
//

import CoreData
import SwiftUI
import UIKit

struct AddTask: View {

//    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var manager = RequestHandle()
    @State private var newTask = AddTaskStructure()
    @State private var addMember = false
    @State private var inputDuration: String = ""
    @State private var localMemList :[String] = []
    @State private var lostConnection = false

    var body: some View {
        VStack{
            VStack{
                TextField("Title", text: $newTask.title, onCommit: {})
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Description", text: $newTask.description, onCommit: {})
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            .padding()
            VStack (alignment: .leading){
                HStack{
                    Text("Duration").font(.title3).bold()
                    Spacer()
                }
                HStack{
                    TextField("Countdown duration",
                              text: $inputDuration)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("minutes")
                }
            }
            .padding()
            VStack{
                HStack{
                    Text("Member").font(.title3).bold()
                    Spacer()
                }
                List{
                    ForEach(localMemList, id: \.self) { mem in
                        Text(mem)
                    }
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onAppear()
                
                HStack{
                    Spacer().frame(width: 240)
                    Button(action: {
                        if Reachability.isConnectedToNetwork(){
                            addMember = true
                        } else{
                            lostConnection = true
                        }
                        
                    }) {
                        Text("Add member")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 120, maxWidth: 120, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    .alert(isPresented: $addMember,
                           TextAlert(title: "Add Member",
                                     message: "Enter member email") { result in
                            if let text = result {
                                // Text was accepted
                                if localMemList.contains(text) {
                                   // it exists, do nothing
                                } else {
                                   // item could not be found
                                    localMemList.append(text)
                                    newTask.member.append(text)
                                }
                            }
                        })
                    .alert(isPresented: $lostConnection) { () -> Alert in
                        Alert(title: Text("Network is not available :("), message: Text("you can't create group task now"))
                    }
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 30, maxWidth:.infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 10, maxHeight: 20, alignment: .topTrailing)
            }
            .padding()
            VStack{
                HStack{
                    Text("Type").font(.title3).bold()
                    Spacer()
                }
                TextField("Type", text: $newTask.typestr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            Spacer()
        }
            
        .navigationBarTitle("Add Task")
        .navigationBarItems(trailing:
            Button(action: {
                newTask.duration = Int(inputDuration) ?? 0
                self.manager.postAddTask(addTask: newTask)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            })
    }
}
