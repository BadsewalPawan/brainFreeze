//
//  launchVC.swift
//  brainFreeze
//
//  Created by Pawan Badsewal on 14/06/18.
//  Copyright © 2018 Pawan Badsewal. All rights reserved.
//

import UIKit

class launchVC: UIViewController {

    var timer:Timer = Timer()
    
    @objc func segue(){
        performSegue(withIdentifier: "launchScreenSegue", sender: Any?.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(segue), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
