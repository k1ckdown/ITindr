//
//  Reducer.swift
//  UDF
//
//  Created by Ivan Semenov on 18.05.2024.
//

public protocol Reducer<State, Intent> {
    associatedtype State
    associatedtype Intent
    
    func reduce(state: inout State, intent: Intent)
}
