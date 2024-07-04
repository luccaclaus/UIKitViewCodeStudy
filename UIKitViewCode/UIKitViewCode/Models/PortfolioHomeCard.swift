//
//  PortfolioHomeCard.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 02/07/24.
//

import Foundation
import UniformTypeIdentifiers

final class PortfolioHomeCard: NSObject, NSItemProviderWriting, NSItemProviderReading, Codable {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [UTType.data.identifier]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress?  {
        let progress = Progress(totalUnitCount: 100)
          do {
            //Here the object is encoded to a JSON data object and sent to the completion handler
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
          } catch {
            completionHandler(nil, error)
          }
          return progress
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [UTType.data.identifier]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> PortfolioHomeCard {
      let decoder = JSONDecoder()
      do {
        //Here we decode the object back to it's class representation and return it
        let subject = try decoder.decode(PortfolioHomeCard.self, from: data)
        return subject
      } catch {
        fatalError("\(error)")
      }
    }
    
    
    var title: String
    var shortDescription: String
    
    init(title: String, shortDescription: String) {
        self.title = title
        self.shortDescription = shortDescription
    }
}


