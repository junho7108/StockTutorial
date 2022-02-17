import RxSwift
import RxCocoa

open class RxTextFieldDelegateProxy
: DelegateProxy<UITextField, UITextFieldDelegate>,
  DelegateProxyType,
  UITextFieldDelegate {
    
    public weak private(set) var textField: UITextField?
    
    public static func registerKnownImplementations() {
        register(make: RxTextFieldDelegateProxy.init)
    }
    
    public static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
    }
    
    public init(textField: ParentObject) {
        self.textField = textField
        super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
    }
    
    @objc open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return forwardToDelegate()?.textFieldShouldReturn?(textField) ?? true
    }
    
    @objc open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return forwardToDelegate()?.textFieldShouldClear?(textField) ?? true
    }
}
