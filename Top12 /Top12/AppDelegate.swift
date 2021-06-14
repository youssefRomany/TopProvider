//
//  AppDelegate.swift
//  Top12
//
//  Created by Sara Ashraf on 1/7/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit
import GoogleMaps
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import NotificationBannerSwift
import SwiftyJSON
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate ,CLLocationManagerDelegate{
    var locationManager: CLLocationManager = CLLocationManager()
    let gcmMessageIDKey = "gcm.message_id"
    static var FCMTOKEN = ""
    var window: UIWindow?
    var firstOpenApp =  UserDefaults.standard.bool(forKey: "FirstOpenApp")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyAPtNOduCumK0cNs48ik2I-pDvNkG9AxS8")
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
//        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.3286560178, green: 0.7481182814, blue: 0.6407282948, alpha: 1)
        if(UserDefaults.standard.string(forKey: "LoggedNow")  == "no" || UserDefaults.standard.string(forKey: "LoggedNow") == nil){
            defaults.set("", forKey: User_ID)
            self.gotoLogin()
        }else {
            self.gotohomeUser()
        }
        
        
//        print("😰\(Language.currentLanguage())")
//         print("😰\(isAppAlreadyLaunchedOnce())")
//        if (isAppAlreadyLaunchedOnce() == false) {
//            Language.setAppLanguage(lang: "ar-EG")
//            LocalizeBase.changeLanguageToArabic()
//
//        }else{
//            if Language.currentLanguage() == "en" {
//                Language.setAppLanguage(lang: "en")
//                LocalizeBase.changeLanguageToEnglish()
//                //            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
//                //            UserDefaults.standard.synchronize()
//
//            }else{
//                Language.setAppLanguage(lang: "ar-EG")
//               LocalizeBase.changeLanguageToArabic()
//                //            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
//                //            UserDefaults.standard.synchronize()
//            }
//        }
        
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        UNUserNotificationCenter.current().delegate = self
        initNotificationSetupCheck()
        
        return true
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func gotoLogin() {
       
        let rootViewController = self.window!.rootViewController as! UINavigationController
        let mainStoryboard = Storyboard.Main.instantiate(LoginViewController.self)
        rootViewController.pushViewController(mainStoryboard, animated: true)
        
    }
    
    func gotohomeUser() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc =  Storyboard.Main.instantiate(MyTabBAr.self)
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        
        // print("🌸latitude\(lastLocation.coordinate.latitude)")
        // print("🌸latitude\(lastLocation.coordinate.longitude)")
        
        UserDefaults.standard.set(lastLocation.coordinate.latitude, forKey: User_Lat)
        UserDefaults.standard.set(lastLocation.coordinate.longitude, forKey: User_Lng)
        
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        // Print full message.
        print(userInfo)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
        //   hasAllowedNotification = false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        //   hasAllowedNotification = true
        /*
         var token = ""
         for i in 0..<deviceToken.count {
         token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
         }
         print("Registration succeeded! Token: ", token)
         
         if let refreshedToken = InstanceID.instanceID().token() {
         print("InstanceID token: \(refreshedToken)")
         }
         */
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }


}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func registerForLocalNotification(on application:UIApplication) {
        
    }
    
    func dispatchlocalNotification(with title: String, body: String, userInfo: [AnyHashable: Any]? = nil, at date:Date) {
        
    }
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let pushContent = notification.request.content
        let badgeCount = pushContent.badge as? Int
        UIApplication.shared.applicationIconBadgeNumber = badgeCount!
        
        print("will present notification")
        
        print("🤩 \(notification.request.content.body)")
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // custom code to handle push while app is in the foreground
        print("from foreground \(userInfo)")
        NotificationCenter.default.post(name: NSNotification.Name("RefreshCounter"), object: nil, userInfo: nil)
        
        let body = JSON(userInfo[AnyHashable("msg")]!).string
        let title = JSON(userInfo[AnyHashable("title")]!).string
        
        let banner = NotificationBanner(title: title!, subtitle: body!, style: .success)
        banner.subtitleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        banner.subtitleLabel?.font = UIFont(name: "Cairo-Regular", size: 14)
        banner.titleLabel?.textColor = #colorLiteral(red: 0.3286560178, green: 0.7481182814, blue: 0.6407282948, alpha: 1)
        banner.titleLabel?.font = UIFont(name: "Cairo-Regular", size: 17)
        banner.backgroundColor = UIColor.white
        
        banner.dismissOnSwipeUp = true
      
        banner.onTap = {
            banner.dismiss()
        }
        
        
        if (JSON(userInfo[AnyHashable("notification_type")]!).stringValue == "chat") {
            NotificationCenter.default.post(name: Notification.Name("Notify_count"), object: self, userInfo:  ["count": notification.request.content.badge as! Int])
            
            let order = JSON(userInfo[AnyHashable("order")]!).stringValue
            let user = JSON(userInfo[AnyHashable("user")]!).stringValue
            
            let chat_id = ["order_id": order , "user_id" :  user]
            if let saved_chat = UserDefaults.standard.string(forKey: "chat") {
                print("🐏\(saved_chat) ")
                
                if saved_chat == order {
                    NotificationCenter.default.post(name: Notification.Name("didReceiveData"), object: self, userInfo: chat_id)
                }else{
                    banner.show()
                }
            }else{
                banner.show()
            }
            
        }else{
            banner.show()
        
        }
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("did receive response")
        let pushContent = response.notification.request.content
        let badgeCount = pushContent.badge as? Int
        UIApplication.shared.applicationIconBadgeNumber = badgeCount!
        print("🤩 \(response.notification.request.content.body)")
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print("from 🤩🤩🤩🤩🤩 user\(userInfo)")
        NotificationCenter.default.post(name: NSNotification.Name("RefreshCounter"), object: nil, userInfo: nil)
        guard let window = UIApplication.shared.keyWindow else { return }
        var vc = MyTabBAr()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBAr") as! MyTabBAr
        window.rootViewController = vc
        
        if (JSON(userInfo[AnyHashable("notification_type")]!).stringValue == "chat") {
            
            let order = JSON(userInfo[AnyHashable("order")]!).stringValue
            UserDefaults.standard.set(true, forKey: "isMsg")
            
            if getUserID() != nil {
                if getUserID() != "0" {
                    
                    guard let window = UIApplication.shared.keyWindow else { return }
                    var vc = MyTabBAr()
                    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBAr") as! MyTabBAr
                    window.rootViewController = vc
                }
                
            }
            
            
            
        }
        
        completionHandler()
    }
    
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector("statusBar")) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension AppDelegate : MessagingDelegate {
    
    func showAlertAppDelegate(title: String,message : String,buttonTitle: String,window: UIWindow){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        window.rootViewController?.present(alert, animated: false, completion: nil)
    }
    
    
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        //        temp.token = fcmToken
        temp.token = fcmToken
        let token = Messaging.messaging().fcmToken
        
        AppDelegate.FCMTOKEN = token!
        //UserDefaults.standard.set(token, forKey: "FCMTOKEN")
        print("FCM token: \(token ?? "")")
    }
    
    
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    
    
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        NotificationCenter.default.post(name: NSNotification.Name("RefreshCounter"), object: nil, userInfo: nil)

        //when open or return to app when push from fcm direct
        //         let d : [String : Any] = remoteMessage.appData["notification"] as! [String : Any]
        //         let body : String = d["body"] as! String
        //         let title : String = d["title"] as! String
        //         self.showAlertAppDelegate(title: title,message:body,buttonTitle:"اغلاق",window:self.window!)
        
        //        if let d = remoteMessage.appData as? [String : Any] {
        //            if let m = d["body"] as? String {
        //                showNot(b: m)
        //            }else if let m = d["sender_id"] as? String {
        //                print(m)
        //                print("recMsg")
        //                NotificationCenter.default.post(name: NSNotification.Name("recMsg"), object: nil)
        //                //showNot(b: msg.msg)
        //            }else if let m = d["notification_type"] as? String {
        //                print(m)
        //                showNot(b: d["msg"] as! String)
        //            }
        //        }
    }
    // [END ios_10_data_message]
    
    func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func showNot(b:String){
        let notification = UNMutableNotificationContent()
        notification.title = "my own title"
        //notification.subtitle = ""
        notification.body = b
        //notification.badge = 1
        notification.sound = UNNotificationSound.default()
        notification.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
