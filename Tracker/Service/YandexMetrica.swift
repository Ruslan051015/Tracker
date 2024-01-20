import Foundation
import YandexMobileMetrica

final class YandexMetrica {
    static let shared = YandexMetrica()
    func initialize() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "f024718c-0eae-4687-8f17-6a5fe6b59c44") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func sendReport(about event: String, and item: String?, on screen: String) {
        let params: [AnyHashable : Any] = ["event": event, "item": item ?? "", "screen": screen]
        YMMYandexMetrica.reportEvent(event, parameters: params, onFailure: { (error) in
            print("DID FAIL REPORT EVENT: %@")
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}
