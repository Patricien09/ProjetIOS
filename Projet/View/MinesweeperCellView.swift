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
    @State private var cellWidth = CGFloat(30)
    
    var body: some View {
        Button(action: {}) {
            let text = cell.getClicked() ? String(cell.getNoNeighboursMines()) : " "
            Text("\(text)")
                .foregroundColor(Color.white)
                .onTapGesture {
                    cellTouched()
                }
                .onLongPressGesture(minimumDuration: 0.1) {
                    print("Long tap")
                }
        }
        .frame(width: cellWidth, height: cellWidth)
        .background(Color.black)
    }
    
    func cellTouched() {
        grid.clickCell(cell: cell)
    }
}
