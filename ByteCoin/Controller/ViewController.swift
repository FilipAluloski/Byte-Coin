
import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    var selectedCurrency: String = ""
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    
}
    
//MARK: - UIPickerView

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}
  


//MARK: - CoinManagerDelegate
    
extension ViewController: CoinManagerDelegate{
    func didUpdatePrice(_ coinManager: CoinManager, price: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", price)
            self.currencyLabel.text = self.selectedCurrency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}





