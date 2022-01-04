//
//  RecieptViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

class RecieptViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var recipeList: UICollectionView!
    
    let locationNames = ["Olive", "Оливье", "Оливье", "Оливье", "Оливье"]
       
	let locationImages = [UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive")]
              
    
    override func viewDidLoad() {
        super.viewDidLoad()
				
	
	
		self.recipeList.register(UINib(nibName: "RecieptCell", bundle: nil), forCellWithReuseIdentifier: "RecieptCell")

		self.recipeList.dataSource = self
		self.recipeList.delegate = self
		
		
        // Do any additional setup after loading the view.
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecieptCell", for: indexPath) as! RecieptCell
        
		cell.image.image = locationImages[indexPath.item]
		cell.title.text = locationNames[indexPath.item]

        
        //This creates the shadows and modifies the cards a little bit
//        cell.contentView.layer.cornerRadius = 4.0
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = indexPath.item
        print(id)
        
		let storyboard = UIStoryboard(name: "RecipeCard", bundle: nil)
		
		guard let vc = storyboard.instantiateViewController(identifier: "RecipeCard") as? RecipeCard else { return }
		vc.itemName = locationNames[indexPath.item]
		vc.itemImage = locationImages[indexPath.item]

//		let vc = storyboard.instantiateViewController(withIdentifier: "RecipeCard")
		vc.modalPresentationStyle = .fullScreen
		
//		self.navigationController?.pushViewController(vc, animated: true)
		present(vc, animated:true)
		
	}
}
