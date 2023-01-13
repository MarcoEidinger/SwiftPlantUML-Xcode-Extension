import Foundation

@objc protocol XPCServiceProtocol {
    func generateDiagram(from content: String, completionHandler: @escaping (() -> Void))
    func generateDiagram(for paths: [String], completionHandler: @escaping (() -> Void))
}
