//
//  PaymentViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit

final internal class PaymentViewController: UIViewController {

    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupWebView()
        setupCancelButton()
    }

    private func setupWebView() {
        var frame = view.bounds
        frame.origin.y += 20
        webView = WKWebView(frame: frame)
        view.addSubview(webView)
        webView.loadHTMLString(htmlContent(), baseURL: nil)
        injectScripts()
    }

    private func setupCancelButton() {
        let cancelButton = UIButton()
        let origin = CGPoint(x: 0, y: 20)
        cancelButton.frame.origin = origin
        cancelButton.setTitle(Define.String.cancel, for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.sizeToFit()
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }

    @objc private func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func injectScripts() {
        let controller = webView.configuration.userContentController
        controller.addUserScript(userScript())
    }

    private func htmlContent() -> String {
        do {
            let url = self.url(forResource: "atone", withExtension: "html")
            let string = try String(contentsOf: url)
            return string
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func userScript() -> WKUserScript {
        do {
            let url = self.url(forResource: "atone", withExtension: "js")
            let source = try String(contentsOf: url, encoding: .utf8)
            let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            return userScript
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func url(forResource name: String?, withExtension ext: String?) -> URL {
        let bundle = Bundle(for: PaymentViewController.self)
        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            fatalError("File Not Found")
        }
        return url
    }
}
