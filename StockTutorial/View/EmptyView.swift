import UIKit

class EmptyView: BaseView {
    
    let descriptionLabel: NormalLabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        descriptionLabel.text = "This is no any contents."
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
