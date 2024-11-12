//
//  LanguageSelectionViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 23.08.2023.
//

import UIKit

class LanguageSelectionViewController: UIViewController {
    
    @IBOutlet weak var navigationView: ProfileMenuNavigationView!
    @IBOutlet weak var languageSelectionView: LanguageSelectionView!
    var languageSelectionViewModel: LanguageSelectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.presentingViewController = self
        languageSelectionViewModel = LanguageSelectionViewModel(view: self.languageSelectionView)
        navigationView.configureWith(title: "Language")
        // Do any additional setup after loading the view.
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
