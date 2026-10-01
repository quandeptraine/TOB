import Foundation
import SwiftData

@Model final class WorkoutSession {
    var id: UUID = UUID()
    var date: Date = Date()
    var title: String = ""
    var calories: Double = 0
    var volume: Double = 0
    var duration: Int = 0
    init(title: String, calories: Double = 0, volume: Double = 0, duration: Int = 0) {
        self.title = title; self.calories = calories; self.volume = volume; self.duration = duration
    }
}

@Model final class ExerciseLog {
    var id: UUID = UUID()
    var date: Date = Date()
    var exerciseName: String = ""
    var weight: Double = 0
    var reps: Int = 0
    var volume: Double { weight * Double(reps) }
    init(exerciseName: String, weight: Double, reps: Int) {
        self.exerciseName = exerciseName; self.weight = weight; self.reps = reps
    }
}

@Model final class BodyMetric {
    var date: Date = Date()
    var weight: Double = 0
    var bodyFat: Double = 0
    init(weight: Double, bodyFat: Double = 0) { self.weight = weight; self.bodyFat = bodyFat }
}

@Model final class FoodLog {
    var date: Date = Date()
    var name: String = ""
    var calories: Double = 0
    var protein: Double = 0
    init(name: String, calories: Double, protein: Double) {
        self.name = name; self.calories = calories; self.protein = protein
    }
}
