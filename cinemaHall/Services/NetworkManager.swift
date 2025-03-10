//
//  NetworkManager.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func request(completion: @escaping(Result<Session,Error>)->Void)
}

class NetworkManager : NSObject, NetworkManagerProtocol {
    private var networkConfiguration = NetworkConfig()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)

    func request(completion: @escaping(Result<Session,Error>)->Void) {
        guard let url = URL(string: "\(networkConfiguration.url)") else {
            completion(.failure(CustomError(message: "Wrong uri")))
            return
        }
        
        let dataTask = urlSession.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<400:
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                    
                    do {
                        let session = try jsonDecoder.decode(Session.self, from: data)
                        completion(.success(session))
                    } catch {
                        completion(.failure(error))
                    }
                default:
                    completion(.failure(CustomError(message: "\(response.statusCode)")))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
}
