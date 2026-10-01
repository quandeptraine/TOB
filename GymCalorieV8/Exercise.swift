import Foundation

enum MuscleGroup: String, CaseIterable, Identifiable {
    case chest = "Ngực", back = "Lưng", shoulders = "Vai", biceps = "Tay trước"
    case triceps = "Tay sau", legs = "Chân", glutes = "Mông", abs = "Bụng", cardio = "Cardio"
    var id: String { rawValue }
}

struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let muscle: MuscleGroup
    let equipment: String
    let level: String
    let sets: Int
    let reps: String
    let realVideoURL: String?
    let threeDVideoURL: String?
}

let exerciseLibrary: [Exercise] = {
    let data: [(String, MuscleGroup, String, String)] = [
        ("Barbell Bench Press",.chest,"Barbell","Trung bình"),("Incline Bench Press",.chest,"Barbell","Trung bình"),
        ("Dumbbell Bench Press",.chest,"Dumbbell","Trung bình"),("Incline Dumbbell Press",.chest,"Dumbbell","Trung bình"),
        ("Chest Fly",.chest,"Machine","Cơ bản"),("Cable Crossover",.chest,"Cable","Trung bình"),
        ("Push Up",.chest,"Bodyweight","Cơ bản"),("Decline Bench Press",.chest,"Barbell","Nâng cao"),
        ("Dumbbell Fly",.chest,"Dumbbell","Trung bình"),("Machine Chest Press",.chest,"Machine","Cơ bản"),
        ("Deadlift",.back,"Barbell","Nâng cao"),("Lat Pulldown",.back,"Cable","Cơ bản"),
        ("Pull Up",.back,"Bodyweight","Nâng cao"),("Assisted Pull Up",.back,"Machine","Cơ bản"),
        ("Barbell Row",.back,"Barbell","Nâng cao"),("Seated Cable Row",.back,"Cable","Cơ bản"),
        ("One Arm Dumbbell Row",.back,"Dumbbell","Cơ bản"),("Chest Supported Row",.back,"Machine","Cơ bản"),
        ("Straight Arm Pulldown",.back,"Cable","Cơ bản"),("T Bar Row",.back,"Machine","Trung bình"),
        ("Overhead Press",.shoulders,"Barbell","Trung bình"),("Dumbbell Shoulder Press",.shoulders,"Dumbbell","Cơ bản"),
        ("Arnold Press",.shoulders,"Dumbbell","Trung bình"),("Lateral Raise",.shoulders,"Dumbbell","Cơ bản"),
        ("Cable Lateral Raise",.shoulders,"Cable","Cơ bản"),("Front Raise",.shoulders,"Dumbbell","Cơ bản"),
        ("Rear Delt Fly",.shoulders,"Dumbbell","Cơ bản"),("Face Pull",.shoulders,"Cable","Cơ bản"),
        ("Barbell Curl",.biceps,"Barbell","Cơ bản"),("Dumbbell Curl",.biceps,"Dumbbell","Cơ bản"),
        ("Hammer Curl",.biceps,"Dumbbell","Cơ bản"),("Incline Dumbbell Curl",.biceps,"Dumbbell","Trung bình"),
        ("Preacher Curl",.biceps,"Machine","Cơ bản"),("Cable Curl",.biceps,"Cable","Cơ bản"),
        ("EZ Bar Curl",.biceps,"EZ Bar","Cơ bản"),("Concentration Curl",.biceps,"Dumbbell","Cơ bản"),
        ("Triceps Pushdown",.triceps,"Cable","Cơ bản"),("Overhead Triceps Extension",.triceps,"Cable","Cơ bản"),
        ("Skull Crusher",.triceps,"EZ Bar","Trung bình"),("Close Grip Bench Press",.triceps,"Barbell","Nâng cao"),
        ("Dumbbell Kickback",.triceps,"Dumbbell","Cơ bản"),("Bench Dip",.triceps,"Bodyweight","Cơ bản"),
        ("Squat",.legs,"Barbell","Trung bình"),("Front Squat",.legs,"Barbell","Nâng cao"),
        ("Leg Press",.legs,"Machine","Cơ bản"),("Leg Extension",.legs,"Machine","Cơ bản"),
        ("Leg Curl",.legs,"Machine","Cơ bản"),("Romanian Deadlift",.legs,"Barbell","Trung bình"),
        ("Walking Lunge",.legs,"Dumbbell","Cơ bản"),("Bulgarian Split Squat",.legs,"Dumbbell","Trung bình"),
        ("Hack Squat",.legs,"Machine","Trung bình"),("Calf Raise",.legs,"Machine","Cơ bản"),
        ("Hip Thrust",.glutes,"Barbell","Trung bình"),("Glute Bridge",.glutes,"Bodyweight","Cơ bản"),
        ("Cable Kickback",.glutes,"Cable","Cơ bản"),("Step Up",.glutes,"Dumbbell","Cơ bản"),
        ("Sumo Squat",.glutes,"Dumbbell","Cơ bản"),("Abduction Machine",.glutes,"Machine","Cơ bản"),
        ("Plank",.abs,"Bodyweight","Cơ bản"),("Crunch",.abs,"Bodyweight","Cơ bản"),
        ("Cable Crunch",.abs,"Cable","Cơ bản"),("Hanging Leg Raise",.abs,"Bodyweight","Trung bình"),
        ("Russian Twist",.abs,"Bodyweight","Cơ bản"),("Ab Wheel Rollout",.abs,"Wheel","Nâng cao"),
        ("Bicycle Crunch",.abs,"Bodyweight","Cơ bản"),("Dead Bug",.abs,"Bodyweight","Cơ bản"),
        ("Treadmill Walk",.cardio,"Treadmill","Cơ bản"),("Treadmill Run",.cardio,"Treadmill","Trung bình"),
        ("Incline Walk",.cardio,"Treadmill","Trung bình"),("Cycling",.cardio,"Bike","Cơ bản"),
        ("Rowing Machine",.cardio,"Rower","Trung bình"),("Elliptical",.cardio,"Machine","Cơ bản"),
        ("Stair Climber",.cardio,"Machine","Trung bình"),("Jump Rope",.cardio,"Rope","Trung bình")
    ]
    return data.map { Exercise(name:$0.0,muscle:$0.1,equipment:$0.2,level:$0.3,sets:3,reps:"8–12",realVideoURL:nil,threeDVideoURL:nil) }
}()
