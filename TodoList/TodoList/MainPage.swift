//
//  HomepageView.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.
//

import SwiftUI
import UIKit
import CoreData

struct MainPageView: View {
    @ObservedObject private var manager = RequestHandle()
    @State var bakToMain : Bool = false
    // Create timer to check for group task update
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingAlert = false
    @State private var postInterval = 3
    @State private var postCount = 0
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                HStack{
                    Text("My TodoList")
                        .bold()
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: UserDetailView()){
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .foregroundColor(Color.orange)
                    }
                }
                Text("Overview")
                    .bold()
                    .font(.title2)
                Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack{
                    
                    List{
                        let max = manager.taskList.count > 4 ? 4 : manager.taskList.count
                        ForEach(0..<max, id: \.self) { idx in
                            if manager.taskList[idx].isfinish == false{
                                NavigationLink(destination: TaskDetail(task: manager.taskList[idx])) {
                                    TaskRow(task: manager.taskList[idx])
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.all, -40.0)
                    .navigationBarTitle("Tasks")
                    .listRowInsets(EdgeInsets())
                    .navigationBarHidden(true)
                    .frame(height: 180)
                    .onAppear(perform: {
                        manager.getUserData()
                        manager.getTaskList()
                    })
                }
                .padding(5.0)
                
                VStack (alignment: .leading){
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack{
                        NavigationLink(destination: AddTask()) {
                           Text("New Task")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        NavigationLink(destination: TaskList()) {
                           Text("View All")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    Text("Statistics")
//                        .bold()
//                        .font(.title2)
                    HStack{
                        NavigationLink(destination: ShowFriends()) {
                           Text("See Friends")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        Spacer()
                        NavigationLink(destination: RankingListView()) {
                           Text("See Ranking")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Main page")
            .navigationBarHidden(true)
            .padding(.horizontal)
            .padding(.top)
        }
        .frame(width: .infinity, height: .infinity, alignment: .topLeading)
        .navigationBarTitle(Text("Main page"))
        .navigationBarHidden(true)
        .onAppear(perform: {
            manager.getUserData()
            manager.getTaskList()
        })
        .onReceive(timer) { time in
            self.postCount += 1
            // Change check post request frequency based on battery level.
            if checkBatteryLevel() < 0.3 && checkBatteryLevel() > 0.1 {
               postInterval = 10
            }else if checkBatteryLevel() > 0.3{
                postInterval = 3
            }else{
                postInterval = 1000
            }
            
            if postCount % postInterval == 0{
                manager.getGroupTaskState()
                if manager.inviteToGroupTask == true{
                    showingAlert = true
                }
            }
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("You are invited to task "+manager.tmpRetTask.title),
                              message: Text("If you accept, please go to this task to start."),
                              dismissButton: .default(Text("OK")))
        }
    }

}

//struct MainPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainPageView()
//    }
//}
