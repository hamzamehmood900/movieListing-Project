//
//  MovieListVC.swift
//  Movie Project
//
//  Created by hamza mahmood on 01/08/2023.
//

import UIKit
import Kingfisher
import Network

class MovieListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    var reuseIdentifier = "MovieListCell"
    var pagination = 1
    var listing = [Results]()
    var storeListing = [Results]()
    var filteredStoreListing: [Results] = []

    var isLastItemReached = false

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadCell()
        getMovieListingFromAPI(page: "\(pagination)")
        setupTapGesture()

    }
    
    
    func reloadCell() {
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    


    //Fetch data from API
    func getMovieListingFromAPI(page: String) {
        APIManager.getMovieLists(page: page,completion: { [weak self] response, error in
            guard let strongSelf = self else { return }
            if response != nil {
                if strongSelf.pagination == 1 {
                    strongSelf.storeListing.removeAll()
                }
                strongSelf.listing.removeAll()
                strongSelf.listing =  response ?? []
                strongSelf.storeListing.append(contentsOf: strongSelf.listing)
                strongSelf.filteredStoreListing = strongSelf.storeListing
                strongSelf.storeFilteredDataInUserDefaults()
                strongSelf.collectionView?.reloadData()
            } else {
                print(error)
            }
        })
    }
}




