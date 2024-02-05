//
//  TrackerCoreData+CoreDataProperties.swift
//  
//
//  Created by Руслан Халилулин on 03.02.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

extension TrackerCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerCoreData> {
        return NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
    }

    @NSManaged public var color: NSObject?
    @NSManaged public var emoji: String?
    @NSManaged public var name: String?
    @NSManaged public var pin: Bool
    @NSManaged public var schedule: NSObject?
    @NSManaged public var trackerID: UUID?
    @NSManaged public var category: TrackerCategoryCoreData?
    @NSManaged public var record: NSSet?

}

// MARK: Generated accessors for record
extension TrackerCoreData {

    @objc(addRecordObject:)
    @NSManaged public func addToRecord(_ value: TrackerRecordCoreData)

    @objc(removeRecordObject:)
    @NSManaged public func removeFromRecord(_ value: TrackerRecordCoreData)

    @objc(addRecord:)
    @NSManaged public func addToRecord(_ values: NSSet)

    @objc(removeRecord:)
    @NSManaged public func removeFromRecord(_ values: NSSet)

}

extension TrackerCoreData: Identifiable {

}
