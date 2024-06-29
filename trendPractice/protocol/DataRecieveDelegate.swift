//
//  DataRecieve.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import Foundation

protocol DataReceiveDelegate {
    func receiveData<T>(data: T)
}
