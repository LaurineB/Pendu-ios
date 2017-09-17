//
//  StatsDataManager.swift
//  Pendu
//
//  Created by Laurine Baillet on 16/06/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

import Foundation

class StatsDataManager: NSObject {
    
    var userDefault : UserDefaults?
    //-------------------------------------------------------------------
    //MARK: - Initialisation
    //-------------------------------------------------------------------
    override init() {
        super.init()
        
        userDefault = UserDefaults.standard
    }
    //-------------------------------------------------------------------
    //MARK: - Reset
    //-------------------------------------------------------------------
    func resetStats() {
         //userDefault?.removeObject(forKey: "firstLetterStat")
    }
    //-------------------------------------------------------------------
    //MARK: - Setters
    //-------------------------------------------------------------------
    /**
     Save the first letter tried in a party
    */
    func saveFirstLetterTried(letter : String) {
        /*
        var firstLetterStat : NSDictionary = NSDictionary()
        if(userDefault?.dictionary(forKey: "firstLetterStat") != nil) {
             firstLetterStat = userDefault?.dictionary(forKey: "firstLetterStat") as! NSDictionary
        }
       
        var total  : Int = 0
        if firstLetterStat.object(forKey: "total") != nil {
           total = firstLetterStat.object(forKey: "total") as! Int
        }
        total += 1
        
        var numberOfAppearance : Int = 0
        if firstLetterStat.object(forKey: letter) != nil {
            numberOfAppearance = firstLetterStat.object(forKey: letter) as! Int
        }
        numberOfAppearance += 1
        
        
        firstLetterStat.setValue(numberOfAppearance, forKey: letter)
        firstLetterStat.setValue(total, forKey: "total")
        
        userDefault?.setValue(firstLetterStat, forKey: "firstLetterStat")
        userDefault?.synchronize()
         */
    }
    //-------------------------------------------------------------------
    /**
     Save the letter played
    */
    func saveLetter(letter: Character, life : Int, valid: Bool) {
        
    }
    public struct Tries {
        let letter : Character
        let triesRemaining : Int
        let valid : Bool
        
        var error : NSError
        func toJson() -> String {
            let dict : NSDictionary = ["letter":letter, "triesRemaining":triesRemaining,"valid":valid]
            var jsonText : String = ""
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                jsonText = String(data: jsonData, encoding: .utf8)!
            } catch {
                print(error)
            }
            return jsonText
        }
    }
    //-------------------------------------------------------------------
    /**
     Save the letters tried, the number off letters not valid and the size of the word
    */
    
    public struct Game {
        //Tries
        var tries : NSMutableArray = NSMutableArray()
        var date : Date = Date()
        var wordSize : Int
        var charNotGuessed : Int
        
        func toJson() -> String{
            let jsonArray : NSMutableArray = NSMutableArray()
            var dict : NSDictionary
            for oneTry in tries {
                dict = ["try":(oneTry as! Tries).toJson,"date":date,"wordSize":wordSize,"charNotGuessed":charNotGuessed]
                jsonArray.add(dict)
            }
            
            var jsonText : String = ""
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
                jsonText = String(data: jsonData, encoding: .utf8)!
            } catch {
                print(error)
            }
            return jsonText
        }
        
    }
    
    func saveEndGame(letters : Array<Character>, nLettersMiss : Int, wordSize : Int) {
        
    }
    //-------------------------------------------------------------------
    /**
     Save games
    */
    func BaseDDGames(partyArray : Array<Any>) {
        
    }
    //-------------------------------------------------------------------
    //MARK: - Getters
    //-------------------------------------------------------------------
    /*
    func firstLetterTried() -> NSDictionary {
        return userDefault?.dictionary(forKey: "firstLetterStat") as! NSDictionary
    }
     */
}
