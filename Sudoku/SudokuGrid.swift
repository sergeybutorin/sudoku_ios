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
    private var fields = [UIButton]()
    var sudoku: Sudoku!
    private var fi: UIButton!
    
    
    // MARK: Field Action
    func fieldTapped(field: UIButton){
        if field.currentTitle == "" {
            if let prev = fi {
                fi.backgroundColor = UIColor.lightGray
                if let num = Int(prev.currentTitle!){
                    if num >= 1 && num <= 9 {
                        fi.backgroundColor = UIColor.green
                    }
                }
            }
            field.backgroundColor = UIColor.red
            field.isSelected = true
            fi = field
        }
    }
    
    // Set new value for selected field
    
    func fieldSet(value: String){
        if let index = fields.index(of: fi){
            if (Int(value) == sudoku.answer[index / (sudoku.n * sudoku.n)][index % (sudoku.n * sudoku.n)]) {
                sudoku.score += ((sudoku.scoreMultiplier + 50) * UInt(value)!)
                fi.setTitle(value, for: .normal)
                print("Score: ", sudoku.score)
            } else if fi.currentTitle == "" {
                sudoku.mistakes += 1
                sudoku.scoreMultiplier -= 50
                print("Mistakes: ", sudoku.mistakes)
            }
        }
    }
    
    
    // MARK: Private Methods
    
    private func setupFields() {
        let w = Int(frame.width / 9 - 0.7), h = Int(frame.width / 9 - 0.7)
        var xPos = 1, yPos = 1
        for i in 0..<9 {
            for j in 0..<9 {
                let field = UIButton(frame: CGRect(x: xPos, y: yPos, width: w, height: h))
                let num = sudoku.gameGrid[i][j]
                if num >= 1 && num <= 9{
                    field.backgroundColor = UIColor.green
                    field.setTitle(String(num), for: .normal)
                } else {
                    field.backgroundColor = UIColor.lightGray
                    field.setTitle("", for: .normal)
                }
                
                field.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                field.layer.cornerRadius = 5
                field.layer.borderWidth = 1
                field.layer.borderColor = UIColor.black.cgColor
                
                // Setup the field action
                field.addTarget(self, action: #selector(SudokuGrid.fieldTapped(field:)), for: .touchUpInside)
                
                // Add the field
                addSubview(field)
                
                fields.append(field)
                xPos += (w + 1)
            }
            xPos = 1
            yPos += (h + 1)
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupFields()
    }
 
}
