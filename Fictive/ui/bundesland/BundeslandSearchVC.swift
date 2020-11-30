//
//  BundeslandSearchVC.swift
//  Fictive
//
//  Created by Prof Ahyox on 29/11/2020.
//

import UIKit

class BundeslandSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var refreshController = UIRefreshControl()
    var firstLoading:Bool = false
    
    var featureList = [Features]()
    var filteredFeatures: [Features] = []
    
    let OFFSET = 20
    var min = 1
    var max = 20

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        askForNotificationPermission()
        
        featureList.removeAll()
        tableView.reloadData()
        loadFeature()
        
    }
    
    func initView () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 76
        
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
               
        refreshController.attributedTitle = NSAttributedString(string: LanguageManager.getPullToRefreshMessage())
        
        refreshController.addTarget(self, action: #selector(loadFeature), for: .valueChanged)
        tableView.addSubview(refreshController)
        
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = LanguageManager.getSearchHint()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func askForNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if error != nil {
                DispatchQueue.main.async {
                    AppUtility.alertMessage(title: LanguageManager.getErrorTitle(), message: LanguageManager.getNotificationRefused(), view: self)
                }
            }
        }
    }

    @objc func loadFeature() {
        self.refreshController.endRefreshing()
        let spinner = AppUtility.displaySpinner(onView: self.view)
        
        
        let param = "OBJECTID >= \(min) AND OBJECTID <= \(max)".addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        
        let url = "\(BASE_URL)\(FEATURE_SERVIEC_QUERY_PATH)where=\(param!)&outFields=*&outSR=4326&f=json"
        
        AlamofireWrapper.sharedInstance.getRequest(url: url, success: {
            (data:ResponseData) in
            
            AppUtility.removeSpinner(spinner: spinner)
            
            for feature in data.features {
                self.featureList.append(feature)
            }
            self.tableView.reloadData()
            
            if data.features.count > 0 {
                self.min += self.OFFSET
                self.max += self.OFFSET
            }
        }, failure: {error in
            AppUtility.removeSpinner(spinner: spinner)
            AppUtility.alertMessage(title: LanguageManager.getErrorTitle(), message: LanguageManager.getErrorMessage(), view: self)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredFeatures.count
        }
        return featureList.count
    }
         
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BundeslandItemViewCell", for: indexPath) as! BundeslandItemViewCell
           
        
        let feature:Features
        
        if isFiltering {
            feature = filteredFeatures[indexPath.row]
        } else {
            feature = featureList[indexPath.row]
        }
        
        cell.bundeslandLabel.text = feature.attributes.bundesland
        cell.countyLabel.text = feature.attributes.county
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
           
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            //Update the next page
        
            loadFeature()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let feature:Features
        
        if isFiltering {
            feature = filteredFeatures[indexPath.row]
        } else {
            feature = featureList[indexPath.row]
        }
        
        //Display alert
        self.presentAlertWithTitle(title: LanguageManager.getInfoMessage(), message: LanguageManager.getcountyAlertMessage(), options: LanguageManager.getNo(), LanguageManager.getYes()) { (option) in
                   
            switch(option) {
                case 1:
                    self.featureSelection(feature: feature)
                    break
                default:
                    break
            }
        }

    }
    
    func featureSelection(feature:Features) {
        let coronaChecker = CoronaRuleUtil(feature: feature)
        PrefUtil.setSelectedCounty(county: feature.attributes.county)
        PrefUtil.setCurrentCase(currentCase: coronaChecker.check())
        
        //Open Feature Detailed Page  FeatureDetailledVC
        let detailedFeatureVC = STORY_BOARD.instantiateViewController(withIdentifier: "CoronaDetailedRuleVC") as! CoronaDetailedRuleVC
        
        detailedFeatureVC.coronaChecker = coronaChecker
        detailedFeatureVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailedFeatureVC, animated: true)
    }

}


extension BundeslandSearchVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterSearchContent(searchBar.text!)
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterSearchContent(_ searchText: String) {
        filteredFeatures = featureList.filter { (feature: Features) -> Bool in
            return feature.attributes.bundesland.lowercased().contains(searchText.lowercased())
        }
      
        tableView.reloadData()
    }

}

extension UIViewController {
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                    completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
