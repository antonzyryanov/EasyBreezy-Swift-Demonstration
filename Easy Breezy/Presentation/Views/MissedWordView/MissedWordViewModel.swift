//
//  MissedWordViewModel.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 03.01.2023.
//

import Foundation
import UIKit

class MissedWordViewModel {
    
    var view: MissedWordView!
    var model: MissedWordModel!
    var chosenWords: [ChosenMissedWord] = []
    var missedWordsViewsCGRects: [CGRect] = []
    
    init(view: MissedWordView, model: MissedWordModel) {
        self.view = view
        self.model = model
        self.view.textView.textContainer.lineBreakMode = .byWordWrapping
        configure()
    }
    
    func configure() {
        
      //  self.view.textView.
        
        let ranges = setupWords()
        
        setupMissedWordViews(with: ranges)
    }
    
    private func setupWords() -> [NSRange] {
        var passedMissedWords: Int = 0
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 25
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        
        var finalString: NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: ""))
        
        for missedWordString in model.missedWordStrings {
            var attributedString = NSMutableAttributedString(string: missedWordString.string + "  ")
            if missedWordString.type == .missedWord && passedMissedWords < chosenWords.count {
                let url = URL(string: "https://www.apple.com")!
                attributedString = NSMutableAttributedString(string: chosenWords[passedMissedWords].string.replacingOccurrences(of: " ", with: "_") .replacingOccurrences(of: "-", with: "_") )
                attributedString.setAttributes([.link: url,.font: UIFont(name: "Inter-Bold", size: 16), .paragraphStyle: style], range: NSMakeRange(0, attributedString.string.count))
                passedMissedWords += 1
                
                var range = NSRange(location: 0, length: attributedString.length)
                let inputLength = attributedString.string.count
                let searchString = "_"
                let searchLength = searchString.count
                while (range.location != NSNotFound) {
                    range = (attributedString.string as NSString).range(of: searchString, options: [], range: range)
                    if (range.location != NSNotFound) {
                        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: range.location, length: searchLength))
                        attributedString.setAttributes([.foregroundColor: UIColor.white], range: NSMakeRange(range.location, 1))
                        range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                    }
                }
                
                
            } else {
                
                attributedString.setAttributes([.font: UIFont(name: "Inter-Medium", size: 16),.paragraphStyle: style], range: NSMakeRange(0, attributedString.string.count))
                
                if missedWordString.type == .missedWord {
                    var range = NSRange(location: 0, length: attributedString.length)
                    let inputLength = attributedString.string.count
                    let searchString = "________"
                    let searchLength = searchString.count
                    while (range.location != NSNotFound) {
                        range = (attributedString.string as NSString).range(of: searchString, options: [], range: range)
                        if (range.location != NSNotFound) {
                            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: range.location, length: searchLength))
                            range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                        }
                    }
                }
                
            }
            
            
            
            finalString.append(attributedString)
        }
        
        var ranges: [NSRange] = []
        
        self.view.textView.attributedText = finalString
        self.view.textView.isUserInteractionEnabled = true
        self.view.textView.isEditable = false
        
        self.view.textView.linkTextAttributes = [
            .foregroundColor: UIColor(red: 0.22, green: 0.631, blue: 1, alpha: 1),
            .font: UIFont(name: "Inter-Medium", size: 16)
        ]
        
        let str1 = finalString.string as NSString
        
        var rangeStart: Int = 0
        
        for index in 0..<20 {
            let range = str1.range(of: "________", options: NSString.CompareOptions.literal, range: NSMakeRange(rangeStart, str1.length - rangeStart))
            if range.length == 0 {
                continue
            }
            ranges.append(NSMakeRange(range.location, range.length))
            rangeStart = range.location + range.length
        }
        
        for word in chosenWords {
            let range = str1.range(of: word.string.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "_") , options: NSString.CompareOptions.literal, range: NSMakeRange(0, str1.length))
            if range.length != 0 {
                ranges.append(range)
            }
        }
        
        return ranges
        
    }
    
    private func setupMissedWordViews(with ranges: [NSRange]) {
        
        self.view.textView.layoutManager.ensureLayout(for: self.view.textView.textContainer)
        
        var rects: [CGRect] = []
        
        for range in ranges {
            
            // text position of the range.location
            guard let start = self.view.textView.position(from: self.view.textView.beginningOfDocument, offset: range.location) else { continue }
            // text position of the end of the range
            guard let end = self.view.textView.position(from: start, offset: range.length) else { continue }
            // text range of the range
            guard let tRange = self.view.textView.textRange(from: start, to: end) else { continue }
            // here it is!
            let rect = self.view.textView.firstRect(for: tRange)
            rects.append(rect)
        }
        
        self.missedWordsViewsCGRects = rects
    }
    
    
    
}
