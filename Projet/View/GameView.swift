//
//  GameView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/15/23.
//

import SwiftUI
import PopupView

struct GameView: View {
    @StateObject var grid = MinesweeperGrid(mineRate: 0.12, width: 10, height: 16)
    @State private var startDate = Date()
    @State private var timeElapsed: String = "0.0"
    @State private var timer: Timer? = nil
    @State private var selectedDifficulty: Difficulty = .inter
    
    @State var showingVictoryPopup: Bool = false
    @State var showingLoosePopup: Bool = false
    
    var body: some View {
        NavigationView {
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
                
                Button(action: {}) {
                    Image(getClickTypeImageName())
                        .onTapGesture {
                            changeClickType()
                        }
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
                    .closeOnTap(false)
                    .backgroundColor(.gray.opacity(0.5))
            }
        }
        .navigationBarTitle("Démineur")
    }
    
    func changeClickType() {
        grid.changeClickType()
    }
    
    func getClickTypeImageName() -> String {
        var imageName = ""
        switch grid.getClickType() {
            case .empty:
                imageName = "normal"
            case .flag:
                imageName = "flag"
            case .questionMark:
                imageName = "question_mark"
        }
        return imageName
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
