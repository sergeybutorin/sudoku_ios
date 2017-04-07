//
//  SudokuGrid.swift
//  Sudoku
//
//  Created by Сергей Буторин on 03.01.17.
//  Copyright © 2017 Сергей Буторин. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SudokuGrid: UIView {
    // MARK: Properties
    private var cells = [Cell]()
    var sudoku: Sudoku! = Sudoku()
    private var selectedCell: Cell!
    
    
    // MARK: Cell Action
    func cellTapped(cell: Cell){
        if selectedCell != nil {
            if selectedCell.currentTitle == "" {
            selectedCell.backgroundColor = UIColor.lightGray
            } else {
                selectedCell.backgroundColor = UIColor.init(rgb: 0x80E800)
            }
        }
        selectedCell = cell
        highlightRelatedCells()
    }
    
    func highlightRelatedCells() {
        setCellsColors()
        for cell in cells {
            if cell.col == selectedCell.col || cell.row == selectedCell.row {
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor.init(rgb: 0xCFF93E).cgColor
            }
        }
        selectedCell.backgroundColor = UIColor.init(rgb: 0xFF9E00)
    }
    
    func setCellsColors() {
        for cell in cells {
            if cell.currentTitle == "" {
                cell.backgroundColor = UIColor.lightGray
            } else {
                cell.backgroundColor = UIColor.init(rgb: 0x80E800)
            }
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    // Set new value for selected field
    
    func setCellValue(value: String){
        if selectedCell != nil {
            if sudoku.gameGrid[selectedCell.row][selectedCell.col] == 0 {
                if Int(value) == sudoku.answer[selectedCell.row][selectedCell.col] {
                    sudoku.gameGrid[selectedCell.row][selectedCell.col] = Int(value)!
                    sudoku.score += ((sudoku.scoreMultiplier + 50) * UInt(value)!)
                    selectedCell.setTitle(value, for: .normal)
                    selectedCell.backgroundColor = UIColor.init(rgb: 0x80E800)
                    selectedCell = nil
                } else if selectedCell.currentTitle == "" {
                    sudoku.mistakes += 1
                    sudoku.scoreMultiplier -= 50
                }
            }
        }
    }
    
    
    // MARK: Private Methods
    
    private func setupCells() {
        let w = Int(frame.width / 9 - 0.7), h = Int(frame.width / 9 - 0.7)
        var xPos = 1, yPos = 1
        for rowIdx in 0..<9 {
            for colIdx in 0..<9 {
                let cell = Cell(rowIdx: rowIdx, colIdx: colIdx, frame: CGRect(x: xPos, y: yPos, width: w, height: h))
                let num = sudoku.gameGrid[rowIdx][colIdx]
                if num >= 1 && num <= 9{
                    cell.setTitle(String(num), for: .normal)
                } else {
                    cell.setTitle("", for: .normal)
                }
                
                cell.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                cell.layer.cornerRadius = 5
                
                // Setup the cell action
                cell.addTarget(self, action: #selector(SudokuGrid.cellTapped(cell:)), for: .touchUpInside)
                
                // Add the cell
                addSubview(cell)
                
                cells.append(cell)
                xPos += (w + 1)
            }
            xPos = 1
            yPos += (h + 1)
        }
        setCellsColors()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupCells()
    }
 
}
