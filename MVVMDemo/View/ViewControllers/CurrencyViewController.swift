//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView! 
    let refreshControl = UIRefreshControl()
    let dataSource = CurrencyDataSource()
    
    lazy var viewModel : CurrencyViewModel = {
        let viewModel = CurrencyViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Currencies"
        
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
        
        // add error handling example
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error ?
            self?.refreshControl.endRefreshing()
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        
        self.viewModel.fetchCurrencies()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        self.viewModel.fetchCurrencies()
    }
}

extension CurrencyViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyConverterViewController") as! CurrencyConverterViewController
        vc.selectedCurrency = self.dataSource.data.value[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
