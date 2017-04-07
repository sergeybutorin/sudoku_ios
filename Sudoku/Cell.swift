//
//  Field.swift
//  Sudoku
//
//  Created by Сергей Буторин on 07.04.17.
//  Copyright © 2017 Сергей Буторин. All rights reserved.
//

import Foundation
import UIKit

class Cell: UIButton {
    //MARK: Properties
    var row:Int, col:Int
    
    init(rowIdx: Int, colIdx:Int, frame:CGRect) {
        self.row = rowIdx
        self.col = colIdx
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
