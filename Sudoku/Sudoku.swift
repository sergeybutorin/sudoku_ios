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
    var numbersArr = [[Int]]()
    var answer = [[Int]]()
    var mistakes = 0
    var scoreMultiplier: UInt = 1000
    var score: UInt = 0
    let n = 3
    
    //MARK: Initialization
    
    init() {
        numbersArr = [[Int]](repeating:[Int](repeating:0, count:n*n), count:n*n)
        for i in 0..<n*n {
            for j in 0..<n*n {
                numbersArr[i][j] = ((i*n + i/n + j) % (n*n) + 1)
            }
        }
        mix(n: 1000)
        answer = numbersArr
        deleteFields()
    }
    
    // Транспонирование матрицы
    
    func transposing()
    {
        for rowIdx in 0..<n*n {
            for colIdx in rowIdx+1..<n*n {
                swap(&numbersArr[rowIdx][colIdx], &numbersArr[colIdx][rowIdx])
            }
        }
    }
    
    // Обмен двух строк
    
    func swapRowsSmall() {
        let area = Int(arc4random_uniform(UInt32(n)))
        let line1 = Int(arc4random_uniform(UInt32(n)))
        var line2 = Int(arc4random_uniform(UInt32(n)))
        while (line1 == line2){
            line2 = Int(arc4random_uniform(UInt32(n)))
        }
        swap(&numbersArr[area * n + line1], &numbersArr[area * n + line2])
    }
    
    // Обмен двух столбцов
    
    func swapColumsSmall(){
        transposing()
        swapRowsSmall()
        transposing()
    }
    
    func swapRowsArea(){
        let area1 = Int(arc4random_uniform(UInt32(n)))
        var area2 = Int(arc4random_uniform(UInt32(n)))
        while (area1 == area2){
            area2 = Int(arc4random_uniform(UInt32(n)))
        }
        for i in 0..<n{
            swap(&numbersArr[area1 * n + i], &numbersArr[area2 * n + i])
        }
    }
    
    func swapColumsArea(){
        transposing()
        swapRowsArea()
        transposing()
    }
    
    //
    
    func mix(n: Int = 20) {
        for _ in 0...n {
            let funcNum = Int(arc4random_uniform(UInt32(5)) + 1)
            switch funcNum {
            case 1:
                transposing()
            case 2:
                swapRowsSmall()
            case 3:
                swapColumsSmall()
            case 4:
                swapRowsArea()
            case 5:
                swapColumsArea()
            default:
                fatalError("Wrong number of function: \(funcNum)")
            }
        }
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
                
                let temp = numbersArr[i][j]
                numbersArr[i][j] = 0
                digitCount -= 1
                
                var table_solution = [[Int]]()
                for copy_i in 0..<n*n {
                    table_solution.append(numbersArr[copy_i])
                }
                /*var i_solution = 0
                for _ in solving(board: table_solution) {
                    print("check solutions")
                    i_solution += 1
                }*/
                //print(digitCount)
                //print("Solutions count = ", i_solution)
                if !solving(board: table_solution) {
                    numbersArr[i][j] = temp
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
