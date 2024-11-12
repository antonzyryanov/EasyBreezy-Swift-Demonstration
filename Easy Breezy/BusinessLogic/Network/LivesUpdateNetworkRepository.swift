//
//  LivesUpdateNetworkRepository.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 27.02.2023.
//

import Alamofire
import Foundation

class LivesUpdateNetworkRepository {
    
    func registerAccount(livesInfo: Parameters, completion: @escaping (Bool)->(Void)) {
        
        let headers: HTTPHeaders = [
                    "Authorization":"Bearer \(UserProfile.shared.userInfo.jwt)",
                    "Content-Type":"application/json"
                ]
        AF.request(Constants.API.source + "lives", method: .post, parameters: livesInfo, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in

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
                        completion(true)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        completion(false)
                        return
                    }
                case .failure(let error):
                guard let data = response.data else { return }
                let str = String(decoding: data, as: UTF8.self)
                completion(false)
            }
        }
    }
    
}
