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
    
    
    @IBAction func goBack(_ sender: Any) {
        
    }
    
    @IBAction func goNext(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
