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
    private var mineRate: Float
    private var width: Int
    private var height: Int
    private var mines: [MinesweeperCell] = [MinesweeperCell]()
    
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
        for i in 0..<height {
            var line = [MinesweeperCell]()
            for j in 0..<width {
                line.append(MinesweeperCell(isMine: false, clicked: false, state: .empty, noNeighboursMines: 0, line: i, col: j))
            }
            grid.append(line)
        }
    }
    
    /**
     * Remplit le tableau avec les mines, en fonction du taux d'apparition et d'un nombre max di'térations
     */
    private func setMines(baseCell: MinesweeperCell) {
        // On remplit le tableau avec les mines
        var numberOfMine = width * height * Int(mineRate * 100) / 100
        var maxIteration = width * height * 100
        while (numberOfMine > 0 && maxIteration > 0) {
            maxIteration -= 1
            let col = Int.random(in: 0..<width)
            let line = Int.random(in: 0..<height)
            let cell = getCell(line: line, col: col)
            
            // Si la cellule est déjà une mine, ou qu'elle correspond à la cellule cliquée en premier, alors on continue
            if (cell.getIsMine() || baseCell == cell) { continue }
            cell.setIsMine(isMine: true)
            
            setNeighboursMines(cell: cell)
            self.mines.append(cell)
            numberOfMine -= 1
        }
    }
    
    /**
     * Pour tous les voisins de la cellule aux coordonnées passées en paramètre, si elle contient une mine
     * on leurs ajoute tous +1 au compteur de mine
     */
    private func setNeighboursMines(cell: MinesweeperCell) {
        if (!cell.getIsMine()) { return }
            
        let neighbours = getCellNeighbours(cell: cell)
        for cell in neighbours {
            cell.setNoNeighboursMines(noNeighboursMines: cell.getNoNeighboursMines() + 1)
        }
    }
    
    /**
     * Renvoie un tableau contenant les 8 cellules voisines de la cellule aux coordonnées passées en paramètre
     */
    func getCellNeighbours(cell: MinesweeperCell) -> [MinesweeperCell] {
        let line = cell.getLine()
        let col = cell.getCol()
        
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
     * C'est ici que l'on gère également la victoire ou la défaite
     */
    func clickCell(cell: MinesweeperCell) {
        if (alreadyClicked) {
            if (cell.getIsMine()) {
                // TODO Fin de la partie et révélation de la grille (p-ê ?)
                self.revealAllMines()
                print("Looser")
            }
//            else if (self.isVictory()) {
//                print("Winner")
//            }
            else {
                self.handleClickPropagation(cell: cell)
            }
        } else {
            alreadyClicked = true
            self.setMines(baseCell: cell)
            self.handleClickPropagation(cell: cell)
        }
    }
    
    /**
     * Permet de propager le click d'une cellule à ses voisines et ainsi de suite
     * S'arrête quand le celulle à déjà été cliquée ou que le nombre de mines aux alentours et différent de 0
     */
    func handleClickPropagation(cell: MinesweeperCell) -> Void {
        if (cell.getClicked() || cell.getNoNeighboursMines() != 0) {
            cell.setClicked(clicked: true)
            return
        }
        cell.setClicked(clicked: true)
        
        let neighbours = self.getCellNeighbours(cell: cell)
        for neighbour in neighbours {
            self.handleClickPropagation(cell: neighbour)
        }
    }
    
    /**
     * Reset le démineur, càd remettre toutes les valeurs des cellules par défault
     * Remet aussi alreadyClicked à false, pour replacer les mines aux premier click
     */
    func reset() -> Void {
        for line in 0..<height {
            for col in 0..<width {
                let cell = self.getCell(line: line, col: col)
                cell.setClicked(clicked: false)
                cell.setIsMine(isMine: false)
                cell.setState(newState: .empty)
                cell.setNoNeighboursMines(noNeighboursMines: 0)
            }
        }
        self.mines = [MinesweeperCell]()
        self.alreadyClicked = false
    }
    
    /**
     * Quand la partie est finie, on révèle toutes les cases contenant une mine
     */
    func revealAllMines() {
        for mine in self.mines {
            mine.setClicked(clicked: true)
        }
    }
    
    /**
     * Permet de déterminer si le joueur à gagner la partie ou non
     * Pour cela, cette fonction regarde si toutes les cases contenant des mines ont été flag
     * Il est aussi possible de gagner en découvrant toutes les cases ne contenant pas de mine, donc possible sans placer de drapeaux
     */
    func isVictory() -> Bool {
        return true
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
    
    func setMineRate(newMineRate: Float) -> Void {
        self.mineRate = newMineRate
    }
}
