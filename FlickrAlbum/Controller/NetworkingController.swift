//
//  NetworkingController.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class NetworkingController {
  static let shared = NetworkingController()
  private init() {}
  
  private let manager: SessionManager = {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 5
    config.timeoutIntervalForResource = 5
    return SessionManager(configuration: config)
  }()
  
  fileprivate func request(to url: String, by method: HTTPMethod, with params: [String: Any]?, _ completion: @escaping ((DataResponse<Data>) -> Void)) {
    
    manager.request(url, method: method, parameters: params, encoding: URLEncoding.default)
      .validate(statusCode: 200..<300)
      .responseData(completionHandler: completion)
  }

  
}

extension NetworkingController: FlickrApi {
  func fetchPhotoFeeds(responseWith handler: FlickrApiResponseHandler) {
    let url = EndPoint.feeds.path
    let completion: ((DataResponse<Data>) -> Void) = { response in
      switch response.result {
      case .success(let value):
        let xml = SWXMLHash.parse(value)
        handler.didReceive(photoFeeds: nil)
        print(xml["feed"]["title"].element ?? "nil")
      case .failure(let error):
        print(error)
      }
    }
    request(to: url, by: .get, with: nil, completion)
  }
}
