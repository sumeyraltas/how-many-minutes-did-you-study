//
//  ContentView.swift
//  how-many-minutes-did-you-study
//
//  Created by Sumeyra Altas on 7.11.2023.
//
import SwiftUI

struct ContentView: View {
    @State private var isTracking = false
    @State private var workedTime: TimeInterval = 0
    @State private var lastWorkedTime: TimeInterval = 0
    @State private var startTime: Date?
    @State private var endTime: Date?
    @State private var isWorkPeriod = true
    let rotation: Double = 360
       let duration: Double = 60
    var body: some View {
        VStack {
            Spacer()
            Text("Total Elapsed Time:").font(.largeTitle)
                .fontWeight(.medium)
            Text(isWorkPeriod ?  "\(formatTimeInterval(workedTime))" : " \(formatTimeInterval(lastWorkedTime))")
                .font(.system(size: 65, weight: .medium))
                .padding()
                
            Spacer()
            if !isTracking {
                HStack {
    
                    Spacer()
                    Button(action: {
                        startTracking()
                    }) {
                        Text("Start")
                            .font(.title)
                    }
                    Spacer()
                    Button(action: {
                        endTracking()
                    }) {
                        Text("End")
                            .font(.title)
                    }
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    Button(action: {
                        stopTracking()
                    }) {
                        Text("Stop")
                            .font(.title)
                    }
                    Spacer()
                    Button(action: {
                        endTracking()
                    }) {
                        Text("End")
                            .font(.title)
                    }
                    Spacer()
                }
            }
        }
    }

    func startTracking() {
        isTracking = true
        startTime = Date()

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if isTracking {
                workedTime = lastWorkedTime + Date().timeIntervalSince(startTime!)
            } else {
                timer.invalidate()
            }
        }
    }

    func stopTracking() {
        isTracking = false
        lastWorkedTime = workedTime
    }

    func endTracking() {
        workedTime = 0
        lastWorkedTime = 0
        isTracking = false
    }
    
    func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        return formatter.string(from: interval) ?? ""
    }
}


#Preview {
    ContentView()
}
