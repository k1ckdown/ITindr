//
//  ProfileState.swift
//  ProfileInterface
//
//  Created by Ivan Semenov on 09.06.2024.
//

enum ProfileState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded(ViewData)

    struct ViewData: Equatable {

    }
}

enum ProfileIntent: Equatable {
    case onAppear
    case editTapped
}
