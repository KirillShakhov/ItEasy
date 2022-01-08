//
//  Menu.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 07.01.2022.
//

import UIKit

class MenuList: UIViewController {
	private let refreshControl = UIRefreshControl()

    @IBOutlet weak var menuList: UICollectionView!
    
	var menus: [MenuModel.Menu] = []
	var selectMenuId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.menuList.delegate = self
		self.menuList.dataSource = self
		menuList.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")

		
		
		refreshControl.layer.zPosition = -1
		menuList.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(updateMenus(_:)), for: .valueChanged)
		
		refreshControl.tintColor = UIColor(red:0.25, green:0.85, blue:0.25, alpha:0.6)
		refreshControl.attributedTitle = NSAttributedString(string: "Update Menu ...")

		menus = MenuModel.getMenu()
		selectMenuId = MenuModel.getSelectedMenu()
		updateMenus(self)
    }
	
	@objc func updateMenus(_ sender: Any) {
		menus = MenuModel.getMenu()
		selectMenuId = MenuModel.getSelectedMenu()
		self.refreshControl.endRefreshing()
		menuList.reloadData()
		print("Updated")
	}
	
	static func selectMenu(id:Int) -> Bool{
		return MenuModel.setSelectedMenu(id: id)
	}

}

extension MenuList: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return menus.count
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "MenuCard", bundle: nil)
		guard let vc = storyboard.instantiateViewController(identifier: "MenuCard") as? MenuCard else { return }
		let menu = menus[indexPath.item]
		vc.selectMenuId = selectMenuId
		vc.menuView = self
		vc.menu = menu
		vc.modalPresentationStyle = .popover
		present(vc, animated:true)
	}
}

extension MenuList: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
		let menu = menus[indexPath.item]
		cell.menuList = self
		cell.menuName.text = menu.name
		if(cell.imageURL != menu.image){
			cell.activityIndicator.isHidden = false
			cell.menuImage.image = nil
			cell.imageURL = menu.image
			DispatchQueue.global().async {
				if let data = try? Data(contentsOf: URL(string: menu.image)!) {
					if let image = UIImage(data: data) {
						DispatchQueue.main.async {
							cell.menuImage.image = image
							cell.activityIndicator.isHidden = true
						}
					}
				}
			}
		}
		cell.menu = menu
		if(menu.id == selectMenuId){
			cell.selectButton.setTitle("Selected", for: .normal)
			cell.selectButton.backgroundColor = UIColor.clear
		}
		else{
			cell.selectButton.setTitle("Select", for: .normal)
			cell.selectButton.backgroundColor = UIColor(rgb: 0x9AC39D)
		}
		return cell
	}
}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
	   assert(red >= 0 && red <= 255, "Invalid red component")
	   assert(green >= 0 && green <= 255, "Invalid green component")
	   assert(blue >= 0 && blue <= 255, "Invalid blue component")

	   self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
	   self.init(
		   red: (rgb >> 16) & 0xFF,
		   green: (rgb >> 8) & 0xFF,
		   blue: rgb & 0xFF
	   )
   }
}
