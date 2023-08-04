//
//  MovieListCell.swift
//  Movie Project
//
//  Created by hamza mahmood on 01/08/2023.
//

import UIKit

class MovieListCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var DirectorName: UILabel!
    @IBOutlet weak var ratingText: UILabel!
    @IBOutlet weak var ratingText_View: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 10
        ratingText_View.layer.cornerRadius = ratingText_View.frame.size.height/2

        self.layer.cornerRadius = 10 // Adjust the value to your desired corner radius
        self.layer.masksToBounds = true

        // Initialization code
    }

}


