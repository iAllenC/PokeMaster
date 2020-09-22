//
//  RegisterRequest.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import Combine

struct RegisterRequest {
    
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError> {
        
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                if password.count > 6 {
                    promise(.success(User(email: email, favoritePokemonIDs: [])))
                } else {
                    promise(.failure(.passwordWrong))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}
