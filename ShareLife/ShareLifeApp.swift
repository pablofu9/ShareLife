//
//  ShareLifeApp.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI
import RealmSwift


let theAppConfig = loadAppConfig()

let atlasUrl = theAppConfig.atlasUrl

let app = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil))

@main
struct ShareLifeApp: SwiftUI.App {
    
    @StateObject var errorHandler = ErrorHandler(app: app)
    
 
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher(app: app)
                .environmentObject(errorHandler)
        }
    }
}

final class ErrorHandler: ObservableObject {
    @Published var error: Swift.Error?

    init(app: RealmSwift.App) {
        // Sync Manager listens for sync errors.
        app.syncManager.errorHandler = { syncError, syncSession in
            self.error = syncError
            
        }
    }
}
