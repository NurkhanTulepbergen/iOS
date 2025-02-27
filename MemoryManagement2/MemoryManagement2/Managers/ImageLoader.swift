import UIKit
import Combine

// Делегат для загрузки изображения
protocol ImageLoaderDelegate: AnyObject {
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil // Используем @Published для обновления UI в SwiftUI
    weak var delegate: ImageLoaderDelegate?
    
    // Замыкание для завершения загрузки изображения
    var completionHandler: ((UIImage?) -> Void)?
    
    func loadImage(url: URL) {
        DispatchQueue.global().async {
            // Загружаем изображение асинхронно
            do {
                let data = try Data(contentsOf: url) // Получаем данные изображения
                guard let loadedImage = UIImage(data: data) else {
                    throw NSError(domain: "ImageLoaderError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать изображение из данных."])
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Обновляем свойство image
                    self.image = loadedImage
                    
                    // Если есть делегат, уведомляем о завершении загрузки
                    self.delegate?.imageLoader(self, didLoad: loadedImage)
                    
                    // Если есть замыкание, вызываем его с загруженным изображением
                    self.completionHandler?(loadedImage)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Обработать ошибку загрузки
                    self.delegate?.imageLoader(self, didFailWith: error)
                    self.completionHandler?(nil) // Передаем nil, если изображение не загрузилось
                }
            }
        }
    }
}
