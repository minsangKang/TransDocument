//
//  TextAdjustUseCase.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

final class TextAdjustUseCase: TextAdjustUseCaseInterface {
    func adjustText(from: String) -> String {
        let filterChars: [String] = ["*", "'", "#", "@"]
        var result = from
        
        for char in filterChars {
            if result.contains(char) {
                result = result.replacingOccurrences(of: char, with: "")
            }
        }
        
        return result
    }
}
