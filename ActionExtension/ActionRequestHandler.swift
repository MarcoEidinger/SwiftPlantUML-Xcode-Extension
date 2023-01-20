//
//  ActionRequestHandler.swift
//  ActionExtension
//
//  Created by Marco Eidinger on 1/13/23.
//

import Foundation
import XPCService

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
        // For an Action Extension there will only ever be one extension item.
        precondition(context.inputItems.count == 1)
        guard let inputItem = context.inputItems[0] as? NSExtensionItem
            else { preconditionFailure("Expected an extension item") }
        
        // The extension item's attachments hold the set of files to process.
        guard let inputAttachments = inputItem.attachments
            else { preconditionFailure("Expected a valid array of attachments") }
        precondition(inputAttachments.isEmpty == false, "Expected at least one attachment")
        
        // The output of this extension is the existing swift files
        guard let inputAttachments = inputItem.attachments
            else { preconditionFailure("Expected a valid array of attachments") }
        
        let handler: (Error) -> Void = { error in
            print("remote proxy error: \(error)")
        }
        let service = connection.remoteObjectProxyWithErrorHandler(handler) as! XPCServiceProtocol
        var paths: [String] = []
        
        // Use a dispatch group to synchronise asynchronous calls to loadInPlaceFileRepresentation.
        let dispatchGroup = DispatchGroup()
        
        for attachment in inputAttachments {
            dispatchGroup.enter()
            
            attachment.loadInPlaceFileRepresentation(forTypeIdentifier: "public.swift-source") { url, inPlace, error in
                if let url = url {
                    paths.append(url.path)
                }

                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            service.generateDiagram(for: paths) {
                context.completeRequest(returningItems: [inputItem], completionHandler: nil)
            }
        }
    }

}
