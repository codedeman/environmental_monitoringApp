//
//  SocketSevices.swift
//  Runner
//
//  Created by Apple on 10/16/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import SocketIO
let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])


class SocketServices:NSObject {
    
    static let instance = SocketServices()
    
    let socket = manager.defaultSocket
    
    
    func onDataChange(place_id:String,completion:@escaping CompletionHandler)  {
        
        socket.on(place_id) { (data, message) in
            
            print("data base \(data)")
            
        }
        

    }
    
    func getNotify(){
        
        socket.on("notify", callback: { (data,message )  in


            print("notify right here \(data)")

            
        })
        
        
        
    }
    
    
}
