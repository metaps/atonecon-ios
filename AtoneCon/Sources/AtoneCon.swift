//
//  AtoneCon.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit

public protocol AtoneConDelegate: class {
    func atoneCon(atoneCon: AtoneCon, needsPerformAction action: AtoneCon.Action)
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
        delegate?.atoneCon(atoneCon: self, needsPerformAction: Action.willPayment(payment))
        self.payment = payment
        let paymenController = PaymentViewController()
        paymenController.delegate = self
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.present(paymenController, animated: true, completion: nil)
    }

    public func dismissWebview() {
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.dismiss(animated: true, completion: nil)
    }
}

extension AtoneCon: PaymentViewControllerDelegate {
    func controller(_ controller: PaymentViewController, didReceiveEvent event: ScriptsHandler.Event) {
        switch event {
            // TODO: save token
        case .authenticated(_):
            break
        case .failed(_):
            // TODO: Handle message error
            delegate?.atoneCon(atoneCon: self, needsPerformAction: Action.failed(NSError()))
        case .canceled:
            if let payment = payment {
                delegate?.atoneCon(atoneCon: self, needsPerformAction: Action.canceled(payment))
            }
        case .succeeded(_):
            // TODO: Handle succeeded
            if let payment = payment {
                delegate?.atoneCon(atoneCon: self, needsPerformAction: Action.finished(payment, " "))
            }
        }
    }
}

extension AtoneCon {
    public enum Action {
        case willPayment(AtoneCon.Payment)
        case canceled(AtoneCon.Payment)
        case finished(AtoneCon.Payment, String)
        case failed(NSError)
    }
}
