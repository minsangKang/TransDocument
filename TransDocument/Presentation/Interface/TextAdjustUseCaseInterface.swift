//
//  TextAdjustUseCaseInterface.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

protocol TextAdjustUseCaseInterface {
    func adjustText(from: String) -> String
    func getAdjustedText(from sentences: [String]) -> String
}
