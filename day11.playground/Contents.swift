import UIKit
//Протокол определяет образец методов, свойств или другие требования, которые соответствуют определенному конкретному заданию или какой-то функциональности. Протокол фактически не предоставляет реализацию для любого из этих требований, он только описывает как реализация должна выглядеть. Протокол может быть принят классом, структурой или перечислением для обеспечения фактической реализации этих требований. Любой тип, который удовлетворяет требованиям протокола, имеет указание соответствовать этому протоколу или другими словами реализовать данный протокол.

protocol Identifiable { //protocol - ключевое слово для создания протокола
    var id: String {get} // он будет требовать чтоб все соответсвующие типы имели id в формате String, которое может быть считано (get) или записано (set)
}

struct Person: Identifiable {
    let id: String
}
var pp = Person(id: "11")
pp.id

func dispalyID (_ thing: Identifiable) {
    print("My ID is \(thing.id)")
}

protocol Payable {
    func calculateWages () -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { //протоколы могут наследовать друг друга
    
}

extension Int { // extension - Расширения позволяют добавлять методы к существующим типам, чтобы заставить их делать то, для чего они изначально не были предназначены.
    func squared () -> Int {
        return self * self
    }
}
let number = 5
number.squared()

//Протоколы позволяют описать, какие методы должны быть, но не предоставляют код внутри. Расширения позволяют предоставлять код внутри методов, но затрагивают только один тип данных - нельзя добавлять метод ко многим типам одновременно. Расширения протокола решают обе эти проблемы: они похожи на обычные расширения, за исключением того, что вместо того, чтобы расширять определенный тип, например Int, вы расширяете весь протокол так, чтобы все соответствующие типы получили свои изменения.

let pythons = ["Alex", "Boris", "Vova"]
let beatles = Set(["Paul", "George", "Ringo"])

// в Swift и array и set относятся к одному протоколу Collection, так что можно написать extension protocol и для array и для set одновременно

extension Collection {
    func summrize () {
        print("There are \(count)of us:")
        
        for name in self {
            print(name)
        }
    }
}
pythons.summrize()

// Расширения протоколов могут обеспечить реализацию по умолчанию для наших собственных методов протокола. Это упрощает приведение типов в соответствие с протоколом и позволяет использовать метод, называемый "протокольно-ориентированное программирование" - создание вашего кода вокруг протоколов и протокольного расширения.
extension Identifiable {
    func identify() {
        print("My ID is \(id)")
    }
}

struct Persona: Identifiable {
    var id: String
}
var vova = Persona(id: "123")
vova.identify()


protocol Check {
    var check1: Any {get set}
//    func check2 ()
}

class ForCheck: Check {
    var check1: Any
    
//    func check2() {
//        <#code#>
    }
    init (check1: Any) {
        self.check1 = check1
    }
//    var check1 = "Hi"
//
//    func check2 (check: String) -> String {
//        return "Hi, \(check)!"
//    }
}
//
