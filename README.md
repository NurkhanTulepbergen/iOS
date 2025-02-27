# 2LAB Memory Management 
## 1. Memory Management Decisions
В проекте используются weak ссылки для предотвращения ретеншн-циклов и утечек памяти.
1. Использование weak для делегатов

Классы ImageLoader и ProfileManager используют weak var delegate, чтобы избежать сильной ссылки на делегата:
```swift
weak var delegate: ImageLoaderDelegate?
```
Это предотвращает возможные утечки памяти, так как объект делегата может быть освобожден без необходимости обрывать связь вручную.

2. Использование weak self в GCD
Во избежание ретеншн-циклов внутри DispatchQueue.global().async, используется weak self внутри DispatchQueue.main.async:
```swift
DispatchQueue.global().async {
    do {
        let data = try Data(contentsOf: url)
        guard let loadedImage = UIImage(data: data) else {
            throw NSError(domain: "ImageLoaderError", code: 1, userInfo: nil)
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.image = loadedImage
            self.delegate?.imageLoader(self, didLoad: loadedImage)
        }
    } catch {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.imageLoader(self!, didFailWith: error)
        }
    }
}
```

## 2. Collection Type Choices
Разные коллекции выбраны в зависимости от требований по производительности и логике работы данных.

1. Использование [UUID: UserProfile] в ProfileManager
```swift
@Published private var activeProfiles: [UUID: UserProfile] = [:]
```
Dictionary ([UUID: UserProfile]) используется для быстрого доступа к профилям по UUID, что значительно эффективнее Array, так как поиск в словаре выполняется за O(1), а в массиве — O(n).
2. Использование Set<String> для хештегов
```swift
private var hashtags: Set<String> = []
```
Set позволяет хранить уникальные хештеги и быстро проверять их наличие (O(1)).

3. Использование Array ([Post]) для хранения ленты постов
```swift
private var feedPosts: [Post] = []
```
Используется Array, так как вставка новых постов в начало выполняется с допустимой сложностью (O(n)), а доступ к элементам осуществляется за O(1).

## 3.Protocol Implementation
В проекте используется protocol для слабосвязанных компонентов.

1. ImageLoaderDelegate для загрузки изображений
```swift
protocol ImageLoaderDelegate: AnyObject {
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}
```
Делегат позволяет уведомлять UI-компоненты о загруженном изображении.
AnyObject используется, чтобы delegate можно было объявить как weak.

2. ProfileUpdateDelegate для обновления профиля
```swift
protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}
```
Делегат позволяет передавать изменения в ProfileManager без жесткой привязки к конкретному объекту.

3. Реализация Hashable и Equatable в Post и UserProfile

Для обеспечения корректной работы Set и Dictionary, Post и UserProfile реализуют Hashable и Equatable:
```swift
struct Post: Hashable, Equatable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int
    var imageURL: URL?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(authorId)
    }

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.authorId == rhs.authorId
    }
}
```

```swift
struct UserProfile: Hashable, Equatable {
    let id: UUID
    let username: String
    var bio: String
    var followers: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
    }

    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.id == rhs.id && lhs.username == rhs.username
    }
}
```
