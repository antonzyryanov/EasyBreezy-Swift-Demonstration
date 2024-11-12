//
//  OnBoardingQuestionsViewController.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 01.08.2023.
//

import UIKit
import AppTrackingTransparency
import AdSupport

class OnBoardingQuestionsViewController: UIViewController {
    
    var viewModel: OnBoardingQuestionsViewModel!
    
    @IBOutlet weak var progressBarHorizontalContainerView: HorisontalContainerView!
    @IBOutlet weak var answersContainerView: ContainerView!
    @IBOutlet weak var multipleAnswersContainerView: ContainerView!
    @IBOutlet weak var nextPageButton: PrimaryDarkBlueBottomButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var emojiImage: UIImageView!
    
    @IBOutlet weak var answersContainerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var multipleAnswersContainerViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OnBoardingQuestionsViewModel(viewController: self, model: OnBoardingQuestionsModel(questions: [
                                                                                                        OnBoardingQuestionModel(question: "What's your marketing experience?", bigEmoji: "big_emoji_mac", answers:  [OnboardingAnswerModel(emojiImage: "emoji_none", answer: "None at all"),OnboardingAnswerModel(emojiImage: "emoji_liar", answer: "Yes, I am a seasoned marketer (more than 3 years)"),OnboardingAnswerModel(emojiImage: "emoji_baby", answer: "Yes, I have some experience (less then 3 years)")]),
                                                                                                        OnBoardingQuestionModel(question: "What are your objectives in studying marketing?", bigEmoji: "big_emoji_glasses", answers:  [OnboardingAnswerModel(emojiImage: "emoji_hm", answer: "General interest"),OnboardingAnswerModel(emojiImage: "emoji_nerd", answer:"Deeping knowledge"),OnboardingAnswerModel(emojiImage: "emoji_wtf", answer: "Learn specific topics"),OnboardingAnswerModel(emojiImage: "emoji_snitchy", answer: "Other")]),
                                                                                                        
                                                                                                        OnBoardingQuestionModel(question: "What's your current role?", bigEmoji: "big_emoji_worker", answers:  [OnboardingAnswerModel(emojiImage: "emoji_student", answer: "Student"),OnboardingAnswerModel(emojiImage: "emoji_beard", answer:"Business owner/Entrepreneur"),OnboardingAnswerModel(emojiImage: "emoji_king", answer: "Marketing professional"),OnboardingAnswerModel(emojiImage: "emoji_cross", answer: "Non-marketing professional"),OnboardingAnswerModel(emojiImage: "emoji_punk", answer: "Other")]),
                                                                                                        
                                                                                                        OnBoardingQuestionModel(question: "What marketing topics are you interested in?", bigEmoji: "big_emoji_blow", answers:  [OnboardingAnswerModel(emojiImage: "", answer: "Comprehensive Digital Marketing"),OnboardingAnswerModel(emojiImage: "", answer:"Social Media Marketing"),OnboardingAnswerModel(emojiImage: "", answer: "User Acquisition and Pay-Per-Click (PPC) Advertising"),OnboardingAnswerModel(emojiImage: "", answer: "Search Engine Optimization (SEO)"),OnboardingAnswerModel(emojiImage: "", answer: "Product Marketing"),OnboardingAnswerModel(emojiImage: "", answer: "Affiliate Marketing")]),
                                                                                                        
        ]
        ))
        viewModel.configure()
        nextPageButton.tapAction = nextPageButtonPressed
        nextPageButton.title = "Continue"
        requestPermission()
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
    
    
    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }
    
    private func nextPageButtonPressed() {
        viewModel.updateUI()
    }

}
