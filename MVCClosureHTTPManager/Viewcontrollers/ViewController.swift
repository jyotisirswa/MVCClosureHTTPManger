//
//  ViewController.swift
//  MVCClosureHTTPManager
//
//  Created by Jyoti on 25/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelDownloaded: UILabel!

    var dataDownloaded = 0 {
        didSet {
            DispatchQueue.main.async(execute: {
                [weak self] () -> Void in
                guard let self = self else {return}
                self.labelDownloaded.text = "Objects downloaded : \(self.dataDownloaded)"
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAPICallClicked(_ sender: UIButton) {
        ClosureHTTPManager.shared.getUrl(urlString: baseUrl + breachesExtensionURL, completionBlock: { [weak self] data in
            print("Thread", Thread.current)
            guard let self = self else {
                return
            }
            switch data {
            case .failure(let error) :
                print(error)
            case .success(let data) :
                self.dataDownloaded += data.count
            }
        })
    }
}

