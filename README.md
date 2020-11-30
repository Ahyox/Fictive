# Fictive

This is an iOS app that allows user know what corona virus rule(s) are set within their county. It also notify user(s) if there is/are change(s) in rules.

## Getting Started

* Clone or download the source code from [github](https://github.com/Ahyox/Fictive).
* Open project in Xcode
* Run project

## Library Used
``` Alamofire ```


## App Usage
**BundeslandSearchVC** ViewController display list of bundesland and county in batches of 20 (auto endless scrolling). User get to choose their bundesland or county, the App Store their preference and displays **CoronaDetailedRuleVC** ViewController. This ViewController displays the user selected county rule and regulation.

A background task starts running every ten (10) min to check for changes in the selected county. If there's a notification is pushed to user with all the newly rules applied to that county.

## Project Structure
The project contains four (4) major packages which are
* ui (This contains the user interface of the app)
* model (This contains the data model)
* network (This contains the network / api consumption)
* helper (This contain utility classes or objects)


### Salient Objects Info or Usage

#### Constant.swift
This allows you set and update the app constants and parameter used

#### AlamofireWrapper.swift
This allows you consume api endpoint with ease. See usage below:

* **Step One:** Create a decodable of the expected server response 

```swift
struct Attributes : Decodable {
    var id:Int
    var bundesland:String
    let county:String
    let lastUpdate:String
    let cases7Per100k:Double
    let cases7BundesLandPer100k:Double
    
    enum CodingKeys: String, CodingKey {
        case id = "OBJECTID"
        case bundesland = "BL"
        case county
        case lastUpdate = "last_update"
        case cases7Per100k = "cases7_per_100k"
        case cases7BundesLandPer100k = "cases7_bl_per_100k"
    }
}
```

* **Step Two:** Consume the endpoint with less than 4 line of codes. See below

```swift
   AlamofireWrapper.sharedInstance.getRequest(url: url, success: {
        (data:<Decodable goes here>) in        
        
        //Process success
    }, failure: {error in
        // Process failure
    })
```

#### PrefUtil
This is an utility class for storing user preferences on the app

#### LanguageManager
This provide easy access to string localisation

#### AppDelegate
This is where the background task of 10 min is done. It first check if background fetch is allowed by user, if yes it register a background fetch whenever the app is in background else it uses a scheduled timer. 

If any changes happens within the user county it notifies the user if notification permission is allowed.


## NOTE
Background fetch is used because when the app goes to background, timer stops.
