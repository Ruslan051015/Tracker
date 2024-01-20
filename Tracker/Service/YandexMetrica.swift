import Foundation
import YandexMobileMetrica

final class YandexMetrica {
    func initialize() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "f024718c-0eae-4687-8f17-6a5fe6b59c44") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
}
