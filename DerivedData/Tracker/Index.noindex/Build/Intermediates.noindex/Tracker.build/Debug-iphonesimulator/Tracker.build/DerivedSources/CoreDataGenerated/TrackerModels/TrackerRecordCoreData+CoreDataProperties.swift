//
//  TrackerRecordCoreData+CoreDataProperties.swift
//  
//
//  Created by Руслан Халилулин on 03.02.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

extension TrackerRecordCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerRecordCoreData> {
        return NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var recordID: UUID?
    @NSManaged public var tracker: TrackerCoreData?

}

extension TrackerRecordCoreData: Identifiable {

}
