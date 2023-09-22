//
//  ProjetTests.swift
//  ProjetTests
//
//  Created by Tom Rouillon on 9/8/23.
//

import XCTest
@testable import Projet

final class ProjetTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     * Ce test vérifie la défaite en cas de clic sur une mine
     */
    func testClickMine() throws {
        var grid = MinesweeperGrid(mineRate: 0.2, width: 10, height: 10)
        
        let mines = grid.getMines()
        
        grid.clickCell(cell: mines[0])
        XCTAssertEqual(grid.loose, true)
    }
    
    /**
     * Ce test vérifie la victoire si toutes les cases non-mines sont découvertes
     */
    func testVictory() throws {
        var grid = MinesweeperGrid(mineRate: 0.2, width: 10, height: 10)
        
        for line in 0..<grid.getHeight() {
            for col in 0..<grid.getWidth() {
                let cell = grid.getCell(line: line, col: col)
                if(!cell.getClicked() && !cell.getIsMine()) {
                    grid.clickCell(cell: cell)
                }
            }
        }
        XCTAssertEqual(grid.won, true)
    }
}
