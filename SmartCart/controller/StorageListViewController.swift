import UIKit

class StorageListViewController: UIViewController {

    
    private let cellIdentifier = String(describing: StorageListTableViewCell.self)
    var ProdList: ProductsList?
    var NewProductName: String?
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ProdList?.NameOfList
        
        tableView.delegate = self
        tableView.dataSource = self
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tableView.tableFooterView = footer
        
        tableView.backgroundColor = CurrentTheme.current.backgroundColor
        tableView.separatorColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.barTintColor = CurrentTheme.current.backgroundColor
        addButton.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CurrentTheme.current.fontColor]
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.backgroundColor = CurrentTheme.current.backgroundColor
        tableView.separatorColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.barTintColor = CurrentTheme.current.backgroundColor
        addButton.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CurrentTheme.current.fontColor]
        tableView.reloadData()
    }
    
    @IBAction func AddProductButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "New product", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        alert.textFields![0].placeholder = "Enter title"
        alert.textFields![1].placeholder = "Days to date expire"
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
            print("Canceled")
        }))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(action) in
            let days = alert.textFields![1].text ?? ""
            self.NewProductName = alert.textFields![0].text ?? ""
            self.checkForNewProduct(days: days)
        }))
        self.present(alert, animated: true)
    }
    
    func checkForNewProduct(days: String){
        if NewProductName != "" && NewProductName != nil && ((Int(days)) != nil)
        {
            ProdList?.addProduct(named: NewProductName!, days: Int(days)!)
            NewProductName = nil
            tableView.reloadData()
        }
    }

}

extension StorageListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Change product", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        alert.textFields![0].placeholder = self.ProdList?.ProductList[indexPath.row].Name
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
            print("Canceled")
        }))
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: {(action) in
            self.ProdList?.ProductList[indexPath.row].Name = ((alert.textFields![0].text ?? self.ProdList?.ProductList[indexPath.row].Name)!)
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ProdList?.ProductList.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StorageListTableViewCell else {
            fatalError("Can't find StorageListTableViewCell")
        }
        cell.titleLabel?.text = ProdList?.ProductList[indexPath.row].Name
        cell.quantityLabel?.text = String((ProdList?.ProductList[indexPath.row].quantity)!)
        cell.rowIndex = indexPath.row
        cell.delegate = self
        cell.backgroundColor = CurrentTheme.current.backgroundColor
        cell.tintColor = CurrentTheme.current.fontColor
        cell.titleLabel?.textColor = CurrentTheme.current.fontColor
        cell.inreaseButton?.tintColor = CurrentTheme.current.fontColor
        cell.reduceButton?.tintColor = CurrentTheme.current.fontColor
        cell.quantityLabel?.textColor = CurrentTheme.current.fontColor
        cell.layer.cornerRadius = 1
        let days = (ProdList?.ProductList[indexPath.row].daysToExpire)!
        let imgName = String(days)+".circle"
        if(days <= Settings.expireTime_2)
        {
            cell.expirationState.setImage(UIImage(systemName: imgName), for: .normal)
            cell.expirationState.tintColor = UIColor.red
        }else if(days <= Settings.expireTime_1())
        {
            cell.expirationState.setImage(UIImage(systemName: imgName), for: .normal)
            cell.expirationState.tintColor = UIColor.blue
        }else
        {
            if days <= 50 {
                cell.expirationState.setImage(UIImage(systemName: imgName), for: .normal)
            }else {
                cell.expirationState.setImage(UIImage(systemName: "circle"), for: .normal)
            }
            cell.expirationState.tintColor = UIColor.green
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ProdList?.ProductList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //
        }
    }

}

extension StorageListViewController: StorageListViewCellTableViewCellDelegate
{
    func pressedDeleteButton(for cellIndex: Int) {
        ProdList?.ProductList[cellIndex].decreaseQuantity()
        tableView.reloadData()
    }
    
    func pressedIncreaseButton(for cellIndex: Int) {
        ProdList?.ProductList[cellIndex].increaseQuantity()
        tableView.reloadData()
    }
    
    
}
