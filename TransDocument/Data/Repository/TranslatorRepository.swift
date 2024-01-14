//
//  TranslatorRepository.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation
import Moya
import Combine
import CombineMoya

final class TranslatorRepository: TranslatorRepositoryInterface {
    private let provider = MoyaProvider<TranslatorAPI>()
    
    func translate(sentences: [String]) -> AnyPublisher<[String], NetworkError> {
        provider.requestPublisher(.translate(sentences))
            .mapError { error in
                print(error)
                return NetworkError.translateError
            }
            .tryMap { response in
                let data = response.data
                let statusCode = response.statusCode
                
                // statusCode에 따른 error 반환
                guard (200...299).contains(statusCode) else {
                    throw NetworkError.translateError
                }
                
                // DTO 디코딩과정
                guard let dto = try? JSONDecoder().decode(TranslateResults.self, from: data) else {
                    throw NetworkError.translateError
                }
                
                // Entity 반환
                let infos = dto.toDomain()
                return infos
            }
            .mapError { error in
                print(error)
                return NetworkError.translateError
            }
            .eraseToAnyPublisher()
    }
}
