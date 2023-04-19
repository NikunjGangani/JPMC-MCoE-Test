//
//  PlanetViewModelTest.swift
//  JPMC MCoE TestTests
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation
import XCTest
import Combine

class PlanetViewModelTest: XCTestCase {
    
    var viewM: PlanetViewModel!
    var mockSession: ServiceSessionMock!
    private var cancellable: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSession = ServiceSessionMock()
        mockSession.data = MockPlanetData().getPlanetDataFromFile()
        viewM = PlanetViewModel(manager: ServiceManager(session: mockSession))
        viewM.getPlanetList()
    }
    
    override func tearDownWithError() throws {
        viewM = nil
        mockSession = nil
        try super.tearDownWithError()
    }
    
    func testFetchPlanets() {
        viewM.getPlanetList()
        XCTAssertGreaterThan(viewM.noOfPlanets, 5)
    }
    
    func testTableViewFirstCellData() {
        viewM.$planetList.sink { list in
            guard list.count > 0 else { return }
            let indexPath = IndexPath(row: 0, section: 0)
            let firstObject = self.viewM.cellForRowValue(indexPath: indexPath)
            XCTAssertEqual(firstObject?.name ?? "", "Nikunj_iOS_Developer")
        }.store(in: &cancellable)
    }
    
}
