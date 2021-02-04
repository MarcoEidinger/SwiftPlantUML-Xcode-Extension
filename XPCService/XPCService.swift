import Foundation
import SwiftPlantUMLFramework

@objc class XPCService: NSObject, XPCServiceProtocol {
    func generateDiagram(from content: String, completionHandler: @escaping (() -> Void)) {
        ClassDiagramGenerator().generate(from: content)
        completionHandler()
    }
}
