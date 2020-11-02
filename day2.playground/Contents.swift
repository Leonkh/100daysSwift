import UIKit

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo] // array - массив

//print(beatles)
beatles[1]
beatles[0]

let colours = Set(["red","green", "blue"])
let colors2 = Set(["red", "green", "blue", "red", "blue"]) // Set - сеты, это как массивы, только в них каждый элемент уникален (повторы игнорятся) и Swift не гарантирует конкретный порядок элементов в сете
//print(colors2)

var name = (first: "Taylor", last: "Swift") // tuples - кортежи - 1. Создаются фиксированного размера, 2. нельзя менять тип данных после генерации, 3. Можно получать доступ по позиции или названию
//print(name.0)
print(name.first)

let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville") // Если вам нужна конкретная, фиксированная коллекция связанных значений, где каждый элемент имеет точное положение или имя, вы должны использовать tuple

let set = Set(["aardvark", "astronaut", "azalea"]) // юзаем set для коллекции уникальных объектов

let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
] // dictionary - словарь, Словари - это наборы значений, как и массивы, но вместо того, чтобы хранить вещи в целочисленной позиции, вы можете обращаться к ним, используя все, что захотите.
heights["Taylor Swift"]


let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Paul"]
favoriteIceCream["Charlotte"] // если сделать запрос из словаря несуществующего значения, то Swift вернёт значение "nil"

favoriteIceCream["Charlotte", default: "Unknown"] // при запросе, можно указать словарю, что по умолчанию на несуществующие значения выдавать что-то (в нашем случае "Unknow")

// Arrays, sets, and dictionaries are called collections, because they collect values together in one place

var teams = [String: String]() // можно создавать пустую коллекцию просто написав её тип с последующими открывающими и закрывающими круглыми скобками.
teams["Paul"]="red"
//var results = [Int]()
//var words = Set<String>()
//var numbers = Set<Int>()

let result = "failure"
let result2 = "failed"
let result3 = "fail"

enum Result {
    case success
    case failure
} // Enumerations – обычно называемые enums - перечисления

let result4 = Result.failure

enum Activity {
    case bored
    case running(destdfjhsdjfhjsdfsdation: String)
    case talking(topic: String)
    case singing(volume: Int)
} // Помимо хранения простого значения, enums могут также хранить связанные с ними значения, привязанные к каждому случаю. Это позволяет прикреплять к перечислениям дополнительную информацию, чтобы они могли представлять более подробные данные.
let talking = Activity.talking(topic: "football")

enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars //
} // Иногда необходимо иметь возможность присваивать значения enums, чтобы они имели смысл. Это позволяет создавать их динамически, а также использовать по-разному. Например, можно создать enums Planet, в котором будут храниться целочисленные значения для каждого ее случая. Swift автоматически назначит каждому из них число, начинающееся с 0, и вы можете использовать это число для создания экземпляра соответствующего перечислительного списка
let ourplanet = Planet(rawValue: 3)
print (ourplanet)
