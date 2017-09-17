//
//  GuessWordView.swift
//  Pendu
//
//  Created by Laurine Baillet on 16/06/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

import UIKit
import Foundation

protocol GuessWordViewDelegate {
    func guessed()
    func charNotIn()
}

class GuessWordView: UIView {
    
    @IBOutlet weak var containerCharView: UIView!
    @IBOutlet weak var containerLineView: UIView!
    
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    
    var word : String = ""
    var charGuessed : Int = 0
    
    var delegate : GuessWordViewDelegate?
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    //-------------------------------------------------------------------
    //MARK: - Initialisation
    //-------------------------------------------------------------------
    func initWithWord(word: String) {
        self.word = word
        
        hideAllChars()
        initCharsForTest()
        //initCharView(count: word.characters.count)
        //initLineView(count: word.characters.count)
        
    }
    //-------------------------------------------------------------------
    /**
     Init array of chars for five letters word
    */
    private func initCharsForTest() {
        for index in 0...word.characters.count {
            switch index {
            case 0:
                oneLabel.text = word.characterAtIndex(index: index)
            case 1:
                twoLabel.text = word.characterAtIndex(index: index)
            case 2:
                threeLabel.text = word.characterAtIndex(index: index)
            case 3:
                fourLabel.text = word.characterAtIndex(index: index)
            case 4:
                fiveLabel.text = word.characterAtIndex(index: index)
            default: break
            }
        }
    }
    //-------------------------------------------------------------------
    /**
     For variable number of letter in word
     */
    private func initCharView(count : Int) {
        
        // CharView
        let charView : UIView = UIView()
        
        var rect : CGRect = CGRect()
        rect.size.width = CGFloat(count * 10)
        rect.size.height = containerCharView.frame.size.height
        rect.origin.x = 0
        rect.origin.y = 0
        charView.draw(rect)
        
        containerCharView.addSubview(charView)
        
        for x in 0...count {
            let label = UILabel.init(frame: CGRect(x:(x+1*10), y:30, width:10,height: 30))
            //let range = word.index(word.startIndex, offsetBy: x)
            //label.text = String(word.characters.prefix(x))
            label.isHidden = true
            charView.addSubview(label)
        }
        
    }
    //-------------------------------------------------------------------
    /**
     Init lines to show according to word size
    */
    private func initLineView(count : Int) {
        
    }
    //-------------------------------------------------------------------
    //MARK: - Guess Methods
    //-------------------------------------------------------------------
    /**
     Test if char is in the word
    */
    func tryChar(char : Character) {
        if word.characters.index(of: char) != nil {
            let indexes = word.indexes(of: String(char))
            
            for index in indexes {
                showCharAtIndex(index: word.distance(from:word.startIndex, to: index))
                charGuessed += 1
            }
        } else {
            charNotIn()
        }
        if(charGuessed == word.characters.count) {
            guessed()
        }
    }
    //-------------------------------------------------------------------
    /**
     Show char found by user when initCharsForTest is used as initializer
    */
    func showCharAtIndex(index: Int) {
        switch index {
        case 0:
            oneLabel.isHidden = false
        case 1:
            twoLabel.isHidden = false
        case 2:
            threeLabel.isHidden = false
        case 3:
            fourLabel.isHidden = false
        case 4:
            fiveLabel.isHidden = false
        default:
            clear()
        }
    }
    //-------------------------------------------------------------------
    /**
     Empty and hide label. Re initialise number of char guessed
    */
    func clear() {
        oneLabel.text = ""
        twoLabel.text = ""
        threeLabel.text = ""
        fourLabel.text = ""
        fiveLabel.text = ""
        hideAllChars()
        charGuessed = 0
    }
    //-------------------------------------------------------------------
    /**
     Hide labels/chars
    */
    func hideAllChars() {
        oneLabel.isHidden = true
        twoLabel.isHidden = true
        threeLabel.isHidden = true
        fourLabel.isHidden = true
        fiveLabel.isHidden = true
    }
    //-------------------------------------------------------------------
    //MARK: - GuessWordView Delegate
    //-------------------------------------------------------------------
    /**
     Called when user guessed the word = all label shown
    */
    func guessed() {
        self.delegate?.guessed()
    }
    //-------------------------------------------------------------------
    /**
     Called when the char tried is not in the word
    */
    func charNotIn() {
        self.delegate?.charNotIn()
    }
}
//-------------------------------------------------------------------
//MARK: - Extension String
//-------------------------------------------------------------------
extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
    func characterAtIndex(index: Int) -> String? {
        var cur = 0
        for char in self {
            if cur == index {
                return String(char)
            }
            cur += 1
        }
        return nil
    }
}

extension String : Collection {
    
}
