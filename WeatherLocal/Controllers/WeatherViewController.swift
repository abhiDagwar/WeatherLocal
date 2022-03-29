//
//  WeatherViewController.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 29/03/22.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var forecastSummary: UILabel!
    
    var latitute: String?
    var longitute: String?
    
    lazy var viewModel = {
        WeatherDataViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let latitute = latitute else {
            return
        }

        guard let longitute = longitute else {
            return
        }

        viewModel.fetchWeatherDataForLocation(lat: latitute, lon: longitute)
        
        viewModel.locationName.bind { [weak self] locationName in
            self?.cityLabel.text = locationName
        }
        viewModel.state.bind { [weak self] state in
            self?.stateLabel.text = state
        }
        viewModel.date.bind { [weak self] date in
            self?.dateLabel.text = date
        }
        viewModel.icon.bind { [weak self] icon in
            self?.currentIcon.image = UIImage(named: icon)
        }
        viewModel.summary.bind { [weak self] summary in
            self?.currentSummaryLabel.text = summary
        }
        viewModel.forcastSummary.bind { [weak self] forecastSummary in
            self?.forecastSummary.text = forecastSummary
        }
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
