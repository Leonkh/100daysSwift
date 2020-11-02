//import UIKit
//
////func printHelp() {
////    let message = """
////Welcome to MyApp!
//////
//////Run this app inside a directory of images and
//////MyApp will resize them all into thumbnails
//////"""
////print(message)
////}
////printHelp()
//
////func square (number: Int) {
////    print(number * number)
////}
////
////square(number: 5)
//
////func square (number: Int) -> Int {
////    return number * number
////}
////
////print(square2(number: 5))
//
//func sayHello (to name: String) {  // у параметра может быть два имени - внешнее и внутреннее
//    print("Hello, \(name)!")
//}
//sayHello(to: "Alex")
//
//// можно вместо внешнего имени параметра поставить _ и тогда не надо будет явно его писать
//
//func sayHello2 (_ name: String) {
//    print("Hello, \(name)!")
//}
//sayHello2("Tigr")
//
//func greet(_ person: String, nicely: Bool = true) {  // значения по умолчанию ставятся после типа данных знаком =
//    if nicely == true {
//        print("Hello, \(person)!")
//    } else {
//        print("Oh no, it's \(person) again...")
//    }
//}
////greet("Taylor")
////greet("Taylor", nicely: false)
//
//func square (x numbers: Int...) {  //  после типа можно поставить троеточие, чтоб количество вводимых в функцию данных было неограниченно
//    for number in numbers {
//        print("\(number) squared is \(number * number)")
//    }
//}
//square(x: 1,2,3,4,5)

enum passwordError: Error {  // тип данных Error
    case obvios
}

func passwordCheck (_ password: String) throws -> Bool {
    if password == "password" {
        throw passwordError.obvios
    }
    return true
}

do {
    try passwordCheck("password1")
    print("That password is good")
} catch {
    print("You can't use this password")
}

func double (_ number: inout  Int) -> Int {   // Все параметры, передаваемые в функцию в Swift, являются константами, поэтому их нельзя изменить. При желании вы можете передать один или несколько параметров как inout, что означает, что они могут быть изменены внутри вашей функции, и эти изменения отражаются в исходном значении вне функции.
    number *= 2
    return number
}
var s = 5
print(double(&s)) // знак & перед передаваемым значением является явным признаком использования inout
//
