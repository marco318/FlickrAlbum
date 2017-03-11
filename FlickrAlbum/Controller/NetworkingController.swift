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
        handler.didReceive(photoFeeds: self.photoFeeds(from: xml))
      case .failure(let error):
        print(error)
      }
    }
    request(to: url, by: .get, with: nil, completion)
  }
  
  private func photoFeeds(from xml: XMLIndexer) -> PhotoFeeds? {
    var photos: [Photo] = []
    let timeString = xml["feed"]["updated"].element?.text
    let photosXml = xml["feed"]["entry"].all
    photosXml.forEach { element in
      if let photo = photo(from: element) {
        photos.append(photo)
      }
    }
    return PhotoFeeds(updatedTimeString: timeString, photos: photos)
  }
  
  private func photo(from xml: XMLIndexer) -> Photo? {
    let title = xml["entry"]["title"].element?.text
    let url = xml["entry"]["link"].element?.attribute(by: "href")?.text
    
    return Photo(title: title, urlString: url)
  }
}
