//
//  MapViewController.swift
//  NeighborhoodHistory
//
//  Created by Matthew Poelsterl on 8/3/21.
//

import UIKit
import MapKit
import CoreLocation
import CoreData


class MapViewController: UIViewController {
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //Globals
    let manager = CLLocationManager()
    var currentLocation = CLLocation()
    var locations: [Location] = []
    
    //Helper Functions
    func addToPersistent(location: Location) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newEntity = NSEntityDescription.entity(forEntityName: "Locations", in: managedContext)!
        let newLocation = NSManagedObject(entity: newEntity, insertInto: managedContext)
        newLocation.setValue(location.name, forKey: "name")
        newLocation.setValue(location.address, forKey: "address")
        newLocation.setValue(location.caption, forKey: "caption")
        newLocation.setValue(location.descript, forKey: "descript")
        newLocation.setValue(location.latitude, forKey: "latitude")
        newLocation.setValue(location.longitude, forKey: "longitude")
        newLocation.setValue(location.tags, forKey: "tags")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Storing protoype data into database
        //Create and save Lincoln Monument location
        let lincolnMonument = Location(name: "Lincoln Monument", address: "2045 N Lincoln Park Ave", coordinate: CLLocationCoordinate2D(latitude: 41.91929, longitude: -87.63978), caption: "Larger than life statue of Abraham Lincoln", descript: "TKTK: Full Description", tags: [""])
        addToPersistent(location: lincolnMonument)
        //Create and save Biograph Theater
        let bioTheater = Location(name: "Biograph Theather", address: "2433 N Lincoln Park Ave", coordinate: CLLocationCoordinate2D(latitude: 41.926261, longitude: -87.649681), caption: "Where John Dilinger was killed", descript: "TKTK: Full Description", tags: [""])
        addToPersistent(location: bioTheater)
        //Create and save Chicago Youth Center
        let chiYouthCenter = Location(name: "Chicago Youth Center", address: "844 W 32nd St", coordinate: CLLocationCoordinate2D(latitude: 41.8365336, longitude: -87.6480685), caption: "The Fellowship House structure was constructed in the late 1800s as one of two settlement houses in Chicago.", descript: "TKTK: Full Description", tags: [""])
        addToPersistent(location: chiYouthCenter)
        //Create and save Haines School
        let hainesSchool = Location(name: "Haines School", address: "247 W 23rd Pl", coordinate: CLLocationCoordinate2D(latitude: 41.8497919, longitude: -87.6347287), caption: "Haines School had been one of the oldest building in Chicago Public Schools. Haines School is 130 years old and in 1994, a new building was constructed.", descript: "TKTK: Full Description", tags: [""])
        addToPersistent(location: hainesSchool)
        //Create and save Ping Tom Memorial Park
        let pingTom = Location(name: "Ping Tom Memorial Park", address: "1700 S Wentworth Ave", coordinate: CLLocationCoordinate2D(latitude: 41.85764300697448, longitude: -87.634673178967), caption: "The park was named in honor of the leading force behind its creation, Chinatown's most noted civic leader, Ping Tom (1935-1995).", descript: "TKTK: Full Description", tags: [""])
        addToPersistent(location: pingTom)
        
        
        //Loading data from CoreData database into locations array
        //Getting managed context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        //Sending fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Locations")
        //Transform fetched data into usable locations array
        do {
            locations = try managedContext.fetch(fetchRequest) as! [Location]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        //Adding annotations to map
        mapView.addAnnotations(locations)
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



