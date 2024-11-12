//
//  ExerciseTopView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 10.01.2023.
//

import UIKit
import SideMenu
import LGSideMenuController

class ExerciseTopView: UIView, XibLoadable {
    
    
    @IBOutlet weak var toAllCoursesButton: UIButton!
    @IBOutlet weak var toAllCoursesLabel: UILabel!
    @IBOutlet weak var navigationArrow: UIImageView!
    @IBOutlet weak var themeName: UILabel!
    
  //  @IBOutlet weak var advertisementView: UIView! 
    
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var courseProgressBar: CourseProgressBar!
    @IBOutlet weak var lifesView: LifesView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromXib()
    }
    
    func customizeView() {
        self.accountButton.setTitle("", for: .normal)
        self.toAllCoursesButton.setTitle("", for: .normal)
    }
    
    
    @IBAction func allCoursesButtonAction(_ sender: Any) {
        guard let viewController = self.viewController else { return }
        viewController.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func accountButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProfileMenuViewController", bundle: nil)
        let profileMenuViewController = storyboard.instantiateViewController(withIdentifier: "ProfileMenuViewController")
      //  let profileMenuViewController = ProfileMenuViewController()
      //  profileMenuViewController.modalPresentationStyle = .overCurrentContext
        
        if let currentVewController = UIApplication.topViewController() as? LGSideMenuController {
          //  let menu = SideMenuNavigationController(rootViewController: profileMenuViewController)
            print("TEST BUDA 2 \(currentVewController)")
            print("TEST BUDA \(currentVewController.parent)")
            currentVewController.showLeftView()
            //currentVewController.presentDetail(profileMenuViewController)
           // currentVewController.present(menu, animated: true)
         //   lgSideMenuController.showLeftView()
        }
        
    }
    
}
