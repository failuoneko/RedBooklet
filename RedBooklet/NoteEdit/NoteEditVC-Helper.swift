//
//  NoteEditVC-Helper.swift
//  RedBooklet
//
//  Created by L on 2023/2/20.
//

extension NoteEditVC {
    func handleTFEditChanged(){
        // 當前有高亮文字時(拼音等)return
        guard titleTextField.markedTextRange == nil else { return }
        
        // 若輸入完文字大於最大字數，擷取前面最大字數文本。
        if titleTextField.unwrappedText.count > kMaxNoteTitleCount{
            
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            
            showTextHUD("标题最多输入\(kMaxNoteTitleCount)字哦")
            
            // 複製貼上文本後光標位置，默認在文字前面，這邊改為最後面。
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
}
