import UIKit
//
//
//var aa: Int = 213
//
//var aaa: Int? = 213
//
//
//var age: Int? = nil // optionals - опционалы - после типа надо вставить ? - делает доступным значение nil для переменной
//age = 38
//
//var name: String? = nil // создаём переменную String с nil
//
//// Because of this, trying to read name.count is unsafe and Swift won’t allow it. Instead, we must look inside the optional and see what’s there – a process known as unwrapping.
//
////if let unwrapped = name { // можно ли посчитать количество символов в nil
////    print("\(unwrapped.count) letters")
////}
////else {
////    print("Missing name")
////} // нет
//
//func green (_ name: String?) {
//    guard let unwrapped = name else { //вместо if let для unwrapped можно юзать guard let
//        print("You didn't provide a name!")
//        return
//    }
//    print("Hello, \(unwrapped)!")
//}
//
//name = "Al"
//green(name)
//
//
//let number = "5"
//let intnumber = Int(number) //конвертация форматов. тут intnumber будет опционалом, ведь Swift предполагает что вы могли конвертировать какое либо слово в Int.
////print(intnumber)
//let forcenumber = Int(number)! // если поставить ! после конвертации то это будет force конвертация и forcenumber будет 100% Int. Но если сюда попадет слово то код просто крашнется.
////print(forcenumber)
//
//let age2: Int! = nil // implicitly unwrapped optionals - как опционалы только не надо их unwrapped. Сложна тут. Если такой опционал задействовать, а он будет со значением nil - то код крашнется. Поэтому их избегают
//
//
//func username (for id: Int) -> String? {
//    if id == 1 {
//        return "Taylor Swift"
//    }
//    else {
//        return nil
//    }
//}
//
//let user = username(for: 2) ?? "Anon" // можно юзать такую конструкцию
//print(user)
//
//let names = ["John", "Alex", "Boris"]
//let gays = names.first?.uppercased()
//
//// https://www.hackingwithswift.com/sixty/10/8/optional-try - не понял прикола
//
//struct Person {
//    var id: String
//
//    init?(id: String) { // init? - отказоустойчивый инициализатор - вернёт nil, вместо того чтоб крашнуть код
//        if id.count == 9 {
//            self.id = id
//        } else {
//            return nil
//        }
//    }
//}
//var ala = Person(id: "123456789")
//
//
//class Animal {}
//class Fish: Animal {}
//
//class Dog: Animal {
//    func noise () {
//        print("Woof!")
//    }
//}
//
//let pets = [Fish(), Dog(), Fish(), Fish()]
//
//for pet in pets {
//    if let dog = pet as? Dog { // If we want to loop over the pets array and ask all the dogs to bark, we need to perform a typecast: Swift will check to see whether each pet is a Dog object, and if it is we can then call noise()/ This uses a new keyword called as?, which returns an optional: it will be nil if the typecast failed, or a converted type otherwise.
//        dog.noise()
//    }
//}


class Person {
    var name: String? = nil
}


