//
//  StatsViewController.swift
//  Pendu
//
//  Created by Laurine Baillet on 16/06/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    var statsDataManager : StatsDataManager?
    
    //FirstLetterStat
    @IBOutlet weak var firstLetterFirst: UILabel!
    @IBOutlet weak var firstLetterSecond: UILabel!
    @IBOutlet weak var firstLetterThird: UILabel!
    
    //-------------------------------------------------------------------
    //-------------------------------------------------------------------
    // NB : Si j'avais eu du temps, j'aurai fait une tableView qui redirigeais 
    // vers les différentes sections
    //-------------------------------------------------------------------
    //-------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        statsDataManager = StatsDataManager.init()
        
        setFirstLetterStat()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------------
    func setFirstLetterStat() {
        //var dictionary : NSDictionary = statsDataManager!.firstLetterTried()
        
        //firstLetterThird.text = dictionary.description
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
