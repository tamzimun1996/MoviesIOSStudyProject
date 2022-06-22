//
//  Casts.swift
//  Movies
//
//  Created by Aida Moldaly on 19.05.2022.
//

import Foundation

struct CastIDEntity: Decodable {
    let id: Int
}

struct CastId: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    let id: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
    }
}




struct CastEntity: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case position = "known_for_department"
        case image = "profile_path"
        case birthday
        case biography
        case birthPlace = "place_of_birth"
    }

    let name: String
    let position: String
    let castUrl: String?
    let birthday: String?
    let biography: String?
    let birthPlace: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        position = try container.decode(String.self, forKey: .position)
        birthday = try? container.decodeIfPresent(String.self, forKey: .birthday)
        biography = try? container.decodeIfPresent(String.self, forKey:.biography)
        birthPlace = try? container.decodeIfPresent(String.self, forKey: .birthPlace)
        if let image = try? container.decodeIfPresent(String.self, forKey: .image) {
            castUrl  =  "https://image.tmdb.org/t/p/w200\(image)"
        } else {
            castUrl = nil
        }
    }
}
