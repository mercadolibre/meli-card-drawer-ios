//
//  ComboSwitchSmallView.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 01/07/2021.
//

public class ComboSwitchSmallView: ComboSwitchView {
    
    var switchModel : SwitchModel?
    
    @IBOutlet weak var switchControl: CustomSwitch!
    
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
    
    override public func setSwitchModel(_ switchModel: SwitchModel) {
        self.switchModel = switchModel
        switchControl.delegate = self
        switchControl.backgroundColor = UIColor.fromHex(switchModel.switchBackgroundColor)
        switchControl.selectorViewColor = UIColor.fromHex(switchModel.pillBackgroundColor)
        switchControl.selectorTextColor = UIColor.fromHex(switchModel.states.checked.textColor)
        switchControl.textColor = UIColor.fromHex(switchModel.states.unchecked.textColor)
        switchControl.buttonFont = switchModel.states.unchecked.weight.getFont()
        switchControl.buttonSelectedFont = switchModel.states.checked.weight.getFont()
        switchControl.setOptions(options: switchModel.options)
        switchControl.selectedOption = switchModel.defaultState
        backgroundColor = UIColor.clear
    }
    
    override func change(to index: Int) {
        if let id = switchModel?.options[index].id, let callback = switchDidChangeCallback {
            switchControl.selectedOption = id
            callback(id)
        }
    }
}
