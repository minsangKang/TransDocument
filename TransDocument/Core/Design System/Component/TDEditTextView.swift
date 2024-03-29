//
//  TDEditTextView.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Combine
import SwiftUI

struct TDEditTextView: NSViewRepresentable {
    @Binding var text: String
    @Binding var isEditable: Bool
    var font: NSFont?    = .systemFont(ofSize: 14, weight: .regular)
    
    var onEditingChanged: () -> Void       = {}
    var onCommit        : () -> Void       = {}
    var onTextChange    : (String) -> Void = { _ in }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> CustomTextView {
        let textView = CustomTextView(
            text: text,
            isEditable: isEditable,
            font: font
        )
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateNSView(_ view: CustomTextView, context: Context) {
        view.text = text
        view.updateEditable(to: isEditable)
        view.selectedRanges = context.coordinator.selectedRanges
    }
}

// MARK: - Coordinator
extension TDEditTextView {
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TDEditTextView
        var selectedRanges: [NSValue] = []
        
        init(_ parent: TDEditTextView) {
            self.parent = parent
        }
        
        /// TextView 입력으로 넘어왔을 경우 실행
        func textDidBeginEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.parent.onEditingChanged()
        }
        
        /// 텍스트가 입력될 때 마다 실행
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.selectedRanges = textView.selectedRanges
            self.parent.onTextChange(textView.string)
        }
        
        /// 다른View로 입력이 넘어갔을 경우 실행
        func textDidEndEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.parent.onCommit()
        }
    }
}
// MARK: - CustomTextView
final class CustomTextView: NSView {
    private var isEditable: Bool
    private var font: NSFont?
    
    weak var delegate: NSTextViewDelegate?
    
    var text: String {
        didSet {
            textView.string = text
        }
    }
    
    var selectedRanges: [NSValue] = [] {
        didSet {
            guard selectedRanges.count > 0 else {
                return
            }
            
            textView.selectedRanges = selectedRanges
        }
    }
    
    private lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.drawsBackground           = true
        scrollView.borderType                = .noBorder
        scrollView.hasVerticalScroller       = true
        scrollView.hasHorizontalRuler        = false
        scrollView.autoresizingMask          = [.width, .height]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var textView: NSTextView = {
        let contentSize = scrollView.contentSize
        let textStorage = NSTextStorage()
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(containerSize: scrollView.frame.size)
        textContainer.widthTracksTextView = true
        textContainer.containerSize = NSSize(
            width: contentSize.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        layoutManager.addTextContainer(textContainer)
        
        
        let textView                     = NSTextView(frame: .zero, textContainer: textContainer)
        textView.autoresizingMask        = .width
        textView.backgroundColor         = NSColor.textBackgroundColor
        textView.delegate                = self.delegate
        textView.drawsBackground         = true
        textView.font                    = self.font
        textView.isEditable              = self.isEditable
        textView.isHorizontallyResizable = false
        textView.isVerticallyResizable   = true
        textView.maxSize                 = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.minSize                 = NSSize(width: 0, height: contentSize.height)
        textView.textColor               = NSColor(Colors.black001.toColor)
        textView.allowsUndo              = true
        textView.isRichText              = false
        textView.textContainerInset = NSSize(width: 0, height: 4)
        
        return textView
    }()
    
    // MARK: - Init
    init(text: String, isEditable: Bool, font: NSFont?) {
        self.font       = font
        self.isEditable = isEditable
        self.text       = text
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillDraw() {
        super.viewWillDraw()
        
        self.setupScrollViewConstraints()
        self.setupTextView()
    }
    
    private func setupScrollViewConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func setupTextView() {
        self.scrollView.documentView = self.textView
    }
    
    func updateEditable(to editable: Bool) {
        self.textView.isEditable = editable
    }
}

//// MARK: - Preview
//#if DEBUG
//
//struct TDEditTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            TDEditTextView(
//                text: .constant("{ \n    planets { \n        name \n    }\n}"),
//                isEditable: true,
//                font: .userFixedPitchFont(ofSize: 14)
//            )
//            .environment(\.colorScheme, .dark)
//            .previewDisplayName("Dark Mode")
//            
//            TDEditTextView(
//                text: .constant("{ \n    planets { \n        name \n    }\n}"),
//                isEditable: true,
//                font: .userFixedPitchFont(ofSize: 14)
//            )
//            .environment(\.colorScheme, .light)
//            .previewDisplayName("Light Mode")
//        }
//    }
//}
//#endif
