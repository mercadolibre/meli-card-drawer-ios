//
//  ComboSwitch.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 29/01/2021.
//

public class ComboSwitchView: UIView, CustomSwitchDelegate {
    
    var switchDidChangeCallback : ((_ selectedOption: String) -> Void)?
    
    public func setSwitchModel(_ switchModel: SwitchModel) {
        print("Override this implementation")
    }
    
    public func setSwitchDidChangeCallback(switchDidChangeCallback: @escaping (_ selectedOption: String) -> Void) {
        self.switchDidChangeCallback = switchDidChangeCallback
    }
    
    func change(to index: Int) {
        print("Override this implementation")
    }
}
