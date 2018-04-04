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
    case logo = "https://dev.people.com.ai/mobile/api/v2/logo"
}

class APIService {
    
    static var shared: APIService = {
        return APIService()
    }()
    
    private init() { }
    
    //MARK: - Methods
    func authenticate(user: User,
                      completion: @escaping (APIResponse?) -> (Void)) {
    
        //Guarantees that the URL is a valid one
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
                
                let apiResponse = self.parse(dataResponse: dataResponse)
                
                completion(apiResponse)
        }
    }
    
    func postNew(user: User,
                 completion: @escaping (APIResponse?) -> (Void)) {
        
        //Guarantees that the URL is a valid one
        guard let url = URL(string: EndPoints.register.rawValue) else {
            completion(nil)
            return
        }
        
        //Set up the params for the POST request
        let params: [String: Any] = ["email": user.username,
                                     "name": user.name,
                                     "password": user.passcode]
        
        //Make the request
        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: self.header)
            .validate(statusCode: 200..<300)
            .responseData { (dataResponse) in
                
                let apiResponse = self.parse(dataResponse: dataResponse)
                
                completion(apiResponse)
        }
    }
}

//**************************************************************************************
//
// MARK: - Helpers Extension
//
//**************************************************************************************
extension APIService {
    
    //Set up the common header
    var header: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    func parse(dataResponse: DataResponse<Data>) -> APIResponse? {
        
        //Validate if the response is not nil
        guard let data = dataResponse.data else {
            return nil
        }
        
        //Decode the response into an APIResponse
        let apiResposne = try? JSONDecoder().decode(APIResponse.self, from: data)

        return apiResposne
    }
    
}
