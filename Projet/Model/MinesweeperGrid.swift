//
//  MinesweeperGrid.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import Foundation

class MinesweeperGrid: ObservableObject {
    @Published var grid : [[MinesweeperCell]]
    @Published var alreadyClicked: Bool = false
    private var mineRate : Float = 0.2
    private var width: Int
    private var height: Int
    
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
    
    /**
     * Construit la grille, c'est-à-dire le remplissage du tableau avec des MinesweeperCell
     */
    private func constructGrid() {
        // Construit le tableau initial avec aucunes mines
        for _ in 0..<height {
            var line = [MinesweeperCell]()
            for _ in 0..<width {
                line.append(MinesweeperCell(isMine: false, clicked: false, state: .empty, noNeighboursMines: 0))
            }
            grid.append(line)
        }
    }
    
    /**
     * Remplit le tableau avec les mines, en fonction du taux d'apparition et d'un nombre max di'térations
     */
    private func setMines(baseCellLine: Int, baseCellCol: Int) {
        // On remplit le tableau avec les mines
        var numberOfMine = width * height * Int(mineRate * 100) / 100
        var maxIteration = width * height * 100
        while (numberOfMine > 0 && maxIteration > 0) {
            maxIteration -= 1
            let col = Int.random(in: 0..<width)
            let line = Int.random(in: 0..<height)
            let cell = getCell(line: line, col: col)
            
            // Si la cellule est déjà une mine, ou qu'elle correspond à la cellule cliquée en premier, alors on continue
            if (cell.getIsMine() || (baseCellLine == line && baseCellCol == col)) { continue }
            cell.setIsMine(isMine: true)
            
            setNeighboursMines(line: line, col: col)
            numberOfMine -= 1
        }
    }
    
    /**
     * Pour tous les voisins de la cellule aux coordonnées passées en paramètre, si elle contient une mine
     * on leurs ajoute tous +1 au compteur de mine
     */
    private func setNeighboursMines(line: Int, col: Int) {
        let baseCell = getCell(line: line, col: col)
        if (!baseCell.getIsMine()) { return }
            
        let neighbours = getCellNeighbours(line: line, col: col)
        for cell in neighbours {
            cell.setNoNeighboursMines(noNeighboursMines: cell.getNoNeighboursMines() + 1)
        }
    }
    
    /**
     * Renvoie un tableau contenant les 8 cellules voisines de la cellule aux coordonnées passées en paramètre
     */
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
    
    /**
     * Gère le click d'une cellule
     * C'est ici que l'on gère la victoire ou la défaite
     */
    func clickCell(line: Int, col: Int) {
        let cell = getCell(line: line, col: col)
        cell.setClicked(clicked: true)
        if (alreadyClicked) {
            if (cell.getIsMine()) {
                // TODO Fin de la partie et révélation de la grille (p-ê ?)
                print("Looser")
            }
        } else {
            alreadyClicked = true
            self.setMines(baseCellLine: line, baseCellCol: col)
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
