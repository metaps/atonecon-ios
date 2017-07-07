//
//  AtoneCon.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit

public protocol AtoneConDelegate: class {
    func atoneCon(atoneCon: AtoneCon, willPerformPayment payment: AtoneCon.Payment)
    func atoneCon(atoneCon: AtoneCon, didCancelPayment payment: AtoneCon.Payment)
    func atoneCon(atoneCon: AtoneCon, didFailureWithError error: NSError)
    func atoneCon(atoneCon: AtoneCon, didFinishPayment payment: AtoneCon.Payment, transactionToken: String)
}

final public class AtoneCon {

    // MARK: - Singleton
    public static let shared = AtoneCon()

    // MARK: - Properties
    private var option = Options()
    public weak var delegate: AtoneConDelegate?
    fileprivate var payment: Payment?

    // MARK: - Public Functions
    public func config(_ option: Options) {
        // TODO: Config public key
        self.option = option
    }

    public func performPayment(_ payment: Payment) {
        delegate?.atoneCon(atoneCon: self, willPerformPayment: payment)
        self.payment = payment
        let paymenController = PaymentViewController()
        paymenController.delegate = self
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.present(paymenController, animated: true, completion: nil)
    }
}

extension AtoneCon: PaymentViewControllerDelegate {
    func controller(_ controller: PaymentViewController, needsPerformAction action: ScriptsHandler.Action) {
        switch action {
            // TODO: save token
        case .authenticated(_):
            break
        case .failed(_):
            // TODO: Handle message error
            delegate?.atoneCon(atoneCon: self, didFailureWithError: NSError())
        case .canceled:
            if let payment = payment {
                delegate?.atoneCon(atoneCon: self, didCancelPayment: payment)
            }
        case .succeeded(_):
            // TODO: Return respone from webView
            if let payment = payment {
                delegate?.atoneCon(atoneCon: self, didFinishPayment: payment, transactionToken: "")
            }
        }
    }
}
