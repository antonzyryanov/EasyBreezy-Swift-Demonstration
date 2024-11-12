//
//  ExercisesFactory.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.01.2023.
//

import Foundation

class ExercisesFactory {
    
    static let shared = ExercisesFactory()
    
    func generateExercises(from parsedCourse: ParsedCourse) -> [Exercise] {
        var exercises: [Exercise] = []
        for parsedExercie in parsedCourse.data.attributes.lessons.data {
            if let trainerType = parsedExercie.attributes.trainerType {
                if trainerType == "chooseAnswer" {
                    if let answer = parsedExercie.attributes.trainer?.answer {
                        guard let singleOptionChoiseModel = generateSingleOptionChoiseModel(from: parsedExercie) else { continue }
                        exercises.append(Exercise(type: .singleOptionChoise, content: singleOptionChoiseModel))
                    }
                    if let answers = parsedExercie.attributes.trainer?.answers {
                        guard let multipleOptionChoiseModel = generateMultipleOptionChoiseModel(from: parsedExercie) else { continue }
                        exercises.append(Exercise(type: .multipleOptionsChoise, content: multipleOptionChoiseModel))
                    }
                }
                if trainerType == "makeOrder" {
                    guard let funnelExerciseModel = generateFunnelExerciseModel(from: parsedExercie) else { continue }
                    exercises.append(Exercise(type: .pyramid, content: funnelExerciseModel))
                }
                if trainerType == "rightOrder" {
                    guard let rightOrderExerciseModel = generateRightOrderExerciseModel(from: parsedExercie) else { continue }
                    exercises.append(Exercise(type: .rightOrder, content: rightOrderExerciseModel))
                }
                if trainerType == "distributionByColumns" {
                    guard let twoColumnsModel = generateTwoColumnsExerciseModel(from: parsedExercie) else { continue }
                    exercises.append(Exercise(type: .twoColumns, content: twoColumnsModel))
                }
                if trainerType == "definitionsMatching" {
                    guard let termsComparisonModel = generateTermsComparisonModel(from: parsedExercie) else { continue }
                    exercises.append(Exercise(type: .termsComparison, content: termsComparisonModel))
                }
                if trainerType == "missedWords" {
                    guard let missedWordsModel = generateMissedWordExerciseModel(from: parsedExercie) else { continue }
                    exercises.append(Exercise(type: .missedWord, content: missedWordsModel))
                }
            } else {
                guard let informationModel = generateInformationModel(from: parsedExercie) else { continue }
                exercises.append(Exercise(type: .information, content: informationModel))
            }
        }
        exercises.append(Exercise(type: .courseEnd, content: CourseEndModel(order: 1000, message: "Great!\n You’ve done it", image: "end_1_1")))
        
        print("TEST SND \n \(exercises)")
        
        return exercises.sorted(by: {$0.content.order < $1.content.order})
    }
    
    private func generateInformationModel(from lessonData: LessonData) -> InformationModel? {
        print("TEST M1 \(lessonData)")
        guard let parsedInfoItems = lessonData.attributes.content else { return nil }
        let parsedInfoItemsArray = parsedInfoItems.components(separatedBy: "\n")
        var infoItems: [ContainerItem] = []
        for parsedInfoItem in parsedInfoItemsArray {
            guard let firstLetter = parsedInfoItem.first else { continue }
            if firstLetter == "!" {
                let components = parsedInfoItem.components(separatedBy: ".png]")
                let imageURL = components[1].dropFirst().dropLast()
                infoItems.append(ContainerItem(contentType: .image, content: String(imageURL)))
            } else {
                infoItems.append(ContainerItem(contentType: .text, content: parsedInfoItem))
            }
        }
        return InformationModel(order: lessonData.attributes.order, theme: lessonData.attributes.title, informationItems: infoItems, themeName: lessonData.attributes.name)
    }
    
    private func generateSingleOptionChoiseModel(from lessonData: LessonData) -> SingleOptionChoiseModel? {
        var answersOptions: [String] = []
        var comments: [String] = []
        var answerInt: Int = 0
        guard let answerString = lessonData.attributes.trainer?.answer?.first else { return nil }
        guard let successMessage = lessonData.attributes.trainer?.success else { return nil }
        guard let options = lessonData.attributes.trainer?.options else { return nil }
        let question = lessonData.attributes.content
        let commentary = lessonData.attributes.trainerLabel
        for (index,parsedAnswer) in options.enumerated() {
            answersOptions.append(parsedAnswer.title)
            if parsedAnswer.value == answerString {
                answerInt = index
                comments.append(successMessage)
                continue
            }
            comments.append(parsedAnswer.error ?? "Not right")
        }
        return SingleOptionChoiseModel(order: lessonData.attributes.order, answerOptions: answersOptions, title: lessonData.attributes.title, question: question ?? "", commentary: commentary ?? "", rightAnswer: answerInt, comments: comments, themeName: lessonData.attributes.name)
    }
    
