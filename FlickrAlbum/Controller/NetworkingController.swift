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
        do {
          let xmlDoc = try AEXMLDocument(xml: value)
          guard let entries = xmlDoc.root["entry"].all else {
            break
          }
          var photos: [Photo] = []
          for entry in entries {
            if let title = entry["title"].value,
              let link = entry["link"].attributes["href"] {
              let photo = Photo(title: title, urlString: link)
              photos.append(photo)
            }
          }
          handler.didReceive(photos: photos)
        } catch {
          
        }

      case .failure(let error):
        print(error)
        if error._code == NSURLErrorTimedOut {
          
          //timeout here
        }
      }
    }
    request(to: url, by: .get, with: nil, completion)
  }
  
  
}
