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

public class CustomSwitch: UIView {

    private var options: [SwitchOption]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    var centerDiference: CGFloat = 3
    
    var containerViewBackgroundColor: UIColor = UIColor.clear
    var containerViewBorderColor: CGColor = UIColor.black.cgColor
    var selectedOption = ""
    var textColor: UIColor = .white
    var selectorViewColor: UIColor = .white
    var selectorTextColor: UIColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    
    var buttonFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    var buttonSelectedFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        
    weak var delegate: CustomSwitchDelegate?
    
    convenience init(frame: CGRect, options: [SwitchOption]) {
        self.init(frame: frame)
        self.options = options
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
        DispatchQueue.main.asyncAfter(deadline: .now()) { self.selectDefault() }
    }
    
    func setOptions(options: [SwitchOption]) {
        self.options = options
        updateView()
    }
        
    private func updateView() {
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
        createButton()
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        containerView.backgroundColor = containerViewBackgroundColor
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = containerViewBorderColor
        containerView.layer.cornerRadius = containerView.frame.height/2
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
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
        let selectorWidth = frame.width * 0.54
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: selectorWidth,
                                            height: self.frame.height))
        selectorView.backgroundColor = selectorViewColor
        selectorView.layer.cornerRadius = selectorView.frame.height/2
        selectorView.layer.borderWidth = 1
        selectorView.layer.borderColor = UIColor.blue.cgColor // selectorViewColor.cgColor
        addSubview(selectorView)
    }
    
    func selectDefault() {
        let selectedIndex = options.firstIndex { $0.id == selectedOption } ?? 0
        buttonActionNotAnimated(sender: buttons[selectedIndex])
    }
    
    private func createButton() {
        buttons = []
        subviews.forEach({$0.removeFromSuperview()})
        for (index, buttonTitle) in options.map({$0.name}).enumerated() {
            let button = UIButton(type: .system)
           if (index < 1) {
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: centerDiference, bottom: 0, right: 0)
            } else {
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: centerDiference)
            }
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(self.buttonAction(sender:)),
                             for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            
            button.titleLabel?.font = buttonFont
            button.titleLabel?.numberOfLines = 1
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.lineBreakMode = .byClipping
            button.tag = index
            
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            
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
                    if let centerDiference = self?.centerDiference {
                        if (sender.tag > 0) {
                            self?.selectorView.center.x = button.center.x - centerDiference
                        } else {
                            self?.selectorView.center.x = button.center.x + centerDiference
                        }
                    }
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
                if (button.tag > 0) {
                    self.selectorView.center.x = button.center.x - centerDiference
                } else {
                    self.selectorView.center.x = button.center.x + centerDiference
                }
                button.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }

}
