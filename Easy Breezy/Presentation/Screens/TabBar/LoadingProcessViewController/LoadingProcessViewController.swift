//
//  LoadingProcessViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 13.08.2023.
//

import UIKit

class LoadingProcessViewController: UIViewController {
    
    
    @IBOutlet weak var firstLoadingProccesCoub: UIImageView!
    @IBOutlet weak var secondLoadingProccesCoub: UIImageView!
    @IBOutlet weak var thirdLoadingProccesCoub: UIImageView!
    @IBOutlet weak var fourthLoadingProccesCoub: UIImageView!
    
    @IBOutlet weak var progressBar: CourseProgressBar!
    
    
    @IBOutlet weak var loaderImageView: UIImageView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    var viewModel: LoadingProcessViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoadingProcessViewModel(viewController: self)
        // Do any additional setup after loading the view.
        loaderImageView.image = UIImage.gifImageWithName("loader_2")
        progressBar.progressBar.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
