//
//  CollectionViewExtension.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 03/08/2023.
//

import Foundation
import UIKit

extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 25
        let collectionCellSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionCellSize/2, height: collectionCellSize/1.1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredStoreListing.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieListCell
        cell.movieName.text = filteredStoreListing[indexPath.row].title
        cell.DirectorName.text = filteredStoreListing[indexPath.row].release_date
        cell.ratingText.text = "\(filteredStoreListing[indexPath.row].vote_average ?? 0)"
        
        getImagesFromServer(myImage: cell.movieImage, imageURL: self.filteredStoreListing[indexPath.row].poster_path  ?? "")
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItemIndex = storeListing.count - 1
        if indexPath.row == lastItemIndex {
            pagination += 1
            getMovieListingFromAPI(page: "\(pagination)")
            isLastItemReached = true // Set the flag to true to avoid multiple calls
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = filteredStoreListing[indexPath.row]
        nextViewController(identifier: "DetailVC", data: selectedMovie)
        
    }
}

//MARK: - For Last Row For Pagination

public extension IndexPath {
    func isLastRow(at collectionView: UICollectionView) -> Bool {
        return row == (collectionView.numberOfItems(inSection: section) - 1)
    }
}

