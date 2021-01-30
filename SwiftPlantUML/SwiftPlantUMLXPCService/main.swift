//
//  main.swift
//  SwiftPlantUMLXPCService
//
//  Created by Eidinger, Marco on 1/30/21.
//

import Foundation

class ServiceDelegate : NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: SwiftPlantUMLXPCServiceProtocol.self)
        let exportedObject = SwiftPlantUMLXPCService()
        newConnection.exportedObject = exportedObject
        newConnection.resume()
        return true
    }
}

// Create the listener and resume it:
let delegate = ServiceDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate;
listener.resume()
