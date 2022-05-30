//
//  CurrencyCell.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter = DateFormatter()
    var currencyRate : CurrencyRate? {
        didSet {
            guard let currencyRate = currencyRate else {
                return
            }
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let date = Date(timeIntervalSince1970: currencyRate.timestamp)
            rateLabel?.text = "\(currencyRate.rate)"
            currencyLabel?.text = currencyRate.currencyIso
            dateLabel?.text = dateFormatter.string(from: date)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
