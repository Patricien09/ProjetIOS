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

class MinesweeperCell: ObservableObject {
    // Détermine si la case est une mine ou pas
    @Published var isMine: Bool
    // Détermine si la case a été découverte ou pas
    @Published var clicked: Bool
    // Détermine le statut de la cellule si elle n'a pas été découverte
    @Published var state: CellState
    // Nombre de mine dans les voisins de la case
    private var noNeighboursMines: Int
    
    init(isMine: Bool, clicked: Bool, state: CellState, noNeighboursMines: Int) {
        self.isMine = isMine
        self.clicked = clicked
        self.state = state
        self.noNeighboursMines = noNeighboursMines
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
}
