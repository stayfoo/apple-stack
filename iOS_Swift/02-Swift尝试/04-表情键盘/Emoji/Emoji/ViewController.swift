//
//  ViewController.swift
//  Emoji
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emojiLabel: UILabel!

    @IBAction func shouEmojiClick(_ sender: Any) {
        
        let attachment = NSTextAttachment() // 附件
        attachment.image = UIImage(named: "d_aoteman")
        let attStr = NSAttributedString(attachment: attachment)
        
        let mutaStr = NSMutableAttributedString()
        mutaStr.append(attStr)
        
        let attrStr = NSAttributedString(string: "对小怪兽说:我")
        mutaStr.append(attrStr)
        
        
        let attachment2 = NSTextAttachment() //附件
        attachment2.image = UIImage(named: "d_aini")
        attachment2.bounds = CGRect(x: 0, y: -4, width: emojiLabel.font.lineHeight, height: emojiLabel.font.lineHeight)
        let attStr2 = NSAttributedString(attachment: attachment2)
        
        
        mutaStr.append(attStr2)
        
        emojiLabel.attributedText = mutaStr
    }
    
    @IBAction func hideEmojiClick(_ sender: Any) {
        emojiLabel.text = "奥特曼对小怪兽说:我爱你"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emojStr = "0x1f613ouojouojojojojoj"
        let scanner = Scanner(string: emojStr)
        
        //将扫描字符串的结果 输出到某一个地址下
        var value: UInt32 = 0
        scanner.scanHexInt32(&value)
        
        //将十六进制的数据转换为 unicode 编码字符
        let c = Character(UnicodeScalar(value)!)
        
        let eStr = "\(c)"
        print(eStr)
        
        
        print("emojStr.emojiStr(): \(emojStr.emojiStr())")
        
        
        
        //设置表情键盘
        setupEmoticonKeyboardView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
// MARK: - 设置表情键盘
    @IBOutlet weak var textView: UITextView!
    
    func setupEmoticonKeyboardView() {
        keyboardView.backgroundColor = UIColor.orange
        
        textView.becomeFirstResponder()
        textView.inputView = keyboardView;
        textView.inputAccessoryView = UIButton(type: UIButtonType.contactAdd)
        
        EmoticonManager().loadPackages()
    }
    
    fileprivate lazy var keyboardView: EmoticonKeyboardView = EmoticonKeyboardView { (emoticon) in
        self.insertText(emoticon)
    }
        
//     [weak self]
    
    
    fileprivate func insertText(_ em: Emoticon) {
        //1.点击空表情
        if em.isEmpty {
            print("点击空表情")
            return
        }
        //点击删除按钮
        if em.isDelete {
            textView.deleteBackward()
            return
        }
        //点击emoji表情
        if em.code != nil {
            //文本替换
            textView.replace(textView.selectedTextRange!, withText: em.emojiStr ?? "")
            return
        }
        
        //插入表情图片
        //1. 表情图片添加到附件中
        let attachment = NSTextAttachment()
        attachment.image = UIImage(contentsOfFile: em.imagePath ?? "")
        let lineHeight = textView.font!.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        
        //2.将附件添加到属性文本中
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        imageText.addAttribute(NSFontAttributeName, value: textView.font!, range: NSRange(location: 0, length: 1)) //给imageText属性文本添加属性
        
        //3.替换对应的文本
        let strM = NSMutableAttributedString(attributedString: textView.attributedText)
        let range = textView.selectedRange //替换前记录之前选中的光标
        strM.replaceCharacters(in: textView.selectedRange, with: imageText)
        
        //4.修改textView属性文本
        textView.attributedText = strM
        textView.selectedRange = NSRange(location: range.location + 1, length: 0) //恢复光标
        
        
    }
    
}

