//
//  PostResource.swift
//  ProductHuntExample
//
//  Created by Willie Johnson on 7/30/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

enum EndPoints {
  case posts
  case comments

  func getHTTPMethod() -> String {
    return "GET"
  }

  func getHeaders(token: String) -> [String: String] {
    return [
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer \(token)",
      "Host": "api.producthunt.com"
    ]
  }

  func getParams(id: Int? = nil) -> [String: String] {
    switch self {
    case .posts:
      return [
        "sort_by": "votes_count",
        "order": "desc",
        "per_page": "20",

        "search[featured]": "true"
      ]

    case .comments:
      guard let id = id else { return [:] }

      return [
        "sort_by": "votes",
        "order": "asc",
        "per_page": "20",

        "search[post_id]": "\(id)"
      ]
    }
  }

  func stringFrom(_ parameters: [String: String]) -> String {
    let parameterArray = parameters.map { key, value in
      return "\(key)=\(value)"
    }

    return parameterArray.joined(separator: "&")
  }

  func getPath() -> String {
    switch self {
    case .posts:
      return "posts/all"

    case .comments:
      return "comments"
    }
  }
}
