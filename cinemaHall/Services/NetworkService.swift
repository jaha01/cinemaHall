//
//  NetworkService.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import Foundation

// Сервис для работы с сетью
class NetworkService {
    
    // Функция для выполнения сетевого запроса
    func fetchSessions(url: URL, completion: @escaping (Result<Session, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received."])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                let sessions = try decoder.decode(Session.self, from: data)
                completion(.success(sessions))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
