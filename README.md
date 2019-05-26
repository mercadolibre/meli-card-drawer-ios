![Screenshot iOS](https://i.ibb.co/hCsHg7B/libcover.jpg)
<p align="center">
    <a href="https://app.bitrise.io/app/769306824c08dd17">
        <img src="https://app.bitrise.io/app/769306824c08dd17/status.svg?token=4F8Ib-Y-8u3tLWtebEr2gA&branch=master" alt="Bitrise" />
    </a>
      <a href="https://codebeat.co/projects/github-com-mercadolibre-meli-card-drawer-ios-master"><img alt="codebeat badge" src="https://codebeat.co/badges/nro" /></a>
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" />
    <a href="https://cocoapods.org/pods/MLCardDrawer">
        <img src="https://img.shields.io/cocoapods/v/MLCardDrawer.svg" alt="CocoaPods" />
    </a>
    <a href="https://cocoapods.org/pods/MLCardDrawer">
        <img src="https://img.shields.io/cocoapods/dt/MLCardDrawer.svg?style=flat" alt="CocoaPods downloads" />
    </a>
    <a href="https://twitter.com/johnsanzo">
        <img src="https://img.shields.io/badge/twitter-@JohnSanzo-blue.svg?style=flat" alt="Twitter: @JohnSanzo" />
    </a>
</p>

## 📲 How to Install

#### Using [CocoaPods](https://cocoapods.org)

Edit your `Podfile` and specify the dependency:

```ruby
pod 'MLCardDrawer'
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
import MLCardDrawer
```

### 2 - Define CardHeaderController reference & your own container view.
```swift
// You can create your containerView by code or by storyboard/xib (as you like)
private var containerView: UIView = UIView()
private var cardDrawer: MLCardDrawerController?
```

### 3 - Init cardDrawer sending CardUI and CardData protocol as parameters.
```swift
cardDrawer = MLCardDrawerController(cardUIHandler, cardDataHandler)
```

### 4 - Call to setup and show method.
```swift
cardDrawer?.setUp(inView: containerView).show()
```

## 💡 Advanced features
### Show security code
![Gif](https://media.giphy.com/media/Ma67kJcJ0bl49kFsi3/giphy.gif)
```swift
// You can highlight the security code location. 
// If the security code is behind, the card will transition with flip animation.
cardDrawer?.showSecurityCode()
```

### Show front card view
```swift
cardDrawer?.show()
```

## 💳 Card data structure and style customization
You can customize the data structure and style of your card.

### 🔠 CardData protocol
Using `CardData` protocol to update the card display values.
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
Using `CardUI` protocol to customize: position of security code, card background, font color, place holders, etc.

```swift
@objc public protocol CardUI {
    var cardPattern: [Int] { get }
    var placeholderName: String { get }
    var placeholderExpiration: String { get }
    var cardFontColor: UIColor { get }
    var cardBackgroundColor: UIColor { get }
    var securityCodeLocation: MLCardSecurityCodeLocation { get }
    var defaultUI: Bool { get }
    var securityCodePattern: Int { get }

    @objc optional func set(bank: UIImageView)
    @objc optional func set(logo: UIImageView)
    @objc optional var fontType: String { get }
    @objc optional var bankImage: UIImage? { get }
    @objc optional var cardLogoImage: UIImage? { get }
}
```

### 😉 Next steps
* [x] Bitrise for releases
* [x] Codebeat integration
* [ ] SwiftLint
* [ ] Migration to Swift 5
* [ ] Shine card effect with motion blur 🔥🔥
* [ ] Native support to display card in disabled mode (card disabled)


### 🔮 Project Example
This project include an example project using `MLCardDrawer` and another target with `xCTests` test cases.
Enter to path: `meli-card-drawer-ios/Example_MeliCardDrawer` and run pod install command. After that, you can open `Example_MeliCardDrawer.xcworkspace`


### 🕵️‍♂️ Test cases
![TestCases](https://i.ibb.co/3c0h1wF/Tests.png)

### 📋 Supported OS & SDK Versions
* iOS 9.0+
* Swift 4.2
* xCode 9.2+
* @Objc full compatibility

## ❤️ Feedback
This is an open source project, so feel free to contribute. How? -> Fork this project and propose your own fixes, suggestions and open a pull request with the changes.

## 👨🏻‍💻 Author
Juan Sanzone / @juansanzone

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
