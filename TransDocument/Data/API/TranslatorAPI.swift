//
//  TranslatorAPI.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation
import Moya

enum TranslatorAPI {
    case translate([String])
}

extension TranslatorAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api-free.deepl.com")!
    }
    
    var path: String {
        return "/v2/translate"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .translate(let sentences):
            let request = TranslatorRequest(text: sentences, target_lang: "KO")
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
            "Authorization": "\(Infos.DeepL_Key.value)",
        ]
    }
}
