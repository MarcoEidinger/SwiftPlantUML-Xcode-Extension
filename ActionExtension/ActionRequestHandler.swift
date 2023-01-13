//
//  ActionRequestHandler.swift
//  ActionExtension
//
//  Created by Marco Eidinger on 1/13/23.
//

import ApplicationServices
import Foundation
import XPCService
import SwiftPlantUMLFramework

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {

    lazy var connection: NSXPCConnection = {
        let connection = NSXPCConnection(serviceName: "us.eidinger.SwiftPlantUMLXPCService")
        connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        connection.resume()
        return connection
    }()

    deinit {
        connection.invalidate()
    }
    
    func beginRequest(with context: NSExtensionContext) {
        precondition(context.inputItems.count == 1)
        guard let inputItem = context.inputItems[0] as? NSExtensionItem
            else { preconditionFailure("Expected an extension item") }
        guard let inputAttachments = inputItem.attachments
            else { preconditionFailure("Expected a valid array of attachments") }
        precondition(inputAttachments.isEmpty == false, "Expected at least one attachment")
        
        guard let inputAttachments = inputItem.attachments
            else { preconditionFailure("Expected a valid array of attachments") }
        
        let handler: (Error) -> Void = { error in
            print("remote proxy error: \(error)")
        }
        let service = connection.remoteObjectProxyWithErrorHandler(handler) as! XPCServiceProtocol
        
        for attachment in inputAttachments {
            attachment.loadInPlaceFileRepresentation(forTypeIdentifier: "public.swift-source") { url, inPlace, error in
                print("yoo")
                guard let url = url else { return }
                var path = url.path
                service.generateDiagram(for: [path]) {
                    print("Done")
                }
//                service.generateDiagram(from: "struct Meep {}") {
//                    print("done")
//                }
            }
        }
        
        
            
        context.completeRequest(returningItems: [inputItem], completionHandler: nil)
    }

}
