//
//  ContentView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/15/23.
//

import SwiftUI
import PopupView

struct ContentView: View {
    @StateObject var grid = MinesweeperGrid(mineRate: 0.12, width: 10, height: 16)
    @State private var startDate = Date()
    @State private var timeElapsed: String = "0.0"
    @State private var timer: Timer? = nil
    @State private var selectedDifficulty: Difficulty = .inter
    
    @State var showingVictoryPopup: Bool = false
    @State var showingLoosePopup: Bool = false
    
    var body: some View {
        VStack {
            Text("\(timeElapsed)")
            
            Text("Mines restantes : \(grid.getNbMines())")
            
            DifficultyPickerView(selectedDifficulty: $selectedDifficulty)
            .onChange(of: selectedDifficulty) { test in
                resetGame()
                grid.setMineRate(newMineRate: selectedDifficulty.rawValue)
            }
            
            MinesweeperGridView()
                .environmentObject(grid)
                .onChange(of: grid.alreadyClicked) { isFirstClick in
                    if (isFirstClick) {
                        startTimer()
                    }
                }
                .onChange(of: grid.won) { didWon in
                    stopTimer()
                    showingVictoryPopup = didWon
                }
                .onChange(of: grid.loose) { didLoose in
                    stopTimer()
                    showingLoosePopup = didLoose
                }
            
            Button(action: resetGame) {
                Text("Recommencer")
            }
        }
        
        .popup(isPresented: $showingLoosePopup) {
            LooseView()
        } customize: {
            $0
                .isOpaque(true)
                .closeOnTapOutside(true)
                .backgroundColor(.gray.opacity(0.5))
        }
        
        .popup(isPresented: $showingVictoryPopup){
            VictoryView(time: timeElapsed)
        } customize: {
            $0
                .isOpaque(true)
                .closeOnTapOutside(true)
                .backgroundColor(.gray.opacity(0.5))
        }
    }
    
    func startTimer() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { tempTimer in
            timeElapsed = String(format: "%.1f", (Date().timeIntervalSince(startDate)))
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetGame() -> Void {
        grid.reset()
        timeElapsed = "0.0"
        stopTimer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
