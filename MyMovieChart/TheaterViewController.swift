//
//  TheaterViewController.swift
//  MyMovieChart
//
//  Created by 박시현 on 2019/12/20.
//  Copyright © 2019 박시현. All rights reserved.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    var param: NSDictionary!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        self.navigationItem.title = self.param["상영관명"] as? String
        
        let lat = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        let regionRadius : CLLocationDistance = 100
        let coordinateRegion = MKCoordinateRegion.init(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.map.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = location
        self.map.addAnnotation(point)
    }
}
