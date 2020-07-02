//
//  RequestType.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol RequestType {
    associatedtype ResponseType: Decodable
    var data: RequestData { get set }
    var queue: Queue { get set }
}

extension RequestType {

    // MARK: - Public

    /// executes the associated request
    /// - Parameters:
    ///   - dispatcher: the NetworkDispatcher instance which will dispatch the request
    ///   - completion: callback when done
    func execute(dispatcher: NetworkDispatcher, _ completion: @escaping ((Result<ResponseType>) -> Void)) {
        dispatcher.dispatch(request: self.data, completion: { (responseData: Result<Data>) in
            self.queue.main {
                completion(self.responseFrom(responseData: responseData))
            }
        })
    }

    /// decode the associated response object
    /// - Parameter responseData: Result<> object with response Data
    /// - Returns: result data or error as a Result<> object
    private func responseFrom(responseData: Result<Data>) -> Result<ResponseType> {
        switch responseData {
        case .success(let data):
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                let result = try jsonDecoder.decode(ResponseType.self, from: data)
                return .success(result)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
