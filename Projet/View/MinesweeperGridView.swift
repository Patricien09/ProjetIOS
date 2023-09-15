//
//  ContentView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import SwiftUI

struct MinesweeperGridView: View {
    @EnvironmentObject var grid: MinesweeperGrid
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<grid.getHeight()) { line in
                HStack(spacing: 0) {
                    ForEach(0..<grid.getWidth()) { col in
                        MinesweeperCellView(cell: grid.getCell(line: line, col: col))
                    }
                }
            }
        }
    }
}
