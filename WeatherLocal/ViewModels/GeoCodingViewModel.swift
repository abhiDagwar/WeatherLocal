//
//  GeoCodingViewModel.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 28/03/22.
//

import Foundation

class GeoCodingViewModel: NSObject {
    var networkClientProtocol: NetworkClientProtocol
    var searchLocations: GeoLocations = []
    var filteredGeoLocations: GeoLocations = []
    
    var reloadTableView: (() -> Void)?
    let networkClient = NetworkClient()
    var geoCodingCellViewModels = [GeoCodingCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(networkClientProtocol: NetworkClientProtocol = NetworkClient()) {
        self.networkClientProtocol = networkClientProtocol
    }
    
    func fetchDefaultLocations() {
        fetchCellData(geoLocations: locations)
    }
    
    func fetchLocations(with address: String) {
        networkClient.getGeoAddress(for: address) { [weak self] (locationData, error) in
            
            guard
                let self = self,
                let locationData = locationData
            else {
                print("Error fetching locations...")
                return
            }
            
            self.fetchCellData(geoLocations: locationData)
        }
    }
    
    func fetchCellData(geoLocations: GeoLocations) {
        self.searchLocations = geoLocations
        var cellData = [GeoCodingCellViewModel]()
        for geoLocation in geoLocations {
            cellData.append(createCellModel(geoLocation: geoLocation))
        }
        geoCodingCellViewModels = cellData
    }
    
    func createCellModel(geoLocation: GeoLocation) -> GeoCodingCellViewModel {
        let name = geoLocation.name
        let state = geoLocation.state
        let lat = String(geoLocation.lat)
        let long = String(geoLocation.lon)
        
        return GeoCodingCellViewModel(name: Box(name), state: Box(state), lat: Box(lat), long: Box(long))
    }
    
    func getLocationSectionCount() -> Int {
        return 1
    }
    
    func getLocationRowCount() -> Int {
        return searchLocations.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GeoCodingCellViewModel {
        return geoCodingCellViewModels[indexPath.row]
    }
    
    func filteredContentForSearchText(_ searchText: String) {
        filteredGeoLocations = searchLocations.filter { (geolocation: GeoLocation) -> Bool in
            return geolocation.name.lowercased().contains(searchText.lowercased())
        }
        fetchCellData(geoLocations: filteredGeoLocations)
    }
}
