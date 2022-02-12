import UIKit
import Pure

class StockDetailController: BaseViewController, FactoryModule {
    
    struct Dependency {
        let stock: Stock
    }
    
    let stock: Stock
    let selfView = StockDetailView()
    
    //MARK: - Lifecycle
    
    required init(dependency: Dependency, payload: ()) {
        self.stock = dependency.stock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        enableScrollWhenKeyboardAppeared(scrollView: selfView.scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeListeners()
    }
    
    //MARK: - Configure
    
    override func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Detail"
        
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
