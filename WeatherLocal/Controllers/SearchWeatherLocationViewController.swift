//
//  ViewController.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 25/02/22.
//

import UIKit

class SearchWeatherLocationViewController: UIViewController {
    @IBOutlet weak var locationListTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var viewModel = {
        GeoCodingViewModel()
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(numberOfVowel(str: "Exception"))
        
        setupSearchBar()
        
        getDefaultLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = locationListTableView.indexPathForSelectedRow {
            locationListTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Location"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func getDefaultLocation() {
        viewModel.fetchDefaultLocations()
        //Reload tableview closure
        viewModel.reloadTableView = { [weak self] in
            self?.locationListTableView.reloadData()
        }
    }
    
    func numberOfVowel(str: String) -> Int {
        let vowel: [Character] = ["a", "e", "i", "o", "u"]
        return str.lowercased().reduce(0) { $0 + (vowel.contains($1) ? 1 : 0) }
    }
}

extension SearchWeatherLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationListTableView.dequeueReusableCell(withIdentifier: "SearchWeatherCell", for: indexPath)
        
        var cellVM: GeoCodingCellViewModel
        
        cellVM = viewModel.getCellViewModel(at: indexPath)
        cellVM.name.bind { name in
            cell.textLabel?.text = name
        }
        cellVM.state.bind { state in
            cell.detailTextLabel?.text = state
        }
        
        return cell
    }
}

extension SearchWeatherLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cellVM.lat.bind { lat in
            vc?.latitute = lat
        }
        cellVM.long.bind { lon in
            vc?.longitute = lon
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension SearchWeatherLocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if isSearchBarEmpty {
            getDefaultLocation()
        } else {
            viewModel.filteredContentForSearchText(searchBar.text!)
            viewModel.reloadTableView = { [weak self] in
                self?.locationListTableView.reloadData()
            }
        }
    }
}

extension SearchWeatherLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isSearchBarEmpty {
            getDefaultLocation()
        } else {
            viewModel.filteredContentForSearchText(searchBar.text!)
            viewModel.reloadTableView = { [weak self] in
                self?.locationListTableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getDefaultLocation()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        if let searchBarText = searchBar.text, searchBarText.count > 3 {
            viewModel.fetchLocations(with: searchBarText)
            
            //Reload tableview closure
            viewModel.reloadTableView = { [weak self] in
                self?.locationListTableView.reloadData()
            }
        }
      searchBar.resignFirstResponder()
    }
}
