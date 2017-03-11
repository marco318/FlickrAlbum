//
//  EndPoint.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

enum EndPoint {
  case feeds
  
  static let host = "https://api.flickr.com"
  
  var path: String {
    switch self {
    case .feeds: return EndPoint.host + "/services/feeds/photos_public.gne"
    }
  }
  
}
