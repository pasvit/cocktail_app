//
//  CocktailServiceTests.swift
//  CocktailsTests
//
//  Created by Pasquale on 02/07/22.
//

import XCTest
@testable import Cocktails

class CocktailServiceTests: XCTestCase {
    var sut: CocktailServiceFacade!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CocktailServiceFacade()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_fetchCocktailsByLetterA_withSuccessResult() throws {
        try XCTSkipUnless(
            InternetConnectionManager.isConnectedToNetwork(),
            "Network connectivity needed for this test.")
        
        // given
        sut = CocktailServiceFacade()
        
        let promise = expectation(description: "Success")
        
        // when
        sut?.fetchCocktails(by: "a") { result in
            switch result {
            // then
            case .success(let cocktails):
                XCTAssert(cocktails.count > 0)
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
        }
   
        wait(for: [promise], timeout: 5)
    }
   
    func test_fetchCocktailImageByStringUrl_withSuccessResult() throws {
        try XCTSkipUnless(
            InternetConnectionManager.isConnectedToNetwork(),
            "Network connectivity needed for this test.")
        
        // given
        sut = CocktailServiceFacade()
        
        let promise = expectation(description: "Success")
        
        // when
        sut?.fetchCocktailImage(with: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg") { result in
            switch result {
            // then
            case .success(let image):
                XCTAssertNotNil(image)
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
        }
   
        wait(for: [promise], timeout: 5)
    }
    
    func test_fetchRandomCocktail_withSuccessResult() throws {
        try XCTSkipUnless(
            InternetConnectionManager.isConnectedToNetwork(),
            "Network connectivity needed for this test.")
        
        // given
        sut = CocktailServiceFacade()
        
        let promise = expectation(description: "Success")
        
        // when
        sut?.fetchRandomCocktail() { result in
            switch result {
            // then
            case .success(let cocktail):
                XCTAssertNotNil(!cocktail.id.isEmpty)
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
        }
   
        wait(for: [promise], timeout: 5)
    }
}
