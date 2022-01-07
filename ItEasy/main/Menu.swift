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

    override func viewDidLoad() {
        super.viewDidLoad()
		self.menuList.delegate = self
		self.menuList.dataSource = self
		menuList.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")

		menus = MenuModel.getMenu()
		
		
		refreshControl.layer.zPosition = -1
		menuList.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(updateRecipes(_:)), for: .valueChanged)
		
		refreshControl.tintColor = UIColor(red:0.25, green:0.85, blue:0.25, alpha:0.6)
		refreshControl.attributedTitle = NSAttributedString(string: "Update Menu ...")

    }
	
	@objc private func updateRecipes(_ sender: Any) {
		menus = MenuModel.getMenu()
		self.refreshControl.endRefreshing()
		menuList.reloadData()
		print("Updated")
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

		vc.menu = menu
		vc.modalPresentationStyle = .popover
		present(vc, animated:true)
	}
}

extension MenuList: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
		let menu = menus[indexPath.item]
		cell.menu = menu
		cell.menuName.text = menu.name
		cell.menuImage.image = nil
		cell.activityIndicator.isHidden = false
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
		return cell
	}
}
