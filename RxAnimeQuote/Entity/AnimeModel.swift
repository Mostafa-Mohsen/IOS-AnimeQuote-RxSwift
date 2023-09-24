//
//  AnimeModel.swift
//  RxAnimeQuote
//
//  Created by User on 24/12/2022.
//

import Foundation

enum AnimeKeys: String {
    case anime
    case character
    case quote
    case error
}

struct AnimeModel {
    let anime: String
    let character: String
    let quote: String
    
    init?(attributes: [String: AnyObject]) {
        guard let anime = attributes[AnimeKeys.anime.rawValue] as? String else {
            return nil
        }
        self.anime = anime
        character = attributes[AnimeKeys.character.rawValue] as? String ?? ""
        quote = attributes[AnimeKeys.quote.rawValue] as? String ?? ""
    }
}

struct AnimeError {
    let error: String
    
    init(attributes: [String: AnyObject]) {
        error = attributes[AnimeKeys.character.rawValue] as? String ?? "An error has accoured 🥲"
    }
}

extension AnimeError {
    static let emptyError = "The anime title can't be empty 😤"
}
