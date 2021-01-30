//
//  SwiftPlantUMLXPCServiceProtocol.swift
//  SwiftPlantUMLXPCService
//
//  Created by Eidinger, Marco on 1/30/21.
//

import Foundation

@objc protocol SwiftPlantUMLXPCServiceProtocol {
    func generateDiagram(from content: String, completionHandler: @escaping (() -> Void))
}
