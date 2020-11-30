//
//  AppDelegate.swift
//  Fictive
//
//  Created by Prof Ahyox on 18/11/2020.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let timer = RepeatingTaskManager(timeInterval: REPEAT_TIME_IN_SEC)
    let backgroundRefreshID = "com.ahyoxsoft.Fictive.refresh"
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        checkBackgroundRefreshStatus()
        return true
    }
    
    func checkBackgroundRefreshStatus() {
        switch UIApplication.shared.backgroundRefreshStatus {
            case .available:
                AppUtility.debugMessage(message: "Background fetch enabled.")
                self.registerBackgroundTask()
                break
            case .denied:
                AppUtility.debugMessage(message: "Background fetch is denied")
        
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                break
            case .restricted:
                startTimerIncaseBackgroundTaskDisabled()
                AppUtility.debugMessage(message: "Background fetch is restricted, e.g. under parental control")
                break
            default:
                AppUtility.debugMessage(message: "Unknown reason")
        }
    }
    
    func registerBackgroundTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundRefreshID, using: nil) { task in
            
            AppUtility.debugMessage(message: "running....")
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func startTimerIncaseBackgroundTaskDisabled() {
        timer.eventHandler = {
            AppUtility.debugMessage(message: "running....")
            self.checkCoronaStatusByCounty()
        }
        timer.resume()
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }
    
    
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: backgroundRefreshID)
        request.earliestBeginDate = Date(timeIntervalSinceNow: REPEAT_TIME_IN_SEC) // Fetch no earlier than 10 minutes from now
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            AppUtility.debugMessage(message: "Could not schedule app refresh: \(error)")
        }
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        
        // Provide an expiration handler for the background task
        // that cancels the operation
        task.expirationHandler = {
            // After all operations are cancelled, the completion block below is called to set the task to complete.
            queue.cancelAllOperations()
        }

         
        let lastOperation = queue.operations.last
        lastOperation?.completionBlock = {
           task.setTaskCompleted(success: !lastOperation!.isCancelled)
        }
        
        
        // Start the operation
        queue.addOperation {
            self.checkCoronaStatusByCounty()
        }

    
        //let isFetchingSuccess = true
        //task.setTaskCompleted(success: isFetchingSuccess)
    }

    func checkCoronaStatusByCounty() {
        if !PrefUtil.getSelectedCounty().isEmpty {
            let param = "county = '\(PrefUtil.getSelectedCounty())'".addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
            let url = "\(BASE_URL)\(FEATURE_SERVIEC_QUERY_PATH)where=\(param!)&outFields=*&outSR=4326&f=json"
            
            AlamofireWrapper.sharedInstance.getRequest(url: url, success: {
                (data:ResponseData) in
                
                if data.features.count > 0 {
                    let coronaRuleUtil = CoronaRuleUtil(feature: data.features[0])
                    
                    let currentCaseState = coronaRuleUtil.check()
                    AppUtility.debugMessage(message: "Previous Case: \(PrefUtil.getCurrentCase()) Now Case: \(coronaRuleUtil.check())")
                    //If corona state status changes, notify user
                    if PrefUtil.getCurrentCase() != currentCaseState {
                        var message = ""
                        for msg in coronaRuleUtil.getRules(state: currentCaseState) {
                            message += "- \(msg)\n\n"
                        }
                        
                        //Send Notofication to user
                        let notification = Notification(title: LanguageManager.getDefaultLocationTitle(), body: message)
                        
                        notification.notify()
                        
                    }
                }
            
            }, failure: {error in
                
            })
        }
    }



    
    
}

