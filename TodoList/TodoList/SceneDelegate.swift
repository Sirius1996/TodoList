//  TodoListApp.swift
//  TodoList
//
//  Created by 陈子迪 on 2020/12/30.

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    static var isLogin = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller
        if let windowScene = scene as? UIWindowScene {
            if SceneDelegate.isLogin == true{
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: MainPageView())
                self.window = window
                window.makeKeyAndVisible()
            }else{
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: LoginView())
                self.window = window
                window.makeKeyAndVisible()
            }

        }
    }

//    @IBAction func saveLoginTapped(_ sender: UIButton){
//        SceneDelegate.isLogin = true
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UIHostingController(rootView: MainPageView())
//        UIApplication.setRootView(LoginView.ins)
//    }
//
//    @IBAction func clearLoginTapped(_ sender: UIButton){
//        SceneDelegate.isLogin = false
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UIHostingController(rootView: LoginView())
//    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//        let _ = HandleLocalFile.createLocalFile()
//        let _ = localUserData = HandleLocalFile.loadUserJson()
//        if localUserData.email != ""{
//            SceneDelegate.isLogin = true
//        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

