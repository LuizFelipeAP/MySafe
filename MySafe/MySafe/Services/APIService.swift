//
//  APIService.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import Alamofire

enum EndPoints: String {
    
    case login = "https://dev.people.com.ai/mobile/api/v2/login"
    case register = "https://dev.people.com.ai/mobile/api/v2/register"
}

class APIService {
    
    static var shared: APIService = {
        return APIService()
    }()
    
    private init() { }
    
    //MARK: - Methods
    func authenticate(user: User,
                      completion: @escaping (APIResponse?) -> (Void)) {
    
        //Garantee that the URL is a valid one
        guard let url = URL(string: EndPoints.login.rawValue) else {
            completion(nil)
            return
        }
        
        //Set up the params for the POST request
        let params: [String: Any] = ["email": user.username,
                                     "password": user.passcode]
        
        
        //Make the request
        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: self.header)
            .validate(statusCode: 200..<300)
            .responseData { (dataResponse) in
                
                //Validate if the response in not nil
                guard let data = dataResponse.data else {
                    completion(nil)
                    return
                }
                
                //Decode the response into an APIResponse
                let apiResposne = try? JSONDecoder().decode(APIResponse.self, from: data)
                
                //call the completion with the response decoded
                completion(apiResposne)
        }
    }
    
    func postNew(user: User,
                 completion: @escaping (APIResponse) -> (Void)) {
        
    }
}

extension APIService {
    
    var header: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
