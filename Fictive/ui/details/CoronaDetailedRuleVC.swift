//
//  FeatureDetailedVC.swift
//  Fictive
//
//  Created by Prof Ahyox on 28/11/2020.
//

import UIKit

class CoronaDetailedRuleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var card1View: UIView!
    @IBOutlet weak var importantNoticeLabel: UILabel!
    @IBOutlet weak var statusHintLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusIcon: UIImageView!

    var coronaChecker:CoronaRuleUtil!
    var signals = [Signal]()
    
    let greenLightRulesIcons = ["circle_face", "circle_event", "circle_mask"]
    let yellowLightRulesIcons = ["circle_event", "circle_mask", "circle_curfew"]
    let redLightRulesIcons = ["circle_event", "circle_mask", "circle_curfew"]
    
    var groupedRuleIcons = [[String]]()
    
    
    let coronaLights = ["green_notify.png", "yellow_notify.png", "red_notify.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
        initResources()
    }
    
    func initViews() {
        statusHintLabel.text = LanguageManager.getstatusHint()
        card1View.elevate(color: UIColor.gray, radius: 10)
        importantNoticeLabel.text = LanguageManager.getImportantNote()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 155
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
    }
    
    
    func initResources() {
        groupedRuleIcons.append(greenLightRulesIcons)
        groupedRuleIcons.append(yellowLightRulesIcons)
        groupedRuleIcons.append(redLightRulesIcons)
        
        let currentCaseState = coronaChecker.check()
        statusIcon.image = UIImage(named: coronaLights[currentCaseState - 1])
        
        let textArray = coronaChecker.getRules(state: currentCaseState)
        for i in 0..<textArray.count {
            signals.append(Signal(img: groupedRuleIcons[currentCaseState-1][i], text: textArray[i]))
        }
    }
   
    
    func populateSignalTable(signalStatus:Int) {
        switch signalStatus {
        case GREEN_LIGHT:
            let textArray = LanguageManager.getGreenLightRules()
            for i in 0..<textArray.count {
                signals.append(Signal(img: greenLightRulesIcons[i], text: textArray[i]))
            }
            break
        case YELLOW_LIGHT:
            let textArray = LanguageManager.getYellowLightRules()
            for i in 0..<textArray.count {
                signals.append(Signal(img: yellowLightRulesIcons[i], text: textArray[i]))
            }
            break
        case RED_LIGHT:
            let textArray = LanguageManager.getRedLightRules()
            for i in 0..<textArray.count {
                signals.append(Signal(img: redLightRulesIcons[i], text: textArray[i]))
            }
            break
        default:
            print()
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return signals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedCell", for: indexPath) as! DetailedCell
           
        
        let signal:Signal = signals[indexPath.row]
        cell.phaseIcon.image = UIImage(named: signal.img)
        cell.phaseLabel.text = signal.text
        
        return cell
    }

}
