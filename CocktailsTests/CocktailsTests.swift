//
//  CocktailsTests.swift
//  CocktailsTests
//
//  Created by Johan Forsell on 2022-07-07.
//

import XCTest
@testable import Cocktails

class CocktailsTests: XCTestCase {

    func testCocktailsListVC_LoadsCocktails() throws {
        let vc = CocktailsListVC(service: CocktailsServiceMock())
        
        let expectation = expectation(description: "VC loads cocktails from server")
        
        vc.loadCocktails() {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(vc.cocktails.count, 3)
        XCTAssertEqual(vc.cocktails.first?.name, "Afterglow")
    }

    @MainActor
    func testCocktailDetailsViewModel_LoadsDetailedCocktail() async throws {
        let vm = CocktailDetailsViewModel(cocktailId: "12560", service: CocktailsServiceMock(jsonFileName: "detailed_cocktail_example"), imageCache: ImageCache())
        
        await vm.getCocktail()
        
        XCTAssertEqual(vm.cocktail?.name, "Afterglow")
    }
}
