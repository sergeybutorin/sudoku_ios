//
//  Sudoku.swift
//  Sudoku
//
//  Created by Сергей Буторин on 04.01.17.
//  Copyright © 2017 Сергей Буторин. All rights reserved.
//

import Foundation
import Accelerate

class Sudoku {
    var gameGrid = [[Int]]()
    var answer = [[Int]]()
    var mistakes = 0
    var scoreMultiplier: UInt = 1000
    var score: UInt = 0
    let n = 3
    let digits = [1,2,3,4,5,6,7,8,9]
    
    //MARK: Initialization
    
    init() {
        gameGrid = [[Int]](repeating:[Int](repeating:0, count:n*n), count:n*n)
        var rowIdx = 0
        while rowIdx<n*n {
            var colIdx = 0
            var cellWrong = 0, rowWrong = 0
            while colIdx<n*n {
                var digitsForBlock = getPossibleDigits(currentRow: rowIdx, currentCol: colIdx)
                if digitsForBlock.isEmpty {
                    colIdx -= 1
                    gameGrid[rowIdx][colIdx] = 0
                    cellWrong += 1
                    if (cellWrong > 3) {
                        gameGrid[rowIdx] = [Int](repeating:0, count:n*n)
                        colIdx = 0
                        cellWrong = 0
                        rowWrong += 1
                        if (rowWrong > 3) {
                            rowIdx -= 1
                            gameGrid[rowIdx] = [Int](repeating:0, count:n*n)
                            rowWrong = 0
                        }
                    }
                    continue
                }
                gameGrid[rowIdx][colIdx] = digitsForBlock.remove(at: Int(arc4random_uniform(UInt32(digitsForBlock.count))))
                colIdx += 1
            }
            rowIdx += 1
        }
        answer = gameGrid
        deleteFields()
    }
    
    // This method removing digits, which are already used in row/column/block, from array
    func getPossibleDigits(currentRow: Int, currentCol:Int) -> [Int] {
        var result = digits
        for rowIdx in (currentRow/n)*n..<currentRow {
            for colIdx in (currentCol/n)*n..<(currentCol/n + 1)*n {
                if result.contains(gameGrid[rowIdx][colIdx]) {
                    result.remove(at: result.index(of: gameGrid[rowIdx][colIdx])!)
                }
            }
        }
        for rowIdx in 0..<currentRow {
            if result.contains(gameGrid[rowIdx][currentCol]) {
                result.remove(at: result.index(of: gameGrid[rowIdx][currentCol])!)
            }
        }
        for colIdx in 0..<currentCol {
            if result.contains(gameGrid[currentRow][colIdx]) {
                result.remove(at: result.index(of: gameGrid[currentRow][colIdx])!)
            }
            
        }
        return result
    }
    
    func deleteFields(difficult: Int = 30) {
        var flook = [[Int]](repeating:[Int](repeating:0, count:n*n), count:n*n)
        var iterator = 0
        var digitCount = Int(NSDecimalNumber(decimal: pow(Decimal(n),  4)))
        
        while iterator < Int(NSDecimalNumber(decimal: pow(Decimal(n),  4))) {
            let i = Int(arc4random_uniform(UInt32(n * n))), j = Int(arc4random_uniform(UInt32(n * n)))
            if flook[i][j] == 0 {
                iterator += 1
                flook[i][j] = 1
                
                let temp = gameGrid[i][j]
                gameGrid[i][j] = 0
                digitCount -= 1
                
                var table_solution = [[Int]]()
                for copy_i in 0..<n*n {
                    table_solution.append(gameGrid[copy_i])
                }
                if !solving(board: table_solution) {
                    gameGrid[i][j] = temp
                    digitCount += 1
                } 
                if digitCount == difficult{
                    return
                }
            }
        }
    }
    
    func solving(board: [[Int]]) -> Bool {
        var board = board
        var isSolved = false
        for x in 0 ..< 9  {
            for y in 0 ..< 9 {
                if board[x][y] == 0 {
                    let known = Set(board.map { $0[y] } + board[x] + subgrid(board, pos: (x, y)))
                    let possible = Set(Array(1...9)).subtracting(known)
                    if possible.count == 1  {
                        board[x][y] = possible.first!
                    }
                }
            }
            isSolved = 45 == board[x].reduce(0, +)
        }
        return isSolved
    }

    
    
    func subgrid(_ board: [[Int]], pos: (Int, Int)) -> [Int] {
        var r = [Int]()
        var (x, y) = pos
        x = x / 3 * 3
        y = y / 3 * 3
        for i in x ..< x + 3 {
            for j in y ..< y + 3 {
                r.append(board[i][j])
            }
        }
        return r
    }
    
    
}
