//
//  BrunchesViewController.swift
//  Circuit
//
//  Created by Djuro Alfirevic on 12/8/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import UIKit

class BrunchesViewController: UIViewController, Setup {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var brunches = [Brunch]()
    private var filteredBrunches = [Brunch]()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.placeholder = Placeholders.search
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        tableView.tableFooterView = UIView()
        
        setupDummyData()
    }
    
    // MARK: - Private API
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    private func setupDummyData() {
        for i in 1...12 {
            var image: UIImage!
            if i < 10 {
                image = UIImage(named: "venuePhoto0\(i).jpg")!
            } else {
                image = UIImage(named: "venuePhoto\(i).jpg")!
            }
            
            var brunch = Brunch(name: "Venue #\(i)", description: "Cozy - Busy", distance: Double(i) * 0.34, image: image)
            brunch.review = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
            brunches.append(brunch)
        }
        
        tableView.reloadData()
    }
    
    private func filterBrunches(by term: String) {
        if term.count > 0 {
            filteredBrunches.removeAll()
            filteredBrunches.append(contentsOf: brunches.filter {
                $0.name.contains(term)
            })
        } else {
            filteredBrunches.removeAll()
        }
        
        tableView.reloadData()
    }
    
    private func showDetails(for brunch: Brunch) {
        if let toViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BrunchViewController") as? BrunchViewController {
            toViewController.brunch = brunch
            toViewController.modalTransitionStyle = .crossDissolve
            toViewController.modalPresentationStyle = .overCurrentContext
            self.present(toViewController, animated: true)
        }
    }
    
}

extension BrunchesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredBrunches.count : brunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.brunch, for: indexPath) as! BrunchTableViewCell
        
        cell.brunch = isFiltering() ? filteredBrunches[indexPath.row] : brunches[indexPath.row]
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let brunch = isFiltering() ? filteredBrunches[indexPath.row] : brunches[indexPath.row]
        
        if searchController.isActive {
            searchController.searchBar.text = ""
            searchController.isActive = false
        }
        
        showDetails(for: brunch)
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 50)
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
        })
    }

}

extension BrunchesViewController: UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterBrunches(by: term)
        }
    }
    
}
