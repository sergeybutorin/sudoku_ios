//
//  MenuViewController.swift
//  Sudoku
//
//  Created by Сергей Буторин on 02.04.17.
//  Copyright © 2017 Сергей Буторин. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var mainSubview: UIView!
    @IBOutlet var selectDifficultySubview: UIView!
    @IBOutlet var aboutSubview: UIView!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mainSubview)
        self.mainSubview.center = self.view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func continueGameButtonPushed(_ sender: UIButton) {
        let GameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(GameViewController, animated:true, completion:nil)
        GameViewController.startGame(isNewGame: false)
    }
    
    @IBAction func newGameButtonPushed(_ sender: UIButton) {
        self.mainSubview.removeFromSuperview()
        self.view.addSubview(selectDifficultySubview)
        selectDifficultySubview.center = self.view.center
    }
    
    @IBAction func easyGameButtonPushed(_ sender: UIButton) { // TODO: rewrite this
        let GameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(GameViewController, animated:true, completion:nil)
        GameViewController.startGame(isNewGame: true)
        GameViewController.grid.sudoku.deleteFields(difficult: 35)
    }
    
    @IBAction func mediumGameButtonPushed(_ sender: UIButton) { // TODO: rewrite this
        let GameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(GameViewController, animated:true, completion:nil)
        GameViewController.startGame(isNewGame: true)
        GameViewController.grid.sudoku.deleteFields(difficult: 30)
    }
    
    @IBAction func hardGameButtonPushed(_ sender: UIButton) { // TODO: rewrite this
        let GameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(GameViewController, animated:true, completion:nil)
        GameViewController.startGame(isNewGame: true)
        GameViewController.grid.sudoku.deleteFields(difficult: 25)
    }
    
    @IBAction func infoButtonPushed(_ sender: UIButton) {
        self.view.addSubview(aboutSubview)
        self.aboutSubview.center = self.view.center
        self.aboutSubview.layer.cornerRadius = 10
    }
    
    @IBAction func aboutDoneButtonPushed(_ sender: UIButton) {
        self.aboutSubview.removeFromSuperview()
    }
    
    @IBAction func backButtonPushed(_ sender: UIButton) {
        let MenuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(MenuViewController, animated:true, completion:nil)
    }
}
