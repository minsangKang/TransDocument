//
//  TextAdjustUseCase.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

final class TextAdjustUseCase: TextAdjustUseCaseInterface {
    func adjustText(from text: String) -> String {
        let filterChars: [String] = ["*", "'", "#", "@"]
        var result = text
        
        for char in filterChars {
            if result.contains(char) {
                result = result.replacingOccurrences(of: char, with: "")
            }
        }
        
        return result
    }
    
    func getAdjustedText(from sentences: [String]) -> String {
        var result = ""
        for sentence in sentences {
            result += sentence
            result += "\n\n"
        }
        
        return result
    }
}
