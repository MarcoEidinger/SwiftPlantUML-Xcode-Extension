//
//  SwiftPlantUMLXPCService.swift
//  SwiftPlantUMLXPCService
//
//  Created by Eidinger, Marco on 1/30/21.
//

import Foundation
import SwiftPlantUMLFramework

@objc class SwiftPlantUMLXPCService: NSObject, SwiftPlantUMLXPCServiceProtocol {

    func generateDiagram(from content: String, completionHandler: @escaping (() -> Void)) {
        let generator = ClassDiagramGenerator()
        generator.generate(from: content)
        print("meep")
        completionHandler()
    }

}
