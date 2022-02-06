import RxSwift

class StockListViewModel {
    var loading: BehaviorSubject<Bool> = .init(value: false)
    var errorMessage: BehaviorSubject<String?> = .init(value: nil)
    var stocks: BehaviorSubject<[Stock]> = .init(value: [])
    
    private let disposeBag = DisposeBag()
    
    let usecase: StockUseCase
    
    init(usecase: StockUseCase) {
        self.usecase = usecase
    }
    
    func fetchStocks() {
        loading.onNext(true)
        
        usecase.fetchStocksPublisher(keywords: "AMZ")
            .subscribe(onNext: { stockResult in
                self.stocks.onNext(stockResult.items)
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
            
       
    }
}
