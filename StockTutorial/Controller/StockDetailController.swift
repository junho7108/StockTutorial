import UIKit
import Pure

class StockDetailController: BaseViewController, FactoryModule {
    
    struct Dependency {
        let stock: Stock
    }
    
    let stock: Stock
    
    //MARK: - Lifecycle
    
    required init(dependency: Dependency, payload: ()) {
        self.stock = dependency.stock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    override func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Detail"
    }
}
