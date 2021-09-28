//
//  Game.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 26.09.2021.
//

import Foundation

class Game{
    
    struct Item{
        var title: String
        var redColor: Int
        var greenColor: Int
        var blueColor: Int
        var isFound: Bool = false
    }
    
    private let data = Array(1...99)
    private let redColorData = Array(0...255)
    private let greenColorData = Array(0...255)
    private let blueColorData = Array(0...255)
    var items: [Item] = []
    private var countItems: Int
    
    init(countItems: Int) {
        self.countItems = countItems
        setupGame()
    }
    
    private func setupGame(){
        var digits = data.shuffled()
        var redColor = redColorData.shuffled()
        var greenColor = greenColorData.shuffled()
        var blueColor = blueColorData.shuffled()
        while items.count < countItems {
            //var buttonColor: UIColor = UIColor(red:255/255, green:0/255, blue:0/255, alpha: 1)
            let item = Item(title: String(digits.removeFirst()), redColor: redColor.removeFirst(), greenColor: greenColor.removeFirst(), blueColor: blueColor.removeFirst())
            print("redColor: \(item.redColor), greenColor: \(item.greenColor), blueColor: \(item.blueColor)")
//            let item = Item(title: String(digits.removeFirst()), redColor: 255, greenColor: 0, blueColor: 0)
            items.append(item)
        }
    }
}
