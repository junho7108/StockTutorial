import RxSwift

class StockDetailViewModel: BaseViewModel {
    
    let usecase: StockDetailUseCase
    
    var timeSeriesAdjusted: BehaviorSubject<TimeSeriesMonthlyAdjusted?> = .init(value: nil)

    
    init(usecase: StockDetailUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    func fetchTimeSeries(symbol: String) {
        loading.onNext(true)
        
        usecase.fetchTimeSeriesPublisher(keywords: symbol)
            .subscribe { [unowned self] value in
                var timeSeriesMonthlyAdjusted = value
                timeSeriesMonthlyAdjusted.generateMonthInfos()
    
                self.timeSeriesAdjusted.onNext(timeSeriesMonthlyAdjusted)
                self.loading.onNext(false)
    
            } onError: { [unowned self] error in
                self.errorMessage.onNext(error.localizedDescription)
                self.loading.onNext(false)
            }
            .disposed(by: disposeBag)
    }
}
