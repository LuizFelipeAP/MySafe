//
//  APIServiceMock.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class APIServiceMock: APIServiceProtocol {
  
    //An array of user to simulate the user in the DataBase
    private let legalUsers: [User]
    
    init() {
        
        let userOne = User(name: "John", username: "john@mail.com", passcode: "Pass@12345")
        let userTwo = User(name: "Mary", username: "mary@mail.com", passcode: "Pass@12345")
        
        self.legalUsers = [userOne, userTwo]
    }
    
    func authenticate(user: User, completion: @escaping (APIResponse?) -> (Void)) {
        
        let apiResponse: APIResponse?
        
        if self.legalUsers.contains(where: { $0.username == user.username && $0.passcode == user.passcode }) {
            
            //Load success response
            let successResponse = self.getSuccessLoginMock()
            
            apiResponse = parse(data: successResponse)
            
        } else {
            
            let failureResponse = self.getFailureLoginMock()

            apiResponse = parse(data: failureResponse)
        }

        completion(apiResponse)
    }
    
    func postNew(user: User, completion: @escaping (APIResponse?) -> (Void)) {
        
        let apiResponse: APIResponse?
        
        if !self.legalUsers.contains(user) {
            
            //Load success response
            let successResponse = self.getSuccessRegisterMock()
            
            apiResponse = parse(data: successResponse)
            
        } else {
            
            let failureResponse = self.getFailureRegisterMock()
            
            apiResponse = parse(data: failureResponse)
        }
        
        completion(apiResponse)
    }

    func parse(data: Data) -> APIResponse? {
        
        //Decode the response into an APIResponse
        let apiResposne = try? JSONDecoder().decode(APIResponse.self, from: data)
        
        return apiResposne
    }

    
    //MOCK REQUEST
    
    fileprivate func getSuccessLoginMock() -> Data {
        
        
        guard let path = Bundle.main.path(forResource: "successLoginResponse", ofType: "json") else { return Data() }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else { return Data() }
        
        return data
    }
    
    fileprivate func getFailureLoginMock() -> Data {
        
        guard let path = Bundle.main.path(forResource: "failureLoginResponse", ofType: "json") else { return Data() }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url) else { return Data() }
        
        return data
        
    }
    
    fileprivate func getSuccessRegisterMock() -> Data {
        guard let path = Bundle.main.path(forResource: "successRegisterResponse", ofType: "json") else { return Data() }

        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else { return Data() }
        
        return data
    }
    
    fileprivate func getFailureRegisterMock() -> Data {
        guard let path = Bundle.main.path(forResource: "failureRegisterResponse", ofType: "json") else { return Data() }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url) else { return Data() }
        
        return data
    }
}
