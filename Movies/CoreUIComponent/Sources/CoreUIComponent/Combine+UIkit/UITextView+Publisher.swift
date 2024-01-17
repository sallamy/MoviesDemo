
import Combine
import UIKit

extension UITextView {
    public  func textPublisher() -> AnyPublisher<String, Never> {
      NotificationCenter.default
          .publisher(for: UITextView.textDidChangeNotification, object: self)
          .map { ($0.object as? UITextView)?.text  ?? "" }
          .eraseToAnyPublisher()
  }
}
