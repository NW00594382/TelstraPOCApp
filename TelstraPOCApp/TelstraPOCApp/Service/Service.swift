//
//  Service.swift
//  TelstraPOCApp
//
//  Created by Nikhil Wagh on 04/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

struct Service {
    
    static let sharedInstance = Service()
    
    /// This method is to GET facts data from API
    /// - Parameter completion: Result parameter is to return Success or Failure
    func getAPIData(completion: @escaping (Result<FactsModel, Error>) -> Void) {
        let urlString = "\(Constants.BaseURL.url)\(Constants.API.facts)"
        guard let serviceURL = URL.init(string: urlString) else { return }
        URLSession.shared.dataTask(with: serviceURL) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(FactsModel.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
