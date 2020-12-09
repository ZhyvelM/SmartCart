import UIKit

protocol GroceryListViewCellTableViewCellDelegate: class {
    func pressedDeleteButton(for cellIndex: Int)
    func pressedIncreaseButton(for cellIndex: Int)
}

class GroceryListViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var reduceButton: UIButton?
    @IBOutlet weak var inreaseButton: UIButton?
    @IBOutlet weak var quantityLabel: UILabel?
    
    var rowIndex: Int?
    weak var delegate: GroceryListViewCellTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
