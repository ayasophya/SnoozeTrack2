//
//  SnoozeTrack2App.swift
//  SnoozeTrack2
//
//  Created by DaZhuo Xie on 2023-12-14.
//

import SwiftUI
import Firebase

@main
struct SnoozeTrack2App: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
