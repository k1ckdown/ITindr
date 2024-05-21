//
//  Store.swift
//  UDF
//
//  Created by Ivan Semenov on 18.05.2024.
//

import SwiftUI

public typealias StoreOf<R: Reducer> = Store<R.State, R.Intent>

public final class Store<State, Intent>: ObservableObject {
    public typealias AnyReducer = any Reducer<State, Intent>
    public typealias AnyMiddleware = any Middleware<State, Intent>
    
    @Published public private(set) var state: State
    
    private let reducer: AnyReducer
    private let middleware: AnyMiddleware
    
    public init(initialState: State, reducer: AnyReducer, middleware: AnyMiddleware) {
        state = initialState
        self.reducer = reducer
        self.middleware = middleware
    }
    
    @MainActor
    public func dispatch(_ intent: Intent) {
        reducer.reduce(state: &state, intent: intent)
        Task { await intercept(intent) }
    }
    
    private func intercept(_ intent: Intent) async {
        guard let intent = await middleware.handle(state: state, intent: intent) else { return }
        await dispatch(intent)
    }
}
