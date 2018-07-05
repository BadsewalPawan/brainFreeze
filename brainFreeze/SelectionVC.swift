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
    var iLastScore:Int! = 0
    var iHighScore:Int! = 0
    var iHighScoreDefault = UserDefaults.standard
    
    @IBOutlet var highScorelbl: UILabel!
    
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(iHighScoreDefault.value(forKey: "HighScore") == nil ){
            iHighScore = 0
        }else{
            iHighScore = iHighScoreDefault.value(forKey: "HighScore") as? Int
        }
        if(iLastScore > iHighScore){
            iHighScore = iLastScore
            iHighScoreDefault.set(iHighScore, forKey: "HighScore")
            iHighScoreDefault.synchronize()
        }
        highScorelbl.text = "Higest score " + String(iHighScore)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
