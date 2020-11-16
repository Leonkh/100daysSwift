import UIKit

//var str = "Hello, playground"
//print(str)

//extension UIView { // Работает, проверено
//    func bounceOut(duration: Int) {
//        let durationD = Double(duration)
//        UIView.animate(withDuration: durationD, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, options: [], animations: {
//            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
//        })
//    }
//}

//extension Int { // Работает, проверенно
//    func times(_ closure: () -> Void) {
//        if self >= 0 {
//            var i = 0
//            while i != self {
//                closure()
//                i += 1
//        }
//    }
//    }
//}
//
//let a: Int = 5
//a.times( { print("Hello!") }) // Проверка 2-го задания

var arr = ["1", "2", "1"]
print(arr)

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}

arr.remove(item: "1")
