//
//  ViewController.swift
//  Project22
//
//  Created by Леонид Хабибуллин on 15.11.2020.
//
import CoreLocation // framework для отслеживания локации
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    var firstContact = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .gray
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {  // Чекает есть рядом маяк или нет
            if CLLocationManager.isRangingAvailable() { // Чекает можем ли мы узнать расстояние до него
                if !firstContact{ // Challenge 1
                    let ac = UIAlertController(title: "First contact with beacon!", message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
                startScanning()
            }
            }
        }
        
    }
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "Far"
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "Near"
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "Right here"
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "Unknown"
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }


}

