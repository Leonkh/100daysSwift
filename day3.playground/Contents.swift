import UIKit

let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore // сумма ёпт
let differenc = firstScore - secondScore //вычитание ёпт
let product = firstScore * secondScore // умножение ёпт
let divided = firstScore / secondScore // целочисленное деление так то
let remainder = 13 % secondScore // нахождение остатка от деления
var x: Int = 15
var y: Int = 4
let res = x / y
let fakers = "Fakers gonna "
let fake = fakers + "fake!" // можем суммировать ОДНОТИПНЫЕ данные между собой

var score = 95
score -= 5 // операторы -= и += сами вычитают и присваивают конкретное значение к переменной

firstScore == secondScore // оператор сранения ==: выдает true если равны, иначе false
firstScore != secondScore // оператор отрицания равенства !=: выдает true если НЕ равны, иначе false

firstScore > secondScore
firstScore <= secondScore

"Alexфx" <= "Igor" // сравнение строковых данных идёт по порядку букв в алфавите
"А" > "Б"

let firstCard = 10
let secondCard = 11
//
//if firstCard + secondCard == 21 { // оператор if для условия
//    print("BlacJack!")
//}
//else if { // оператор else для иного варианта
//    print("Regular card")
//}
//else {
    
//if {
//
//        }

//let age1 = 22
//let age2 = 21
//
//if age1 > 18 && age2 > 18 {  // оператор && для "и" и оператор || для "или"
//    print("Both are over 18")
//}

//let firstCard = 11
//let secondCard = 10
//print(firstCard == secondCard ? "Cards are the same" : "Cards are different") // оператор "?" с ":" тернарый оператор, если перед ним true, он выдает первое значение после себя, иначе второе. Применяется редко
//
//let weather = "sunny"
//switch weather {     // конструкция switch-case-default проверяет объект после switch с объектами case, если есть совпадение применяется этот case
//case "rain":
//    print("Bring a umbrella")
//case "snow":
//    print("Wrap up warm")
//case "sunny":
//    print("wear sunscreen")
//    fallthrough     // после применения case программа выходит из конструкции, но если прописать fallthrough то после case код продолжится.
//default:            // если код дошёл до default то случай default исполнится
//    print("Enjoy your day!")
//}

let yourScore = 83

//switch yourScore {
//case 0..<50:
//    print("It's bad")
//case 50..<85:
//    print("You can better")
//default:
//    print("you win!")
//}
//
if yourScore >= 0 && yourScore < 50 {
    print("It's bad")
}
else if yourScore >= 50 && yourScore < 85 {
print("You can better")
}
else {
    print("You can better")
}

