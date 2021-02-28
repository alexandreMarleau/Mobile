//
//  BMIController.swift
//  BMI
//
//  Created by Mac15 on 2021-02-22.
//

import UIKit

class BMIController: UIViewController,  UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var HeightLabel: UILabel!
    @IBOutlet weak var SliderHeight: UISlider!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var SliderWeight: UISlider!
    @IBOutlet weak var BMIStatTable: UITableView!
    
    // Data model: These strings will be the data for the table view cells
    let classWeight: [String] = ["Severely underweight", "underweight", "Normal", "Overweight", "Obese Class I", "Obese Class II", "Obese Class III"]
    let weight: [String] = ["< 16", "16 - 18.5", "18.5 - 25", "25-30", "30 - 35", "35 - 40", "> 40"]
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    let colorGradient: [String] = ["#ffc9bd88", "#ffb7a688", "#ffb19e88", "#ff806188", "#ff5f3888", "#fa471b88", "#ff320088"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SliderWeight.minimumValue = 40
        SliderWeight.maximumValue = 120
        SliderHeight.maximumValue = 210
        SliderHeight.minimumValue = 100
        HeightLabel.text = String((SliderHeight.maximumValue + SliderHeight.minimumValue) / 2)
        SliderHeight.value = (SliderHeight.maximumValue + SliderHeight.minimumValue) / 2
        WeightLabel.text = String((SliderWeight.maximumValue + SliderWeight.minimumValue) / 2)
        SliderWeight.value = (SliderWeight.maximumValue + SliderWeight.minimumValue) / 2
        
        
        
        self.BMIStatTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        BMIStatTable.delegate = self
        BMIStatTable.dataSource = self
               
     
    }
    

    @IBAction func CalculateBMI(_ sender: Any) {
        let height = Float(HeightLabel.text!)
        let weight = Float(WeightLabel.text!)
        let bmi = weight!/((pow((height!/100), 2)))
        print(pow(height!, 2))
        BMILabel.text = String(bmi)
        
        //Select Row
        let indexPath = IndexPath(row: findRow(bmi: bmi), section: 0)
        colorReset()
        self.BMIStatTable.cellForRow(at: indexPath)?.backgroundColor = UIColor(hex: "#FFE666ff")
        
    }
    @IBAction func SliderHeight(_ sender: Any) {
        
        let currentValue = Int(SliderHeight.value)
     
        HeightLabel.text = String(currentValue)
    }
    @IBAction func Slider(_ sender: Any) {
        var currentValue = Float(SliderWeight.value)
        currentValue = Float(round(100*currentValue)/100)
        WeightLabel.text = String(currentValue)
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classWeight.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        var cell:UITableViewCell = (self.BMIStatTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.textLabel?.textAlignment = .center
        cell = UITableViewCell(style: UITableViewCell.CellStyle.value1,reuseIdentifier: cellReuseIdentifier)
        cell.textLabel?.textAlignment = .center
        cell.detailTextLabel?.text = self.weight[indexPath.row]

        cell.textLabel?.text = self.classWeight[indexPath.row]
        
        cell.backgroundColor = UIColor(hex: self.colorGradient[indexPath.row])
        
       
        
        return cell
    }
    
    func findRow(bmi: Float) -> Int{
     
        switch bmi {
        case 0...15:
            return 0
        case 16...18.5 :
            return 1
        case 18.6...25:
            return 2
        case 26...30:
            return 3
        case 31...35:
            return 4
        case 36...40:
            return 5
        case 41...:
            return 6
        default:
            return 3
        }
    }
    
    func colorReset (){
        var counter: Int = 0
        for cell: UITableViewCell in self.BMIStatTable.visibleCells{
            
            cell.backgroundColor = UIColor(hex: self.colorGradient[Int(counter) ])
            counter += 1
            
        }
    }

    
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
    

