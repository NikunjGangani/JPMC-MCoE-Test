//
//  MockPlanetData.swift
//  JPMC MCoE TestTests
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation

class MockPlanetData {
    func getPlanetDataFromFile() -> Data {
        return dataFromJSON(withName: "PlanetsAPIResponse")!
    }
}

func dataFromJSON(withName name: String) -> Data? {
    guard let fileURL = Bundle(for: JPMC_MCoE_TestTests.self).url(forResource: name, withExtension: "json") else {
        return nil
    }
    return try? Data(contentsOf: fileURL)
}
