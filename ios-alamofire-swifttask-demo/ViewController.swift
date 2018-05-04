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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func requestAPI() {
        let request = ITunesSearchRequest(term: "コブクロ")

        request.sendAPIRequest()
            .success { result in
                Logger.debug(message: "ITunesSearchRequest sendAPIRequest(): success")
                Logger.debug(message: "result: \(result)")

            }.failure { error in
                Logger.debug(message: "ITunesSearchRequest sendAPIRequest(): failure")
                Logger.debug(message: "error: \(error)")

                if let iTunesSearchError = error.error {
                    Logger.debug(message: "error message: \(iTunesSearchError.message)")
                }

            }.then { _, _ in
                Logger.debug(message: "done")
        }
    }
}
