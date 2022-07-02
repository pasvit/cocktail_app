//
//  CocktailsTests.swift
//  CocktailsTests
//
//  Created by Pasquale on 29/06/22.
//

import XCTest
@testable import Cocktails

class CocktailListViewModelTests: XCTestCase {
    var sut: CocktailListViewModel!
    var mockDrinksService: MockCocktailService!
    
    override func setUpWithError() throws {
        mockDrinksService = MockCocktailService()
        sut = .init(service: mockDrinksService)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_cocktailListViewModel_haventCocktails() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success([])
        
        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssert(sut.cocktailsViewModel.isEmpty)
    }
    
    func test_cocktailListViewModel_haveCocktails() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success(MockCocktailService.mockedDrinks)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssert(!sut.cocktailsViewModel.isEmpty)
    }
    
    func test_cocktailListViewModel_withMargaritaCocktail() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success(MockCocktailService.mockedDrinks)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssertNotNil(sut.cocktailsViewModel.filter({ $0.name == "Margarita"}).first)
    }
    
    func test_cocktailListViewModel_withGinTonicCocktail() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success(MockCocktailService.mockedDrinks)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssertNotNil(sut.cocktailsViewModel.filter({ $0.name == "Gin Tonic"}).first)
    }
    
    func test_cocktailListViewModel_allCocktailsWithId() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success(MockCocktailService.mockedDrinks)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssertNil(sut.cocktailsViewModel.filter({ $0.id.isEmpty}).first)
    }
    
    func test_cocktailListViewModel_allCocktailsWithName() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success(MockCocktailService.mockedDrinks)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssertNil(sut.cocktailsViewModel.filter({ $0.name.isEmpty}).first)
    }
    
    func test_cocktailListViewModel_allCocktailsWithAlcoholicInfo() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success(MockCocktailService.mockedDrinks)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssertNil(sut.cocktailsViewModel.filter({ $0.alcoholic.isEmpty}).first)
    }
    
    func test_cocktailListViewModel_in_finishedLoadingState() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .success(MockCocktailService.mockedDrinks)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssert(sut.state.isFinishedLoading)
    }
    
    func test_cocktailListViewModel_in_errorState() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .failure(DrinksError.genericError)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssert(sut.state.isError)
    }
    
    func test_cocktailListViewModel_in_errorState_withDescription() throws {
        //when
        mockDrinksService.fetchCocktailsResult = .failure(DrinksError.genericError)

        // given
        sut = .init(service: mockDrinksService)

        //then
        XCTAssert(!sut.state.errorDescription!.isEmpty)
    }
}
