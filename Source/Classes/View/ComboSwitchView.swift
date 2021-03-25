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
        
        switchControl.setButtonTitles(buttonTitles: switchModel.options.map { $0.name })
        switchControl.delegate = self
        
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
