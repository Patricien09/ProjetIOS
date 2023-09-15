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
            if(cell.getClicked())
            {
                cell.getIsMine() ? Image("mine") : Image(String(cell.getNoNeighboursMines()))
            }
            else if(cell.state == CellState.empty)
            {
                Image("not_clicked")
            }
            else {
                cell.state == CellState.flag ? Image("flag") : Image("question_mark")
            }
        }
        .frame(width: cellWidth, height: cellWidth)
    }
    
    func cellTouched() {
        grid.clickCell(line: line, col: col)
    }
}
