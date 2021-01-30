//
//  SourceEditorCommand.swift
//  SwiftPlantUMLSourceEditorExtension
//
//  Created by Eidinger, Marco on 1/27/21.
//

import Foundation
import XcodeKit
//import SwiftPlantUMLFramework
import ApplicationServices

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

    lazy var connection: NSXPCConnection = {
        let connection = NSXPCConnection(serviceName: "us.eidinger.SwiftPlantUMLXPCService")
        connection.remoteObjectInterface = NSXPCInterface(with: SwiftPlantUMLXPCServiceProtocol.self)
        connection.resume()
        return connection
    }()

    deinit {
        connection.invalidate()
    }

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

        let handler: (Error) -> () = { error in
            print("remote proxy error: \(error)")
        }
        let service = connection.remoteObjectProxyWithErrorHandler(handler) as! SwiftPlantUMLXPCServiceProtocol

        var code = invocation.buffer.completeBuffer

//        if let firstSelection = invocation.buffer.selections.firstObject as? XCSourceTextRange,
//           let lastSelection = invocation.buffer.selections.lastObject as? XCSourceTextRange {
//            let range = (firstSelection.start.line...lastSelection.end.line).saneRange(for: invocation.buffer.lines.count)
//            code = invocation.buffer.lines.compactMap { $0 as? String }.joined()
//        }


        service.generateDiagram(from: code) {
            completionHandler(nil)
        }

        
        //        let content = invocation.buffer.completeBuffer
        //        let generator = ClassDiagramGenerator()
        //        generator.generate(from: content)
        //
        //        completionHandler(nil)
    }
    
}

extension CountableClosedRange where Bound == Int {

    func saneRange(for elementsCount: Int) -> CountableClosedRange<Bound> {
        let lowerBound = Swift.max(self.lowerBound, 0)
        let upperBound = Swift.min(self.upperBound, Swift.max(0, elementsCount - 1))
        return lowerBound...upperBound
    }

    func omittingFirstAndLastNewLine(in lines: NSMutableArray) -> CountableClosedRange<Int> {
        let saneRange = self.saneRange(for: lines.count)

        guard lines.count > 2,
              let first = lines[saneRange.lowerBound] as? String,
              let last = lines[saneRange.upperBound] as? String else {
            return self
        }

        let lowerBound = first.trimmingCharacters(in: .newlines).isEmpty ? saneRange.lowerBound + 1 : saneRange.lowerBound
        let upperBound = last.trimmingCharacters(in: .newlines).isEmpty ? saneRange.upperBound - 1 : saneRange.upperBound

        return lowerBound...upperBound
    }
}
