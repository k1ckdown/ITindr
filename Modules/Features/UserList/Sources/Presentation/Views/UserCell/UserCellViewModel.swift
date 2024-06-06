//
//  UserCellViewModel.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

struct UserCellViewModel: Equatable {
    let name: String
    let avatarUrl: String?
}

extension UserCellViewModel {

    static let mock: [UserCellViewModel] = [
        .init(name: "Max", avatarUrl: "https://zoomd.com/wp-content/uploads/2020/09/man-avatar-profile-vector-21372076.jpg"),
        .init(name: "Gladys", avatarUrl: "https://ru-static.z-dn.net/files/ddd/02bd3a23f077cda4cc1843b6467a4db1.jpg"),
        .init(name: "Victoria", avatarUrl: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg"),
        .init(name: "Colleen", avatarUrl: "https://i.pinimg.com/originals/ad/ee/82/adee824009382c7dfeaf002698dc02a1.png"),
        .init(name: "Philip", avatarUrl: "https://i.pinimg.com/originals/01/c7/b1/01c7b181419e15cc614b2297a0e0b959.jpg"),
        .init(name: "Mitchell", avatarUrl: "https://telegram.org.ru/uploads/posts/2023-04/1680791368_photo_2023-04-06_23-29-05.jpg"),
        .init(name: "Max", avatarUrl: "https://zoomd.com/wp-content/uploads/2020/09/man-avatar-profile-vector-21372076.jpg"),
        .init(name: "Gladys", avatarUrl: "https://ru-static.z-dn.net/files/ddd/02bd3a23f077cda4cc1843b6467a4db1.jpg"),
        .init(name: "Victoria", avatarUrl: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg"),
        .init(name: "Colleen", avatarUrl: "https://i.pinimg.com/originals/ad/ee/82/adee824009382c7dfeaf002698dc02a1.png"),
        .init(name: "Philip", avatarUrl: "https://i.pinimg.com/originals/01/c7/b1/01c7b181419e15cc614b2297a0e0b959.jpg"),
        .init(name: "Mitchell", avatarUrl: "https://telegram.org.ru/uploads/posts/2023-04/1680791368_photo_2023-04-06_23-29-05.jpg"),
        .init(name: "Colleen", avatarUrl: "https://i.pinimg.com/originals/ad/ee/82/adee824009382c7dfeaf002698dc02a1.png"),
        .init(name: "Philip", avatarUrl: "https://i.pinimg.com/originals/01/c7/b1/01c7b181419e15cc614b2297a0e0b959.jpg"),
        .init(name: "Mitchell", avatarUrl: "https://telegram.org.ru/uploads/posts/2023-04/1680791368_photo_2023-04-06_23-29-05.jpg")
    ]
}
