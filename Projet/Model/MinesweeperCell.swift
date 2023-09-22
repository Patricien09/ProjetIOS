//
//  MinesweeperModel.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import Foundation

enum CellState {
    case flag
    case questionMark
    case empty
}

class MinesweeperCell: ObservableObject, Comparable {
    // Détermine si la case est une mine ou pas
    @Published var isMine: Bool
    // Détermine si la case a été découverte ou pas
    @Published var clicked: Bool
    // Détermine le statut de la cellule si elle n'a pas été découverte
    @Published var state: CellState
    // Nombre de mine dans les voisins de la case
    private var noNeighboursMines: Int
    private var line: Int
    private var col: Int
    static let cellWidth: CGFloat = 30
    
    init(isMine: Bool, clicked: Bool, state: CellState, noNeighboursMines: Int, line: Int, col: Int) {
        self.isMine = isMine
        self.clicked = clicked
        self.state = state
        self.noNeighboursMines = noNeighboursMines
        self.line = line
        self.col = col
    }
    
    static func < (lhs: MinesweeperCell, rhs: MinesweeperCell) -> Bool {
        return false
    }
    
    static func == (lhs: MinesweeperCell, rhs: MinesweeperCell) -> Bool {
        return (lhs.getLine() == rhs.getLine() && lhs.getCol() == rhs.getCol())
    }

    func setIsMine(isMine: Bool) -> Void {
        self.isMine = isMine
    }
    func setClicked(clicked: Bool) -> Void {
        self.clicked = clicked
    }
    func setState(newState: CellState) -> Void {
        self.state = newState
    }
    func setNoNeighboursMines(noNeighboursMines: Int) -> Void {
        self.noNeighboursMines = noNeighboursMines
    }
    
    func getIsMine() -> Bool {
        return self.isMine
    }
    func getClicked() -> Bool {
        return self.clicked
    }
    func getState() -> CellState {
        return self.state
    }
    func getNoNeighboursMines() -> Int {
        return self.noNeighboursMines
    }
    func getLine() -> Int {
        return self.line
    }
    func getCol() -> Int {
        return self.col
    }
}
