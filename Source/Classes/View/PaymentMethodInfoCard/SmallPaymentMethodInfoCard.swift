import Foundation

class SmallPaymentMethodInfoCard: BasePaymentMethodInfoCard {
    
    enum ConstraintValues {
        static let amountTopAnchor: CGFloat = 8
        static let amountTrailingAnchor: CGFloat = -16
        static let amountWidthAnchor: CGFloat = 195

        static let panLeadingAnchor: CGFloat = 16
        static let panTopAnchor: CGFloat = 12
        static let panBottomAnchor: CGFloat = -13
        
        static let paymentTypeTrailingAnchor: CGFloat = -16
        static let paymentTypeBottomAnchor: CGFloat = -8
        static let paymentTypeLeadingAnchor: CGFloat = 12
    }
    
    override func setupCornerRadius() {
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .small)
    }
    
    override func setupConstraints() {
        self.addSubview(container)
        container.addSubview(gradient)
        container.addSubview(overlay)
        container.addSubview(amount)
        container.addSubview(pan)
        container.addSubview(paymentType)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            gradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradient.topAnchor.constraint(equalTo: self.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradient.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlay.topAnchor.constraint(equalTo: self.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            amount.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.amountTopAnchor),
            amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor),
            amount.widthAnchor.constraint(equalToConstant: ConstraintValues.amountWidthAnchor),
            
            pan.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ConstraintValues.panLeadingAnchor),
            pan.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.panTopAnchor),
            pan.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.panBottomAnchor),
            
            paymentType.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.paymentTypeBottomAnchor),
            paymentType.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor),
            paymentType.leadingAnchor.constraint(equalTo: pan.trailingAnchor, constant: ConstraintValues.paymentTypeLeadingAnchor)
        ])
    }
}
