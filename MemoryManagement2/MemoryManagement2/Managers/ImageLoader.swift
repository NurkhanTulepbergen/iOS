import UIKit
import Combine

protocol ImageLoaderDelegate: AnyObject {
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    weak var delegate: ImageLoaderDelegate?
    
    var completionHandler: ((UIImage?) -> Void)?
    
    func loadImage(url: URL) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                guard let loadedImage = UIImage(data: data) else {
                    throw NSError(domain: "ImageLoaderError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать изображение из данных."])
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.image = loadedImage
                    
                    self.delegate?.imageLoader(self, didLoad: loadedImage)
                    
                    self.completionHandler?(loadedImage)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.delegate?.imageLoader(self, didFailWith: error)
                    self.completionHandler?(nil) 
                }
            }
        }
    }
}
