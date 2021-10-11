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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self] (status, time) in
        guard let self = self else {return}
        
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            let redColor = game.items[index].redColor
            let greenColor = game.items[index].greenColor
            let blueColor = game.items[index].blueColor
            buttons[index].backgroundColor = UIColor(red: CGFloat(redColor/255), green: CGFloat(greenColor/255), blue: CGFloat(blueColor/255), alpha: 1)
            buttons[index].isHidden = false
            buttons[index].layer.borderWidth = 0
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
    }
    
    private func updateUI() {
        for index in game.items.indices {
            if game.items[index].isSelected {
                buttons[index].layer.borderWidth = 8
                buttons[index].layer.borderColor = UIColor(red:255/255, green:0/255, blue:0/255, alpha: 1).cgColor
            }
            //buttons[index].isHidden = game.items[index].isFound
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                }
            completion: { [weak self] ( _) in
                    let redColor = self?.game.items[index].redColor
                    let greenColor = self?.game.items[index].greenColor
                    let blueColor = self?.game.items[index].blueColor
                self?.buttons[index].backgroundColor = UIColor(red: CGFloat(redColor!/255), green: CGFloat(greenColor!/255), blue: CGFloat(blueColor!/255), alpha: 1)
                
                    self?.game.items[index].isError = false
                }
            }
            
        }
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: statusGame) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась!!!"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы выиграли!!!"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
        case .lose:
            statusLabel.text = "Вы проиграли!!!"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        }
    }
}
