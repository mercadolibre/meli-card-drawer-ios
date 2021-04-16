//
//  CustomSwitch.swift
//  MLCardDrawer
//
//  Created by Vinicius De Andrade Silva on 24/03/21.
//

import UIKit

protocol CustomSwitchDelegate: class {
    func change(to index: Int)
}

class CustomSwitch: UIView {

    private var options: [SwitchOption]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var selectedOption = ""
    var textColor: UIColor = .white
    var selectorViewColor: UIColor = .white
    var selectorTextColor: UIColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    
    var buttonFont = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    var buttonSelectedFont = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        
    weak var delegate: CustomSwitchDelegate?
    
    convenience init(frame: CGRect, options: [SwitchOption]) {
        self.init(frame: frame)
        self.options = options
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.selectDefault() }
    }
    
    func setOptions(options: [SwitchOption]) {
        self.options = options
        updateView()
    }
        
    private func updateView() {
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
        createButton()
        configureSelectorView()
        configureStackView()
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.layoutMargins = .zero
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func configureSelectorView() {
        let selectorWidth = frame.width/1.75
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: selectorWidth,
                                            height: self.frame.height))
        selectorView.backgroundColor = selectorViewColor
        selectorView.layer.cornerRadius = selectorView.frame.height/2
        selectorView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        selectorView.layer.borderWidth = 3
        selectorView.layer.borderColor = selectorViewColor.cgColor
        selectorView.addInnerShadow()
        addSubview(selectorView)
    }
    
    func selectDefault() {
        let selectedIndex = options.firstIndex { $0.id == selectedOption } ?? 0
        buttonActionNotAnimated(sender: buttons[selectedIndex])
    }
    
    private func createButton() {
        buttons = []
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in options.map({$0.name}) {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(self.buttonAction(sender:)),
                             for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = buttonFont
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = buttonSelectedFont
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, button) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            if button == sender {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.selectorView.center.x = button.center.x
                } completion: { [weak self] _ in
                    self?.delegate?.change(to: buttonIndex)
                }
                button.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    func buttonActionNotAnimated(sender: UIButton) {
        for button in buttons {
            button.setTitleColor(textColor, for: .normal)
            if button == sender {
                self.selectorView.center.x = button.center.x
                button.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }

}
