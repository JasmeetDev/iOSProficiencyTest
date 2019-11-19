//
//  ListingServiceManager.swift
//  iOSProficiencyExercise
//
//  Created by Jasmeet Singh on 18/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import Foundation
import TDWebServiceAlamofire
import TDWebService
import TDResult

class ListingServiceManager: TDWebserviceAlamofire{
    
    
    func url() -> String {
        return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    
    
    func validalidatorClient() -> TDResultValidatorApi? {
        return ApplicationResultValidatorApi()
    }
    
    func methodType() -> TDMethodType {
        return .GET
    }
    
    func encodingType() -> TDURLEncodingType {
        return .QUERY
    }
    
    func requestTimeOut()->Int {
        return 30
    }
    
    
    func resultType() -> TDResultType {
        return .Data
    }
    
    
    var handler : ((TDResult<Content, TDError>) -> Void)?
    
    
    func call(_ completionHandler: @escaping (TDResult<Content, TDError>) -> Void) {
        handler = completionHandler
        apiCall {(result) in
            switch result {
            case .Success(let resultData):
                let jsonData = resultData.resultData as! Data
                let jsonString = String(decoding: jsonData, as: UTF8.self)
                let data = jsonString.data(using: .utf8)!
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                       if let result = jsonObj as? [String:AnyObject]{
                                        let content = Content.mapJsonDictionaryData(jsonDictionary: result)!
                                        completionHandler(TDResult.init(value:content))
                        }
                }
                catch {
                    print(error.localizedDescription)
                    completionHandler(TDResult.Error(TDError.init(TDWebServiceError.apiError)))

                }
            case .Error(let error):
                completionHandler(TDResult.Error(error))
            }
            
        }
    }
    
}
