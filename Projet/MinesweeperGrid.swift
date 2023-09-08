//
//  MinesweeperGrid.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import Foundation

class MinesweeperGrid {
    private var grid : [[MinesweeperCell]]
    private var mineRate : Float = 0.2
    private var width: Int
    private var height: Int
    
    init(grid: [[MinesweeperCell]], mineRate: Float, width: Int, height: Int) {
        self.grid = grid
        self.mineRate = mineRate
        self.width = width
        self.height = height
    }
    init(mineRate: Float, width: Int, height: Int) {
        self.mineRate = mineRate
        self.width = width
        self.height = height
        grid = Array(repeating: Array(repeating: MinesweeperCell(isMine: false, clicked: false, state: .empty, noNeighboursMines: 0), count: width), count: height)
    }
    
    func getGrid() ->[[MinesweeperCell]] {
        return self.grid
    }
    func getMineRate() -> Float {
        return self.mineRate
    }
    func getHeight() -> Int {
        return self.height
    }
    func getWidth() -> Int {
        return self.width
    }
    
    
    
    
}
