//
//  MinesweeperGrid.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import Foundation

class MinesweeperGrid: ObservableObject {
    @Published var grid : [[MinesweeperCell]]
    private var mineRate : Float = 0.2
    private var width: Int
    private var height: Int
    @Published var alreadyClicked: Bool = false
    
    init(grid: [[MinesweeperCell]], mineRate: Float) {
        self.grid = grid
        self.mineRate = mineRate
        self.width = grid[0].count
        self.height = grid.count
    }
    
    init(mineRate: Float, width: Int, height: Int) {
        self.grid = [[MinesweeperCell]]()
        self.mineRate = mineRate
        self.width = width
        self.height = height
        
        self.constructGrid()
    }
    
    private func constructGrid() {
        for _ in 0..<height {
            var line = [MinesweeperCell]()
            for _ in 0..<width {
                line.append(MinesweeperCell(isMine: false, clicked: false, state: .empty, noNeighboursMines: 0))
            }
            grid.append(line)
        }
        
        var numberOfMine = width * height * Int(mineRate * 100) / 100
        var maxIteration = width * height * 100
        while (numberOfMine > 0 && maxIteration > 0) {
            maxIteration -= 1
            let col = Int.random(in: 0..<width)
            let line = Int.random(in: 0..<height)
            let cell = getCell(line: line, col: col)
            
            if (cell.getIsMine()) { continue }
            cell.setIsMine(isMine: true)
            
            setNeighboursMines(line: line, col: col)
            numberOfMine -= 1
        }
    }
    
    private func setNeighboursMines(line: Int, col: Int) {
        let baseCell = getCell(line: line, col: col)
        if (!baseCell.getIsMine()) { return }
            
        let neighbours = getCellNeighbours(line: line, col: col)
        for cell in neighbours {
            cell.setNoNeighboursMines(noNeighboursMines: cell.getNoNeighboursMines() + 1)
        }
    }
    
    func getCellNeighbours(line: Int, col: Int) -> [MinesweeperCell] {
        let minLine = max(line - 1, 0)
        let minCol = max(col - 1, 0)
        let maxLine = min(line + 1, height - 1)
        let maxCol = min(col + 1, width - 1)
        
        var cells = [MinesweeperCell]()
        for line in minLine...maxLine {
            for col in minCol...maxCol {
                cells.append(getCell(line: line, col: col))
            }
        }
        return cells
    }
    
    func clickCell(line: Int, col: Int) {
        let cell = getCell(line: line, col: col)
        cell.setClicked(clicked: true)
        if (cell.getIsMine()) {
            // TODO Fin de la partie et révélation de la grille (p-ê ?)
            print("Looser")
        }
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
    func getCell(line: Int, col: Int) -> MinesweeperCell {
        return grid[line][col]
    }
}
