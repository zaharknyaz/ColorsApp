//
//  GameViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 22.09.2021.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var statusLabel: UILabel!
    
    lazy var game = Game(countItems: buttons.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        sender.layer.borderWidth = 8
        sender.layer.borderColor = UIColor(red:255/255, green:0/255, blue:0/255, alpha: 1).cgColor
        game.check(index: buttonIndex)
        updateUI()
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            let redColor = game.items[index].redColor
            let greenColor = game.items[index].greenColor
            let blueColor = game.items[index].blueColor
            buttons[index].backgroundColor = UIColor(red: CGFloat(redColor/255), green: CGFloat(greenColor/255), blue: CGFloat(blueColor/255), alpha: 1)
            buttons[index].isHidden = false
        }
    }
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isSelected
        }
        if game.status == .win {
            statusLabel.text = "Вы выиграли!!!"
            statusLabel.textColor = .green
        }
    }
}
