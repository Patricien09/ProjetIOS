//
//  CellView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import SwiftUI

struct MinesweeperCellView: View {
    @EnvironmentObject var grid: MinesweeperGrid
    @State private var cellWidth = CGFloat(30)
    @State public var line: Int
    @State public var col: Int
    
    var body: some View {
        Button(action: cellTouched) {
            let cell = grid.getCell(line: line, col: col)
            let text = cell.getIsMine() ? "M" : String(cell.getNoNeighboursMines())
            Text("\(text)")
                .foregroundColor(Color.white)
        }
        .frame(width: cellWidth, height: cellWidth)
        .background(Color.black)
    }
    
    func cellTouched() {
        grid.clickCell(line: line, col: col)
    }
}
