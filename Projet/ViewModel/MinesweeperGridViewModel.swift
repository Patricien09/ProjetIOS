//
//  MinesweeperGridViewModel.swift
//  Projet
//
//  Created by Tom Rouillon on 9/15/23.
//

import Foundation

class MinesweeperGridViewModel: ObservableObject {
    @Published private var grid = MinesweeperGrid(mineRate: 0.12, width: 10, height: 16)
    
    var alreadyClicked: Bool {
        return grid.alreadyClicked
    }
}
