import Foundation
import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import CoreLocation

class Wifi {

    static let shared = Wifi()

    private let locationManager = CLLocationManager()

    var ssid: String {
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary?,
                    let ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String {
                    return ssid
                }
            }
        }
        return ""
    }

    private init() {
        if #available(iOS 13.0, *) {
            let status = CLLocationManager.authorizationStatus()
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                break
            default:
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }

    func connectWifi(completion: @escaping (Bool) -> Void) {
        let manager = NEHotspotConfigurationManager.shared
        let hotspotConfiguration = NEHotspotConfiguration(ssid: "",
                                                          passphrase: "",
                                                          isWEP: false)
        hotspotConfiguration.joinOnce = false
        hotspotConfiguration.lifeTimeInDays = 1

        manager.apply(hotspotConfiguration) { error in
            if let error = error as NSError? {
                Logger.error(error.debugDescription)
                // Warning: wi-fiに繋がっているにも関わらずエラーが返るケースがある
                if error.userInfo.values
                    .compactMap({
                        $0 as? String
                    })
                    .first(where: {
                        $0.contains("already associated")
                    }) != nil {
                    return completion(true)
                }
                return completion(false)
            }
            completion(true)
        }
    }

    func disconnectWifi() {
        let manager = NEHotspotConfigurationManager.shared
        manager.removeConfiguration(forSSID: "")
    }
}
