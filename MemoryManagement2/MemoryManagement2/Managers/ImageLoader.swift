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
            // Симуляция загрузки изображения (замените на реальный запрос, если нужно)
            let image = UIImage(systemName: "photo") ?? UIImage() // Плейсхолдер изображения
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                // Обновляем свойство image
                self.image = image
                
                // Если есть делегат, уведомляем о завершении загрузки
                self.delegate?.imageLoader(self, didLoad: image)
                
                // Если есть замыкание, вызываем его с загруженным изображением
                self.completionHandler?(image)
            }
        }
    }
}
