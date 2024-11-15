import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = WeatherPersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Main()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
