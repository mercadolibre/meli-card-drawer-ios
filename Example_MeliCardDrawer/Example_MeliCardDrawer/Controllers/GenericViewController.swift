//
//  GenericViewController.swift
//  Example_MeliCardDrawer
//
//  Created by Vinicius De Andrade Silva on 27/04/21.
//  Copyright © 2021 Mercadolibre. All rights reserved.
//

import UIKit
import MLCardDrawer

class GenericViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardDrawer = MLCardDrawerController(CardUIExamples.Pix(), CardDataHandler())
        
        let cardView = cardDrawer.getCardView()
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        
        containerView.addSubview(cardView)
        
        cardView.layer.borderColor = UIColor.black.cgColor
        cardView.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([cardView.topAnchor.constraint(equalTo: containerView.topAnchor),
                                     cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                                     cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                                     cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
