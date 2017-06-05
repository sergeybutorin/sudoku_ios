//
//  ViewController.swift
//  Sudoku
//
//  Created by Сергей Буторин on 03.01.17.
//  Copyright © 2017 Сергей Буторин. All rights reserved.
//

import UIKit
import os.log

class GameViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var grid: SudokuGrid!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mistakesLabel: UILabel!
    @IBOutlet weak var multplierLabel: UILabel!
    @IBOutlet weak var backButton: UIView!
    
    var timer:Timer?
    
    func startGame(isNewGame: Bool) {
        if isNewGame {
            grid.sudoku = Sudoku()
        } else if let loadedGame = loadGame() {
            grid.sudoku = loadedGame
        } else {
            os_log("Failed to load game...", log: OSLog.default, type: .error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(onUpdateTimer), userInfo: nil, repeats:true)
    }
    
    
    func onUpdateTimer()
    {
        grid.sudoku.seconds += 1
        if grid.sudoku.seconds % 5 == 0 {
            grid.sudoku.scoreMultiplier -= 1
            if grid.sudoku.seconds % 30 == 0 {
                saveGame()
            }
        }
        let min:UInt = (grid.sudoku.seconds / 60) % 60
        let sec:UInt = grid.sudoku.seconds % 60
        
        let min_p:String = String(format: "%02d", min)
        let sec_p:String = String(format: "%02d", sec)
        
        timeLabel!.text = "\(min_p):\(sec_p)"
        scoreLabel?.text = "\(grid.sudoku.score)"
        mistakesLabel.text = "Ошибки: \(grid.sudoku.mistakes)"
        multplierLabel.text = "\(grid.sudoku.scoreMultiplier)"
    }
    
    
    // MARK: Actions
    
    @IBAction func digitPushed(_ sender: UIButton) {
        let number = sender.tag
        if !(number >= 1 && number <= 9)  {
            fatalError("Wrong number: \(number)")
        }
        grid.setCellValue(value: String(sender .tag))
        if grid.sudoku.digitsLeft == 0 {
            timer?.invalidate()
            os_log("Game over!", log: OSLog.default, type: .debug)
            let SuccessViewController = storyboard?.instantiateViewController(withIdentifier: "SuccessViewController")
            self.present(SuccessViewController!, animated:true, completion:nil)
        }
        saveGame()
    }
    
    @IBAction func backButtonPushed(_ sender: UIButton) {
        saveGame()
        let MenuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(MenuViewController, animated: true, completion:nil)
    }
    
    
    //MARK: Private Methods
    private func saveGame() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(grid.sudoku, toFile: Sudoku.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Game successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save game...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadGame() -> Sudoku?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Sudoku.ArchiveURL.path) as? Sudoku
    }
}
