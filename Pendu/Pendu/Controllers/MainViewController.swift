//
//  MainViewController.swift
//  Pendu
//
//  Created by Laurine Baillet on 16/06/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var containerGuessWordView: UIView!
    @IBOutlet weak var containerHangedGuy: UIView!
    
    var hangedGuyView : HangedGuyView?
    var guessWordView : GuessWordView?
    var statsDataManager : StatsDataManager?
    
    @IBOutlet weak var tryCharTextField: UITextField!
    @IBOutlet weak var tryButton: UIButton!
    
    @IBOutlet weak var otherGameButton: UIButton!
    
    var gameRunning : Bool = false
    var firstLetter : Bool = false
    
    let words : Array = ["mufle", "miche", "légal", "creez", "corse", "miens", "laque", "melon", "rugby", "rimer", "devez", "ouate", "vaque", "brode", "notre", "usons", "mulet", "djinn", "phlox", "cauri", "sassa", "doris", "mayas", "foras", "posas", "bonne", "mites", "aphte", "cumul", "peurs", "taras", "micas",   "hiver", "axant", "garda", "igues", "fraie", "basic", "doges", "lento", "taire", "muras", "freux", "brife", "staff", "trait", "louez", "jurys", "quine",  "civil", "culez", "dames", "caqua", "rural", "pesas", "nouas", "azote","cidre","point", "minet", "tirer", "baffe", "delco", "blanc", "capes", "coure", "marcs", "jodla"]
    
    //-------------------------------------------------------------------
    //MARK: - Initialisation
    //-------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsDataManager = StatsDataManager.init()
        
        // Do any additional setup after loading the view.
        
        let guessViewFromNib = Bundle.main.loadNibNamed("GuessWord",
                                                        owner: nil,
                                                        options: nil)?.first as! GuessWordView
        guessWordView = guessViewFromNib
        guessWordView?.delegate = self
        guessWordView?.frame = CGRect(x:0, y: 0, width: 300, height: 100)
        containerGuessWordView.addSubview(guessWordView!)
        
        let hangedGuyViewFromNib = Bundle.main.loadNibNamed("HangedGuy",
                                                            owner: nil,
                                                            options: nil)?.first as! HangedGuyView
        hangedGuyView = hangedGuyViewFromNib
        hangedGuyView?.delegate = self
        hangedGuyView?.frame = CGRect(x:5, y: 5, width: 300, height: 100)
        containerHangedGuy.addSubview(hangedGuyView!)
        
        otherGameButton.isHidden = true
        
        startGame()
        
    }
    //-------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------------
    //MARK: - Game Methods
    //-------------------------------------------------------------------
    /**
     Start a new game and initialise a new word.
    */
    func startGame() {
        gameRunning = true
        firstLetter = true
        otherGameButton.isHidden = true
        tryCharTextField.isHidden = false
        tryButton.isHidden = false
        
        let random = Int(arc4random_uniform(UInt32(words.count)))
        let wordToGuess : String = words[random]
        
        guessWordView?.initWithWord(word: wordToGuess)
        
    }
    //-------------------------------------------------------------------
    /**
     Stop the game. Hide Text field and button used to play
    */
    func endGame() {
        gameRunning = false
        otherGameButton.isHidden = false
        
        tryCharTextField.isHidden = true
        tryButton.isHidden = true
    }
    //-------------------------------------------------------------------
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //-------------------------------------------------------------------
    //MARK: - Action Button
    //-------------------------------------------------------------------
    /**
      Try to guess a char
    */
    @IBAction func tryAction(_ sender: UIButton) {
        if(gameRunning) {
            if(tryCharTextField.text != nil && tryCharTextField.text != "" && tryCharTextField.text?.characters.count == 1) {
                if(firstLetter) {
                    firstLetter = false
                    statsDataManager?.saveFirstLetterTried(letter: tryCharTextField.text!)
                }
                guessWordView?.tryChar(char: Character(tryCharTextField.text!))
            }
        }
    }
//-------------------------------------------------------------------
    /**
     Ask to start a new game
    */
    @IBAction func otherGame(_ sender: UIButton) {
        guessWordView?.clear()
        hangedGuyView?.clear()
        startGame()
    }
    
}
//-------------------------------------------------------------------
//MARK: - HangedGuyViewDelegate
//-------------------------------------------------------------------
extension MainViewController : HangedGuyViewDelegate {
    /**
     No try remaining. Game over
    */
    func dead() {
        let alert = UIAlertController(title: "Oups", message: "Hanged guy died", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok, no matter", style: UIAlertActionStyle.default, handler:{ action in
        self.endGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
//-------------------------------------------------------------------
//MARK: - GuessWordViewDelegate
//-------------------------------------------------------------------
extension MainViewController : GuessWordViewDelegate {
    /**
     The word is guessed. Game win
    */
    func guessed() {
        let alert = UIAlertController(title: "YES", message: "You did it", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok, I knew it", style: UIAlertActionStyle.default, handler:{ action in
            self.endGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    //-------------------------------------------------------------------
    /**
     Char not in the word
    */
    func charNotIn() {
        hangedGuyView?.removeTry()
    }
}
