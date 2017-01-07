//
//  ViewController.swift
//  Sudoku
//
//  Created by Сергей Буторин on 03.01.17.
//  Copyright © 2017 Сергей Буторин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var grid: SudokuGrid!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mistakesLabel: UILabel!
    @IBOutlet weak var multplierLabel: UILabel!
    
    var timer:Timer?
    var seconds = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(onUpdateTimer), userInfo: nil, repeats:true)
    }

    
    func onUpdateTimer()
    {
        seconds += 1
        if seconds % 5 == 0 {
            grid.sudoku.scoreMultiplier -= 1
        }
        let min:Int = (seconds / 60) % 60
        let sec:Int = seconds % 60
        
        let min_p:String = String(format: "%02d", min)
        let sec_p:String = String(format: "%02d", sec)
        
        timeLabel!.text = "\(min_p):\(sec_p)"
        scoreLabel?.text = "\(grid.sudoku.score)"
        mistakesLabel.text = "Ошибки: \(grid.sudoku.mistakes)"
        multplierLabel.text = "\(grid.sudoku.scoreMultiplier)"
    }
    
    
    // MARK: Actions
    
    @IBAction func digitPushed(_ sender: UIButton) {
        let number = sender .tag
        if !(number >= 1 && number <= 9)  {
            fatalError("Wrong number: \(number)")
        }
        grid.fieldSet(value: String(sender .tag))
    }
   
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */

}

