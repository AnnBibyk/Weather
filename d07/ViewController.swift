//
//  ViewController.swift
//  d07
//
//  Created by Anna BIBYK on 1/23/19.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var requestField: UITextField!
    
    @IBOutlet weak var answerField: UILabel!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answearButton(_ sender: UIButton) {
        guard let text = requestField.text?.trimmingCharacters(in: .whitespaces) else { return }
        if text.isEmpty { return }
        
        if let queston = requestField.text {
            networkManager.getLocation(queston, completion: { [weak self] (answer) in
                DispatchQueue.main.async {
                    self?.answerField.text = answer
                }
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
//
//    var bot : RecastAIClient?
//    var client: DarkSkyClient?
//
//    let myToken = "3cd97a9f54ceeffbdf17d56aa2c898d4"
//    let darkToken  = "76637466482e672bcc9f936626f6c40d"
//
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        self.bot = RecastAIClient(token : myToken)
//        self.bot = RecastAIClient(token : myToken, language: "en")
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func makeRequest()
//    {
//        //Call makeRequest with string parameter to make a text request
//        self.bot?.textRequest(<#T##request: String##String#>, successHandler: <#T##(Response) -> Void#>, failureHandle: <#T##(Error) -> Void#>)
//    }

}

