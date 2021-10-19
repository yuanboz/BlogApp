//
//  BlogEntry+CoreDataProperties.swift
//  BlogApp
//
//  Created by 周元博 on 10/19/21.
//
//

import Foundation
import CoreData


extension BlogEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BlogEntry> {
        return NSFetchRequest<BlogEntry>(entityName: "BlogEntry")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

extension BlogEntry : Identifiable {
    func setMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        if let dateToBeModified = date {
            let month = dateFormatter.string(from: dateToBeModified)
            return month.uppercased()
        }
        return ""
    }
    
    func setDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        if let dateToBeModified = date {
            let day = dateFormatter.string(from: dateToBeModified)
            return day.uppercased()
        }
        return ""
    }
}
