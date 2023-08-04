//
//  Plugin.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import Foundation
import Moya
import UIKit
import Kingfisher
import ProgressHUD

struct Plugin {
    static let networkPlugin = NetworkActivityPlugin.init(networkActivityClosure: { (changeType, targetType) in
        switch (changeType){
        case .began:
            UIApplication.startActivityIndicator()
        case .ended:
            UIApplication.stopActivityIndicator()
        }
    })
}


extension UIApplication{
    class func startActivityIndicator(with message: String? = "") {
        DispatchQueue.main.async {
            ProgressHUD.colorHUD = UIColor.red
            ProgressHUD.colorAnimation = UIColor.blue
            ProgressHUD.animationType = .circleStrokeSpin
            ProgressHUD.show(nil, interaction: false)
        }
    }
    
    class func startActivityProgressview(with message: String? = "") {
        DispatchQueue.main.async {
            ProgressHUD.colorHUD = UIColor.init(named: "ViewBgColor")!
            ProgressHUD.colorAnimation = .red
            ProgressHUD.animationType = .lineScaling
            ProgressHUD.showProgress("We are uploading your story.", 10.0)// // // // // / / / / /
        }
    }
    
    class func stopActivityIndicator(){
        DispatchQueue.main.async {
            ProgressHUD.dismiss()
        }
    }
    
    class func kgfImageWithPlaceholder(image: UIImageView, img_url: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: img_url)
        var dImage : UIImage?
        let processor = DownsamplingImageProcessor(size: image.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        image.kf.indicatorType = .activity
        image.kf.setImage(with: url,
                          placeholder: UIImage(named: "noImageFound"),
                          options: [.processor(processor),
                                    .scaleFactor(UIScreen.main.scale),
                                    .transition(.fade(1)),
                                    .cacheOriginalImage]) { result in
                                        switch result {
                                        case .success(let value):
                                            print("Task done for: \(value.source.url?.absoluteString ?? "")")
                                            dImage = image.image
                                            completion(dImage)
                                        case .failure(let error):
                                            print("Job failed: \(error.localizedDescription)")
                                            dImage = UIImage(named: "noImageFound")!
                                            completion(dImage)
            }
        }
    }
}
