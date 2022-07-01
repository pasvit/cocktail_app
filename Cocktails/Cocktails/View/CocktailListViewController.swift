//
//  ViewController.swift
//  Cocktails
//
//  Created by Pasquale on 29/06/22.
//

import UIKit

class CocktailListViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    
    private var loaderView: UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.startAnimating()
        activityIndicatorView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        return activityIndicatorView
    }
    
    weak var coordinator: MainCoordinator?
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private Var
    // \_____________________________________________________________________/
    private var cocktailListViewModel: CocktailListViewModel?
    private var cocktailsViewModel: [CocktailViewModel]? {
        cocktailListViewModel?.cocktailsViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setUpNavigation()
        callToViewModelForUIUpdate()
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private Methods
    // \_____________________________________________________________________/
    private func setUpNavigation() {
        navigationItem.title = "Cocktails"
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
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
}

extension CocktailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cocktailsVM = cocktailsViewModel else { return 0 }
        return cocktailsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell", for: indexPath) as! CocktailTableViewCell
        cell.cocktailViewModel = self.cocktailsViewModel?[indexPath.row]
        return cell
    }
}

extension CocktailListViewController: UITableViewDelegate {
    
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
