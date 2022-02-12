import RxSwift

class StockUseCase {
    
    private let stockRepository: StockRepository
    
    init(stockRepository: StockRepository) {
        self.stockRepository = stockRepository
    }
    
    func fetchStocksPublisher(keywords: String) -> Observable<StockResult> {
        return self.stockRepository.fetchStockPublisher(keywords: keywords)
    }
}
