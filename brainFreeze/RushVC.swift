//
//  RushVC.swift
//  brainFreeze
//
//  Created by Pawan Badsewal on 11/06/18.
//  Copyright © 2018 Pawan Badsewal. All rights reserved.
//

import UIKit
import AVFoundation

class RushVC: UIViewController {
    
    var iRandomSpot:Int!
    var iCorrectCount:Int = 0
    var iWrongCount:Int = 0
    var iScoreCount:Int = 0
    var iCorrctBtnTag:Int?
    var receivedgameMode:String!
    var gameMode:String!
    var iFirstNum:Int!
    var iSecondNum:Int!
    var iAnswer:Int! = 0
    var iOptAccuracy:Int! = 50
    var iFirstOption:Int! = 0
    var iSecondOption:Int! = 0
    var iThirdOption:Int! = 0
    var optionArray:[Int]!
    var randomArray = [Int]()
    var btnArray = [UIButton]()
    var timer:Timer = Timer()
    var numRange:UInt32! = 10
    var dummyVariable:Int = 0
    var iHigestScore:Int!
    var AudioPlayer: AVAudioPlayer!
    
    
    @IBOutlet var wrongAns1: UIImageView!
    @IBOutlet var wrongAns2: UIImageView!
    @IBOutlet var wrongAns3: UIImageView!
    @IBOutlet var uiViewTimer: GradientView!
    @IBOutlet var questionLbl: UILabel!
    @IBOutlet var firstOptBtn: UIButton!
    @IBOutlet var secondOptBtn: UIButton!
    @IBOutlet var thirdOptBtn: UIButton!
    @IBOutlet var fourthOptBtn: UIButton!
    
    
    func generateQuestion(){
        resetBackground()
        if (receivedgameMode == "mixed"){
            switch arc4random_uniform(4){
            case 0:
                gameMode = "add"
            case 1:
                gameMode = "subtract"
            case 2:
                gameMode = "multiply"
            case 3:
                gameMode = "divide"
            default:
                break
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        UIApplication.shared.endIgnoringInteractionEvents()
        iFirstNum = Int(arc4random_uniform(UInt32(numRange)))
        iSecondNum = Int(arc4random_uniform(UInt32(numRange)))
        
        switch gameMode {
        case "add":
            questionLbl.text = String(iFirstNum) + " + " + String(iSecondNum)
            iAnswer = iFirstNum + iSecondNum
        case "subtract":
            if (iFirstNum > iSecondNum ){
                questionLbl.text = String(iFirstNum) + " - " + String(iSecondNum)
                iAnswer = iFirstNum - iSecondNum
            }else{
                questionLbl.text = String(iSecondNum) + " - " + String(iFirstNum)
                iAnswer = iSecondNum - iFirstNum
            }
        case "multiply":
            questionLbl.text = String(iFirstNum) + " X " + String(iSecondNum)
            iAnswer = iFirstNum * iSecondNum
        case "divide":
            if (iSecondNum == 0){
                questionLbl.text = String(iFirstNum) + " ÷ " + String(iSecondNum+1)
                iAnswer = iFirstNum / (iSecondNum+1)
            }else{
                while(floor(Double(iFirstNum) / Double(iSecondNum)) != Double(iFirstNum) / Double(iSecondNum)){
                    iFirstNum = Int(arc4random_uniform(UInt32(numRange)))
                    iSecondNum = Int(arc4random_uniform(UInt32(numRange)))+1
                }
                questionLbl.text = String(iFirstNum) + " ÷ " + String(iSecondNum)
                iAnswer = iFirstNum / iSecondNum
            }
        default:
            break
        }
        
        repeat{
            iFirstOption = Int(arc4random_uniform(UInt32(iAnswer + iOptAccuracy)))
            iSecondOption = Int(arc4random_uniform(UInt32(iAnswer + iOptAccuracy + 10)))
            iThirdOption = Int(arc4random_uniform(UInt32(iAnswer + iOptAccuracy + 20)))
        }while (iAnswer == iFirstOption || iAnswer == iSecondOption || iAnswer == iThirdOption && iFirstOption != iSecondOption && iFirstOption != iThirdOption)
        optionArray = [iFirstOption, iSecondOption, iThirdOption, iAnswer]
        
        for _ in optionArray{
            dummyVariable = Int(arc4random_uniform(UInt32((optionArray.count))))
            randomArray.append(optionArray[dummyVariable])
            optionArray.remove(at: dummyVariable)
        }
        print(randomArray)
        dummyVariable = 0
        for btn in btnArray{
            btn.setTitle(String(randomArray[dummyVariable]), for: UIControlState())
            btn.backgroundColor = UIColor.clear
            dummyVariable += 1
        }
        dummyVariable = 0
    }
    
    func playCorrectSound(){
        let path = Bundle.main.path(forResource: "correctSoundEffect" , ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do{
            AudioPlayer = try AVAudioPlayer(contentsOf: url)
            AudioPlayer.prepareToPlay()
        }
        catch let error as NSError{
            print(error.description)
        }
        AudioPlayer.play()
    }
    
    func playIncorrectSound(){
        let path = Bundle.main.path(forResource: "incorrectSoundEffect" , ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do{
            AudioPlayer = try AVAudioPlayer(contentsOf: url)
            AudioPlayer.prepareToPlay()
        }
        catch let error as NSError{
            print(error.description)
        }
        AudioPlayer.play()
    }
    
    func wrongAnswer(){
        playIncorrectSound()
        iWrongCount += 1
        switch iWrongCount {
        case 1:
            wrongAns1.image = UIImage(named: "wrongAns")
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(generateNextQuestion), userInfo: nil, repeats: false)
        case 2:
            wrongAns2.image = UIImage(named: "wrongAns")
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(generateNextQuestion), userInfo: nil, repeats: false)
        case 3:
            wrongAns3.image = UIImage(named: "wrongAns")
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(goToSelectionVC), userInfo: nil, repeats: false)
        default:
            break
        }
    }
    
    func resetBackground(){
        uiViewTimer.startLocation = 0
        uiViewTimer.endLocation = 0.01
        randomArray.removeAll()
    }
    
    @objc func generateNextQuestion(){
        generateQuestion()
    }
    
    @objc func goToSelectionVC(){
        UIApplication.shared.endIgnoringInteractionEvents()
        performSegue(withIdentifier: "selectionSegue", sender: Any?.self)
    }
    
    @objc func timerAction(){
        uiViewTimer.startLocation += 0.01
        uiViewTimer.endLocation += 0.01
        if (uiViewTimer.startLocation >= 1){
            timer.invalidate()
            UIApplication.shared.beginIgnoringInteractionEvents()
            for btn in btnArray{
                if(btn.titleLabel?.text == String(iAnswer)){
                    btn.backgroundColor = UIColor(red: 88/255, green: 187/255, blue: 92/255, alpha: 1)}
            }
            playIncorrectSound()
            wrongAnswer()
        }
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        timer.invalidate()
        UIApplication.shared.beginIgnoringInteractionEvents()
        for btn in btnArray{
            if(btn.titleLabel?.text == String(iAnswer)){
                btn.backgroundColor = UIColor(red: 88/255, green: 187/255, blue: 92/255, alpha: 1)}
        }
        numRange = UInt32(Int(numRange)+10)
        if(sender.titleLabel?.text == String(iAnswer)){
            playCorrectSound()
            iScoreCount += 1
            iCorrectCount += 1
            if (iOptAccuracy > 0){
                if ((iCorrectCount % 5) == 0){
                    iOptAccuracy = Int(iOptAccuracy) - 5}
            }
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(generateNextQuestion), userInfo: nil, repeats: false)
        }else{
            sender.backgroundColor = UIColor(red: 190/255, green: 55/255, blue: 41/255, alpha: 1)
            wrongAnswer()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameMode = receivedgameMode
        btnArray = [firstOptBtn, secondOptBtn, thirdOptBtn, fourthOptBtn]
        generateQuestion()
        wrongAns1.image = UIImage(named: "multiply")
        wrongAns2.image = UIImage(named: "multiply")
        wrongAns3.image = UIImage(named: "multiply")
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
