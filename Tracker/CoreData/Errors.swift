//
//  Errors.swift
//  Tracker
//
//  Created by Руслан Халилулин on 20.11.2023.
//

import Foundation

enum CDErrors: Error {
    case creatingTrackerFromModelError
    case creatingCategoryFromModelError
    case categoryTitleError
    case categoryTrackersError
    case getCoreDataCategoryError
    case creatingCoreDataTrackerError
    case recordCoreDataCreatingError
}
