import UIKit
import MLCardDrawer

class PaymentMethodInfoCardViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerViewHeightConstraint: NSLayoutConstraint!
    var cardType: MLCardDrawerTypeV3 = .large
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(nil, action: #selector(valueChanged), for: .valueChanged)
        setupCard(cardType: cardType)
    }
    
    @objc func valueChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cardType = .large
            containerViewHeightConstraint.constant = 198
            
        case 1:
            cardType = .medium
            containerViewHeightConstraint.constant = 158
        
        case 2:
            cardType = .small
            containerViewHeightConstraint.constant = 105
            
        default:
            break
        }
        
        setupCard(cardType: cardType)
    }
    
    private func setupCard(cardType: MLCardDrawerTypeV3) {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        let topCardDrawer = MLCardDrawerController(cardUI: CardUIExamples.AccountMoney(), cardType, CardDataEmpty())
        
        let bottomCardDrawer = MLCardDrawerController(cardUI: CardUIExamples.Nubank(), cardType, CardDataHandler2())
                
        let topCardView = topCardDrawer.getCardView()
        let bottomCardView = bottomCardDrawer.getCardView()

        topCardView.translatesAutoresizingMaskIntoConstraints = false
        bottomCardView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.masksToBounds = true
        
        containerView.addSubview(topCardView)
        containerView.addSubview(bottomCardView)
       
        switch cardType {
        case .small:
            smallCardsConstraints(
                containerView: containerView,
                topCardView: topCardView,
                bottomCardView:bottomCardView
            )
        case .medium:
            mediumCardsConstraints(
                containerView: containerView,
                topCardView: topCardView,
                bottomCardView:bottomCardView
            )
        case .large:
            largeCardsConstraints(
                containerView: containerView,
                topCardView: topCardView,
                bottomCardView:bottomCardView
            )
        default: break
        }
    }
    
    private func largeCardsConstraints(containerView: UIView, topCardView: UIView, bottomCardView: UIView) {
        NSLayoutConstraint.activate([
            topCardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topCardView.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -2.0),
            bottomCardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomCardView.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 2.0)
        ])
    }
    
    private func mediumCardsConstraints(containerView: UIView, topCardView: UIView, bottomCardView: UIView) {
        NSLayoutConstraint.activate([
            topCardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topCardView.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -2.0),
            bottomCardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomCardView.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 2.0)
        ])
    }
    
    private func smallCardsConstraints(containerView: UIView, topCardView: UIView, bottomCardView: UIView) {
        NSLayoutConstraint.activate([
            topCardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topCardView.bottomAnchor.constraint(equalTo: bottomCardView.topAnchor, constant: -1.5),
            bottomCardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomCardView.topAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 1.5)
        ])
    }

}
