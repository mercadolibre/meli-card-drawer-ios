//
//  ViewController.swift
//  Example_MeliCardDrawer
//
//  Created by Juan sebastian Sanzone on 5/21/19.
//  Copyright © 2019 Mercadolibre. All rights reserved.
//

import UIKit
import MLCardDrawer

// codebeat:disable
final class ViewController: UIViewController {

    // MARK: Outlets.
    @IBOutlet weak var cardTypesCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var safeAreaSwitch: UISwitch!
    
    var type: MLCardDrawerType = .large
    
    // MARK: Private Vars
    // Example implementation CardHeaderController - MeliCardDrawer.
    private var cardDrawer: MLCardDrawerController?
    private var cardUIHandler: CardUI = CardUIExamples.VisaSantander()
    private var cardDataHandler: CardData = CardDataHandler()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .dark {
            changeTheme(backgroundColor: .black, fontColor: .white)
        } else {
            changeTheme(backgroundColor: .white, fontColor: .black)
        }
    }
}

// MARK: UI Setup.
extension ViewController {
    private func setupUI() {
        setupCardExample()
        setupDismissGesture()
        cardTypesCollectionView.dataSource = self
        cardTypesCollectionView.delegate = self
    }

    // Example implementation MeliCardDrawer - CardHeaderController.
    private func setupCardExample() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        cardDrawer = MLCardDrawerController(cardUIHandler, cardDataHandler, false, type)
        
        if let cardDrawerInstance = cardDrawer {
            let cardView = cardDrawerInstance.getCardView()
            cardView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(cardView)
            
            NSLayoutConstraint.activate([cardView.topAnchor.constraint(equalTo: containerView.topAnchor),
                                         cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                                         cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                                         cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)])
            
            if type == .large && safeAreaSwitch.isOn {
                cardDrawerInstance.setCustomView(generateComboSwitchView())
            }
        }
    }

    private func setupDismissGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: Update card data handler protocol.
extension ViewController {
    @IBAction func cardNumberChange(_ sender: UITextField) {
        if let txt = sender.text {
            cardDataHandler.number = txt
        }
    }

    @IBAction func cardNameChange(_ sender: UITextField) {
        if let txt = sender.text {
            cardDataHandler.name = txt.uppercased()
        }
    }

    @IBAction func expirationChange(_ sender: UITextField) {
        if let txt = sender.text {
            cardDataHandler.expiration = txt
        }
    }
}

// MARK: SecurityCode managment.
extension ViewController {
    @IBAction func ccvChange(_ sender: UITextField) {
        if let txt = sender.text {
            cardDataHandler.securityCode = txt
        }
    }

    @IBAction func cvvEditingDidBegin(_ sender: Any) {
        cardDrawer?.showSecurityCode()
    }

    @IBAction func cvvEditingDidEnd(_ sender: UITextField) {
        cardDrawer?.show()
    }
}

// MARK: CollectionView.
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CardUIExamples.cardUILists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let targetIndex = indexPath.item
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCollectionCell.identifier, for: indexPath) as? TypeCollectionCell, CardUIExamples.cardUILists.indices.contains(targetIndex) {
            cell.setup(CardUIExamples.cardUILists[targetIndex])
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetIndex = indexPath.item
        if CardUIExamples.cardUILists.indices.contains(targetIndex) {
            cardDrawer?.cardUI = CardUIExamples.cardUILists[targetIndex]
        }
    }
}

// MARK: Keyboard.
extension ViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Card Type Segmented Control
extension ViewController {
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            type = .large
        case 1:
            type = .medium
        case 2:
            type = .small
        default:
            break
        }
        setupCardExample()
    }
}

// MARK: Toggle shine card feature.
extension ViewController {
    @IBAction func didChangeShineToggle(_ sender: UISwitch) {
        cardDrawer?.setShineCard(enabled: sender.isOn)
    }

    @IBAction func didCHangeUISwitch(_ sender: UISwitch) {
        changeTheme(backgroundColor: sender.isOn ? .black : .white, fontColor: sender.isOn ? .white : .black)
    }

    private func changeTheme(backgroundColor: UIColor, fontColor: UIColor) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.backgroundColor = backgroundColor
            if let tView = self?.view {
                for tLabel in tView.subviews {
                    if let targetLabel = tLabel as? UILabel {
                        targetLabel.textColor = fontColor
                    }
                }
            }
        }
    }
}

// MARK: Toggle SafeArea feature
extension ViewController {
    @IBAction func didChangeSafeArea(_ sender: UISwitch) {
        if sender.isOn {
            cardDrawer?.setCustomView(generateComboSwitchView())
        } else {
            cardDrawer?.removeCustomView()
        }
    }
    
    func generateComboSwitchView () -> UIView {
        // Switch States
        let checkedState = State(textColor: "#333333", weight: "normal")
        let uncheckedState = State(textColor: "#ffffff", weight: "normal")
        
        let switchStates = SwitchStates(checked: checkedState, unchecked: uncheckedState)
        
        // Switch options
        let debitOption = SwitchOption(id: "debit_card", name: "Débito")
        let creditOption = SwitchOption(id: "credit_card", name: "Crédito")
        
        let switchOptions = [debitOption, creditOption]
        
        // Description
        let description = Text(text: "Você paga com", textColor: "#ffffff", weight: "semi_bold")
        
        // Switch model
        let switchModel = SwitchModel(description: description,
                                      states: switchStates,
                                      defaultState: "credit_card",
                                      switchBackgroundColor: "#009ee3",
                                      pillBackgroundColor: "#ffffff",
                                      safeZoneBackgroundColor: "#26000000",
                                      options: switchOptions)
        
        let customView = ComboSwitchView()
        
        customView.setSwitchModel(switchModel)
        
        customView.setSwitchDidChangeCallback() {
          print("selected option \($0)")
        }
        
        return customView
    }
}
