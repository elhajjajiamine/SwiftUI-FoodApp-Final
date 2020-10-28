//
//  HomeModelView.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/28/20.
//

import SwiftUI
import CoreLocation
import Firebase


//Fetching User Location...
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    //Location Deatails...
    @Published var userLocation :CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    //Menu...
    @Published var showMenu = false
    
    //ItemData...
    
    @Published var items : [Item] = []
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //checking Location Acces
        switch manager.authorizationStatus{
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            //Direct Call
            locationManager.requestWhenInUseAuthorization()
            //Modifying Info.plist
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        
        // reading User Location and extracting details
        self.userLocation = locations.last
        self.extractLocation()
        //After Extracting loation logging in ...
        self.login()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in

            guard let safeData = res else {return}
            
            var address = ""
            
            // Getting area and locality name ....
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
        
    }
    
    // Anonymous login for reading database...
    func login(){
        Auth.auth().signInAnonymously { (res, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            print("Seccess = \(res!.user.uid)")
            
            // after logging in fetching data
            self.fetchData()
        }
    }
    
    //Fetching items data...
    func fetchData(){
        let db = Firestore.firestore()
        db.collection("Items").getDocuments {(snap, err) in
            guard let itemData = snap else {return}
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let ratings = doc.get("item_ratings") as! String
                let image = doc.get("item_image") as! String
                let details = doc.get("item_details") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_ratings: ratings)



                
            })
    }
    
    
}
}
