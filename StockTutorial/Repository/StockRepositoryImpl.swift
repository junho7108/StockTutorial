import Foundation
import RxSwift
import Alamofire

class StockRepositoryImpl: StockRepository {
    let apiKey: String = "IZEI2Y7NR30L387V"
    let decoder = JSONDecoder()
    
    func fetchStockPublisher(keywords: String) -> Observable<StockResult> {
        return Observable.create { observable -> Disposable in
            
            self.fetchStockPublisher(keywords: keywords) { result in
                switch result {
                case .success(let stockResult):
                    observable.onNext(stockResult)
                    observable.onCompleted()
                    
                case .failure(let error):
                    observable.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

extension StockRepositoryImpl {
    private func fetchStockPublisher(keywords: String, completion: @escaping ((Result<StockResult, Error>) -> Void)) {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(URLError.init(.badURL)))
        }
        
        AF.request(url, method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil, interceptor: nil, requestModifier: nil)
            .responseDecodable(of: StockResult.self) { response in
                
                if let error = response.error {
                    completion(.failure(error))
                }
                
                if let stockResult = response.value {
                    completion(.success(stockResult))
                }
            }
    }
}
