//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String
    var publisher: AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if self.email.lowercased() == "onevcat@gmail.com" {
                    promise(.success(false))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
