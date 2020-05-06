//
//  FactsViewModel.swift
//  TelstraPOCApp
//
//  Created by Nikhil Wagh on 04/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

class FactsViewModel {
    
    var dataModel: FactsModel?
    var factsArray : [Fact]  = [Fact]()
    var screenTitle: String = ""
    
    /// This method is to get Facts Data from Service
    /// - Parameter completion: Result parameter is to return Success or Failure
    func getFactsData(completion: @escaping (Result<Bool, Error>) -> Void) {
        Service.sharedInstance.getAPIData { result in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let results):
                    self.dataModel = results
                    self.screenTitle = self.dataModel?.title ?? ""
                    self.factsArray = self.dataModel?.facts.filter{ $0.title != nil } ?? []
                    completion(.success(true))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