    private func generateMultipleOptionChoiseModel(from lessonData: LessonData) -> MultipleOptionChoiseModel? {
        var answersOptions: [String] = []
        var comments: [String] = []
        var answersInt: [Int] = []
        guard let answersString: [String] = lessonData.attributes.trainer?.answers else { return nil }
        guard let successMessage = lessonData.attributes.trainer?.success else { return nil }
        guard let options = lessonData.attributes.trainer?.options else { return nil }
        let question = lessonData.attributes.content ?? ""
        let commentary = lessonData.attributes.trainerLabel
        comments.append(successMessage)
        for (index,parsedAnswer) in options.enumerated() {
            answersOptions.append(parsedAnswer.title)
            comments.append(parsedAnswer.error ?? successMessage)
            if answersString.contains(parsedAnswer.value) {
                answersInt.append(index)
            }
        }
        return MultipleOptionChoiseModel(order: lessonData.attributes.order, answerOptions: answersOptions, rightAnswers: answersInt, title: lessonData.attributes.title, commentary: commentary ?? "", comments: comments, themeName: lessonData.attributes.name, question: question)
    }
    
    fileprivate func fillContentItemsWith(_ lessonData: LessonData, _ contentItems: inout [ContainerItem]) {
        if let parsedContentItems = lessonData.attributes.content {
            let parsedContentItemsArray = parsedContentItems.components(separatedBy: "\n")
            for parsedInfoItem in parsedContentItemsArray {
                guard let firstLetter = parsedInfoItem.first else { continue }
                if firstLetter == "!" {
                    let components = parsedInfoItem.components(separatedBy: ".png]")
                    let imageURL = components[1].dropFirst().dropLast()
                    contentItems.append(ContainerItem(contentType: .image, content: String(imageURL)))
                } else {
                    contentItems.append(ContainerItem(contentType: .text, content: parsedInfoItem))
                }
            }
        }
    }
    
    private func generateFunnelExerciseModel(from lessonData: LessonData) -> FunnelExerciseModel? {
        var steps: [String] = []
        var comments: [String] = []
        var rightOrder: String = ""
        guard let answersString: [String] = lessonData.attributes.trainer?.answer else { return nil }
        let successMessage = lessonData.attributes.trainer?.success
        let error = lessonData.attributes.trainer?.error
        guard let options = lessonData.attributes.trainer?.options else { return nil }
        let question = lessonData.attributes.content
        let commentary = lessonData.attributes.trainerLabel
        comments.append(successMessage ?? "")
        comments.append(error ?? "")
        for parsedAnswer in answersString {
            for (index,option) in options.enumerated() {
                if option.value == parsedAnswer { rightOrder.append(String(index+1)) }
            }
        }
        
        var contentItems: [ContainerItem] = []
        
        fillContentItemsWith(lessonData, &contentItems)
        
        
        for (index,parsedAnswer) in options.enumerated() {
            steps.append(parsedAnswer.title)
        }
        return FunnelExerciseModel(order: lessonData.attributes.order, title: lessonData.attributes.title, commentary: commentary ?? "", steps: steps, rightOrder: rightOrder, comments: comments, themeName: lessonData.attributes.name, contentItems: contentItems)
    }
    
    private func generateRightOrderExerciseModel(from lessonData: LessonData) -> RightOrderExerciseModel? {
        var steps: [String] = []
        var comments: [String] = []
        var rightOrder: String = ""
        guard let answersString: [String] = lessonData.attributes.trainer?.answer else { return nil }
        let successMessage = lessonData.attributes.trainer?.success
        let error = lessonData.attributes.trainer?.error
        guard let options = lessonData.attributes.trainer?.options else { return nil }
        let question = lessonData.attributes.content
        let commentary = lessonData.attributes.trainerLabel
        comments.append(successMessage ?? "")
        comments.append(error ?? "")
        for parsedAnswer in answersString {
            for (index,option) in options.enumerated() {
                if option.value == parsedAnswer { rightOrder.append(String(index+1)) }
            }
        }
        for (index,parsedAnswer) in options.enumerated() {
            steps.append(parsedAnswer.title)
        }
        
        var contentItems: [ContainerItem] = []
        
        fillContentItemsWith(lessonData, &contentItems)
        
        return RightOrderExerciseModel(order: lessonData.attributes.order, title: lessonData.attributes.title, commentary: commentary ?? "", steps: steps, numberOfSteps: steps.count, rightOrder: rightOrder, comments: comments, themeName: lessonData.attributes.name, contentItems: contentItems)
    }
    
