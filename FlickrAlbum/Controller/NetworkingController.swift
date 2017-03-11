//
//  NetworkingController.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation
import Alamofire
import AEXML
import SwiftyJSON

class NetworkingController {
  static let shared = NetworkingController()
  private init() {}
  
  private let manager: SessionManager = {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 5
    config.timeoutIntervalForResource = 5
    return SessionManager(configuration: config)
  }()
    
  fileprivate func request(to url: String, by method: HTTPMethod, with params: [String: Any]?, _ completion: @escaping ((DataResponse<Any>) -> Void)) {
    
    manager.request(url, method: method, parameters: params, encoding: URLEncoding.default)
      .validate(statusCode: 200..<300)
      .responseJSON(completionHandler: completion)
  }

  
}

extension NetworkingController: FlickrApi {
  func fetchPhotoFeeds(responseWith handler: FlickrApiResponseHandler) {
    let url = EndPoint.feeds.path
    let params: [String: Any] = [
      "format": "json",
      "nojsoncallback": 1
    ]
    let completion: ((DataResponse<Any>) -> Void) = { response in
      switch response.result {
      case .success(let value):
        var photos: [Photo] = []
        let json = JSON(value)
        let items = json["items"].arrayValue
        for item in items {
          let title = item["title"].stringValue
          let url = item["media"]["m"].stringValue
          let photo = Photo(title: title, urlString: url)
          
          photos.append(photo)
        }
        handler.didReceive(photos: photos)

      case .failure(let error):
        if error._code == NSURLErrorTimedOut {
          handler.didReceiveTimeOut()
        } else {
          print(response.data)
          handler.didReceiveError(description: error.localizedDescription)
        }
      }
    }
    request(to: url, by: .get, with: params, completion)
  }
  
  
}
