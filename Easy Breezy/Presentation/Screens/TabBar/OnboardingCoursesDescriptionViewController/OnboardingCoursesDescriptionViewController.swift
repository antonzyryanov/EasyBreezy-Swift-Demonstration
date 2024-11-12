//
//  OnboardingCoursesDescriptionViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 25.08.2023.
//

import UIKit

class OnboardingCoursesDescriptionViewController: UIViewController {
    
    @IBOutlet weak var coursesContainerView: ContainerView!
    
    @IBOutlet weak var continueButton: PrimaryDarkBlueBottomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = OnboardingCoursesDescriptionViewModel(viewController: self, model: OnboardingCoursesDescriptionModel(courses: [
            OnboardingCourseDescriptionItemModel(courseName: "Introduction to Digital Marketing", imageName: "onboarding_course_image_test", themes: [
                OnboardingCourseThemeItemModel(couseNumber: "01", lessonsQuantity: "12 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "02", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "03", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "04", lessonsQuantity: "10 lessons", themeName: "More 20 themes")
            ]),
            OnboardingCourseDescriptionItemModel(courseName: "Comprehensive Digital Marketing",imageName: "onboarding_course_image_test", themes: [
                OnboardingCourseThemeItemModel(couseNumber: "01", lessonsQuantity: "12 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "02", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "03", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing")
            ]),
            OnboardingCourseDescriptionItemModel(courseName: "Comprehensive Digital Marketing 2",imageName: "onboarding_course_image_test", themes: [
                OnboardingCourseThemeItemModel(couseNumber: "01", lessonsQuantity: "12 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "02", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "03", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "04", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing"),
                OnboardingCourseThemeItemModel(couseNumber: "05", lessonsQuantity: "10 lessons", themeName: "Learn how digital marketing is different from marketing")
            ])
        ]))
        
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
