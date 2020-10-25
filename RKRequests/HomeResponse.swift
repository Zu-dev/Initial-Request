//
//  HomeResponse.swift
//  RKRequests
//
//  Created by Zukhra on 10/26/20.
//  Copyright © 2020 Zu project first app UICollectionView. All rights reserved.
//

import Foundation

struct HomeResponse: Decodable {
    let message: String?
    let data: HomeData
}

struct HomeData: Decodable {
    let recommendedFirms: [RecommendedFirms]?
}

struct RecommendedFirms: Decodable {
    let id: Int?
    let name, address: String?
    let urlKey: String?
}

struct PPP: Encodable {
    let name: String
}
