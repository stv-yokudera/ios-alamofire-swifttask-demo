//
//  ViewController.swift
//  ios-alamofire-swifttask-demo
//
//  Created by OkuderaYuki on 2018/05/03.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        requestAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func requestAPI() {
        let request = ITunesSearchRequest(term: "コブクロ")

        APIClient.request(request: request)
            .success { result in
                Logger.debug(message: "result: \(result)")

            }.failure { error in
                Logger.debug(message: "error: \(error)")

            }.then { _, _ in
                Logger.debug(message: "done")
        }
    }
}
