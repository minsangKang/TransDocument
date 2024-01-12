//
//  SentenceAdjustUseCaseInterface.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

protocol SentenceAdjustUseCaseInterface {
    func adjustSentence(from: String) -> [String]
}
