//
//  NewDocumentModel.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation
import Combine

final class NewDocumentModel: ObservableObject {
    @Published var title: String = ""
    @Published var url: String = ""
    @Published var text: String = ""
    @Published var isEditable: Bool = true
    @Published var submitSelectable: Bool = false
    private(set) var sentences: [String] = []
    
    private let textAdjustUseCase: TextAdjustUseCaseInterface
    private let sentenceAdjustUseCase: SentenceAdjustUseCaseInterface
    private let getWordsFromSentenceUseCase: GetWordsFromSentenceUseCaseInterface
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        textAdnustUseCase: TextAdjustUseCaseInterface,
        sentenceAdjustUseCase: SentenceAdjustUseCaseInterface,
        getWordsFromSentenceUseCase: GetWordsFromSentenceUseCaseInterface
    ) {
        self.textAdjustUseCase = textAdnustUseCase
        self.sentenceAdjustUseCase = sentenceAdjustUseCase
        self.getWordsFromSentenceUseCase = getWordsFromSentenceUseCase
        self.bind()
    }
    
    private func bind() {
        self.$title
            .sink { [weak self] _ in
                self?.updateSubmitSelectable()
            }
            .store(in: &cancellables)
        
        self.$text
            .sink { [weak self] _ in
                self?.updateSubmitSelectable()
            }
            .store(in: &cancellables)
    }
    
    private func updateSubmitSelectable() {
        self.submitSelectable = (!title.isEmpty && !text.isEmpty)
    }
}

// MARK: Input
extension NewDocumentModel {
    func submit() {
        self.text = self.textAdjustUseCase.adjustText(from: self.text)
        self.sentences = self.sentenceAdjustUseCase.adjustSentence(from: self.text)
        var words: [String] = []
        for sentence in self.sentences {
            for word in self.getWordsFromSentenceUseCase.getWords(from: sentence) where !words.contains(word) {
                words.append(word)
            }
        }
        for word in words {
            print(word)
        }
        self.isEditable = false
    }
}
