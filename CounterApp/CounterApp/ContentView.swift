import SwiftUI

struct ContentView: View {
    @State private var count: Int = 0
    @State private var timeElapsed: Double = 0.0
    @State private var isRunning: Bool = false
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.2),
                    Color(red: 0.2, green: 0.1, blue: 0.3),
                    Color(red: 0.1, green: 0.2, blue: 0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 50) {
                VStack(spacing: 25) {
                    Text("SAYAÇ")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .tracking(3)
                    
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.blue.opacity(0.3),
                                        Color.purple.opacity(0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 150, height: 150)
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                        
                        Text("\(count)")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .scaleEffect(count > 0 ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: count)
                    
                    HStack(spacing: 25) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if count > 0 { count -= 1 }
                            }
                        }) {
                            Image(systemName: "minus")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.red.opacity(0.8), Color.pink.opacity(0.6)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                                .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .scaleEffect(count > 0 ? 1.0 : 0.8)
                        .animation(.easeInOut(duration: 0.2), value: count)
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                count = 0
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.secondary.opacity(0.6)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                                .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                count += 1
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.green.opacity(0.8), Color.mint.opacity(0.6)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                                .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                    }
                }
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.3), Color.clear]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 1)
                    .padding(.horizontal, 50)
                
                VStack(spacing: 25) {
                    Text("KRONOMETRE")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .tracking(3)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.orange.opacity(0.3),
                                        Color.yellow.opacity(0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 220, height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                        
                        Text(formattedTime())
                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                    }
                    .scaleEffect(isRunning ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: isRunning)
                    
                    HStack(spacing: 30) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if isRunning { stopTimer() } else { startTimer() }
                            }
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: isRunning ? "pause.fill" : "play.fill")
                                    .font(.title3)
                                Text(isRunning ? "Durdur" : "Başlat")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                            }
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: isRunning ?
                                                [Color.orange.opacity(0.8), Color.red.opacity(0.6)] :
                                                [Color.green.opacity(0.8), Color.blue.opacity(0.6)]
                                            ),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                            .shadow(color: (isRunning ? Color.orange : Color.green).opacity(0.4), radius: 15, x: 0, y: 8)
                        }
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                stopTimer()
                                timeElapsed = 0.0
                            }
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.clockwise")
                                    .font(.title3)
                                Text("Sıfırla")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                            }
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.secondary.opacity(0.6)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                            .shadow(color: Color.gray.opacity(0.4), radius: 15, x: 0, y: 8)
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 50)
        }
    }

    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            timeElapsed += 0.01
        }
    }

    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func formattedTime() -> String {
        let minutes = Int(timeElapsed) / 60
        let seconds = Int(timeElapsed) % 60
        let centiseconds = Int((timeElapsed * 100).truncatingRemainder(dividingBy: 100))
        return String(format: "%02d:%02d:%02d", minutes, seconds, centiseconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
