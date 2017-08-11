//
//  AtoneCon.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/30/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//
import Foundation
import ObjectMapper
import SAMKeychain

public protocol AtoneConDelegate: class {
    func atoneCon(atoneCon: AtoneCon, didReceivePaymentEvent event: AtoneCon.PaymentEvent)
}

final public class AtoneCon {

    // MARK: - Singleton
    public static let shared = AtoneCon()

    // MARK: - Properties
    internal var option = Options()
    public weak var delegate: AtoneConDelegate?
    fileprivate var payment: Payment?
    var paymenController: PaymentViewController!

    // MARK: - Public Functions
    public func config(_ option: Options) {
        self.option = option
    }

    public func performPayment(_ payment: Payment) {
        let root = UIApplication.shared.delegate?.window??.rootViewController
        guard NetworkReachabilityManager()?.isReachable == true else {
            let error: [String: Any] = ["name": Define.Strings.network,
                                        "title": Define.Strings.Error.network]
            let event = PaymentEvent.failed(error)
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: event)
            return
        }
        self.payment = payment
        paymenController = PaymentViewController(payment: payment)
        let paymentNavigation = UINavigationController(rootViewController: paymenController)
        paymenController.delegate = self
        root?.present(paymentNavigation, animated: true, completion: nil)
    }

    public func dismissWebview() {
        let root = UIApplication.shared.delegate?.window??.rootViewController
        root?.dismiss(animated: true, completion: nil)
    }

    public func resetAuthenToken() {
        Session.shared.clearCredential()
    }

    public func showError(title: String?, message: String?) {
        paymenController.showError(title: title, message: message)
    }
}

extension AtoneCon {
    public enum PaymentEvent {
        case authenticated(String?)
        case cancelled
        case finished([String: Any]?)
        case failed([String: Any]?)
        case error([String: Any]?)
    }
}

extension AtoneCon: PaymentViewControllerDelegate {
    func controller(_ controller: PaymentViewController, didReceiveScriptEvent event: ScriptEvent) {
        switch event {
        case .authenticated(let authenToken):
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .authenticated(authenToken))
        case .failed(let response):
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .failed(response))
        case .cancelled:
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .cancelled)
        case .succeeded(let response):
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .finished(response))
        case .error(let response):
            delegate?.atoneCon(atoneCon: self, didReceivePaymentEvent: .error(response))
        }
    }
}
