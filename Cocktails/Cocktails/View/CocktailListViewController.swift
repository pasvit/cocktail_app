//
//  ViewController.swift
//  Cocktails
//
//  Created by Pasquale on 29/06/22.
//

import UIKit

class CocktailListViewController: UIViewController, Storyboarded {
    //    MARK: - Coordinator
    weak var coordinator: MainCoordinator?
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - View
    // \_____________________________________________________________________/
    @IBOutlet weak var tableView: UITableView!
    private var loaderView: UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.startAnimating()
        activityIndicatorView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        return activityIndicatorView
    }
    
    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private Var
    // \_____________________________________________________________________/
    private var cocktailListViewModel: CocktailListViewModel?
    private var cocktailsViewModel: [CocktailViewModel]? {
        cocktailListViewModel?.cocktailsViewModel
    }
    
    // filter
    private var filteredCocktails: [CocktailViewModel] = []
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpNavigation()
        setUpSearchController()
        callToViewModelForUIUpdate()
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private Methods
    // \_____________________________________________________________________/
    private func setupTableView() {
        registerTableViewCells()
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Cocktails"
    }
    
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cocktail"
        searchController.searchBar.backgroundImage = UIImage()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func callToViewModelForUIUpdate() {
        self.cocktailListViewModel = CocktailListViewModel()
        self.cocktailListViewModel?.bindCocktailsToView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.loadMoreCocktails()
            }
        }
        self.cocktailListViewModel?.bindStateToView = { [weak self] in
            DispatchQueue.main.async {
                if let error = self?.cocktailListViewModel?.state.errorDescription {
                    UIAlertController.showError(message: error)
                    self?.hideBottomLoader()
                }
                if let isListCompleted = self?.cocktailListViewModel?.state.isCompleted {
                    if isListCompleted { self?.tableView.tableFooterView?.isHidden = true }
                }
            }
        }
    }
    
    private func loadMoreCocktails() {
        if let cocktailItem = self.cocktailsViewModel?.last {
            if InternetConnectionManager.isConnectedToNetwork() {
                self.cocktailListViewModel?.loadMoreCocktailsIfNeeded(lastCocktail: cocktailItem)
            }
        }
    }
    
    private func showBottomLoader() {
        self.tableView.tableFooterView?.isHidden = false
    }
    
    private func hideBottomLoader() {
        self.tableView.tableFooterView?.isHidden = true
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        if InternetConnectionManager.isConnectedToNetwork() {
            if let isLoading = self.cocktailListViewModel?.state.isLoading, !isLoading {
                self.callToViewModelForUIUpdate()
            }
            self.refreshControl.endRefreshing()
        } else {
            UIAlertController.showError(title: "Info", message: "Turn on connection if you want to refresh cocktails") {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
}

// ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
//    MARK: - TableView Data Source
// \___________________________________________/
extension CocktailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCocktails.count
        }
        return cocktailsViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cocktailVM: CocktailViewModel?
        
        if isFiltering {
            cocktailVM = filteredCocktails[indexPath.row]
        } else if let cocktailsVM = self.cocktailsViewModel, !cocktailsVM.isEmpty {
            if cocktailsVM.count >= indexPath.row {
                cocktailVM = cocktailsVM[indexPath.row]
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell", for: indexPath) as! CocktailTableViewCell
        cell.cocktailViewModel = cocktailVM
        return cell
    }
}

// ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
//    MARK: - TableView Delegate
// \___________________________________________/
extension CocktailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cocktailVM: CocktailViewModel?
        
        if isFiltering {
            cocktailVM = filteredCocktails[indexPath.row]
        } else {
            cocktailVM = self.cocktailsViewModel?[indexPath.row]
        }
        
        if let cocktailVM = cocktailVM {
            coordinator?.pushDetail(with: cocktailVM)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.loadMoreCocktails()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let isListCompleted = self.cocktailListViewModel?.state.isCompleted, InternetConnectionManager.isConnectedToNetwork() && !isListCompleted {
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                self.tableView.tableFooterView = loaderView
                self.showBottomLoader()
            }
        }
    }
}

// ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
//    MARK: - UISearchResultsUpdating Delegate
// \___________________________________________/
extension CocktailListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.tableFooterView?.isHidden = true
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    cocktailVM: CocktailViewModel? = nil) {
        filteredCocktails = cocktailsViewModel?.filter({
            $0.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        
        tableView.reloadData()
    }
}
