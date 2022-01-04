//
//  RecieptViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

class RecieptViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let locationNames = ["Olive", "Оливье", "Оливье", "Оливье", "Оливье"]
       
	let locationImages = [UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive")]
              
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecieptCard
        
		cell.locationImage.image = locationImages[indexPath.row]
		cell.locationName.text = locationNames[indexPath.row]

        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }

}

class RecieptCard: UICollectionViewCell {
	@IBOutlet weak var locationImage: UIImageView!
	@IBOutlet weak var locationName: UILabel!
}
