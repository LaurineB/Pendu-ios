//
//  HangedGuyView.swift
//  Pendu
//
//  Created by Laurine Baillet on 16/06/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

import UIKit

protocol HangedGuyViewDelegate {
    func dead()
}

class HangedGuyView: UIView {

    @IBOutlet weak var sol: UIImageView!
    @IBOutlet weak var poteau: UIImageView!
    @IBOutlet weak var transverse: UIImageView!
    @IBOutlet weak var corde: UIImageView!
    @IBOutlet weak var tete: UIImageView!
    @IBOutlet weak var corps: UIImageView!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var bd: UIImageView!
    @IBOutlet weak var jg: UIImageView!
    @IBOutlet weak var jd: UIImageView!
    
    var delegate : HangedGuyViewDelegate?
    var tryCount : Int = 0
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        clear()
    }
    //-------------------------------------------------------------------
    /**
     Number of try -1
    */
    func removeTry() {
        switch tryCount {
        case 0:
            sol.isHidden = false
            tryCount += 1
        case 1:
            poteau.isHidden = false
            tryCount += 1
        case 2:
            transverse.isHidden = false
            tryCount += 1
        case 3:
            corde.isHidden = false
            tryCount += 1
        case 4:
            tete.isHidden = false
            tryCount += 1
        case 5:
            corps.isHidden = false
            tryCount += 1
        case 6:
            bg.isHidden = false
            tryCount += 1
        case 7:
            bd.isHidden = false
            tryCount += 1
        case 8:
            jg.isHidden = false
            tryCount += 1
        case 9:
            jd.isHidden = false
            dead()
        default:
            clear()
        }
    }
    
    //-------------------------------------------------------------------
    /**
     Clear the hanged guy view
    */
    func clear() {
        sol.isHidden = true
        poteau.isHidden = true
        transverse.isHidden = true
        corde.isHidden = true
        tete.isHidden = true
        corps.isHidden = true
        bg.isHidden = true
        bd.isHidden = true
        jg.isHidden = true
        jd.isHidden = true
        
        tryCount = 0
    }
    //-------------------------------------------------------------------
    //MARK : - HangedGuyViewDelegate
    //-------------------------------------------------------------------
    /**
     Called when number of tries == 0
    */
    func dead() {
        self.delegate?.dead()
    }
}