    private func generateTwoColumnsExerciseModel(from lessonData: LessonData) -> TwoColumnsExerciseModel? {
        
        var steps: [String] = []
        var comments: [String] = []
        var rightOrder: String = ""
        guard let answersString: [String] = lessonData.attributes.trainer?.answer else { return nil }
        let successMessage = lessonData.attributes.trainer?.success
        let error = lessonData.attributes.trainer?.error
        guard let options = lessonData.attributes.trainer?.options else { return nil }
        let question = lessonData.attributes.content
        let commentary = lessonData.attributes.trainerLabel
        comments.append(successMessage ?? "")
        comments.append(error ?? "")
        for parsedAnswer in answersString {
            for (index,option) in options.enumerated() {
                if option.value == parsedAnswer { rightOrder.append(String(index+1)) }
            }
        }
        var firstColumnAnswer: String = ""
        var secondColumnAnswer: String = ""
        var firstColumnIntAnswers: [Int] = []
        var secondColumnIntAnswer: [Int] = []
        guard let firstColumnLetterAnswers: String = lessonData.attributes.trainer?.answer?[0] else { return nil }
        guard let secondColumnLetterAnswers: String = lessonData.attributes.trainer?.answer?[1] else { return nil }
        for (index,parsedAnswer) in options.enumerated() {
            steps.append(parsedAnswer.title)
            if firstColumnLetterAnswers.contains(parsedAnswer.value) {
                firstColumnIntAnswers.append(index+1)
            }
            if secondColumnLetterAnswers.contains(parsedAnswer.value) {
                secondColumnIntAnswer.append(index+1)
            }
        }
        firstColumnIntAnswers.sort { $0<$1 }
        secondColumnIntAnswer.sort { $0<$1 }
        for item in firstColumnIntAnswers {
            firstColumnAnswer += String(item)
        }
        for item in secondColumnIntAnswer {
            secondColumnAnswer += String(item)
        }
        
        var contentItems: [ContainerItem] = []
        
        fillContentItemsWith(lessonData, &contentItems)
        
        var firstColumnName: String = ""
        var secondColumnName: String = ""
        if let parsedFirstColumnName = lessonData.attributes.trainer?.firstColumnName,
           let parsedSecondColumnName = lessonData.attributes.trainer?.secondColumnName {
            firstColumnName = parsedFirstColumnName
            secondColumnName = parsedSecondColumnName
        }
        
        return TwoColumnsExerciseModel(order: lessonData.attributes.order, title: lessonData.attributes.title, commentary: commentary ?? "", steps: steps, firstColumnRightOrder: firstColumnAnswer, secondColumnRightOrder: secondColumnAnswer, firstColumnName: firstColumnName, secondColumnName: secondColumnName, comments: comments, themeName: lessonData.attributes.name, contentItems: contentItems)
    }
    
    private func generateTermsComparisonModel(from lessonData: LessonData) -> TermsComparisonExerciseModel? {
        
        var steps: [String] = []
        var comments: [String] = []
        var rightOrder: String = ""
        guard let answersString: [String] = lessonData.attributes.trainer?.answer else { return nil }
        let successMessage = lessonData.attributes.trainer?.success
        let error = lessonData.attributes.trainer?.error
        guard let options = lessonData.attributes.trainer?.options else { return nil }
        let question = lessonData.attributes.content
        let commentary = lessonData.attributes.trainerLabel
        comments.append(successMessage ?? "")
        comments.append(error ?? "")
        for parsedAnswer in answersString {
            for (index,option) in options.enumerated() {
                if option.value == parsedAnswer { rightOrder.append(String(index+1)) }
            }
        }
        for option in options {
            steps.append(option.title)
        }
        guard let definitions: [String] = lessonData.attributes.trainer?.answers else { return nil }
        
        var contentItems: [ContainerItem] = []
        
        fillContentItemsWith(lessonData, &contentItems)
        
        return TermsComparisonExerciseModel(order: lessonData.attributes.order, title: lessonData.attributes.title, commentary: commentary ?? "", terms: steps, definitions: definitions, rightOrder: rightOrder, comments: comments, themeName: lessonData.attributes.name, contentItems: contentItems)
    }
    
    private func generateMissedWordExerciseModel(from lessonData: LessonData) -> MissedWordExerciseModel? {
        
        var words: [String] = []
        var comments: [String] = []
        var rightOrder: String = ""
        guard let answersString: [String] = lessonData.attributes.trainer?.answer else { return nil }
        let successMessage = lessonData.attributes.trainer?.success
        let error = lessonData.attributes.trainer?.error
        guard let options = lessonData.attributes.trainer?.options else { return nil }
        let question = lessonData.attributes.content
        let commentary = lessonData.attributes.trainerLabel
        comments.append(successMessage ?? "")
        comments.append(error ?? "")
        for parsedAnswer in answersString {
            for (index,option) in options.enumerated() {
                if option.value == parsedAnswer { rightOrder.append(String(index+1)) }
            }
        }
        for option in options {
            words.append(option.title)
        }
        var missedWordStrings: [MissedWordString] = []
        guard let textItems = lessonData.attributes.trainer?.answers else { return nil }
        for item in textItems {
            if item == "" {
                missedWordStrings.append(MissedWordString(string: "________", type: .missedWord))
            } else {
                missedWordStrings.append(MissedWordString(string: item, type: .text))
            }
        }
        let missedWordModel = MissedWordModel(missedWordStrings: missedWordStrings)
        
        var contentItems: [ContainerItem] = []
        fillContentItemsWith(lessonData, &contentItems)
        
        return MissedWordExerciseModel(order: lessonData.attributes.order, title: lessonData.attributes.title, commentary: commentary ?? "", text: missedWordModel, words: words, rightOrder: rightOrder, comments: comments, themeName: lessonData.attributes.name, contentItems: contentItems)
    }
    
}
