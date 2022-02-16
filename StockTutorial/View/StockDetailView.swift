import UIKit

class StockDetailView: BaseView {
    
    let scrollView = UIScrollView()
    
    let loadingView = LoadingView()
    
    let topView = StockDetailTopView()
    
    let bottomView = StockDetailBottomView()
    
    
    override func configureUI() {
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
