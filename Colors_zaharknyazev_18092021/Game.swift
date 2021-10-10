//
//  Game.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 26.09.2021.
//

import Foundation
import UIKit

enum statusGame {
    case start
    case win
    case lose
}

class Game{
    
    struct Item: Equatable{
        var redColor: Float
        var greenColor: Float
        var blueColor: Float
        var isSelected: Bool = false
        var isFound: Bool = false
        
        static func ==(lhs: Item, rhs: Item) -> Bool {
                return lhs.redColor == rhs.redColor && lhs.greenColor == rhs.greenColor && lhs.blueColor == rhs.blueColor
        }
    }
    
    private let redColorData = Array(0...255)
    private let greenColorData = Array(0...255)
    private let blueColorData = Array(0...255)
    var items: [Item] = []
    private var countItems: Int
    
    var status: statusGame = .start{
        didSet{
            if status != .start {
                stopGame()
            }
        }
    }
    
    var firstSelectedButtonIndex: Int?
   
    private var timeForGame: Int
    private var secondsGame: Int{
        didSet{
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame)
        }
    }
    private var timer: Timer?
    private var updateTimer:((statusGame, Int)->Void)
    
    init(countItems: Int, time: Int, updateTimer:@escaping (_ status: statusGame, _ seconds: Int)->Void ) {
        self.countItems = countItems
        self.timeForGame = time
        self.secondsGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame(){
        var redColor = redColorData.shuffled()
        var greenColor = greenColorData.shuffled()
        var blueColor = blueColorData.shuffled()
        items.removeAll()
        while items.count < countItems {
            let item = Item(redColor: Float(redColor.removeFirst()), greenColor: Float(greenColor.removeFirst()), blueColor: Float(blueColor.removeFirst()))
            items.append(item)
            if items.count < countItems {
                items.append(item)
            }
        }
        items.shuffle()
        updateTimer(status, secondsGame)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (_) in self?.secondsGame -= 1
        })
    }
    
    func newGame() {
        status = .start
        self.secondsGame = self.timeForGame
        setupGame()
    }
    
    func check(index: Int){
        guard status == .start else {return}
        
        if firstSelectedButtonIndex == nil {
            firstSelectedButtonIndex = index
            items[index].isSelected = true
        }
        
        if firstSelectedButtonIndex != nil && firstSelectedButtonIndex != index {
            if items[firstSelectedButtonIndex!] == items[index] {
                        items[firstSelectedButtonIndex!].isFound = true
                        items[index].isFound = true
                        firstSelectedButtonIndex = nil
            }
        }
    
        let NotFoundItems = items.filter { (Item) -> Bool in
            !Item.isFound
        }
       
        if NotFoundItems.count <= 1 {
            status = .win
        }
    }
    
    private func stopGame(){
        timer?.invalidate()
    }
}

extension Int {
    func secondsToString() -> String {
       let minutes = self/60
       let seconds = self % 60
       return String(format: "%d:%02d", minutes, seconds)
    }
}
