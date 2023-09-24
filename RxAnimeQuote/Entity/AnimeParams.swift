//
//  AnimeParams.swift
//  RxAnimeQuote
//
//  Created by User on 24/12/2022.
//

import Foundation

struct AnimeParams {
    let query: String
    
    var url: URL? {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let path = "https://animechan.vercel.app/api/random/anime?title=\(encodedQuery ?? "")"
        return URL(string: path)
    }
}
