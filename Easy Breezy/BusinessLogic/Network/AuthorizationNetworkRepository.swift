//
//  RegistrationNetworkRepositoryNetworkRepository.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 28.01.2023.
//

import Alamofire

import Foundation

class RegistrationNetworkRepository {
    
    func registerAccount(userInfo: Parameters, completion: @escaping (Bool)->(Void)) {
        
        let headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                ]
        
        AF.request(Constants.API.source + "auth/local/register", method: .post, parameters: userInfo, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in

            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                         //   print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                         //   print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            return
                        }
                        let decoder = JSONDecoder()
                        if let userInfo = try? decoder.decode(UserInfo.self, from: data) {
                            UserProfile.shared.userInfo = userInfo
                        }
                        completion(true)
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
