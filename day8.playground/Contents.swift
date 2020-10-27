import UIKit

//struct Sport { // struct - структуры
//    var name: String // properties - свойсвтво
//    var isOlympic: Bool
//
//    var isOlimpicStatus: String {  // свойство зависимое от других свойст называется вычсиляемым свойством - computed properties
//        if isOlympic {
//            return "\(name) is olympic sport"
//        }
//        else {
//            return "\(name) is NOT olympic sport"
//        }
//    }
//}
//var tennis = Sport(name: "tennis", isOlympic: false)
//print(tennis.name)
//
////tennis.name = "Lawn tennis" // так как всё var можно изи менять данные
//print(tennis.isOlimpicStatus)

//struct Progress {
//    var task: String
//    var amount: Int { //property observers - наблюдаемые свойства - с помощью didSet можно что-то выполнять ПРИ КАЖДОМ изменении выбранного свойства
//        didSet {
//        print("\(task) is now \(amount)% complete")
//    }
//    }
//}
//var progress = Progress(task: "Loading data", amount: 0)
//progress.amount = 30
//progress.amount = 50
//progress.amount = 70
//progress.amount = 100

//struct City {
//    var population: Int
//
//    func colletTaxes () -> Int { // функции внутри структур называются методами
//        return population * 1000
//    }
//}
//var london = City(population: 9_000_000)
//let tax = london.colletTaxes()
//print(tax)


// Если struct имеет переменное свойство, но экземпляр структуры был создан как константа, то это свойство не может быть изменено - структура является константой, поэтому все ее свойства также являются константными независимо от того, как они были созданы.

//Проблема в том, что при создании структуры Swift понятия не имеет, будете ли вы использовать ее с константами или переменными, поэтому по умолчанию используется безопасный подход: Swift не позволит Вам писать методы, которые изменяют свойства, если Вы специально не запросите их.

//struct Person {
//    var name: String
//
//    mutating func makeAnon () { //  чтобы функция изменяла свойство внутри struct она должна быть mutating
//        name = "anon"
//    }
//}
//var person = Person(name: "Ed")
//print(person.name)
//person.makeAnon()
//print(person.name)


//let string = "Hello there, boys!"
//string.count // у let и var есть свои свойства и методы. например count в типе данных String считает количество символов
//string.hasPrefix("Hello")
//string.sorted()
//
//
//var boys = ["Maks"] // массивы тоже struct как и string и имеет свои свойства и методы
//boys.count
//boys.append("Rostik")
//boys.firstIndex(of: "Rostik")
//boys.sorted()
//boys.remove(at: 1)
//boys
//
//struct User { // Инициализаторы - это специальные методы, которые предоставляют различные способы создания Вашей структуры. Все структуры по умолчанию поставляются с одной, называемой их memberwise init - при создании структуры вам будет предложено указать значение для каждого свойства.
//    var username: String
//    init () {
//        username = "Anon"
//        print("Create new username!")
//    }
//}
//
//var user = User()
//
//user.username = "Tom"

//struct Person {
//    var name: String
//
//    init (name: String) {
//        print("\(name) was born!")
//        self.name = name
//    }
//}
//let Maks = Person(name: "Maks")

//struct FamilyTree {
//    init() {
//        print("Create family tree!")
//    }
//}
//
//struct Person {
//    static var countPerson = 0 // Вы также можете попросить Swift поделиться конкретными свойствами и методами со всеми экземплярами структуры, объявив их статическими.
//    var name: String
//    lazy var tree = FamilyTree() //параметр lazy будет вызывать данное свойство только когда его вызовут напрямую
//
//    init(name: String) {
//        self.name = name
//        Person.countPerson += 1
//    }
//}
//var ed = Person(name: "Ed")
//var shon = Person(name: "Shon")
//print(Person.countPerson)

//
//struct Person {
//    private var id: Int // private делает свойство читабельным только внутри struct
//
//    init (id:Int) {
//        self.id = id
//    }
//    func myId () {
//        print("my id is \(self.id)")
//    }
//}
//
//let alex = Person(id: 1234)
//alex.myId()


struct Person {
    var name: String
    
}

