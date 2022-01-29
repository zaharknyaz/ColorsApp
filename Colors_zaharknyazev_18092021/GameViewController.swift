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
            statusLabel.text = "Игра началась!!!"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы выиграли!!!"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
            if game.isNewRecord {
                showAlert()
            }else {
                showAlertActionSheet()
            }
        case .lose:
            statusLabel.text = "Вы проиграли!!!"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы установили новый рекорд", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertActionSheet() {
        let alert = UIAlertController(title: "Что Вы хотите сделать далее?", message: nil, preferredStyle: .actionSheet)
        
        let newGame = UIAlertAction(title: "Начать новую игру", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        
        let showRecord = UIAlertAction(title: "Посмотреть рекорд", style: .default) { [weak self] (_) in
            // TO DO: - RECORD VIEW CONTROLLER
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        
        let menuAction = UIAlertAction(title: "Перейти в меню", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(newGame)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = statusLabel //self.view
//            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        
        present(alert, animated: true, completion: nil)
    }
}
