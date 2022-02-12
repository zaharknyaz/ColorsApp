//
//  GameViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 22.09.2021.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        guard let self = self else {return}
        
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
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
            
            //скругляем края кнопок
            buttons[index].layer.cornerRadius = 15
        }
        
        
    }
    
    private func updateUI() {
        for index in game.items.indices {
            if game.items[index].isSelected {
                buttons[index].layer.borderWidth = 8
                buttons[index].layer.borderColor = UIColor(red:255/255, green:0/255, blue:0/255, alpha: 1).cgColor
            }
            
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                if Settings.shared.currentSettings.vibroState {
                    //виброзвонок при ошибке
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
                
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                }
                
                completion: { [weak self] ( _) in
                                
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
                    self?.buttons[index].transform = CGAffineTransform(rotationAngle: CGFloat.pi/50)
                }) { (bool) in
                    self?.buttons[index].transform = .identity
                    let redColor = self?.game.items[index].redColor
                    let greenColor = self?.game.items[index].greenColor
                    let blueColor = self?.game.items[index].blueColor
                    self?.buttons[index].backgroundColor = UIColor(red: CGFloat(redColor!/255), green: CGFloat(greenColor!/255), blue: CGFloat(blueColor!/255), alpha: 1)
                }
                    self?.game.items[index].isError = false
                }
            }
            
        }
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: statusGame) {
        switch status {
        case .start:
            statusLabel.text = "Game starts!!!"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "You won!!!"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
            if game.isNewRecord {
                showAlert()
            }else {
                showAlertActionSheet()
            }
        case .lose:
            statusLabel.text = "You lost!!!"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Congratulations!", message: "You set a new record", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertActionSheet() {
        let alert = UIAlertController(title: "What do you want to do next?", message: nil, preferredStyle: .actionSheet)
        
        let newGame = UIAlertAction(title: "New game", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        
        let showRecord = UIAlertAction(title: "Show record", style: .default) { [weak self] (_) in
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        
        let menuAction = UIAlertAction(title: "Go to menu", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(newGame)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = statusLabel
        }
        
        present(alert, animated: true, completion: nil)
    }
}
