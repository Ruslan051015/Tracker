import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    func testingTrackersViewControllerLightStyle() {
        let viewController = TrackersViewController()
        
        assertSnapshot(matching: viewController, as: .image(traits: .init(userInterfaceStyle: .light)))
    }
    
    func testingTrackersViewControllerDarkStyle() {
        let viewController = TrackersViewController()
        
        assertSnapshot(matching: viewController, as: .image(traits: .init(userInterfaceStyle: .dark)))
    }
}
