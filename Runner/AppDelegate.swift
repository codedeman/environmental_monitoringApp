import UIKit
import Flutter
import SwiftyJSON
import UserNotificationsUI
import UserNotifications
import Alamofire



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
    let manager = NetworkReachabilityManager(host: BASE_URL)
    

       
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    // satus connect 
    manager?.listener = { status in
        
        
        switch status {
        case .notReachable:
            print("Lost connect")
            break
        case .reachable(_):
            print("Connected")
            break
        default:
            
            print("unknow")
            
        }
        
        
    }
    manager?.startListening()

    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterBasicMessageChannel(name: "cross",
                                                binaryMessenger: controller.binaryMessenger,codec: FlutterStringCodec.sharedInstance())

    let backgroundChannel = FlutterBasicMessageChannel(name: "backgroundService", binaryMessenger: controller.binaryMessenger,codec: FlutterJSONMessageCodec.sharedInstance())
    
    
    backgroundChannel.setMessageHandler { (message:Any, reply:FlutterReply) in
        
        let json = JSON(parseJSON: message as! String)
        
        
        print("Jocker \(json)")
        
      guard let statusService =  json["command"] as? String else { return }
        
        if statusService == "start_service"{
            
            guard let args =  json["args"] as? String else { return }
            //
            guard let token  =  json["token"] as? String else { return }
            
            guard let place_id = json["place_id"] as? String else {return}
        
            
            SocketServices.instance.onDataChange(place_id: place_id) { (success) in
                
            
                if success{
                    
                    print("Hello I'm Here")
                }else{
                    
                    print("What the hell")
                }
                
            }
            
            
        }
        
//        switch statusService{
//
//        case "start_service":
//
//        guard let args =  json["args"] as? String else { return }
//
//        guard let token  =  json["token"] as? String else { return }
//
//
//            print("token \(token)")
//
//
//
//            break
//
//
//        default:
//
//
//            print("Stop service")
//            break
//
//        }
        
        
            
        
    }
    
    
    
    


    // Send message to Dart and receive reply.


    channel.sendMessage("Hello, world") {(reply: Any?) -> Void in

        print("Received")


    }
    // Receive messages from Dart and send replies.

    channel.setMessageHandler {
      (message: Any?, reply: FlutterReply) -> Void in
        
        print("Received")
//        print("\(type: .infor, message as! String)")
//      os_log("Received: %@", type: .info, message as! String)
      reply("Hi from iOS")
    }

        
    

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//
    
    
  
    
  
}
