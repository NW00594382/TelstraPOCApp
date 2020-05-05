//
//  FactModel.swift
//  TelstraPOCApp
//
//  Created by Nikhil Wagh on 04/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation

// MARK: - FactsModel
struct FactsModel: Decodable {
    
    let title: String
    let facts: [Fact]
    
    enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }
}

// MARK: - Fact
struct Fact: Decodable {
    
    let title, description: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title, description
        case imageURL = "imageHref"
    }
}
