//
//  GetLocationViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 3/15/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//
import UIKit
import GoogleMaps
import CoreLocation
import MapKit
protocol sendDataBackDelegate {
    func finishPassing(location: String , lat:Double , lng:Double)
}

protocol sendDataBackDelegateTwo {
    func finishPassing2(location: String , lat:Double , lng:Double)
}

class GetLocationViewController: UIViewController , UIGestureRecognizerDelegate{
    @IBOutlet weak var confirmationBtn: RoundedButton!
    @IBOutlet var mapView: MKMapView?
    @IBOutlet weak var locationLabel: BorderBaddedTextField!
    @IBOutlet weak var mapypeSegment: UISegmentedControl!
   
    let locationManager = CLLocationManager()
    let GoogleAPI = "AIzaSyDEJd62-3jzmktJR565uvRV6qtedNwwk3c"
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var delegate: sendDataBackDelegate?
    var delegate2: sendDataBackDelegateTwo?
    let Storeannotation = ImageAnnotation()
    let userAnnotaion = ImageAnnotation()
    var lat:Double?
    var lng:Double?
    var addressString = ""
    override func viewWillAppear(_ animated: Bool) {
        requestLocationAccess()
        mapView?.showsUserLocation = true
        mapView?.userLocation
        requestLocationAccess()
    }
  override func viewDidLoad() {
        requestLocationAccess()
        mapView?.showsUserLocation = true
        mapView?.mapType = .standard
        self.locationLabel.isUserInteractionEnabled = false
        mapView?.delegate = self
        self.tabBarController?.tabBar.isHidden = false
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.mapypeSegment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        setMapview()
        self.locationLabel.text = "Your Location".localized()
        self.confirmationBtn.setTitle("Confirmation".localized(), for: .normal)
        
    }
    func setMapview(){
        let lpgr = UITapGestureRecognizer(target: self, action: #selector(handleLongPress(gestureReconizer:)))
        //        lpgr.minimumPressDuration = 0.1
        //        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.mapView?.addGestureRecognizer(lpgr)
    }
    
    
    
    @objc func handleLongPress(gestureReconizer: UITapGestureRecognizer) {
        
        let touchLocation = gestureReconizer.location(in: mapView)
        let locationCoordinate = mapView?.convert(touchLocation,toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate?.latitude) long: \(locationCoordinate?.longitude)")
        self.lat = (locationCoordinate?.latitude)!
        self.lng = (locationCoordinate?.longitude)!
        self.mapView?.removeAnnotations([userAnnotaion])
        addUserAnnotaion(lat:(locationCoordinate?.latitude)! , Lng: (locationCoordinate?.longitude)!)
        //=============================
        var formatted_address: String!
        self.getAddressFromLatLon(pdblLatitude: String(self.lat ?? 0.0), withLongitude: String(self.lng ?? 0.0))

//        API.GET(url: URLs.Google_GeoCoding + "\((locationCoordinate?.latitude)! ?? 21.54238),\((locationCoordinate?.longitude)! ?? 39.19797)&key=\(GoogleAPI)&language=\(getServerLang())") { (success, result) in
//            if success {
//                let dict = result
//                if let status = dict["status"] as? String {
//                    if status == "OK" {
//                        if let results = dict["results"] as? [[String:AnyObject]] {
//                            let resultAddress = results[0]
//                            let fullAddress = resultAddress["formatted_address"] as! String
//                            formatted_address = fullAddress.replacingOccurrences(of: ",", with: " ").replacingOccurrences(of: "-", with: " ")
//                            print("Address:" + formatted_address)
//                            self.locationLabel.text = formatted_address
//                        }
//                    } else {
//                        
//                    }
//                }
//            } else {
//                
//                // Failed to Call API
//                self.getAddressFromLatLon(pdblLatitude: String(self.lat ?? 0.0), withLongitude: String(self.lng ?? 0.0))
//                
//            }
//        }
        //=============================
        return
        
    }
    
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                
                if placemarks != nil {
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        let pm = placemarks![0]
               
                        if pm.subLocality != nil {
                            self.addressString = self.addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            self.addressString = self.addressString + pm.thoroughfare! + ", "
                            
                        }
                        if pm.locality != nil {
                            self.addressString = self.addressString + pm.locality! + ", "
                            
                        }
                        if pm.country != nil {
                            self.addressString = self.addressString + pm.country! + ", "
                            
                        }
                        if pm.postalCode != nil {
                            self.addressString = self.addressString + pm.postalCode! + " "
                        }
                        
                        self.locationManager.stopUpdatingLocation()

                        self.locationLabel.text = self.addressString
                        
                        self.addressString = ""
                    }
                    
                    
                }
        })
        
    }
    @IBAction func chooseLocationBtnPressed(_ sender: Any) {
        print("jjjjjjjjjj",locationLabel.text ?? "jjjj" )
        if self.locationLabel.text?.isEmpty == false  {
            if (self.locationLabel.text == "موقعك" || self.locationLabel.text == "Your Location") {
                Alert.showAlertOnVC(target: self, title: "يجب اختيار موقع", message: "قم بتحديد الموقع علي الخريطة")
            }else{
                delegate?.finishPassing(location: locationLabel.text!, lat: self.lat! , lng: self.lng!)
                delegate2?.finishPassing2(location: locationLabel.text!, lat: self.lat!, lng: self.lng!)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        else{
            Alert.showAlertOnVC(target: self, title: "يجب اختيار موقع", message: "قم بتحديد الموقع علي الخريطة")
        }
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    let regionRadius: CLLocationDistance = 100
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView?.setRegion(coordinateRegion, animated: true)
    }
    @objc func segmentedControlValueChanged(segment: UISegmentedControl) {
        if mapypeSegment.selectedSegmentIndex == 0 {
            self.mapView?.mapType = .standard
            
        }else{
            self.mapView?.mapType = .hybrid
        }
        
    }
   
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("🚢\(Storeannotation.title)")
    }
    func addUserAnnotaion(lat:Double,Lng:Double){
        userAnnotaion.coordinate = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(Lng))
        self.userAnnotaion.annotationImage = #imageLiteral(resourceName: "locationclient")
        self.mapView?.showAnnotations([self.userAnnotaion], animated: true)
        
    }
  
    
}

extension GetLocationViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("listen")
        centerMapOnLocation(location: locationManager.location!)
        self.locationManager.stopUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Alert.showAlertOnVC(target: self, title: "Make sure GPS is open".localized(), message: "")
    }
}
extension GetLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: ImageAnnotation.self) {
            var view: ImageAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? ImageAnnotationView
            if view == nil {
                view = ImageAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
            }
            let annotation = annotation as! ImageAnnotation
            view?.annotationImgView.image = annotation.annotationImage
            view?.annotaionLbl.setTitle(annotation.title, for: .normal)
            view?.annotation = annotation
            
            return view
        }else{
            
        }
        return nil
        
    }
}
class place: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}

