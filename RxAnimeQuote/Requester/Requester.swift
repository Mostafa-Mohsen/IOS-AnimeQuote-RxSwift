//
//  Requester.swift
//  RxAnimeQuote
//
//  Created by User on 24/12/2022.
//

import Foundation
import RxSwift
import RxCocoa


class Requester {
    static func fetchData(with url: URL) -> Observable<Any> {
        let request = URLRequest(url: url)
        return URLSession.shared.rx.json(request: request)
    }
}
