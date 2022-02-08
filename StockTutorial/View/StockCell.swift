import UIKit

class StockCell: UITableViewCell {
    
    static let identifier = "StockCellIdentifier"
    
    let symbolLabel = TitleLabel()
    let descriptionLabel = NormalGrayLabel()
    let companyNameLabel = NormalLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(symbolLabel)
        symbolLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom).offset(12)
            make.leading.equalTo(symbolLabel)
            make.bottom.equalToSuperview().inset(12)
        }
        
        contentView.addSubview(companyNameLabel)
        companyNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(item: Stock) {
        symbolLabel.text = item.symbol
        descriptionLabel.text = "\(item.type ?? "") / \(item.currency ?? "")"
        companyNameLabel.text = item.name
    }
}
