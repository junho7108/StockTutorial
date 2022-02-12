import RxSwift

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    private(set) var loading: BehaviorSubject<Bool> = .init(value: false)
    
    private(set) var errorMessage: BehaviorSubject<String?> = .init(value: nil)
}
