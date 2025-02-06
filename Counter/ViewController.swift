//
//  ViewController.swift
//  Counter
//
//  Created by Михаил Бобылев on 06.02.2025.
//

import UIKit

class ViewController: UIViewController {
    enum LogChange {
        case minus
        case plus
        case reset
        case belowZero
        
        var text: String {
            switch self {
            case .minus:
                return "значение изменено на -1"
            case .plus:
                return "значение изменено на +1"
            case .reset:
                return "значение сброшено"
            case .belowZero:
                return "попытка уменьшить значение счётчика ниже 0"
            }
        }
    }
    
    @IBOutlet weak var historyTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    private var count = 0 {
        didSet {
            countLabel.text = count != 0 ? "Значение счётчика: \(count)" : "\(count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func tapMinus(_ sender: Any) {
        if count > 0 {
            count -= 1
            logChange(.minus)
        } else {
            logChange(.belowZero)
        }
    }
    
    @IBAction func tapPlus(_ sender: Any) {
        count += 1
        logChange(.plus)
    }
    
    @IBAction func tapReset(_ sender: Any) {
        if count != 0 {
            count = 0
            logChange(.reset)
        }
    }
}

private extension ViewController {
    func setupUI() {
        historyTextView.backgroundColor = .secondarySystemBackground
        historyTextView.text = "История изменений:\n"
        historyTextView.layer.cornerRadius = 8
        
        minusButton.layer.cornerRadius = 8
        plusButton.layer.cornerRadius = 8
        resetButton.layer.cornerRadius = 8
    }
    
    func logChange(_ change: LogChange) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = formatter.string(from: Date())
        let resultLog = "[\(timestamp)]: \(change.text)\n"
        
        historyTextView.text.append(resultLog)

        DispatchQueue.main.async {
            self.scrollTextViewToBottom()
        }
    }
    
    func scrollTextViewToBottom() {
        let range = NSRange(location: historyTextView.text.count - 1, length: 1)
        historyTextView.scrollRangeToVisible(range)
    }
}
