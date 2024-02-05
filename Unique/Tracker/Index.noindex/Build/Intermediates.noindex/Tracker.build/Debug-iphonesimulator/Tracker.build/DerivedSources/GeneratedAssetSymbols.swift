import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

    /// The "PickerColor" asset catalog color resource.
    static let picker = ColorResource(name: "PickerColor", bundle: resourceBundle)

    /// The "SearchBarColor" asset catalog color resource.
    static let searchBar = ColorResource(name: "SearchBarColor", bundle: resourceBundle)

    /// The "YPBackground" asset catalog color resource.
    static let ypBackground = ColorResource(name: "YPBackground", bundle: resourceBundle)

    /// The "YPBlack" asset catalog color resource.
    static let ypBlack = ColorResource(name: "YPBlack", bundle: resourceBundle)

    /// The "YPBlackGray" asset catalog color resource.
    static let ypBlackGray = ColorResource(name: "YPBlackGray", bundle: resourceBundle)

    /// The "YPBlue" asset catalog color resource.
    static let ypBlue = ColorResource(name: "YPBlue", bundle: resourceBundle)

    /// The "YPColorSelection1" asset catalog color resource.
    static let ypColorSelection1 = ColorResource(name: "YPColorSelection1", bundle: resourceBundle)

    /// The "YPColorSelection10" asset catalog color resource.
    static let ypColorSelection10 = ColorResource(name: "YPColorSelection10", bundle: resourceBundle)

    /// The "YPColorSelection11" asset catalog color resource.
    static let ypColorSelection11 = ColorResource(name: "YPColorSelection11", bundle: resourceBundle)

    /// The "YPColorSelection12" asset catalog color resource.
    static let ypColorSelection12 = ColorResource(name: "YPColorSelection12", bundle: resourceBundle)

    /// The "YPColorSelection13" asset catalog color resource.
    static let ypColorSelection13 = ColorResource(name: "YPColorSelection13", bundle: resourceBundle)

    /// The "YPColorSelection14" asset catalog color resource.
    static let ypColorSelection14 = ColorResource(name: "YPColorSelection14", bundle: resourceBundle)

    /// The "YPColorSelection15" asset catalog color resource.
    static let ypColorSelection15 = ColorResource(name: "YPColorSelection15", bundle: resourceBundle)

    /// The "YPColorSelection16" asset catalog color resource.
    static let ypColorSelection16 = ColorResource(name: "YPColorSelection16", bundle: resourceBundle)

    /// The "YPColorSelection17" asset catalog color resource.
    static let ypColorSelection17 = ColorResource(name: "YPColorSelection17", bundle: resourceBundle)

    /// The "YPColorSelection18" asset catalog color resource.
    static let ypColorSelection18 = ColorResource(name: "YPColorSelection18", bundle: resourceBundle)

    /// The "YPColorSelection2" asset catalog color resource.
    static let ypColorSelection2 = ColorResource(name: "YPColorSelection2", bundle: resourceBundle)

    /// The "YPColorSelection3" asset catalog color resource.
    static let ypColorSelection3 = ColorResource(name: "YPColorSelection3", bundle: resourceBundle)

    /// The "YPColorSelection4" asset catalog color resource.
    static let ypColorSelection4 = ColorResource(name: "YPColorSelection4", bundle: resourceBundle)

    /// The "YPColorSelection5" asset catalog color resource.
    static let ypColorSelection5 = ColorResource(name: "YPColorSelection5", bundle: resourceBundle)

    /// The "YPColorSelection6" asset catalog color resource.
    static let ypColorSelection6 = ColorResource(name: "YPColorSelection6", bundle: resourceBundle)

    /// The "YPColorSelection7" asset catalog color resource.
    static let ypColorSelection7 = ColorResource(name: "YPColorSelection7", bundle: resourceBundle)

    /// The "YPColorSelection8" asset catalog color resource.
    static let ypColorSelection8 = ColorResource(name: "YPColorSelection8", bundle: resourceBundle)

    /// The "YPColorSelection9" asset catalog color resource.
    static let ypColorSelection9 = ColorResource(name: "YPColorSelection9", bundle: resourceBundle)

    /// The "YPGray" asset catalog color resource.
    static let ypGray = ColorResource(name: "YPGray", bundle: resourceBundle)

    /// The "YPGray&Gray" asset catalog color resource.
    static let ypGrayGray = ColorResource(name: "YPGray&Gray", bundle: resourceBundle)

    /// The "YPLightGray" asset catalog color resource.
    static let ypLightGray = ColorResource(name: "YPLightGray", bundle: resourceBundle)

    /// The "YPOnlyBlack" asset catalog color resource.
    static let ypOnlyBlack = ColorResource(name: "YPOnlyBlack", bundle: resourceBundle)

    /// The "YPOnlyWhite " asset catalog color resource.
    static let ypOnlyWhite = ColorResource(name: "YPOnlyWhite ", bundle: resourceBundle)

    /// The "YPRed" asset catalog color resource.
    static let ypRed = ColorResource(name: "YPRed", bundle: resourceBundle)

    /// The "YPSwitchColor" asset catalog color resource.
    static let ypSwitch = ColorResource(name: "YPSwitchColor", bundle: resourceBundle)

    /// The "YPWhite" asset catalog color resource.
    static let ypWhite = ColorResource(name: "YPWhite", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "checkmark" asset catalog image resource.
    static let checkmark = ImageResource(name: "checkmark", bundle: resourceBundle)

    /// The "chevron" asset catalog image resource.
    static let chevron = ImageResource(name: "chevron", bundle: resourceBundle)

    /// The "firstScreen" asset catalog image resource.
    static let firstScreen = ImageResource(name: "firstScreen", bundle: resourceBundle)

    /// The "logo" asset catalog image resource.
    static let logo = ImageResource(name: "logo", bundle: resourceBundle)

    /// The "notFound" asset catalog image resource.
    static let notFound = ImageResource(name: "notFound", bundle: resourceBundle)

    /// The "pin" asset catalog image resource.
    static let pin = ImageResource(name: "pin", bundle: resourceBundle)

    /// The "plus" asset catalog image resource.
    static let plus = ImageResource(name: "plus", bundle: resourceBundle)

    /// The "praktikumLogo" asset catalog image resource.
    static let praktikumLogo = ImageResource(name: "praktikumLogo", bundle: resourceBundle)

    /// The "record" asset catalog image resource.
    static let record = ImageResource(name: "record", bundle: resourceBundle)

    /// The "sadSmile" asset catalog image resource.
    static let sadSmile = ImageResource(name: "sadSmile", bundle: resourceBundle)

    /// The "secondScreen" asset catalog image resource.
    static let secondScreen = ImageResource(name: "secondScreen", bundle: resourceBundle)

    /// The "starLight" asset catalog image resource.
    static let starLight = ImageResource(name: "starLight", bundle: resourceBundle)

    /// The "statistics" asset catalog image resource.
    static let statistics = ImageResource(name: "statistics", bundle: resourceBundle)

}

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Hashable {

    /// An asset catalog color resource name.
    fileprivate let name: String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Hashable {

    /// An asset catalog image resource name.
    fileprivate let name: String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol ACResourceInitProtocol {}
extension AppKit.NSImage: ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        guard let image = resource.bundle.image(forResource: NSImage.Name(resource.name)) as? Self else {
            return nil
        }
        self = image
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif
