//
//  Model.swift
//  ServicesVK
//
//  Created by Dima on 14.07.22.
//

import Foundation

struct VKServices : Decodable {
    let body: Body
}

struct Body: Decodable {
    let services: [Services]
}

struct Services: Decodable, ServiceCellViewModel {    
    let name: String
    let description: String
    let link: String
    let icon_url: String
}

