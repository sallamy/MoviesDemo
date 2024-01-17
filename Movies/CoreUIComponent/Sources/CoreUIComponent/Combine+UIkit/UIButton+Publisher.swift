
import Combine
import UIKit

extension UIButton {
    public   var tapPublisher: EventPublisher {
        publisher(for: .touchUpInside)
    }
}
