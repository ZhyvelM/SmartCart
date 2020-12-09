import UIKit

protocol StorageListViewCellTableViewCellDelegate: class {
    func pressedDeleteButton(for cellIndex: Int)
    func pressedIncreaseButton(for cellIndex: Int)
}

class StorageListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var reduceButton: UIButton?
    @IBOutlet weak var inreaseButton: UIButton?
    @IBOutlet weak var quantityLabel: UILabel?
    @IBOutlet weak var expirationState: UIButton!
    @IBOutlet weak var addToGrocerryList: UIButton!
    
    var rowIndex: Int?
    weak var delegate: StorageListViewCellTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addToGroceryList(_ sender: Any) {
        
    }
    
    @IBAction func reduceButtonPressed(_ sender: UIButton) {
        guard let index = rowIndex else {
            return
        }
        delegate?.pressedDeleteButton(for: index)
    }
    
    @IBAction func increaseButtonPressed(_ sender: UIButton){
        guard let index = rowIndex else {
            return
        }
        delegate?.pressedIncreaseButton(for: index)
    }
}
