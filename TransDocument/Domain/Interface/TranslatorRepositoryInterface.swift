//
//  TranslatorRepositoryInterface.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation
import Combine

protocol TranslatorRepositoryInterface {
    func translate(sentences: [String]) -> AnyPublisher<[String], NetworkError>
}
