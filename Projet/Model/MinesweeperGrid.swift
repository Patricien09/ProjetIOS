//
//  MinesweeperGrid.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import Foundation

class MinesweeperGrid: ObservableObject {
    @Published var grid: [[MinesweeperCell]]
    @Published var alreadyClicked: Bool = false
    @Published var nbMines: Int = 0
    @Published var won: Bool = false
    @Published var loose: Bool = false
    private var clickType: CellState = .empty
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
            
            // Si la cellule contient déjà une mine, qu'elle correspond à la cellule cliquée en premier (ou qu'elle est dans son voisinage) alors on continue
            if (cell.getIsMine() || baseCell == cell || self.getCellNeighbours(cell: cell).contains(baseCell)) { continue }
            cell.setIsMine(isMine: true)
            
            setNeighboursMines(cell: cell)
            self.mines.append(cell)
            numberOfMine -= 1
        }
        self.nbMines = self.mines.count
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
    func clickCell(cell: MinesweeperCell, fromDiscoverCells: Bool = false) {
        if (self.loose || self.won) { return }
        if (self.clickType == .empty || fromDiscoverCells) {
            if (alreadyClicked) {
                // Fin de la partie quand l'utilisateur clique sur une mine et qu'il n'y a pas de flag ou question mark sur la cellule
                if (cell.getIsMine() && cell.getState() == .empty) {
                    self.loose = true
                    self.revealAllMines()
                    print("Looser")
                    return
                } else {
                    self.handleClickPropagation(cell: cell)
                }
                self.handleClickPropagation(cell: cell)
            }
            self.checkVictory()
        }
        else {
            handleClick(cell: cell)
        }
    }
    
    /**
     * Gère l'appui sur une cellule découverte
     * Si parmis ses voisins il y a autant de cellules flag que de mines voisines, on découvre ceux qui ne sont pas flag
     */
    func discoverCells(cell: MinesweeperCell) {
        if (cell.getNoNeighboursMines() == self.getNumberOfFlaggedNeighbours(cell: cell)) {
            let neighbours = self.getCellNeighbours(cell: cell)
            for neighbour in neighbours {
                if(neighbour.getState() != .flag) {
                    self.clickCell(cell: neighbour, fromDiscoverCells: true)
                }
            }
        }
    }
    
    /**
     * Gère le type de clic grâce au bouton situé en dessous de la grille
     */
    func changeClickType() {
        if(self.alreadyClicked)
        {
            switch self.clickType {
                case .empty:
                    self.clickType = .flag
                case .flag:
                    self.clickType = .questionMark
                case .questionMark:
                    self.clickType = .empty
            }
        }
    }
    
    /**
     * Fonction servant à gérer le clic en fonction du type de clic (empty, flag ou questionMark)
     */
    func handleClick(cell: MinesweeperCell) -> Void {
        if(cell.getClicked()) { return }
        if(self.clickType == .empty) {
            // Si le clickType est empty
            handleEmptyClick(cell: cell)
            self.checkVictory()
        }
        else if(self.clickType == .flag) {
            // Si le clickType est flag
            if(cell.getState() == .flag) {
                // et la cellule est flag, on la passe en empty et incrémentation nbMines
                cell.setState(newState: .empty)
                nbMines += 1
            }
            else {
                // et la cellule n'est pas flag (empty ou questionMark) décrémentation nbMines et on la flag
                self.nbMines -= 1
                cell.setState(newState: .flag)
                self.checkVictory()
            }
        }
        else {
            // Si le clickType est questionMark
            if(cell.getState() == .questionMark) {
                // et la cellule est questionMark, on la passe en empty
                cell.setState(newState: .empty)
                return
            }
            if(cell.getState() == .flag) {
                // et la cellule est flag, on la passe en questionMark et on incrémente nbMines
                self.nbMines += 1
                cell.setState(newState: .questionMark)
                return
            }
            // Sinon (cellule empty) on la questionMark
            cell.setState(newState: .questionMark)
        }
    }
    
    /**
     * Fonction servant à gérer le type de click empty
     * Change le state de la cellule en fonction de l'état précédent
     */
    func handleEmptyClick (cell: MinesweeperCell) {
        if(cell.getState() == .flag) {
            // Si la cellule est flag, on la passe en questionMark et incrémentation nbMines
            self.nbMines += 1
            cell.setState(newState: .questionMark)
            return
        } else if(cell.getState() == .questionMark) {
            // Si la cellule est en questionMark, on la passe en empty
            cell.setState(newState: .empty)
            return
        }
        // sinon (la cellule est empty), on la flag et décrémentation nbMines
        self.nbMines -= 1
        cell.setState(newState: .flag)
    }
    
    /**
     * renvoi le nombre de cellules voisines qui sont flag
     */
    func getNumberOfFlaggedNeighbours (cell: MinesweeperCell) -> Int
    {
        let neighbours = self.getCellNeighbours(cell: cell)
        var nbFlag = 0
        for neighbour in neighbours {
            if(neighbour.getState() == .flag) {
                nbFlag += 1
            }
        }
        return nbFlag
    }
    
    /**
     * Permet de propager le click d'une cellule à ses voisines et ainsi de suite
     * S'arrête quand le celulle à déjà été cliquée ou que le nombre de mines aux alentours est différent de 0
     */
    func handleClickPropagation(cell: MinesweeperCell) -> Void {
        // Si la cellule contient un flag ou question mark, on ne fait rien
        if (cell.getState() != .empty) { return }
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
     * Permet de déterminer si le joueur à gagner la partie ou non
     * Pour cela, cette fonction regarde si toutes les cases contenant des mines ont été flag
     * Il est aussi possible de gagner en découvrant toutes les cases ne contenant pas de mine, donc possible sans placer de drapeaux
     */
    func checkVictory() -> Void {
        if(self.nbMines == 0) {
            for mine in mines {
                if(mine.getState() != .flag)
                {
                    return
                }
            }
        }
        else {
            for line in 0..<height {
                for col in 0..<width {
                    let cell = self.getCell(line: line, col: col)
                    // Si la cellule n'est pas une mine et n'a pas été cliquée
                    if(!cell.getIsMine() && !cell.getClicked())
                    {
                        return
                    }
                }
            }
        }
        self.won = true
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
        self.nbMines = 0
        self.mines = [MinesweeperCell]()
        self.alreadyClicked = false
        self.won = false
        
        self.loose = false
        self.clickType = .empty
    }
    
    /**
     * Quand la partie est finie, on révèle toutes les cases contenant une mine
     */
    func revealAllMines() {
        for mine in self.mines {
            mine.setClicked(clicked: true)
        }
    }
    
    func getNbMines() -> Int {
        return self.nbMines
    }
    func getClickType() -> CellState {
        return self.clickType
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
