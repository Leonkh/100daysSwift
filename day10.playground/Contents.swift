//import UIKit
//// class - классы, так же как и struct позволяют составлять новые типы со своими свойствами и методами, но у них есть 5 важных отличий
//
//// 1. Первое различие между классами и структурами заключается в том, что классы никогда не инициализируются с помощью memberwise инициализатора. Это означает, что если в вашем классе есть свойства, вы всегда должны создавать свой собственный инициализатор.
//
//// 2. Второе отличие между классами и структурами заключается в том, что можно создать класс на основе существующего класса - он наследует все свойства и методы исходного класса, а сверху может добавить свой собственный. Это называется наследованием класса или подклассом, класс, от которого вы наследуете, называется "родительским" или "супер" классом, а новый класс называется "дочерним" классом.
//
//// 3. Третье различие между классами и структурами заключается в том, как они копируются. Когда вы копируете структуру, и оригинал, и копия - это разные вещи - изменение одной не изменит другой. Когда вы копируете класс, и оригинал и копия указывают на одну и ту же вещь, поэтому изменение одного класса меняет другое.
//
//// 4. Четвертое различие между классами и структурами заключается в том, что классы могут иметь деинициализаторы - код, который запускается при уничтожении экземпляра класса.
//5.  Если у вас есть постоянная struct с переменным свойством (var), то это свойство не может быть изменено, так как сама структура является константной. Однако, если у вас есть постоянный class и переменное свойство (var), то это свойство можно изменить. Поэтому классам не нужно ключевое слово "mutating" с методами, которые изменяют свойства; это нужно только для структур.



//class Dog {  // ключевое слово "final" перед "class" сделает этот класс не изменяемым, даже override не перепишет его методы
//    var name: String
//    var breed: String
//
//    init (name: String, breed: String) {
//        self.breed = breed
//        self.name = name
//    }
//    func makeNoise () {
//        print("Woof!")
//    }
//}
//
//let bigDog = Dog(name: "Alex", breed: "German dog")
////bigDog.makeNoise()
//
//class Poddle: Dog {
//    init (name: String) {
//        super.init(name: name, breed: "Poddle") // Из соображений безопасности Swift всегда заставляет вызывать super.init() из дочерних классов - просто на тот случай, если родительский класс делает какую-то важную работу при его создании.
//    }
//    override func makeNoise() { // с помощью override можно переделывать родительские методы
//        print("Yep!")
//    }
//}
//
//let sasha = Poddle(name: "sasha")
//sasha.makeNoise()

//class Singer { // пример с Singer для 3-го различия между class и struct
//    var name = "Taylor Swift"
//}
//var she = Singer()
//she.name
//
//var he = Singer()
//he.name
//he.name = "John"
//he.name
////print(she.name)

//var sheCopy = she
//sheCopy.name = "Ledy Gaga"
//print(she.name)
//
class Person {
    var name: String
    
    var age: Int

    init(name:String) {
        self.name = name
        self.age = 0
//        print("\(name) is alive!")
    }
    
    init(age:Int, name: String) {
        self.age = age
        self.name = "tigr"
//        print("\(name) is alive!")
    }
//    func greeting() {
//        print("Hello, I'm \(name)")
//    }
//
//    deinit {
//        print("\(name) is no more!")
//    }
}

var tigr = Person(name: "Tigr")
print(tigr.name, tigr.age)

var tigr2 = Person(age: 22, name: "tigr2")
print(tigr2.name, tigr2.age)
//tigr/n
//
//for _ in 1...1 {
//    let person = Person()
//    let person2 = Person()
//    person.greeting()
//    print("HI!")
//}
//person.name
//var petya = Person()
//var vasya = Person()



//class Person {
//    var name: String
//
//    init (name: String) {
//        self.name = name
//        print("my name is \(name)")
//    }
//    deinit {
//
//    }
//}

//var Petya = Person(name: "Petya")

//struct Singer {
//    var name = "Taylor Swift"
//}
//var new = Singer()
//new.name = "Ed"
//print(new.name)
