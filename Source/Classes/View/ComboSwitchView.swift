//
//  ComboSwitch.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 29/01/2021.
//

public class ComboSwitchView: UIView {
    
    var switchModel : SwitchModel?
    
    var switchDidChangeCallback : ((_ selectedOption: String) -> Void)?
    
    @IBOutlet weak var switchControl: CustomSwitch!
    @IBOutlet weak var comboLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadFromNib()
    }
    
    public func setSwitchModel(_ switchModel : SwitchModel) {
        self.switchModel = switchModel
        switchControl.delegate = self
        switchControl.setButtonTitles(buttonTitles: switchModel.options.map { $0.name })
        switchControl.backgroundColor = UIColor(hexaRGB: switchModel.switchBackgroundColor)
        switchControl.selectorViewColor = UIColor(hexaRGB: switchModel.pillBackgroundColor)!
        switchControl.selectorTextColor = UIColor(hexaRGB: switchModel.states.checked.textColor)!
        switchControl.textColor = UIColor(hexaRGB: switchModel.states.unchecked.textColor)!
        comboLabel.textColor = UIColor(hexaRGB: switchModel.description.textColor!)
        comboLabel.text = switchModel.description.text
        backgroundColor = UIColor(hexaARGB: switchModel.safeZoneBackgroundColor)
    }
    
    public func setSwitchDidChangeCallback(switchDidChangeCallback: @escaping (_ selectedOption: String) -> Void) {
        self.switchDidChangeCallback = switchDidChangeCallback
    }
}

extension ComboSwitchView: CustomSwitchDelegate {
    func change(to index: Int) {
        if let name = switchModel?.options[index].name, let callback = switchDidChangeCallback {
            callback(name)
        }
    }
}
