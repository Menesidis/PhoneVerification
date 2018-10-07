//
//  Network.swift
//  PhoneVerification
//
//  Created by Menesidis on 02/10/2018.
//  Copyright © 2018 Menesidis. All rights reserved.
//

import Foundation
import Moya

enum PhoneService {
    static private let privateKey = "24303e7d9bd3489389193211ae13f3be"
    case fetchPersonData(phone: String)
    
}

// MARK: - TargetType Protocol Implementation
extension PhoneService: TargetType {
    var baseURL: URL { return URL(string: "https://proapi.whitepages.com")! }
    var path: String {
        switch self {
        case .fetchPersonData:
            return "/3.0/phone"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchPersonData:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .fetchPersonData(phone): // Always sends parameters in URL, regardless of which HTTP method is used
            return .requestParameters(parameters: ["phone": phone,
                                                   "api_key": PhoneService.privateKey,
                                                   "phone.country_hint": "GR"], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        switch self {
        case .fetchPersonData(let phone):
            return "{\"phone\": \(phone)}".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

class Network {
    
    let provider = MoyaProvider<PhoneService>()

    func fetchPersonData(phone: String,
                         success successCallback: @escaping (Record) -> Void,
                         error errorCallback: @escaping (Swift.Error) -> Void) {

        provider.request(PhoneService.fetchPersonData(phone: phone)) { result in

            switch result {
            case .success(let response):
                do {
                    print("URL: \(response.request!.url!)")
                    print(try response.mapJSON())
                    
                    let recordResponse = try response.filterSuccessfulStatusCodes()
                    let record = try recordResponse.map(Record.self)
                    
                    successCallback(record)

                } catch {
                    print(error.localizedDescription)
                    errorCallback(error)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                errorCallback(error)
            }
        }

    }
    
    
//    static func request(target: PhoneService,
//                        success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
//
//        provider.request(target) { (result) in
//            switch result {
//            case .success(let response):
//                // 1:
//                if response.statusCode >= 200 && response.statusCode <= 300 {
//
//                    let recordResponse = try response.filterSuccessfulStatusCodes()
//                    let record = try recordResponse.map(Record.self)
//
//
//                    successCallback(response)
//                } else {
//                    // 2:
//                    let error = NSError(domain:"com.vsemenchenko.networkLayer", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
//                    errorCallback(error)
//                }
//            case .failure(let error):
//                // 3:
//                failureCallback(error)
//            }
//        }
//    }
}
