//
//  Game.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 26.09.2021.
//

import Foundation

enum statusGame {
    case start
    case win
}

class Game{
    
    struct Item{
        var redColor: Float
        var greenColor: Float
        var blueColor: Float
        var isSelected: Bool = false
    }
    
    private let redColorData = Array(0...255)
    private let greenColorData = Array(0...255)
    private let blueColorData = Array(0...255)
    var items: [Item] = []
    private var countItems: Int
    
    var status: statusGame = .start
    var firstSelectedButtonIndex: Int?
    var secondSelectedButtonIndex: Int?
    
    init(countItems: Int) {
        self.countItems = countItems
        setupGame()
    }
    
    private func setupGame(){
        var redColor = redColorData.shuffled()
        var greenColor = greenColorData.shuffled()
        var blueColor = blueColorData.shuffled()
        while items.count < countItems {
            let item = Item(redColor: Float(redColor.removeFirst()), greenColor: Float(greenColor.removeFirst()), blueColor: Float(blueColor.removeFirst()))
            items.append(item)
            if items.count < countItems {
                items.append(item)
            }
        }
        items.shuffle()
    }
    
    func check(index: Int){
        var firstSelectedButtonIndexIsFilled = false
        if firstSelectedButtonIndex == nil {
            firstSelectedButtonIndex = index
            firstSelectedButtonIndexIsFilled = true
        }
        print(!firstSelectedButtonIndexIsFilled && secondSelectedButtonIndex == nil)
        if !firstSelectedButtonIndexIsFilled && secondSelectedButtonIndex == nil {
            secondSelectedButtonIndex = index
        }
        
        if firstSelectedButtonIndex != nil && secondSelectedButtonIndex != nil {
            if items[firstSelectedButtonIndex!].redColor == items[secondSelectedButtonIndex!].redColor
                && items[firstSelectedButtonIndex!].greenColor == items[secondSelectedButtonIndex!].greenColor
                && items[firstSelectedButtonIndex!].blueColor == items[secondSelectedButtonIndex!].blueColor {
                items[firstSelectedButtonIndex!].isSelected = true
                items[secondSelectedButtonIndex!].isSelected = true
                firstSelectedButtonIndex = nil
                secondSelectedButtonIndex = nil
            }
        }
    
        var UnselectedButtons = 0
        for index in items.indices {
            if !items[index].isSelected{
                UnselectedButtons += 1
            }
        }
       
        if UnselectedButtons <= 1 {
            status = .win
        }
    }
}
