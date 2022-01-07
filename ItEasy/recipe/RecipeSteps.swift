//
//  RecipeSteps.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import UIKit

class RecipeSteps: UIViewController {
    
    @IBOutlet weak var currentStep: UILabel!
    @IBOutlet weak var allSteps: UILabel!
    @IBOutlet weak var stepImage: UIImageView!
    
    @IBOutlet weak var stepText: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	var recipe: Recipes.Recipe?
	
	@IBOutlet weak var shadowImageView: ShadowView!
	
	var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
		updateStep()
    }
	
	func updateStep(){
		if(recipe != nil && recipe?.steps != nil){
			if(recipe!.steps!.count>0){
				if(count == 1) {
					backButton.isHidden = true
				}
				else{
					backButton.isHidden = false
				}
				if(count == recipe?.steps?.count) {
					nextButton.isHidden = true
				}
				else{
					nextButton.isHidden = false
				}
				currentStep.text = String(count)
				allSteps.text = String(recipe!.steps!.count)
				
				let index = self.count-1
				stepText.text = recipe!.steps![index].text
				if(self.recipe?.steps![index].image != nil && self.recipe?.steps![index].image != ""){
					self.activityIndicator.isHidden = false
					self.shadowImageView.isHidden = false
					self.stepImage.image = nil
					DispatchQueue.global().async {
							if let data = try? Data(contentsOf: URL(string: self.recipe!.steps![index].image!)!) {
								if let image = UIImage(data: data) {
									DispatchQueue.main.async {
										self.stepImage.image = image
										self.activityIndicator.isHidden = true
										self.shadowImageView.isHidden = false
									}
								}
							}
						
					}
				}
				else{
					self.shadowImageView.isHidden = true
				}
				
			}
			else{
				stepText.text = "Нет данных"
				shadowImageView.isHidden = true
				backButton.isHidden = true
				nextButton.isHidden = true
				currentStep.text = "0"
				allSteps.text = "0"
			}
		}
		else{
			stepText.text = "Нет данных"
			shadowImageView.isHidden = true
			backButton.isHidden = true
			nextButton.isHidden = true
			currentStep.text = "0"
			allSteps.text = "0"
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
	}
    
	@IBAction func goBack(_ sender: Any) {
        if(count != 1) {
            count=count-1
            updateStep()
        }
	}
	
	@IBAction func goNext(_ sender: Any) {
        if(count != recipe?.steps?.count) {
            count=count+1
            updateStep()
        }
	}
}
