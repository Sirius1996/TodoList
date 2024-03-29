//
//  LoginView.swift
//  ToDoList
//
//  Created by Xizhen Huang on 06.01.21.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var manager = RequestHandle()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPwd = false
    @State private var isAuth = false
    @State private var showAlert = false

    var isCanLogin: Bool {
        email.count > 0 &&
        password.count > 0
    }

    var body: some View {
        NavigationView{
            VStack {
                // app name
                HStack{
                    Text("Focus List")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                }
                Spacer()
                    .frame(height: 100.0)
                
                // login input
                VStack(alignment: .center){
                    
                    // account Hstack
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(Color.orange)
                        TextField("email address", text: $email, onCommit: {})
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    }
                    Divider()
                        .padding(.top, 1.0)
                    Spacer()
                        .frame(height: 10.0)
                    
                    // password HStack
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(Color.orange)
                        if showPwd{
                            TextField("password", text: $password, onCommit: {})
                        } else{
                            SecureField("password", text: $password, onCommit: {})
                        }
                        
                        Button(action:{
                            self.showPwd.toggle()
                        }){
                            Image(systemName: self.showPwd ? "eye" : "eye.slash")
                        }
                    }
                }
                .padding(.all)
                .background(SwiftUI.Color.white)
                .cornerRadius(10)
                
                Spacer()
                    .frame(height: 15.0)
               
                NavigationLink(
                    destination:MainPageView(),
                    isActive: $isAuth){
                    Button(action: {
                        self.manager.postLoginRequest(email:self.email, passwd:self.password)
                        sleep(1)
                        if manager.lostConnection{
                            self.showAlert = true
                        }
                        if self.manager.authenticated == true {
                            UserDefaults.standard.set("1", forKey: "isLogin")
                            SceneDelegate.isLogin = true
                            isAuth = localAuth
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                    }
                    .frame(width: 300, height: 45, alignment: .center)
                    .background(isCanLogin ? Color.green : Color.gray)
                    .cornerRadius(20)
                    .disabled(!isCanLogin)
                    .alert(isPresented: $showAlert) { () -> Alert in
                        Alert(title: Text("Network is not available :("))
                    }
                }
                Spacer()
                
                // Register new account
                NavigationLink(destination: RegisterView()){
                    Text("No account? Register one!")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .underline()
                }
            }
            .navigationBarTitle("Login")
            .navigationBarHidden(true)
            .padding(.top, 80.0)
            .padding(.bottom, 20.0)
            .padding(.horizontal)
            .background(SwiftUI.Color.orange.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
