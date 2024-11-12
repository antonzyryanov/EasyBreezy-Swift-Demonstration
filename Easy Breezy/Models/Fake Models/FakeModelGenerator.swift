//
//  FakeModelGenerator.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 04.12.2022.
//

import Foundation

class FakeModelGenerator {
    
    static let shared = FakeModelGenerator()
    
    func generateFakeCourses() -> [Course] {
        return [
            Course(title: "Fake course", image: "course_1", completionPercentage: 0)
        ]
    }
    
    func generateFakeCourseIntro() -> CourseIntroModel {
        return CourseIntroModel(id: 0, name: "Введение в диджитал-маркетинг", description: "Введение в диджитал-маркетинг", items: [
            "Узнаешь чем диджитал маркетинг отличается от маркетинга",
            "Узнаешь чем занимается интернет-маркетолог",
            "Построишь путь пользователя",
            "Выделишь целевую аудиторию",
            "Познакомишься с драйверами и барьерами"
        ])
    }
    
    func generateFakeCurrentCourse() -> CurrentCourse {
        return CurrentCourse(exercises: [
            
            Exercise(type: .information, content: InformationModel(order: 1, theme: "Что же такое маркетинг простыми словами?", informationItems: [
                ContainerItem(contentType: .text, content: "Производитель — производит, например, свитера."),
                ContainerItem(contentType: .text, content: "Потребитель — хочет не замерзнуть. И, возможно, хорошо выглядеть."),
                ContainerItem(contentType: .text, content: "Задача маркетинга — соединить их."),
                ContainerItem(contentType: .image, content: "marketing_1"),
                ContainerItem(contentType: .text, content: "Маркетинг — это своего рода мост, по которому деньги движутся к производителю, а товары/услуги — к потребителю.")
            ], themeName: "Theme 1")),
            
            Exercise(type: .information, content: InformationModel(order: 2, theme: "Давай разберём самые базовые понятия", informationItems: [
                ContainerItem(contentType: .text, content: "Воронка продаж — путь, который проходит пользователь от момента, когда он товар привлек его внимание до момента покупки. Воронка состоит из шагов или этапов. Каждый этап - приближает пользователя к совершению покупки."),
                ContainerItem(contentType: .image, content: "marketing_2"),
                ContainerItem(contentType: .text, content: "Воронка состоит из шагов или этапов. Каждый этап приближает пользователя к совершению покупки.")
            ], themeName: "Theme 2")),
            
            Exercise(type: .singleOptionChoise, content: SingleOptionChoiseModel(order: 3, answerOptions: [
                "Answer 1",
                "Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2",
                "Answer 3",
                "Answer 4",
                "Answer 5",
                "Answer 6",
                "Answer 7",
            ], title: "Давайте сразу к практике", question: "В чем по вашему разница между маркетологом и диджитал маркетологом?", commentary: "Выберите один ответ, который вам кажется правильным" , rightAnswer: 3, comments: ["Да! Диджитал маркетолог достигает тех же целей и использует те же инструменты, только во всем интернете, что позволяет делать это значительно эффективнее.","Близко, но ответ D точнее."], themeName: "Theme 3")
                    ),
            
            Exercise(type: .multipleOptionsChoise, content: MultipleOptionChoiseModel(order: 4, answerOptions: [
                "Answer 1",
                "Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2",
                "Answer 3",
                "Answer 4 (правильный)",
                "Answer 5",
                "Answer 6 (правильный)",
                "Answer 7",
            ],rightAnswers: [3,5], title: "А что входит в спектр задач интернет-маркетолога?",commentary:"Здесь можно выбрать несколько вариантов:", comments: ["Да! Диджитал маркетолог достигает тех же целей и использует те же инструменты, только во всем интернете, что позволяет делать это значительно эффективнее.","Все эти задачи являются частью работы интернет маркетолога"], themeName: "", question: "")
                    ),
            
            Exercise(type: .pyramid, content: FunnelExerciseModel(order: 5, title: "А вот и первая задача. Построй правильную воронку продаж", commentary: "Выбирай этапы воронки из вариантов ниже, начиная с верхнего или перетяни в ячейки", steps: [
                "Step 1",
                "Step 2",
                "Step 3",
                "Step 4",
                "Step 5",
            ], rightOrder: "12354", comments: ["Right answer","Not right answer"], themeName: "", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                     ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])
                    ),
            Exercise(type: .singleOptionChoise, content: SingleOptionChoiseModel(order: 6, answerOptions: ["10 %","50 %","20 %"], title: "Давай разбираться на примерах.", question: "Обратите внимание, что на первом этапе воронки - всегда 100% пользователей, а количество пользователей на следующем шаге вычисляется от предыдущего шага.Тоесть, если зашли на сайт( 100 пользователей, нажали на товар 50, а добавили его корзину 10 , то конверсия второго шага: 50/100=50% , а конверсия третьего шага", commentary: "", rightAnswer: 2, comments: ["Верно! 10 пользователей с третьего шага / 50 пользователей со второго шага = 20% конверсия.","подумай еще"], themeName: "")),
            Exercise(type: .information, content: InformationModel(order: 7, theme: "Кстати, тут мы знакомимся с определением конверсии", informationItems: [
                ContainerItem(contentType: .text, content: "Кстати, тут мы знакомимся с определением конверсии - отношение числа человек, совершивших целевое действие к числу человек, которые могли бы его совершить. И Dropoff(отвал) - это, наоборот, число человек, НЕ совершивших целевое действие к числу человек, которые могли бы его совершить."),
                ContainerItem(contentType: .text, content: "В сумме они дают 100")], themeName: "")),
            Exercise(type: .singleOptionChoise, content: SingleOptionChoiseModel(order: 8, answerOptions: ["Амазонд","Али-экспертс","Одинаково"], title: "", question: "", commentary: "Как думаешь, какой сайт сделает больше продаж если в каждый из них зайдут одинаковое количество посетителей?", rightAnswer: 2, comments: ["Да, верно!","а вот и нет"], themeName: "")),
            Exercise(type: .information, content: InformationModel(order: 9, theme: "А вот что будет если,например, Али-экспертс улучшит конверсию на втором шаге всего на 5 % пунктов", informationItems: [ContainerItem(contentType: .text, content: "Конечное количество продаж увеличилось на 25%!"),ContainerItem(contentType: .text, content: "Это означает, что каждый этап воронки одинаково важен, тем не менее, чем “выше” этап воронки, который мы оптимизируем - тем больше пользователей переходит на следующий этап воронки.")], themeName: "")),
            Exercise(type: .termsComparison, content: TermsComparisonExerciseModel(order: 10, title: "Сопоставь термины с определениями:", commentary: "", terms: ["term 1","term 2","term 3","term 4"], definitions: ["definition 4","definition 3","definition 2","definition 1"], rightOrder: "4321", comments: ["right","not right"], themeName: "", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                                                                                                                                                                                                                                             ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])),
            Exercise(type: .missedWord, content: MissedWordExerciseModel(order: 11, title: "Вставь пропущенные слова", commentary: "",text: MissedWordModel(missedWordStrings: [MissedWordString(string: "Text1 text1text1 text1 text1 text1text1", type: .text),
                                                                                                                                                                     MissedWordString(string: "  ____1  ", type: .missedWord),MissedWordString(string: "Text2text2 text2 text2 text2text2 text2", type: .text),MissedWordString(string: "  ____2  ", type: .missedWord),MissedWordString(string: " Text 3 text3 text3 text3 text3text3.", type: .text),MissedWordString(string: "  ____3  ", type: .missedWord),MissedWordString(string: " Text4 text4text4text4text4 text4.", type: .text),
                                                                                                                                                                     MissedWordString(string: "  ____4  ", type: .missedWord),MissedWordString(string: " Text5 text5text5text5text5 text5. text5text5text5text5\n", type: .text),MissedWordString(string: "  ____5  ", type: .missedWord)
                                                                                                                                                                     
                                                                                                                                                                    ]) , words: [
                "Word 1",
                "Word 2",
                "Word 3",
                "Word 4",
                "Word 5",
                                                                                                                                                                    ], rightOrder: "54321", comments: ["Right answer","Not right answer"], themeName: "", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                                                                                                                                                         ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])),
            Exercise(type: .rightOrder, content: RightOrderExerciseModel(order: 12, title: "Нажми в правильном порядке", commentary: "Нажми в правильном порядке, чтобы воссоздать путь Миши от осознания потребности до покупки. Это - путь пользователя", steps: [
                "Extra step",
                "Extra step",
                "Step 1",
                "Step 2",
                "Step 3",
                "Step 4"
            ], numberOfSteps: 4, rightOrder: "3456", comments: ["Right answer","Not right answer"], themeName: "", contentItems:  [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                   ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])
                    ),
            Exercise(type: .twoColumns, content: TwoColumnsExerciseModel(order: 13, title: "Раздели объекты на два столбика", commentary: "Драйверы и барьеры \n\nПетя хочет купить шоколадный батончик и вот его мысли\nПеренеси барьеры в правый столбик, а драйверы в левый", steps: [
                "left 1",
                "left 2",
                "left 3",
                "right 1",
                "right 2",
                "right 3"
            ],firstColumnRightOrder: "123",secondColumnRightOrder: "456",firstColumnName: "First Column",secondColumnName: "Second Column", comments: ["right","not right"], themeName: "", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                                                                                           ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])),
            Exercise(type: .courseEnd, content: CourseEndModel(order: 14, message: "Great!\n You’ve done it", image: "end_1_1"))
        ])
    }
