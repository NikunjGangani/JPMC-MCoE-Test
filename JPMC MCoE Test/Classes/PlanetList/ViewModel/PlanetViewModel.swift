//
//  PlanetViewModel.swift
//  JPMC MCoE Test
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation
import Combine

class PlanetViewModel {
    
    private var serviceManager: ServiceManager
    @Published var message: String = ""
    @Published var planetList = [Planet]()
    var pageIndex = 1
    var apiState: APIState = .initial
    var planetResult: PlanetResult?
    var noOfPlanets: Int {
        return planetList.count
    }
    
    init(manager: ServiceManager = ServiceManager()) {
        self.serviceManager = manager
    }
    
    // Get planet list API
    func getPlanetList() {
        let param = [Param.page: pageIndex]
        apiState = .inProgress
        serviceManager.getWebService(url: API.planetList.url, params: param) { result in
            switch result {
            case .success(let data):
                self.apiState = .completed
                if let result = try? JSONDecoder().decode(PlanetResult.self, from: data) {
                    if self.apiState == .initial {
                        self.planetList = result.results ?? []
                    } else {
                        self.planetList.append(contentsOf: result.results ?? [])
                    }
                }
            case .failure(let error):
                if !NetworkReachability().isNetworkAvailable() {
                    self.getOfflineData()
                } else {
                    self.message = error.localizedDescription
                }
            }
        }
    }
    
    // Show offline mock data when no network availability
    func getOfflineData() {
        guard let fileURL = Bundle.main.url(forResource: JsonFile.planetList, withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let result = try? JSONDecoder().decode(PlanetResult.self, from: data) {
            self.planetList = result.results ?? []
        }
    }
    
    func cellForRowValue(indexPath: IndexPath) -> Planet? {
        return planetList.count == 0 ? nil : planetList[indexPath.row]
    }
}
