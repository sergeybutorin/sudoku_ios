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
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        let GameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(GameViewController, animated:true, completion:nil)
        GameViewController.startGame(isNewGame: true)
    }
    
    @IBAction func infoButtonPushed(_ sender: UIButton) {
        let AboutViewController = storyboard?.instantiateViewController(withIdentifier: "AboutViewController")
        self.present(AboutViewController!, animated:true, completion:nil)
    }
    
    @IBAction func backButtonPushed(_ sender: UIButton) {
        let MenuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(MenuViewController, animated:true, completion:nil)
    }
}
