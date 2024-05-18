//
//  Middleware.swift
//  UDF
//
//  Created by Ivan Semenov on 18.05.2024.
//

public protocol Middleware<State, Intent> {
    associatedtype State
    associatedtype Intent
    
    func handle(state: State, intent: Intent) -> Intent?
}
