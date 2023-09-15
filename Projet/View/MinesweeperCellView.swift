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
    @ObservedObject public var cell: MinesweeperCell
    
    var body: some View {
        Button(action: cellTouched) {
            let text = cell.getClicked() ? String(cell.getNoNeighboursMines()) : " "
            Text("\(text)")
                .foregroundColor(Color.white)
        }
        .frame(width: cellWidth, height: cellWidth)
        .background(Color.black)
    }
    
    func cellTouched() {
        grid.clickCell(cell: cell)
    }
}
