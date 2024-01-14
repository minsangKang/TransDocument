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
    @Published var wordInfos: [WordInfo] = []
    private(set) var sentences: [String] = []
    
    private let textAdjustUseCase: TextAdjustUseCaseInterface
    private let sentenceAdjustUseCase: SentenceAdjustUseCaseInterface
    private let getWordsFromSentenceUseCase: GetWordsFromSentenceUseCaseInterface
    private let getTranslatedSentencesUseCase: GetTranslatedSentencesUseCaseInterface
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        textAdnustUseCase: TextAdjustUseCaseInterface,
        sentenceAdjustUseCase: SentenceAdjustUseCaseInterface,
        getWordsFromSentenceUseCase: GetWordsFromSentenceUseCaseInterface,
        getTranslatedSentencesUseCase: GetTranslatedSentencesUseCaseInterface
    ) {
        self.textAdjustUseCase = textAdnustUseCase
        self.sentenceAdjustUseCase = sentenceAdjustUseCase
        self.getWordsFromSentenceUseCase = getWordsFromSentenceUseCase
        self.getTranslatedSentencesUseCase = getTranslatedSentencesUseCase
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
        let text = self.textAdjustUseCase.adjustText(from: self.text)
        self.sentences = self.sentenceAdjustUseCase.adjustSentence(from: text)
        
        self.text = self.textAdjustUseCase.getAdjustedText(from: self.sentences)
        self.wordInfos = self.getWordsFromSentenceUseCase.getWordInfos(sentences: self.sentences)
        self.getTranslatedSentencesUseCase.getTranslatedSentencces(sentences: self.sentences)
            .sink { completion in
                switch completion {
                case .finished: return
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] translatedSentences in
                guard let self = self else { return }
                self.text = self.textAdjustUseCase.getMixedText(sentences: self.sentences, transedSencences: translatedSentences)
            }
            .store(in: &cancellables)

    }
    
    func save() {
        
    }
    
    func delete(at index: Int) {
        self.wordInfos.remove(at: index)
    }
}
