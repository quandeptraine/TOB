import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var tab = 0
    var body: some View {
        TabView(selection: $tab) {
            DashboardView().tabItem { Label("Trang chủ", systemImage: "house.fill") }.tag(0)
            ExerciseLibraryView().tabItem { Label("Bài tập", systemImage: "figure.strengthtraining.traditional") }.tag(1)
            WorkoutBuilderView().tabItem { Label("Workout", systemImage: "list.bullet.clipboard") }.tag(2)
            ProgressView().tabItem { Label("Tiến độ", systemImage: "chart.xyaxis.line") }.tag(3)
        }
        .tint(.orange)
    }
}

struct DashboardView: View {
    @Query(sort: \WorkoutSession.date, order: .reverse) private var sessions: [WorkoutSession]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("GymCalorie").font(.largeTitle.bold())
                    Text("V7 • Workout smarter").foregroundStyle(.secondary)
                    HStack {
                        StatCard(title:"Buổi tập", value:"\(sessions.count)", icon:"flame.fill")
                        StatCard(title:"Tuần này", value:"\(sessions.filter{$0.date > Calendar.current.date(byAdding:.day,value:-7,to:Date())!}.count)", icon:"calendar")
                    }
                    NavigationLink { CalorieCalculatorView() } label: {
                        HStack { Image(systemName:"bolt.fill").font(.title2); VStack(alignment:.leading){Text("Tính calo").font(.headline);Text("BMR • TDEE • Calo tập").font(.caption).foregroundStyle(.secondary)}; Spacer(); Image(systemName:"chevron.right") }
                        .padding().background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius:18))
                    }
                }.padding()
            }.navigationTitle("Hôm nay")
        }
    }
}

struct StatCard: View {
    let title:String; let value:String; let icon:String
    var body: some View { VStack(alignment:.leading){Image(systemName:icon);Text(value).font(.title.bold());Text(title).font(.caption).foregroundStyle(.secondary)}.frame(maxWidth:.infinity,alignment:.leading).padding().background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius:16)) }
}

struct ExerciseLibraryView: View {
    @State private var search = ""
    @State private var muscle: MuscleGroup?
    var filtered: [Exercise] { exerciseLibrary.filter { (search.isEmpty || $0.name.localizedCaseInsensitiveContains(search)) && (muscle == nil || $0.muscle == muscle) } }
    var body: some View {
        NavigationStack {
            List {
                ScrollView(.horizontal, showsIndicators:false) { HStack { Button("Tất cả"){muscle=nil}; ForEach(MuscleGroup.allCases){ m in Button(m.rawValue){muscle=m} } } }
                ForEach(filtered) { e in NavigationLink { ExerciseDetailView(exercise:e) } label: {
                    HStack { Image(systemName:"figure.strengthtraining.traditional").frame(width:36); VStack(alignment:.leading){Text(e.name).font(.headline);Text("\(e.muscle.rawValue) • \(e.equipment) • \(e.level)").font(.caption).foregroundStyle(.secondary)} }
                }}
            }.navigationTitle("Bài tập (\(filtered.count))").searchable(text:$search,prompt:"Tìm bài tập")
        }
    }
}

struct ExerciseDetailView: View {
    let exercise: Exercise
    var body: some View {
        ScrollView {
            VStack(alignment:.leading,spacing:18) {
                RoundedRectangle(cornerRadius:24).fill(.thinMaterial).frame(height:230).overlay(VStack(spacing:10){Image(systemName:"play.circle.fill").font(.system(size:60));Text("Video người thật / 3D").font(.headline);Text("Gắn MP4 hoặc URL được cấp phép vào exercise").font(.caption).foregroundStyle(.secondary)})
                Text(exercise.name).font(.largeTitle.bold())
                Text("\(exercise.muscle.rawValue) • \(exercise.equipment) • \(exercise.level)").foregroundStyle(.secondary)
                Label("\(exercise.sets) sets • \(exercise.reps) reps",systemImage:"repeat")
                Text("Hướng dẫn").font(.title2.bold())
                Text("Giữ core ổn định, kiểm soát cả pha xuống và lên, không dùng đà. Điều chỉnh mức tạ để kỹ thuật luôn đúng.")
                Text("Lỗi thường gặp").font(.title2.bold())
                Text("Không khởi động đủ, chọn tạ quá nặng hoặc rút ngắn biên độ chuyển động.")
            }.padding()
        }.navigationTitle("Chi tiết").navigationBarTitleDisplayMode(.inline)
    }
}

struct WorkoutBuilderView: View {
    @State private var selected: [Exercise] = []
    @State private var showLibrary = false
    var body: some View {
        NavigationStack {
            List {
                Section("Workout hôm nay") {
                    if selected.isEmpty { Text("Chưa có bài. Bấm + để thêm.") }
                    ForEach(selected) { e in Text(e.name) }
                        .onDelete { selected.remove(atOffsets:$0) }
                }
            }
            .navigationTitle("Workout Builder")
            .toolbar { Button {showLibrary=true} label:{Image(systemName:"plus")} }
            .sheet(isPresented:$showLibrary) { NavigationStack { List(exerciseLibrary){e in Button(e.name){selected.append(e);showLibrary=false}}.navigationTitle("Thêm bài")} }
        }
    }
}

struct ProgressView: View {
    @Query(sort:\ExerciseLog.date,order:.reverse) private var logs:[ExerciseLog]
    var body: some View {
        NavigationStack {
            List {
                Section("Lịch sử set") {
                    ForEach(logs) { l in HStack{Text(l.exerciseName);Spacer();Text("\(Int(l.weight))kg × \(l.reps)").monospaced();Text("\(Int(l.volume))").foregroundStyle(.orange)} }
                }
            }.navigationTitle("Tiến độ")
        }
    }
}

struct CalorieCalculatorView: View {
    @State private var weight = 70.0
    @State private var minutes = 60.0
    @State private var met = 6.0
    var calories: Double { met * 3.5 * weight / 200 * minutes }
    var body: some View {
        Form {
            Section("Thông số") {
                HStack{Text("Cân nặng");Spacer();TextField("kg",value:$weight,format:.number).keyboardType(.decimalPad)}
                HStack{Text("Thời gian");Spacer();TextField("phút",value:$minutes,format:.number).keyboardType(.decimalPad)}
                HStack{Text("MET");Spacer();TextField("",value:$met,format:.number).keyboardType(.decimalPad)}
            }
            Section("Ước tính") { Text("\(Int(calories)) kcal").font(.largeTitle.bold()).foregroundStyle(.orange); Text("Đây là ước tính, không phải phép đo y tế chính xác.") }
        }.navigationTitle("Tính calo")
    }
}
