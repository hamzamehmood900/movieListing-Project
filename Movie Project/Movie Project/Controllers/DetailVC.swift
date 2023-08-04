//
//  DetailVC.swift
//  Movie Project
//
//  Created by hamza mahmood on 02/08/2023.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleTexr: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var ratingText: UILabel!
    @IBOutlet weak var ratingTextView: UIView!

    var movieDetails: Results?
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtnView.layer.cornerRadius = backBtnView.frame.size.height/2
        ratingTextView.layer.cornerRadius = ratingTextView.frame.size.height/2

        titleTexr.text = movieDetails?.original_title
        descriptionText.text = movieDetails?.overview
        ratingText.text = "\(movieDetails?.vote_average ?? 0)"
        dateText.text = "Relased Date: " + (movieDetails?.release_date ?? "")

        getImagesFromServer(myImage: bannerImage, imageURL: movieDetails?.poster_path ?? "")
        
    }

    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}




