//
//  ApplicationResultValidatorApi.swift
//  iOSProficiencyExercise
//
//  Created by Jasmeet Singh on 18/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import Foundation
import TDWebService
import TDResult
enum ApiError: Error{
    case badAccessToken
    case accountRestored
    case generalError
    case emptyResponse
    case invalidResponseType
    case unknown
}

struct ApplicationResultValidatorApi: TDResultValidatorApi{
    func validateResponse(_ result: TDWSResponse) -> TDResult<TDWSResponse, TDError> {
        guard let jsonData = result.resultData as? TDJson else {
            return TDResult.Error(TDError.init(ApiError.invalidResponseType, code: 400, description: "Invalid Response from Server"))
        }
        guard let response = jsonData.jsonData as? [String:Any] else {
            return TDResult.Error(TDError.init(ApiError.invalidResponseType, code: 400, description: "Invalid Response from Server"))
        }
        if let httpStatusCode =  response["statusCode"] as? Int  {
        if httpStatusCode == 402  {
            NotificationCenter.default.post(name: Notification.Name(rawValue:"sessionExpired"), object: nil, userInfo: ["showAlert":true,"message" : (response["message"] as? String) as Any])
             return TDResult.Error(TDError.init(ApiError.badAccessToken, code: 402, description: response["message"] as? String))
        }
    }
        
      
        guard response["statusCode"] as? Int == 200 else {
            return TDResult.Error(self.getErrorResponse(response: response))
        }
        return TDResult.init(value: result)
    }
    
    func getErrorResponse(response:[String:Any]?)->TDError{
        guard response?["statusCode"] as? Int == 200 && response?["message"] as? String != nil else {
            return TDError.init(ApiError.generalError, code: response?["statusCode"] as? Int, description: response?["message"] as? String)
        }
        return TDError.init(ApiError.emptyResponse, code: 400, description: "Somehing went wrong. Please try again later.")
    }
}

