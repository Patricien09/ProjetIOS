//
//  ContentView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var grid: MinesweeperGrid
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<grid.getHeight()) { line in
                HStack(spacing: 1) {
                    ForEach(0..<grid.getWidth()) { col in
                        MinesweeperCellView(line: line, col: col)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MinesweeperGrid(mineRate: 0.2, width: 10, height: 10))
    }
}
