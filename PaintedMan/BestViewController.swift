//
//  BestViewController.swift
//  PaintedMan
//
//  Created by ООО АКИП on 10.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import UIKit
import Alamofire

class BestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static let url = "https://upachi.com"
    
    @IBAction func onNameChangedClick(_ sender: Any) {
        
        Const.userName = etName.text
        
        struct Params: Encodable {
            let method  : String
            let user    : String
            let name    : String
        }
        
        let params = Params(method: "setUserName", user: UIDevice.current.identifierForVendor!.uuidString, name: Const.userName ?? "")
        
        let request = AF.request(BestViewController.url + "/paintedman/best.php", method: .post, parameters: params, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
        request.validate().response { response in
            print(response)
            self.loadData()
        }
        
    }
    
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var etName: UITextField!
    
    var surviveBestArray: [BestScores] = [BestScores(name: "Survive", score: 0)]
    var punchBestArray: [BestScores] = [BestScores(name: "Punch", score: 0)]
    var catchBestArray: [BestScores] = [BestScores(name: "Catch", score: 0)]
    
    var currentTabArray: [BestScores] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            currentTabArray = surviveBestArray
            labelScore.text = String(Const.bestSurvive)
        case 1:
            currentTabArray = punchBestArray
            labelScore.text = String(Const.bestPunch)
        case 2:
            currentTabArray = catchBestArray
            labelScore.text = String(Const.bestCatch)
        default:
            currentTabArray = surviveBestArray
            labelScore.text = String(Const.bestSurvive)
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Const.userName == nil) {
            let name = "user" + String(UIDevice.current.identifierForVendor!.uuidString).prefix(7)
            Const.userName = name
        }
        
        etName.text = Const.userName
        
        setData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTabArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bestTableViewCell") as! BestTableViewCell
        let item = currentTabArray[indexPath.row]
        
        cell.labelCount.text = "\(indexPath.row + 1)"
        cell.labelName.text = item.name
        cell.labelScore.text = "\(item.score)"
        
        return cell
    }
    
    private func setData() {
        
        struct Params: Encodable {
            let lang      : String
            let user      : String
            let method    : String
            let survive   : Int
            let catch_    : Int
            let punch     : Int
        }
        
        let params = Params(lang: Bundle.main.preferredLocalizations.first!, user: UIDevice.current.identifierForVendor!.uuidString, method: "setData",
                            survive: Const.bestSurvive,
                            catch_: Const.bestCatch,
                            punch: Const.bestPunch)
        
        let request = AF.request(BestViewController.url + "/paintedman/best.php", method: .post, parameters: params, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
        
        request.validate().responseJSON { response in
            print(response)
            self.loadData ()
        }.cURLDescription { description in
            print(description)
        }
        
    }
    
    private func loadData () {
        
        let request = AF.request(BestViewController.url + "/paintedman/best.php", method: .get, encoding: JSONEncoding.default)
        //debugPrint(request)
        request.responseJSON { response in
            
            self.surviveBestArray = []
            self.punchBestArray = []
            self.catchBestArray = []
            
            switch response.result {
            case .success(let JSON):
                
                let arrayResponse = JSON as! NSDictionary
                
                (arrayResponse["survive"] as? NSArray)?.forEach { it in
                    guard let best = it as? NSDictionary else {
                        return
                    }
                    self.surviveBestArray.append(BestScores(name: best["name"] as? String ?? "-", score: best["score"] as? Int ?? 0))
                }
                
                (arrayResponse["punch"] as? NSArray)?.forEach { it in
                    guard let best = it as? NSDictionary else {
                        return
                    }
                    self.punchBestArray.append(BestScores(name: best["name"] as? String ?? "-", score: best["score"] as? Int ?? 0))
                }
                
                (arrayResponse["catch"] as? NSArray)?.forEach { it in
                    guard let best = it as? NSDictionary else {
                        return
                    }
                    self.catchBestArray.append(BestScores(name: best["name"] as? String ?? "-", score: best["score"] as? Int ?? 0))
                }
                
                self.indexChanged(self.segmentController)
                
            default:
                self.surviveBestArray.append(BestScores(name: "Can't load data", score: 0))
                print(response.error?.errorDescription ?? "-", response.response?.statusCode ?? "-")
            }
            
            self.indexChanged(self.segmentController)
        }
    }
    
}

class BestScores {
    
    let name: String
    let score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
}

class BestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
}
