//
//  MapViewController.swift
//  NeighborhoodHistory
//
//  Created by Matthew Poelsterl on 8/3/21.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController {
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //Globals
    let manager = CLLocationManager()
    var currentLocation = CLLocation()
    
    //Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        //get initial location and center map
        let initialLocation = CLLocation(latitude: 41.8781, longitude: -87.6298)
        mapView.centerToLocation(initialLocation)
        
        //Set boundaries around chicago
        let chiCenter = CLLocation(latitude: 41.8781, longitude: -87.6298)
        let region = MKCoordinateRegion(center: chiCenter.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        //Set zoom range
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        //Add example annotation
        let location = Location(name: "Lincoln Monument", address: "2045 N Lincoln Park Ave", coordinate: CLLocationCoordinate2D(latitude: 41.91929, longitude: -87.63978), caption: "Larger than life statue of Abraham Lincoln", descript: "TKTK: Full Description", tags: [""])
        mapView.addAnnotation(location)
    }
    
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
extension MapViewController: MKMapViewDelegate {
    //Creates custom card for click on marker
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Location else {
            return nil
        }
        let identifier = "location"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.markerTintColor = annotation.markerTintColor
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? Location else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let expandedVC = storyboard.instantiateViewController(identifier: "ExpandedCardViewController")
               
        expandedVC.modalPresentationStyle = .pageSheet
        expandedVC.modalTransitionStyle = .crossDissolve
               
        present(expandedVC, animated: true, completion: nil)
        
    }
    
}



