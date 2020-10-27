//import UIKit
//
//let count = 1...10
//
//for number in count{
//    print ("Number is \(number)")
//}
//let albums = ["Red", "1989", "Reputation"]
//
//for album in albums {    // пример работы цикла for
//    print("\(album) is on Apple Music")
//}
//
//var number = 1
//while number <= 20 {  // пример работы while
//    print(number)
//    number += 1
//}
//
//repeat {  // залупинг repeat редко применяется, но его фишка в том, что 1 раз он точно прогонит код и только потом узнает условие.
//    print(number)
//    number += 1
//}
//while number <= 20
//
//var countDown = 10
//
//while countDown >= 0 {
//    print(countDown)
//    countDown -= 1
//    if countDown == 4 {
//        print("Go now!")
//        break          // с помощью break можно сразу выйти из цикла
//    }
//}
//
//print("Blast off!")


outerLoop: for i in 1...10 {  // циклу можно дать имя
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
        if product == 50 {
            print("It's a bullseye!")
          break outerLoop  // оператору break можно указать какой цикл завершить. Если завершается верхний, то циклы в нём тоже мгновенно завершатся
        }
    }
}
var y = 1...10
for i in y {
    if i % 2 == 1 {
        continue  // оператор continue мгновенно начинает следующий цикл
    }

    print(i)
}

var counter = 0

while true { // бесконечные циклы - постоянно юзаются в аппах на айфоне, ожидая действие пользователя. ВАЖНО!!!: НЕ ЗАБУДЬ СДЕЛАТЬ УСЛОВИЕ ВЫХОДА
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}
