//
//  CellView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import SwiftUI

struct MinesweeperCellView: View {
    @EnvironmentObject var grid: MinesweeperGrid
    @ObservedObject public var cell: MinesweeperCell
    
    var body: some View {
        Button(action: {}) {
            Image(self.getImageName(cell: cell))
                .onTapGesture {
                    cellTouched()
                }
                .onLongPressGesture(minimumDuration: 0.1) {
                    longTouch()
                }
        }
        .frame(width: MinesweeperCell.cellWidth, height: MinesweeperCell.cellWidth)
    }
    
    func cellTouched() {
        grid.clickCell(cell: cell)
    }
    
    func longTouch() {
        grid.handleLongClick(cell: cell)
    }
    
    func getImageName(cell: MinesweeperCell) -> String {
        var imageName: String = ""
        
        if(cell.getClicked()) {
            imageName = cell.getIsMine() ? "mine" : String(cell.getNoNeighboursMines())
        } else {
            switch cell.state {
            case .empty:
                imageName = "not_clicked"
            case .flag:
                imageName = "flag"
            case .questionMark:
                imageName = "question_mark"
            }
        }
        return imageName
    }
}
