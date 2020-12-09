import UIKit

class StorageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var ProductLists = StorageList()
    var NewListName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.tabBarController?.tabBar.tintColor = CurrentTheme.current.fontColor
        self.tabBarController?.tabBar.barTintColor =  CurrentTheme.current.backgroundColor
        
        ProductLists.addList(named: "fridge")
        ProductLists.ListOfProductLists[0].addProduct(named: "banana", days: 5)
        ProductLists.ListOfProductLists[0].addProduct(named: "apple", days: 1)
        
    }
    
    @IBOutlet weak var navbar: UINavigationItem!
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.backgroundColor = CurrentTheme.current.backgroundColor
        tableView.separatorColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.barTintColor = CurrentTheme.current.backgroundColor
        addButton.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.tintColor = CurrentTheme.current.fontColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CurrentTheme.current.fontColor]
        self.tabBarController?.tabBar.tintColor = CurrentTheme.current.fontColor
        self.tabBarController?.tabBar.barTintColor =  CurrentTheme.current.backgroundColor
        tableView.reloadData()
    }
    
    @IBAction func AddListButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "New List", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        alert.textFields![0].placeholder = "Enter title"
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
            print("Canceled")
        }))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(action) in
            let NewName = alert.textFields![0].text
            self.NewListName = NewName ?? ""
            self.checkForNewList()
        }))
        self.present(alert, animated: true)
    }
    
    func checkForNewList(){
        if NewListName != "" && NewListName != nil
        {
            ProductLists.addList(named: NewListName!)
            NewListName = nil
            tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? StorageListViewController
        let cell = sender as? UITableViewCell
        destination!.ProdList = ProductLists.ListOfProductLists[tableView.indexPath(for: cell!)!.row]
    }
}

extension StorageViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showList", sender: tableView.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductLists.ListOfProductLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ProductLists.ListOfProductLists[indexPath.row].NameOfList
        cell.backgroundColor = CurrentTheme.current.backgroundColor
        cell.textLabel?.textColor = CurrentTheme.current.fontColor
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ProductLists.ListOfProductLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            ProductLists.addList(named: "Default")
        }
    }
    
}