//    
    func getFakeExercises() -> [Exercise] {
        return [
            Exercise(type: .twoColumns, content: TwoColumnsExerciseModel(order: 1, title: "Раздели объекты на два столбика", commentary: "Драйверы и барьеры \n\nПетя хочет купить шоколадный батончик и вот его мысли\nПеренеси барьеры в правый столбик, а драйверы в левый", steps: [
                "left 1",
                "left 2",
                "left 3",
                "right 1",
                "right 2",
                "right 3"
            ],firstColumnRightOrder: "123",secondColumnRightOrder: "456",firstColumnName: "First Column",secondColumnName: "Second Column", comments: ["right","not right"], themeName: "Theme 1", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                                                                                           ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])),
            Exercise(type: .termsComparison, content: TermsComparisonExerciseModel(order: 2, title: "Сопоставь термины с определениями:", commentary: "", terms: ["term 1","term 2","term 3","term 4"], definitions: ["definition 4","definition 3","definition 2","definition 1"], rightOrder: "4321", comments: ["right","not right"], themeName: "Theme 2", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                                                                                                                                                                                                                                             ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])),
            Exercise(type: .rightOrder, content: RightOrderExerciseModel(order: 3, title: "Нажми в правильном порядке", commentary: "Нажми в правильном порядке, чтобы воссоздать путь Миши от осознания потребности до покупки. Это - путь пользователя", steps: [
                "Extra step",
                "Extra step",
                "Step 1",
                "Step 2",
                "Step 3",
                "Step 4"
            ], numberOfSteps: 4, rightOrder: "3456", comments: ["Right answer","Not right answer"], themeName: "Theme 3", contentItems:  [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                   ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])
                    ),
            Exercise(type: .pyramid, content: FunnelExerciseModel(order: 4, title: "А вот и первая задача. Построй правильную воронку продаж", commentary: "Выбирай этапы воронки из вариантов ниже, начиная с верхнего или перетяни в ячейки", steps: [
                "Step 1",
                "Step 2",
                "Step 3",
                "Step 5",
                "Step 4",
            ], rightOrder: "12354", comments: ["Right answer","Not right answer"], themeName: "", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                       ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])
                    ),
            Exercise(type: .information, content: InformationModel(order: 5, theme: "Что же такое маркетинг простыми словами?", informationItems: [
                ContainerItem(contentType: .text, content: "Производитель — производит, например, свитера."),
                ContainerItem(contentType: .text, content: "Потребитель — хочет не замерзнуть. И, возможно, хорошо выглядеть."),
                ContainerItem(contentType: .text, content: "Задача маркетинга — соединить их."),
                ContainerItem(contentType: .image, content: "marketing_1"),
                ContainerItem(contentType: .text, content: "Маркетинг — это своего рода мост, по которому деньги движутся к производителю, а товары/услуги — к потребителю.")
            ], themeName: "")),
            
            Exercise(type: .information, content: InformationModel(order: 6, theme: "Давай разберём самые базовые понятия", informationItems: [
                ContainerItem(contentType: .text, content: "Воронка продаж — путь, который проходит пользователь от момента, когда он товар привлек его внимание до момента покупки. Воронка состоит из шагов или этапов. Каждый этап - приближает пользователя к совершению покупки."),
                ContainerItem(contentType: .image, content: "marketing_2"),
                ContainerItem(contentType: .text, content: "Воронка состоит из шагов или этапов. Каждый этап приближает пользователя к совершению покупки.")
            ], themeName: "")),
            
            Exercise(type: .singleOptionChoise, content: SingleOptionChoiseModel(order: 7, answerOptions: [
                "Answer 1",
                "Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2",
                "Answer 3",
                "Answer 4",
                "Answer 5",
                "Answer 6",
                "Answer 7",
            ], title: "Давайте сразу к практике", question: "В чем по вашему разница между маркетологом и диджитал маркетологом?", commentary: "Выберите один ответ, который вам кажется правильным" , rightAnswer: 3, comments: ["Да! Диджитал маркетолог достигает тех же целей и использует те же инструменты, только во всем интернете, что позволяет делать это значительно эффективнее.","Сomment 2", "Сomment 3", "Сomment 4", "Сomment 5", "Сomment 6", "Сomment 7",], themeName: "")
                    ),
            
            Exercise(type: .multipleOptionsChoise, content: MultipleOptionChoiseModel(order: 8, answerOptions: [
                "Answer 1",
                "Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2 Answer 2",
                "Answer 3",
                "Answer 4 (правильный)",
                "Answer 5",
                "Answer 6 (правильный)",
                "Answer 7",
            ],rightAnswers: [3,5], title: "А что входит в спектр задач интернет-маркетолога?",commentary:"Здесь можно выбрать несколько вариантов:", comments: ["Да! Диджитал маркетолог достигает тех же целей и использует те же инструменты, только во всем интернете, что позволяет делать это значительно эффективнее.","Все эти задачи являются частью работы интернет маркетолога"], themeName: "", question: "")
                    ),
            
            Exercise(type: .pyramid, content: FunnelExerciseModel(order: 9, title: "А вот и первая задача. Построй правильную воронку продаж", commentary: "Выбирай этапы воронки из вариантов ниже, начиная с верхнего или перетяни в ячейки", steps: [
                "Step 1",
                "Step 2",
                "Step 3",
                "Step 5",
                "Step 4",
            ], rightOrder: "12354", comments: ["Right answer","Not right answer"], themeName: "", contentItems:  [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                       ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])
                    ),
            Exercise(type: .singleOptionChoise, content: SingleOptionChoiseModel(order: 10, answerOptions: ["10 %","50 %","20 %"], title: "Давай разбираться на примерах.", question: "Обратите внимание, что на первом этапе воронки - всегда 100% пользователей, а количество пользователей на следующем шаге вычисляется от предыдущего шага.Тоесть, если зашли на сайт( 100 пользователей, нажали на товар 50, а добавили его корзину 10 , то конверсия второго шага: 50/100=50% , а конверсия третьего шага", commentary: "", rightAnswer: 2, comments: ["Comment 1","Comment 2","Верно! 10 пользователей с третьего шага / 50 пользователей со второго шага = 20% конверсия.","подумай еще"], themeName: "")),
            Exercise(type: .information, content: InformationModel(order: 11, theme: "Кстати, тут мы знакомимся с определением конверсии", informationItems: [
                ContainerItem(contentType: .text, content: "Кстати, тут мы знакомимся с определением конверсии - отношение числа человек, совершивших целевое действие к числу человек, которые могли бы его совершить. И Dropoff(отвал) - это, наоборот, число человек, НЕ совершивших целевое действие к числу человек, которые могли бы его совершить."),
                ContainerItem(contentType: .text, content: "В сумме они дают 100")], themeName: "")),
            Exercise(type: .singleOptionChoise, content: SingleOptionChoiseModel(order: 12, answerOptions: ["Амазонд","Али-экспертс","Одинаково"], title: "", question: "", commentary: "Как думаешь, какой сайт сделает больше продаж если в каждый из них зайдут одинаковое количество посетителей?", rightAnswer: 2, comments: ["Comment 1","Comment 2", "Comment 3"], themeName: "")),
            Exercise(type: .information, content: InformationModel(order: 13, theme: "А вот что будет если,например, Али-экспертс улучшит конверсию на втором шаге всего на 5 % пунктов", informationItems: [ContainerItem(contentType: .text, content: "Конечное количество продаж увеличилось на 25%!"),ContainerItem(contentType: .text, content: "Это означает, что каждый этап воронки одинаково важен, тем не менее, чем “выше” этап воронки, который мы оптимизируем - тем больше пользователей переходит на следующий этап воронки.")], themeName: "")),
            Exercise(type: .missedWord, content: MissedWordExerciseModel(order: 14, title: "Вставь пропущенные слова", commentary: "",text: MissedWordModel(missedWordStrings: [MissedWordString(string: "Text1 text1text1 text1 text1 text1text1", type: .text),
                                                                                                                                                                     MissedWordString(string: "  ____1  ", type: .missedWord),MissedWordString(string: "Text2text2 text2 text2 text2text2 text2", type: .text),MissedWordString(string: "  ____2  ", type: .missedWord),MissedWordString(string: " Text 3 text3 text3 text3 text3text3.", type: .text),MissedWordString(string: "  ____3  ", type: .missedWord),MissedWordString(string: " Text4 text4text4text4text4 text4.", type: .text),
                                                                                                                                                                     MissedWordString(string: "  ____4  ", type: .missedWord),MissedWordString(string: " Text5 text5text5text5text5 text5. text5text5text5text5\n", type: .text),MissedWordString(string: "  ____5  ", type: .missedWord)
                                                                                                                                                                     
                                                                                                                                                                    ]) , words: [
                "Word 1",
                "Word 2",
                "Word 3",
                "Word 4",
                "Word 5",
                                                                                                                                                                    ], rightOrder: "54321", comments: ["Right answer","Not right answer"], themeName: "", contentItems: [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                                                                                                                                                         ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])),
            Exercise(type: .rightOrder, content: RightOrderExerciseModel(order: 15, title: "Нажми в правильном порядке", commentary: "Нажми в правильном порядке, чтобы воссоздать путь Миши от осознания потребности до покупки. Это - путь пользователя", steps: [
                "Extra step",
                "Extra step",
                "Step 1",
                "Step 2",
                "Step 3",
                "Step 4"
            ], numberOfSteps: 4, rightOrder: "3456", comments: ["Right answer","Not right answer"], themeName: "", contentItems:  [ContainerItem(contentType: .text, content: "Item 1 Item 1 Item 1 Item 1 Item 1"),
                                                                                                                                   ContainerItem(contentType: .text, content: "Item 2 Item 2 Item 2")                                                                           ])
                    ),
            Exercise(type: .courseEnd, content: CourseEndModel(order: 16, message: "Great!\n You’ve done it", image: "end_1_1"))
        ]
    }
    
    func generateFakeOnBoardings () -> LoginModel {
        return LoginModel(onBoardings: [
            OnBoardingItem(image: "onBoarding1", text: "Will teach you modern digital marketing"),
            OnBoardingItem(image: "onBoarding2", text: "Bite-sized lessons with interactive trainees"),
            OnBoardingItem(image: "",type: .subscription, text: "Become Pro Marketer with EasyBreezy Pro")
        ])
    }
    
}

