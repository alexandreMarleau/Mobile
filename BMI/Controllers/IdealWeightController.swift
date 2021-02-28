//
//  BMIController.swift
//  BMI
//
//  Created by Mac15 on 2021-02-22.
//

import UIKit

class IdealWeight: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    


    @IBOutlet weak var heightLabel: UILabel!
    
    
    @IBOutlet weak var Button: UIButton!
    
    
    @IBOutlet weak var Date: UIDatePicker!
    @IBOutlet weak var taille: UIPickerView!
    
    var tailleData: [String] = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        taille.selectRow(810, inComponent: 0, animated: true)
        self.taille.delegate = self
        self.taille.dataSource = self
        tailleData = Array(100...210).map{String($0)}
        buttonStyle()
    
        
        

    }
    
    
    @IBAction func Calculate(_ sender: Any) {
        
        let now = Foundation.Date()
        let birthday: Date = Date.date
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let selectedTaille = tailleData[taille.selectedRow(inComponent: 0)]
        
        var idealWeight = ( (Double(selectedTaille)! - 100 + Double(age)/10 ) * 0.9 )
        idealWeight =  (round(100*idealWeight)/100)
        
        let alert = UIAlertController(title: "Ideal weight", message: "\(String(idealWeight)) kg", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        
        self.present(alert, animated: true)
        
    }
    
    func buttonStyle()
    {
        Button.layer.cornerRadius = 5
        Button.layer.borderWidth = 1
        Button.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tailleData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tailleData[row]
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
