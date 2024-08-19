//
//  CustomSegmentedControl.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 17.08.2024.
//

import UIKit

@IBDesignable public class CustomSegmentedControl: UIControl {
    
    var buttons: [UIButton] = []
    var selector: UIView!
    
    @IBInspectable public var borderWidth: CGFloat = 1 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    
    @IBInspectable public var items: [String] = [] {
        didSet { if items.count > 0 { updateView() } }
    }
    
    @IBInspectable public var textColor: UIColor = UIColor.black {
        didSet { updateView() }
    }
    
    @IBInspectable public var selectedColor: UIColor = UIColor.yellow {
        didSet { updateView() }
    }
    
    @IBInspectable public var selectedTextColor: UIColor = UIColor.black {
        didSet { updateView() }
    }
    
    @IBInspectable public var selectedSegmentIndex: Int = 0 {
        didSet { updateView() }
    }
    
    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        updateView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateView()
    }
    
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(item, for: .normal)
            button.setTitleColor(index == selectedSegmentIndex ? selectedTextColor : textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        selector = UIView()
        selector.backgroundColor = selectedColor
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    public override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let selectorWidth = frame.width / CGFloat(items.count)
        let selectorPosition = CGFloat(selectedSegmentIndex) * selectorWidth
        selector.frame = CGRect(x: selectorPosition, y: 0, width: selectorWidth, height: frame.height)
    }
    
    
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                btn.setTitleColor(selectedTextColor, for: .normal)
                
                sendActions(for: .valueChanged)
            }
        }
    }
}
