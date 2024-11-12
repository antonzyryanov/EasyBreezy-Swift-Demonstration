//
//  LoadingProcessViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 13.08.2023.
//

import Foundation
import UIKit

class LoadingProcessViewModel {
    
    var viewController: LoadingProcessViewController!
    
    var timerIteration = 0 {
        didSet {
            completionPercentage = Double(timerIteration*100/20)
        }
    }
    
    var completionPercentage: Double = 0 {
        didSet {
//            DispatchQueue.main.async { [self] in
//                self.viewController.percentageLabel.text = "\(Int(completionPercentage))%"
//            }
        }
    }
    
    init(viewController: LoadingProcessViewController) {
        self.viewController = viewController
        self.setupCoubsAnimations()
        self.runTimer()
    }
    
    private func setupCoubsAnimations() {
        DispatchQueue.main.async { [self] in
            self.setupRhombusTrajectoryAnimationFor(coub: self.viewController.firstLoadingProccesCoub, with: 20, speed: 2.0)
            self.setupRhombusTrajectoryAnimationFor(coub: self.viewController.secondLoadingProccesCoub, with: 5, speed: 1.0)
            self.setupRhombusTrajectoryAnimationFor(coub: self.viewController.thirdLoadingProccesCoub, with: 10, speed: 1.5)
            self.setupRhombusTrajectoryAnimationFor(coub: self.viewController.fourthLoadingProccesCoub, with: 15, speed: 1.8)
        }
    }
    
    private func setupRhombusTrajectoryAnimationFor(coub: UIView, with sideLength: CGFloat, speed: CGFloat) {
        UIView.animate(withDuration: speed, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //Frame Option 1:
                coub.frame = CGRect(x: coub.frame.origin.x + sideLength, y: coub.frame.origin.y + sideLength, width: coub.frame.width, height: coub.frame.height)

                //Frame Option 2:
                //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                },completion: { finish in

                    UIView.animate(withDuration: speed, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                            //Frame Option 1:
                            coub.frame = CGRect(x: coub.frame.origin.x + sideLength, y: coub.frame.origin.y - sideLength, width: coub.frame.width, height: coub.frame.height)

                            //Frame Option 2:
                            //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                            },completion: { finish in

                                UIView.animate(withDuration: speed, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                                        //Frame Option 1:
                                        coub.frame = CGRect(x: coub.frame.origin.x - sideLength, y: coub.frame.origin.y - sideLength, width: coub.frame.width, height: coub.frame.height)

                                        //Frame Option 2:
                                        //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                                        },completion: { finish in

                                            UIView.animate(withDuration: speed, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                                                    //Frame Option 1:
                                                    coub.frame = CGRect(x: coub.frame.origin.x - sideLength, y: coub.frame.origin.y + sideLength, width: coub.frame.width, height: coub.frame.height)

                                                    //Frame Option 2:
                                                    //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                                                    },completion: { finish in

                                                        self.setupRhombusTrajectoryAnimationFor(coub: coub, with: sideLength, speed: speed)
                                                
                                                })
                                    
                                    })
                        
                        })
            
            })
    
        }
    
    
    func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            self.timerIteration += 1
            DispatchQueue.main.async {
                self.viewController.progressBar.configure(with: Double(self.timerIteration*20))
                self.viewController.progressBar.progressBar.isHidden = false
            }
            if self.timerIteration == 5 {
                DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "EnterViewController", bundle: nil)
                    guard let enterViewController = storyboard.instantiateViewController(withIdentifier: "EnterViewController") as? EnterViewController else { return }
                    enterViewController.modalPresentationStyle = .overCurrentContext
                    self.viewController.present(enterViewController, animated: true)
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isOnBoardingPassed")
                }
            }
        }
    }
                       
}
