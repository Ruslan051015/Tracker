import Foundation

final class Mocks {
    static var trackers: [TrackerCategory] = [
        TrackerCategory(
            name: "Study",
            includedTrackers: [
                Tracker(
                    id: UUID(),
                    name: "Swift",
                    schedule: [.Monday, .Thursday, .Wednesday, .Friday, .Saturday, .Sunday, .Tuesday]),
                Tracker(
                    id: UUID(),
                    name: "Trading",
                    schedule: [.Monday, .Thursday, .Tuesday]),
                Tracker(
                    id: UUID(),
                    name: "SwiftBook",
                    schedule: [.Monday, .Wednesday, .Saturday, .Sunday, .Tuesday]),
                Tracker(
                    id: UUID(),
                    name: "CodeWars",
                    schedule: [.Thursday, .Wednesday, .Friday, .Saturday, .Sunday, .Tuesday])
            ]),
        
        TrackerCategory(
            name: "Sport",
            includedTrackers: [
                Tracker(
                    id: UUID(),
                    name: "Gym",
                    schedule: [.Monday, .Wednesday, .Friday, .Sunday,]),
                Tracker(
                    id: UUID(),
                    name: "Football",
                    schedule: [.Tuesday]),
                Tracker(
                    id: UUID(),
                    name: "Jog",
                    schedule: [.Monday, .Tuesday]),
                Tracker(
                    id: UUID(),
                    name: "Swim",
                    schedule: [.Saturday, .Sunday, .Tuesday])
            ]),
        
        TrackerCategory(
            name: "Relationship",
            includedTrackers: [
                Tracker(
                    id: UUID(),
                    name: "Date",
                    schedule: [.Sunday]),
                Tracker(
                    id: UUID(),
                    name: "Flowers", schedule: [.Monday]),
                Tracker(
                    id: UUID(),
                    name: "Series",
                    schedule: [.Monday, .Sunday, .Tuesday]),
                Tracker(
                    id: UUID(),
                    name: "Games",
                    schedule: [.Thursday, .Sunday, .Tuesday])
            ]),
        
        TrackerCategory(
            name: "Parents",
            includedTrackers: [
                Tracker(
                    id: UUID(),
                    name: "Call",
                    schedule: [.Monday, .Thursday, .Wednesday, .Friday, .Saturday, .Sunday, .Tuesday]),
                Tracker(
                    id: UUID(),
                    name: "Meet",
                    schedule: [.Monday, .Thursday]),
                Tracker(
                    id: UUID(),
                    name: "Send money",
                    schedule: [.Monday]),
            ])
    ]
}
