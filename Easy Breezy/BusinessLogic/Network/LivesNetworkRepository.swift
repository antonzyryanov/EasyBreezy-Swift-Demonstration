//
//  LivesNetworkRepository.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 27.02.2023.
//

import Alamofire

import Foundation

class LivesNetworkRepository {
    
    func getLives(completion: @escaping (Lives?)->(Void)) {
        
        let headers: HTTPHeaders = [
                    "Authorization":"Bearer \(UserProfile.shared.userInfo.jwt)",
                    "Content-Type":"application/json"
                ]

        AF.request(Constants.API.source + "lives", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in

            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                        let decoder = JSONDecoder()
                        if let lives = try? decoder.decode(Lives.self, from: data) {
                            completion(lives)
                            return
                        }
                        completion(nil)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        completion(nil)
                        return
                    }
                case .failure(let error):
                    completion(nil)
                    print(error)
            }
        }
    }
    
}
