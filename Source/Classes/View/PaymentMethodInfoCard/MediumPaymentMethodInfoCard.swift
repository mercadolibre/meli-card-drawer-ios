import UIKit

class MediumPaymentMethodInfoCard: BasePaymentMethodInfoCard {

    enum ConstraintValues {
        static let entityLeadingAnchor: Double = 16
        static let entityTopAnchor: Double = 12
        static let entityTrailingAnchor: Double = -4
        
        static let amountLeadingAnchor: Double = 4
        static let amountTopAnchor: Double = 12
        static let amountTrailingAnchor: Double = -16
        
        static let panLeadingAnchor: Double = 16
        static let panBottomAnchor: Double = -12
        
        static let paymentTypeTrailingAnchor: Double = -16
        static let paymentTypeBottomAnchor: Double = -12
        static let paymentTypeWidthAnchor: Double = 195
    }
    
    override func setupCornerRadius() {
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .medium)
    }
    
    override func setupConstraints() {
        self.addSubview(container)
        container.addSubview(gradient)
        container.addSubview(overlay)
        container.addSubview(entity)
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
            
            entity.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ConstraintValues.entityLeadingAnchor),
            entity.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.entityTopAnchor),
            entity.trailingAnchor.constraint(equalTo: container.centerXAnchor, constant: ConstraintValues.entityTrailingAnchor),
            
            amount.leadingAnchor.constraint(equalTo: container.centerXAnchor, constant: ConstraintValues.amountLeadingAnchor),
            amount.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.amountTopAnchor),
            amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor),
            
            pan.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ConstraintValues.panLeadingAnchor),
            pan.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.panBottomAnchor),
            
            paymentType.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.paymentTypeBottomAnchor),
            paymentType.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor),
            paymentType.widthAnchor.constraint(equalToConstant: ConstraintValues.paymentTypeWidthAnchor)
        ])
    }
}



