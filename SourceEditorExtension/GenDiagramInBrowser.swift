import ApplicationServices
import Foundation
import XcodeKit

class GenDiagramInBrowser: NSObject, XCSourceEditorCommand {
    lazy var connection: NSXPCConnection = {
        let connection = NSXPCConnection(serviceName: "us.eidinger.SwiftPlantUMLXPCService")
        connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        connection.resume()
        return connection
    }()

    deinit {
        connection.invalidate()
    }

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let handler: (Error) -> Void = { error in
            print("remote proxy error: \(error)")
        }
        let service = connection.remoteObjectProxyWithErrorHandler(handler) as! XPCServiceProtocol

        let code = determineRelevantCodeForDiagram(invocation: invocation)

        service.generateDiagram(from: code) {
            completionHandler(nil)
        }
    }

    func determineRelevantCodeForDiagram(invocation: XCSourceEditorCommandInvocation) -> String {
        // 1. all lines of current source file in editor
        var code = invocation.buffer.completeBuffer
        // 2. check if specific lines were selected
        var selectedCode = ""
        if invocation.buffer.selections.count > 0 {
            for sel in invocation.buffer.selections {
                guard let selection = sel as? XCSourceTextRange else { continue }
                guard selection.start.line != selection.end.line else { continue }
                let selectedText = (selection.start.line ..< selection.end.line).map { invocation.buffer.lines[$0] as? String }.compactMap { $0 }.joined()
                if selectedText.count > 0 {
                    selectedCode += selectedText
                }
            }
            if selectedCode.count > 0 {
                code = selectedCode
            }
        }
        return code
    }
}
