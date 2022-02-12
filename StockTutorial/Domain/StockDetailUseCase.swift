import RxSwift

class StockDetailUseCase {
    
    private let stockRepository: StockRepository
    
    init(stockRepository: StockRepository) {
        self.stockRepository = stockRepository
    }
    
    func fetchTimeSeriesPublisher(keywords: String) -> Observable<TimeSeriesMonthlyAdjusted> {
        return stockRepository.fetchTimeSeriesPublisher(keywords: keywords)
    }
}
