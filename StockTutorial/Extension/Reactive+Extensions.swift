import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    
    public var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxTextFieldDelegateProxy.proxy(for: base)
    }
    
    public var shouldReturn: ControlEvent<Void> {
        let proxy = base.createRxDelegateProxy()
        let source = delegate.rx.methodInvoked(#selector(proxy.textFieldShouldReturn(_:)))
            .debug(#function)
            .map { _ in }
        
        return ControlEvent(events: source)
    }
    
    public var shouldClear: ControlEvent<Void> {
        let proxy = base.createRxDelegateProxy()
        let source = delegate.rx.methodInvoked(#selector(proxy.textFieldShouldClear(_:)))
            .map { _ in }
        
        return ControlEvent(events: source)
    }
}
