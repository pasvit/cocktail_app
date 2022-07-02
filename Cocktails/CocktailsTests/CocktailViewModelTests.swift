//
//  CocktailDetailViewModelTests.swift
//  CocktailsTests
//
//  Created by Pasquale on 02/07/22.
//

import XCTest
@testable import Cocktails

class CocktailDetailViewModelTests: XCTestCase {
    var sut: CocktailViewModel!
    var mockCountryService: MockCocktailService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCountryService = MockCocktailService()
        sut = MockCocktailService.mockedMargarita
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_cocktailViewModel_haveCocktailId() throws {
        //when
        mockCountryService.fetchCocktailImageResult = .success(UIImage(named: "easterEgg_questionMark")!)
        
        // given
        sut = MockCocktailService.mockedMargarita

        //then
        XCTAssert(!sut.id.isEmpty)
    }
    
    func test_cocktailViewModel_haveCocktailName() throws {
        //when
        mockCountryService.fetchCocktailImageResult = .success(UIImage(named: "easterEgg_questionMark")!)
        
        // given
        sut = MockCocktailService.mockedMargarita

        //then
        XCTAssert(!sut.name.isEmpty)
    }
    
    func test_cocktailViewModel_haveCocktailCategory() throws {
        //when
        mockCountryService.fetchCocktailImageResult = .success(UIImage(named: "easterEgg_questionMark")!)
        
        // given
        sut = MockCocktailService.mockedMargarita

        //then
        XCTAssert(!sut.category.isEmpty)
    }
    
    func test_cocktailViewModel_haveCocktailGlassType() throws {
        //when
        mockCountryService.fetchCocktailImageResult = .success(UIImage(named: "easterEgg_questionMark")!)
        
        // given
        sut = MockCocktailService.mockedMargarita

        //then
        XCTAssert(!sut.glassType.isEmpty)
    }
    
    func test_cocktailViewModel_haveCocktailImageUrlString() throws {
        //when
        mockCountryService.fetchCocktailImageResult = .success(UIImage(named: "easterEgg_questionMark")!)
        
        // given
        sut = MockCocktailService.mockedMargarita

        //then
        XCTAssert(!sut.imageUrlString!.isEmpty)
    }
    
    func test_cocktailViewModel_haveCocktailImage() throws {
        //when
        mockCountryService.fetchCocktailImageResult = .success(UIImage(named: "easterEgg_questionMark")!)
        
        // given
        sut = .init(service: mockCountryService, id: "178365", name: "Gin Tonic", category: "Cocktail", glassType: "Highball glass", alcoholic: "Alcoholic", instructions: "Fill a highball glass with ice, pour the gin, top with tonic water and squeeze a lemon wedge and garnish with a lemon wedge.", ingredientsMeasures: ["Lemon Peel": "1 Slice", "Gin": "4 cl", "Tonic Water": "10 cl", "Ice": "cubes"], imageUrlString: "https://www.thecocktaildb.com/images/media/drink/qcgz0t1643821443.jpg")

        //then
        XCTAssertNotNil(sut.image)
    }
    
    func test_cocktailViewModel_haveAllDetails() throws {
        //when
        mockCountryService.fetchCocktailImageResult = .success(UIImage(named: "easterEgg_questionMark")!)
        
        // given
        sut = .init(service: mockCountryService, id: "178365", name: "Gin Tonic", category: "Cocktail", glassType: "Highball glass", alcoholic: "Alcoholic", instructions: "Fill a highball glass with ice, pour the gin, top with tonic water and squeeze a lemon wedge and garnish with a lemon wedge.", ingredientsMeasures: ["Lemon Peel": "1 Slice", "Gin": "4 cl", "Tonic Water": "10 cl", "Ice": "cubes"], imageUrlString: "https://www.thecocktaildb.com/images/media/drink/qcgz0t1643821443.jpg")

        //then
        XCTAssert(!sut.id.isEmpty && !sut.name.isEmpty && !sut.category.isEmpty && !sut.glassType.isEmpty && !sut.alcoholic.isEmpty && !sut.instructions!.isEmpty && !sut.ingredientsMeasures.isEmpty && !sut.imageUrlString!.isEmpty && sut.image != nil)
    }
}
