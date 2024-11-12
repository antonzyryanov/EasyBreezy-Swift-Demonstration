//
//  CoursesNetworkRepository.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.01.2023.
//

import Alamofire

import Foundation

class CoursesNetworkRepository {
    
    func getCourses(completion: @escaping ([Course]?)->(Void)) {
        
        let headers: HTTPHeaders = [
                    "Authorization":"Bearer \(UserProfile.shared.userInfo.jwt)",
                    "Content-Type":"application/json"
                ]

        AF.request(Constants.API.source + "courses", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            return
                        }
                        let str = String(decoding: data, as: UTF8.self)
                        let decoder = JSONDecoder()
                        if let parsedCourses = try? decoder.decode(ParsedCourses.self, from: data) {
                            var courses: [Course] = []
                            for parsedCourse in parsedCourses.data {
                                let course = Course(title: parsedCourse.attributes.title, image: "course_\(parsedCourse.attributes.order)", completionPercentage: 0, courseData: parsedCourse)
                                courses.append(course)
                                UserProgressInfo.shared.coursesProgress[course.title] = course.completionPercentage
                            }
                            courses = courses.sorted(by: {$0.courseData.attributes.order < $1.courseData.attributes.order})
                            
                            UserProgressInfo.shared.loadProgress()
                            completion(courses)
                            return
                        }
                        completion(nil)
                    } catch {
                        completion(nil)
                        return
                    }
                case .failure(let error):
                    completion(nil)
                
            }
        }
    }
    
    func getCourse(with id: Int, completion: @escaping (Bool)->(Void)) {
        
        let headers: HTTPHeaders = [
                    "Authorization":"Bearer \(UserProfile.shared.userInfo.jwt)",
                    "Content-Type":"application/json"
                ]
        
        AF.request(Constants.API.source + "courses/\(id)?populate=lessons", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in

            switch response.result {
                case .success(let data):
                    do {
                        let str = String(decoding: data, as: UTF8.self)
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            return
                        }
                        let decoder = JSONDecoder()
                        if let parsedCourse = try? decoder.decode(ParsedCourse.self, from: data) {
                            let exercises = ExercisesFactory.shared.generateExercises(from: parsedCourse)
                            CurrentCourse.shared.configureWith(exercises: exercises)
                            completion(true)
                            return
                        }
                        completion(false)
                    } catch {
                        completion(false)
                        return
                    }
                case .failure(let error):
                    completion(false)
                    print(error)
            }
        }
    }
    
}
