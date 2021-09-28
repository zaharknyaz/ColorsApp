//
//  GameViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 22.09.2021.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    
    lazy var game = Game(countItems: buttons.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        sender.layer.borderWidth = 8
        sender.layer.borderColor = UIColor(red:255/255, green:0/255, blue:0/255, alpha: 1).cgColor
        print(sender.tag)
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            let redColor = game.items[index].redColor
            let greenColor = game.items[index].greenColor
            let blueColor = game.items[index].blueColor
            buttons[index].backgroundColor = UIColor(red: CGFloat(redColor/255), green: CGFloat(greenColor/255), blue: CGFloat(blueColor/255), alpha: 1)
            buttons[index].isHidden = false
        }
    }
  
}
