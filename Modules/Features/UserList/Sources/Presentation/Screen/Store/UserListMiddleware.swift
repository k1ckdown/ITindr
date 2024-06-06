//
//  UserListMiddleware.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UDFKit
import Navigation
import CommonDomain
import ProfileDomain

@MainActor
protocol UserListMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToProfile(_ profile: UserProfile)
}

final class UserListMiddleware: Middleware {

    private var users = [UserProfile]()
    private let getUserListUseCase: GetUserListUseCase
    private weak var delegate: UserListMiddlewareDelegate?

    init(getUserListUseCase: GetUserListUseCase, delegate: UserListMiddlewareDelegate?) {
        self.getUserListUseCase = getUserListUseCase
        self.delegate = delegate
    }

    func handle(state: UserListState, intent: UserListIntent) async -> UserListIntent? {
        switch intent {
        case .loadFailed, .dataLoaded: break
        case .onAppear:
            return await getUserList(pagination: .firstPage)
        case .loadMore:
            return checkLoadMoreAvailable(state: state) ? .loadMoreStarted : nil
        case .loadMoreStarted:
            return await loadMore(state: state)
        case .userTapped(let index):
            await handleUserTap(at: index)
        }

        return nil
    }
}

// MARK: - Private methods

private extension UserListMiddleware {

    func handleUserTap(at index: Int) async {
        await delegate?.goToProfile(users[index])
    }

    func loadMore(state: State) async -> UserListIntent? {
        guard case .loaded(let viewData) = state else { return nil }
        return await getUserList(pagination: viewData.pagination)
    }

    func getUserList(pagination: Pagination) async -> UserListIntent {
        do {
            users = try await getUserListUseCase.execute(pagination: pagination)
            return .dataLoaded(users, pagination)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .loadFailed(error.localizedDescription)
        }
    }

    func checkLoadMoreAvailable(state: State) -> Bool {
        guard
            case .loaded(let viewData) = state,
            viewData.isMoreLoading == false,
            viewData.users.count >= viewData.pagination.offset
        else { return false }
        return true
    }
}
