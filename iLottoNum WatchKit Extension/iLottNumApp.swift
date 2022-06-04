//
//  iLottNumApp.swift
//  iLottoNum WatchKit Extension
//
//  Created by David Fekke on 6/4/22.
//

import SwiftUI

@main
struct iLottNumApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
