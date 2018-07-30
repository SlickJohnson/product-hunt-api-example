//
//  Networking.swift
//  ProductHuntExample
//
//  Created by Willie Johnson on 6/29/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}

/**
 Error cases that will be handled by the Client.

 - couldNotParse: Error occurs when that data retrieved can't be converted into a swift model.
 - noData: Error occurs when there is no response data.
 */
enum ResourceError: Error {
  case couldNotParse
  case noData
  case noPosts
  case noComments
}

class NetworkManager {
  let urlSession = URLSession.shared
  var baseURL = "https://api.producthunt.com/v1/"
  var token = "eb715e9a4c4dd4f7eaf72222e75db6fbbd61e49aaa06127fca1494a0c0cac1c6"

  func getPosts(_ completion: @escaping (Result<[Post]>) -> Void) {
    urlSession.dataTask(with: makeRequest(for: .posts)) { data, response, error in
      if let error = error {
        return completion(Result.failure(error))
      }

      guard let data = data else {
        return completion(Result.failure(ResourceError.noData))
      }

      guard let result = try? JSONDecoder().decode(PostApiResponse.self, from: data) else {
        return completion(Result.failure(ResourceError.couldNotParse))
      }

      guard let posts = result.posts else {
        return completion(Result.failure(ResourceError.noComments))
      }

      completion(Result.success(posts))
      }.resume()
  }


  func getComments(_ id: Int, completion: @escaping (Result<[Comment]>) -> Void) {
    urlSession.dataTask(with: makeRequest(for: .comments, with: id)) { data, response, error in
      if let error = error {
        return completion(Result.failure(error))
      }

      guard let data = data else {
        return completion(Result.failure(ResourceError.noData))
      }

      guard let result = try? JSONDecoder().decode(CommentApiResponse.self, from: data) else {
        return completion(Result.failure(ResourceError.couldNotParse))
      }

      guard let comments = result.comments else {
        return completion(Result.failure(ResourceError.noPosts))
      }

      completion(Result.success(comments))
    }.resume()
  }

  private func makeRequest(for endPoint: EndPoints, with id: Int? = nil) -> URLRequest {
    let params = endPoint.getParams(id: id)

    let fullURL = URL(string: baseURL.appending("\(endPoint.getPath())?\(endPoint.stringFrom(params))"))!

    var request = URLRequest(url: fullURL)
    request.httpMethod = endPoint.getHTTPMethod()
    request.allHTTPHeaderFields = endPoint.getHeaders(token: token)

    return request
  }
}
