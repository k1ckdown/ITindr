//
//  ChatCellViewModel.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

final class ChatCellViewModel: Equatable {

    private let id: String
    private(set) var title: String
    private(set) var avatarUrl: String?
    private(set) var lastMessage: String?

    init(id: String, title: String, avatarUrl: String?, lastMessage: String?) {
        self.id = id
        self.title = title
        self.avatarUrl = avatarUrl
        self.lastMessage = lastMessage
    }

    static func == (lhs: ChatCellViewModel, rhs: ChatCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension ChatCellViewModel {

    static let mock: [ChatCellViewModel] = [
        .init(
            id: "",
            title: "Eduardo",
            avatarUrl: "https://zoomd.com/wp-content/uploads/2020/09/man-avatar-profile-vector-21372076.jpg",
            lastMessage: "И обидно вам должно быть за себя раз вы не видите как Яго. И обидно вам должно быть"
        ),
        .init(
            id: "",
            title: "Colleen",
            avatarUrl: "https://ru-static.z-dn.net/files/ddd/02bd3a23f077cda4cc1843b6467a4db1.jpg",
            lastMessage: "Обсудить итоги и результаты работы и определить перспективы. Обсудить итоги и результаты"
        ),
        .init(
            id: "",
            title: "Kyle",
            avatarUrl: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg",
            lastMessage: "Кроме практической точки зрения есть логика. Кроме практической точки"
        ),
        .init(
            id: "",
            title: "Mitchell",
            avatarUrl: "https://i.pinimg.com/originals/ad/ee/82/adee824009382c7dfeaf002698dc02a1.png",
            lastMessage: "И согласно правил этой логики Ягода пока не показала что во. И согласно правил этой логики"
        ),
        .init(
            id: "",
            title: "Marjorie",
            avatarUrl: "https://i.pinimg.com/originals/01/c7/b1/01c7b181419e15cc614b2297a0e0b959.jpg",
            lastMessage: "С одной стороны - всё можно объяснить человеческой псих. С одной стороны - всё"
        ),
        .init(
            id: "",
            title: "Max",
            avatarUrl: "https://telegram.org.ru/uploads/posts/2023-04/1680791368_photo_2023-04-06_23-29-05.jpg",
            lastMessage: "Потому что это отдельная витрина с бронированием, а н. Потому что"
        )
    ]
}
