//
//  SelectionVC.swift
//  brainFreeze
//
//  Created by Pawan Badsewal on 11/06/18.
//  Copyright © 2018 Pawan Badsewal. All rights reserved.
//

import UIKit

class SelectionVC: UIViewController {
    
    var gameMode:String!
    var iLastScore:Int = 0
    var iHigestScore:Int = 0
    
    @IBOutlet var lastScorelbl: UILabel!
    @IBOutlet var higestScorelbl: UILabel!
    
    @IBAction func selectionAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            gameMode = "add"
        case 2:
            gameMode = "subtract"
        case 3:
            gameMode = "multiply"
        case 4:
            gameMode = "divide"
        case 5:
            gameMode = "mixed"
        default:
            break
        }
        performSegue(withIdentifier: "rushSegue", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let RushVC = segue.destination as! RushVC
        RushVC.receivedgameMode = gameMode
        RushVC.iHigestScore = iHigestScore
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (iLastScore > iHigestScore){
            iHigestScore = iLastScore
            higestScorelbl.text = String(iHigestScore)
        }
        lastScorelbl.text = String(iLastScore)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
