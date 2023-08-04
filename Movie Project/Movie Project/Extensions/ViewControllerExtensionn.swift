//
//  ViewControllerExtenstion.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 03/08/2023.
//

import Foundation
import UIKit
import Kingfisher


extension MovieListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredStoreListing = storeListing
        } else {
            filteredStoreListing = storeListing.filter { movie in
                if let title = movie.title {
                    return title.lowercased().contains(searchText.lowercased())
                }
                return false // If movie.title is nil, return false
            }
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // UseToManage Keyboard hide and show
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
}

extension MovieListVC {
    func storeFilteredDataInUserDefaults() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(filteredStoreListing) {
            UserDefaults.standard.set(encodedData, forKey: "filteredMovies")
        } else {
            // Handle the error if encoding fails
        }
    }
}

extension UIViewController {
    
    func getImagesFromServer(myImage: UIImageView,imageURL: String) {
        
        let imageURLString = "https://image.tmdb.org/t/p/original\(imageURL)"
        if let imageURL = URL(string: imageURLString) {
            // Load the image using Kingfisher with placeholder and options
            let options: KingfisherOptionsInfo = [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .processor(ResizingImageProcessor(referenceSize: myImage.bounds.size)),
                .cacheOriginalImage
            ]
            myImage.kf.setImage(with: imageURL, placeholder: Constants.placeholderImage, options: options)
        } else {
            myImage.image = Constants.placeholderImage
        }
        
    }
    
    
    
    func nextViewController(identifier: String, data: Results) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        
        if let destinationVC = newViewController as? DetailVC {
            destinationVC.movieDetails = data
        }
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}


