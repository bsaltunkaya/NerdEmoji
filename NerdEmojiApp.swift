//
//  NerdEmojiApp.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 3.05.2024.
//

import SwiftUI

@main
struct NerdEmojiApp: App {
    
      @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

      var body: some Scene {
        WindowGroup {
          MainView()
        }
    }
}
