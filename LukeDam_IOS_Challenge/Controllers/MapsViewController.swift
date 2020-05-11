//
//  MapsViewController.swift
//  LABS Prepr
//
//  Created by Luke on 2020-05-09.
//  Copyright © 2020 Luke Dam. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    //@IBOutlet weak var cityName: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    //let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let locationManager = CLLocationManager()
    var lonArray = [Double]()
    var latArray = [Double]()
    var destLocation = CLLocation()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setLocation()

    }
    
    func setLocation () {
        
        lonArray.append(-79.6877)
        latArray.append(43.4675)
        // location
        destLocation = CLLocation(latitude: latArray[0] as CLLocationDegrees, longitude: lonArray[0] as CLLocationDegrees)
        
        // center on location and region
        let viewRegion = MKCoordinateRegion.init(center: destLocation.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
        
        // enable mapView region
        mapView.setRegion(viewRegion, animated: true)
        
        annotation(lat: latArray[0], lon: lonArray[0])
        
    }
    
    
    func annotation(lat:Double, lon:Double) {
        
        //let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        
        print (location)
        // span with 20-30km range
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 20000, longitudinalMeters: 20000)
        
        
        mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Your Destination"
        annotation.subtitle = "Destination"
        
        mapView.addAnnotation(annotation)
    }
    
}

// extend mk delegate
extension MapsViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if overlay is MKPolyline {
            // create polyline renderer
            let renderer2 = MKPolylineRenderer(overlay: overlay)

            // renderer.style class
            renderer2.strokeColor = UIColor.blue

            return renderer2
        }
        return MKOverlayRenderer()
    }
}
