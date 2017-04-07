//
//  SudokuTests.swift
//  SudokuTests
//
//  Created by Сергей Буторин on 03.01.17.
//  Copyright © 2017 Сергей Буторин. All rights reserved.
//

import XCTest
@testable import Sudoku

class SudokuTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSudoku() {
        let sudoku: Sudoku = Sudoku()
        XCTAssertEqual(0, sudoku.mistakes)
//        for row in sudoku.gameGrid {
//            for col in row {
//                if col == 0 {
//                    sudoku.gameGrid[row][col] = sudoku.answer[row][col]
//                }
//            }
//        }
    }
}
