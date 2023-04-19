//
//  PlanetListViewControllerTest.swift
//  JPMC MCoE TestTests
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import XCTest
import Combine
@testable import JPMC_MCoE_Test

class PlanetListViewControllerTest: XCTestCase {
    
    private var viewM: PlanetViewModel!
    private var planetController: PlanetListViewController!
    private var mockSession: ServiceSessionMock!
    private var cancellable: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockSession = ServiceSessionMock()
        mockSession.data = MockPlanetData().getPlanetDataFromFile()
        viewM = PlanetViewModel(manager: ServiceManager(session: mockSession))
        let storyboard = UIStoryboard(name: Storyboard.main, bundle: Bundle(for: Self.classForCoder()))
        
        if let controller = storyboard.instantiateViewController(withIdentifier: ControllerKey.planetList) as? PlanetListViewController {
            controller.viewModel = viewM
            planetController = controller
        }
        getPlanetData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewM = nil
        planetController = nil
        try super.tearDownWithError()
        
    }

    func testFetchPlanet_SuccessFully() {
        XCTAssertNotNil(planetController.getPlanetsAPI())
    }
    
    func getPlanetData() {
        planetController.getPlanetsAPI()
        viewM.$message.sink { message in
        }.store(in: &cancellable)
    }
}
