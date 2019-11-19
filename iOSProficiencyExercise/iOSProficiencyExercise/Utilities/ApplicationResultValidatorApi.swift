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
        guard let jsonData = result.resultData as? Data else {
            return TDResult.Error(TDError.init(ApiError.invalidResponseType, code: 400, description: "Invalid Response from Server"))
        }
        do {
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            let data = jsonString.data(using: .utf8)!
             let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            var json = TDJson()
            json.jsonData = jsonObj
        }
        catch {
            print(error.localizedDescription)
                return TDResult.Error(TDError.init(ApiError.invalidResponseType, code: 400, description: "Invalid Response from Server"))
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

