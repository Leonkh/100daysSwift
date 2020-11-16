import UIKit

//let name = "Taylor"

//for letter in name {
//    print("Give me a \(letter)")
//}
//
//let letter = name[name.index(name.startIndex, offsetBy: 3)]
//
//extension String { // полезное расширение чтоб вытаскивать один элемент из String. О тоже будет String
//    subscript(i: Int) -> String {
//        return String(self[index(startIndex, offsetBy: i)])
//    }
//}
//
//let letter2 = name[3]
//type(of: letter2)


//let password = "123456"
//
//password.hasPrefix("123")
//password.hasSuffix("456")
//
//extension String { // расширение для удаления префикса и суффикса
//    func deletingPrefix(_ prefix: String) -> String {
//        guard self.hasPrefix(prefix) else {return self}
//        return String(self.dropFirst(prefix.count))
//    }
//
//    func deletingSuffix(_ suffix: String) -> String {
//        guard self.hasSuffix(suffix) else {return self}
//        return String(self.dropLast(suffix.count))
//}
//}

//let weather = "it's going to rain"
//
//extension String { // Первую букву сделать в верхним регистром
//    var capitalizedFirst: String {
//        guard let firstLetter = self.first else { return "" }
//        return firstLetter.uppercased() + self.dropFirst()
//    }
//}
//weather.capitalizedFirst

//let input = "Swift is like Objective-C without the C"
//input.contains("Swift")
//
//let languages = ["Swift", "Pyhon", "Ruby"]
//
//extension String { // проверить имеет ли строка один из элементов массива
//    func containsAny(of array: [String]) -> Bool {
//        for item in array {
//            if self.contains(item) {
//                return true
//            }
//        }
//
//        return false
//    }
//}
//input.containsAny(of: languages)
//languages.contains(where: input.contains) // встроенный метод проверки

//
//let string = "This is a test string"
//
////let attributes: [NSAttributedString.Key: Any] = [ // прописываем разные параметры строки
////    .foregroundColor: UIColor.white,
////    .backgroundColor: UIColor.red,
////    .font: UIFont.boldSystemFont(ofSize: 36)
////]
////
////let attributedString = NSAttributedString(string: string, attributes: attributes) // создаем строку с нашими параметрами
//
//let attributedString = NSMutableAttributedString(string: string)
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))




extension String {
    
    func addPreefix(_ prefix: String) -> String {  // Challenge 1
        guard !self.hasPrefix(prefix) else {return self}
        return prefix + self
    }
    
    func isNumeric() -> Bool { // Challenge 2
        let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        var rt = false
        for letter in string {
            if numbers.contains("\(letter)") {
                rt = true
                break
            } else {
                rt = false
            }
        }
        return rt
    }
    
//    func lines() -> [String] { // Challenge 3
//        var array = [String]()
//        var part: String = ""
//        for letter in string {
//            if letter == Character(\) {
//                array.append(part)
//                part.removeAll()
//                continue
//            }
//            part.append(letter)
//        }
//        return array
//    }

    
}

let string = "chek"
string.addPreefix("ch") // проверка Challenge 1
string.addPreefix("pref") // проверка Challenge 1

string.isNumeric() // проверка Challenge 2

let lines = "this\nis\na\ntest"
print(lines)
//lines.lines()





