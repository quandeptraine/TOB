import SwiftUI
import SwiftData

@main
struct GymCalorieV7App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [WorkoutSession.self, ExerciseLog.self, BodyMetric.self, FoodLog.self])
    }
}
