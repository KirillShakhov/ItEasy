//
//  MenuCard.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 07.01.2022.
//

import UIKit

class MenuCard: UIViewController {
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuList: UICollectionView!
    @IBOutlet weak var menuDescription: UITextView!
    @IBOutlet weak var menuButtonSelect: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.menuList.dataSource = self
		self.menuList.delegate = self
		self.menuList.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCell")
    }
    
    @IBAction func selectMenu() {
        
    }
}

extension MenuCard: UICollectionViewDelegate{
	
}

extension MenuCard: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.image.image = UIImage(named: "olive")
        cell.title.text = "Оливье"
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
	}
	
	
}
