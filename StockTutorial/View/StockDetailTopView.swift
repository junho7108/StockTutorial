import UIKit

class StockDetailTopView: BaseView {
    
    let titleLabel = TitleLabel()
    let subtitleLabel = NormalGrayLabel()
    let currentValueTextLabel = SmallLabel()
    let currentValueValueLabel = TitleLabel()
    let investmentLabel = SmallLabel()
    let investmentValueLabel = SmallBoldLabel()
    let gainLabel = SmallLabel()
    let gainValueLabel = SmallBoldLabel()
    let annualReturnLabel = SmallLabel()
    let annualReturnValueLabel = SmallBoldLabel()
    
    override func configureUI() {
        
        titleLabel.text = "SPY"
        subtitleLabel.text = "S&P 500 ETF"
        currentValueValueLabel.text = "Current Value (USD)"
        currentValueValueLabel.text = "5000"
        investmentLabel.text = "Investment ammount"
        investmentValueLabel.text = "USD 100"
        gainLabel.text = "Gain"
        gainValueLabel.text = "+100.25 (+10.25%)"
        annualReturnLabel.text = "Annual Return"
        annualReturnValueLabel.text = "10.5%"
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        addSubview(currentValueTextLabel)
        currentValueTextLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        addSubview(currentValueValueLabel)
        currentValueValueLabel.snp.makeConstraints { make in
            make.top.equalTo(currentValueTextLabel.snp.bottom).offset(10)
            make.leading.equalTo(currentValueTextLabel.snp.leading)
        }
        
        addSubview(investmentLabel)
        investmentLabel.snp.makeConstraints { make in
            make.top.equalTo(currentValueValueLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        addSubview(investmentValueLabel)
        investmentValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(investmentLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(gainLabel)
        gainLabel.snp.makeConstraints { make in
            make.top.equalTo(investmentValueLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        addSubview(gainValueLabel)
        gainValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(gainLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(annualReturnLabel)
        annualReturnLabel.snp.makeConstraints { make in
            make.top.equalTo(gainValueLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        addSubview(annualReturnValueLabel)
        annualReturnValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(annualReturnLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
