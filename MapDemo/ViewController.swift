//
//  ViewController.swift
//  MapDemo
//
//  Created by SHIH-YING PAN on 2020/2/15.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "\(MaskAnnotation.self)")
        
        guard let url = URL(string: "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let decoder = MKGeoJSONDecoder()
            if let features = try? decoder.decode(data) as? [MKGeoJSONFeature] {
                
                let maskAnnotations = features.map {
                    MaskAnnotation(feature: $0)
                }
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotations(maskAnnotations)
                   
                }
                
            }
            
            
        }.resume()
    }
}

extension ViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MaskAnnotation else {
            return nil
        }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "\(MaskAnnotation.self)", for: annotation)
        annotationView.canShowCallout = true
        let infoButton = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = infoButton
        if let count = annotation.mask?.maskAdult, count == 0 {
            annotationView.image = UIImage(named: "maskEmpty")
        } else {
            annotationView.image = UIImage(named: "mask")
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
         let annotation = view.annotation as? MaskAnnotation
         print(annotation)
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as? MaskAnnotation
        print(annotation)

    }
}
