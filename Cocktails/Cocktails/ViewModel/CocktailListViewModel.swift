//
//  CocktailListViewModel.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

enum CocktailListViewModelState {
    case notLoad
    case loading
    case finishedLoading
    case completed
    case error(DrinksError)
    
    var isNotLoad: Bool {
        if case .notLoad = self { return true }
        return false
    }
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var isCompleted: Bool {
        if case .completed = self { return true }
        return false
    }
    
    var isFinishedLoading: Bool {
        if case .finishedLoading = self { return true }
        return false
    }
    
    var isError: Bool {
        if case .error(_) = self { return true }
        return false
    }
    
    var errorDescription: String? {
        if case .error(let error) = self {
            return error.localizedDescription
        }
        return nil
    }
}

class CocktailListViewModel {
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private(set) var
    // \_____________________________________________________________________/
    private(set) var cocktailsViewModel: [CocktailViewModel] = [] {
        didSet {
            self.bindCocktailsToView()
        }
    }
    private(set) var state: CocktailListViewModelState = .notLoad {
        didSet {
            self.bindStateToView()
        }
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Binding var
    // \_____________________________________________________________________/
    var bindCocktailsToView : (() -> ()) = {}
    var bindStateToView : (() -> ()) = {}
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private var
    // \_____________________________________________________________________/
    private var service: CocktailServiceProtocol
    
    /// all first letters of cocktails to load
    private let COCKTAILS_INITIALS: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "v", "w", "y", "z"]
    /// last initial used to load cocktails
    private var indexToLoad: Int = -1
    private var canLoadMorePages: Bool {
        indexToLoad != COCKTAILS_INITIALS.count-1
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Init
    // \_____________________________________________________________________/
    init(service: CocktailServiceProtocol = CocktailServiceFacade()) {
        self.service = service
        loadMoreCocktails()
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Public Methods
    // \_____________________________________________________________________/
    func loadMoreCocktailsIfNeeded(lastCocktail cocktail: CocktailViewModel?) {
        let thresholdIndex = cocktailsViewModel.index(cocktailsViewModel.endIndex, offsetBy: -1)
        
        if !canLoadMorePages {
            state = .completed
        } else if cocktailsViewModel.firstIndex(where: { $0.id == cocktail?.id }) == thresholdIndex {
            loadMoreCocktails()
        }
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private Methods
    // \_____________________________________________________________________/
    private func loadMoreCocktails() {
        guard state.isNotLoad || !state.isLoading else { return }
        indexToLoad = COCKTAILS_INITIALS.index(after: indexToLoad)
        
        state = .loading
        
        service.fetchCocktails(by: COCKTAILS_INITIALS[indexToLoad]) { result in
            switch result {
            case .success(let cocktailsVM):
                self.cocktailsViewModel += cocktailsVM
                self.state = .finishedLoading
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
}
