![Screenshot iOS](https://i.ibb.co/hCsHg7B/libcover.jpg)
<p align="center">
    <a href="https://app.bitrise.io/">
      <img src="https://app.bitrise.io/app/d2d19a45654ed1d8/status.svg?token=TODO">
    </a>
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" />
    <a href="https://cocoapods.org/pods/MeliCardDrawer">
        <img src="https://img.shields.io/cocoapods/v/MeliCardDrawer.svg" alt="CocoaPods" />
    </a>
    <a href="https://cocoapods.org/pods/MeliCardDrawer">
        <img src="https://img.shields.io/cocoapods/dt/MeliCardDrawer.svg?style=flat" alt="CocoaPods downloads" />
    </a>
</p>

## 📲 How to Install

#### Using [CocoaPods](https://cocoapods.org)

Edit your `Podfile` and specify the dependency:

```ruby
pod 'MeliCardDrawer'
```

## 🌟 Features
- [x] Easy to integrate
- [x] Card number, name, expiration date and CVV support (CardData protocol)
- [x] Card left and right image customization (CardUI protocol)
- [x] CVV support at front & back view
- [x] Card flip animation integrated
- [x] Live card view updated while CardData protocol is edited
- [x] PCI compliance (We do not save anything)

## 🐒 How to use

### 1 - Import into project
```swift
import MeliCardDrawer
```

### 2 - Define CardHeaderController reference & your own container view.
```swift
// You can create your containerView by code or by storyboard/xib (as you like)
private var containerView: UIView = UIView()
private var cardDrawer: CardHeaderController?
```

### 3 - Init cardDrawer sending CardUI and CardData protocol as parameters.
```swift
cardDrawer = CardHeaderController(cardUIHandler, cardDataHandler)
```

### 4 - Call to setup and show method.
```swift
cardDrawer?.setup(inView: containerView).show()
```

## 💡 Advanced features
### Show security code
You can highlight the security code location. If the security code is behind, the card will transition with flip animation.
```swift
cardDrawer?.showSecurityCode()
```

### Show front card view
```swift
cardDrawer?.show()
```

## 💳 Card data structure and style customization
You can customize the data structure and style of your card.

### 🔠 CardData protocol
Using CardData protocol to update the card display values.
```swift
@objc public protocol CardData {
    var name: String { get set }
    var number: String { get set }
    var expiration: String { get set }
    var securityCode: String { get set }
    @objc optional var lastDigits: String { get set}
}
```

### 🎨 CardUI protocol
Using CardUI protocol to customize: position of security code, card background, font color, place holders, etc.

```swift
@objc public protocol CardUI {
    var cardPattern: [Int] { get }
    var placeholderName: String { get }
    var placeholderExpiration: String { get }
    var cardFontColor: UIColor { get }
    var cardBackgroundColor: UIColor { get }
    var securityCodeLocation: Location { get }
    var defaultUI: Bool { get }
    var securityCodePattern: Int { get }

    @objc optional func set(bank: UIImageView)
    @objc optional func set(logo: UIImageView)
    @objc optional var fontType: String { get }
    @objc optional var bankImage: UIImage? { get }
    @objc optional var cardLogoImage: UIImage? { get }
}
```

### 🔮 Project Example
This project include an example project using MeliCardDrawer and another target with xCTests test cases.

### 🕵️‍♂️ Test cases
![TestCases](https://raw.githubusercontent.com/juansanzone/uicardtest/master/Static/Tests.png)

### 📋 Supported OS & SDK Versions
* iOS 9.0+
* Swift 4.2
* xCode 9.2+
* @Objc full compatibility

## ❤️ Feedback
This is an open source project, so feel free to contribute. How? -> Fork this project and propose your own fixes, suggestions and open a pull request with the changes.

## 👨🏻‍💻 Author
Mercado Libre - Mercado Pago

## 👮🏻 License

```
Copyright 2019 Mercadolibre Developers

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```