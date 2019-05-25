//
//  ViewController.swift
//  Example_MeliCardDrawer
//
//  Created by Juan sebastian Sanzone on 5/21/19.
//  Copyright © 2019 Mercadolibre. All rights reserved.
//

import UIKit
import MLCardDrawer

final class ViewController: UIViewController {
    private var cardUILists: [CardUI] = [CardUIExamples.AmericanExpress(), CardUIExamples.Visa(), CardUIExamples.Maestro19(), CardUIExamples.GaliciaAmex(), CardUIExamples.VisaSantander(), CardUIExamples.Maestro18(),  CardUIExamples.Visa(), CardUIExamples.Visa1(), CardUIExamples.Visa2(), CardUIExamples.Visa3(), CardUIExamples.Visa4(), CardUIExamples.Visa5()]

    // MARK: Outlets.
    @IBOutlet weak var cardTypesCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!

    // MARK: Private Vars
    // Example implementation CardHeaderController - MeliCardDrawer.
    private var cardDrawer: CardHeaderController?
    private var cardUIHandler: CardUI = CardUIExamples.VisaSantander()
    private var cardDataHandler: CardData = CardDataHandler()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
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
        cardDrawer = CardHeaderController(cardUIHandler, cardDataHandler)
        cardDrawer?.setUp(inView: containerView).show()
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
        return cardUILists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let targetIndex = indexPath.item
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCollectionCell.identifier, for: indexPath) as? TypeCollectionCell, cardUILists.indices.contains(targetIndex) {
            cell.setup(cardUILists[targetIndex])
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetIndex = indexPath.item
        if cardUILists.indices.contains(targetIndex) {
            cardDrawer?.cardUI = cardUILists[targetIndex]
        }
    }
}

// MARK: Keyboard.
extension ViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
