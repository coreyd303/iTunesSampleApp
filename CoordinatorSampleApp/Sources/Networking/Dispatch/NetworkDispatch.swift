//
//  NetworkDispatch.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func dispatch(request: RequestData, completion: @escaping ((Result<Data>) -> Void))
}

struct NetworkDispatcherImplementation: NetworkDispatcher {

    /// dispatch request
    /// - Parameters:
    ///   - request: the RequestData object to build the request upon
    ///   - completion: callback when done
    func dispatch(request: RequestData, completion: @escaping ((Result<Data>) -> Void)) {
        guard let url = URL(string: request.path) else {
            completion(.failure(createError("invalid URL")))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        let headers: [String: String] = ["Content-Type": "application/json"]
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                if let response = response as? HTTPURLResponse {
                    completion(.failure(createError(response.statusCode)))
                }

                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(createError("data not found")))
                return
            }

            completion(.success(data))

        }.resume()
    }
}
