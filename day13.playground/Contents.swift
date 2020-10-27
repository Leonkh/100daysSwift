import UIKit
////////var name: String
////////name = "Romeo"
//////
//var age: Int
//age = 25
//////
//////var latitude: Double = 36.166667 //Apple рекомендует юзать Double, так как у него выше точность
//////
//////var longitude: Float = -11186.785333 //Float будет выводить в приоритете число слева направо округляя c 5 в большую сторону
//////
////////var a = 10
////////a = a + 1
////////a = a - 1
////////a = a * a
////////
////////var b = 10
////////b += 10
////////b -= 10
//////
//////var a = 1.1
//////var b = 2.2
//////var c = a + b
//////
//////var name1 = "Alex"
//////var name2 = "Key"
//////var name3 = name1 + name2
//////
//////var d = 10
//////var dd = 3
//////var cc = d % dd
//////
//////c > a
//////c < a
//////
//////var name = "Tim"
//////name == "Tim"
//////name != "Tim"
//////
//////var st = true
//////print("Your name is \(name) and it's \(st)") // LOL
//////
//////var numbers: [Any] = [1, 2, 3, 4]
//////type(of: numbers)
//////
//////var songs: [String] = []
//////songs += ["Royal"]
//////
//////
//////var person = [
//////    "first": "Tyalor",
//////    "middle": "Alison",
//////    "last": "Swift"
//////]
//////person["first"]
//////person["last"]
//////
//////
//////for i in 1...10 {
//////    print("\(i) x 10 is \(i * 10)")
//////}
////
//////func getHattersStatus(weather: String) -> String? {
//////    if weather == "sunny" {
//////        return nil
//////    }
//////    else {
//////    return "Hate"
//////    }
//////}
//////
//////getHattersStatus(weather: "sunny")
//////
//////var status: String?
//////status = getHattersStatus(weather: "rainy")
//////
//////if let unwrappedStatus = status {
//////    // unwrappedStatus contains a non-optional value!
//////    } else {
//////        // in case you want an else block, here you go…
//////    }
//////}
////
////
//////func yearAlbumRealease(name: String) -> Int? {
//////    if name == "Taylor Swift" {return 2006}
//////    if name == "Fearless" {return 2008}
//////    return nil
//////}
//////var year = yearAlbumRealease(name: "Taylor Swift")
//////
//////if year == nil {
//////    print("There is error")
//////} else {
//////    print("It was realesed in \(year!)")
//////}
//////var items = ["James", "John", "Sonny"]
////
//////func position(of string: String, in array: [String]) -> Int {
//////    for i in 0..<array.count {
//////        if array[i] == string{
//////            return i
//////        }
//////    }
//////    return 0
//////}
//////
//////let jamesPosition = position(of: "James", in: items)
//////let johnPosition = position(of: "John", in: items)
//////let sonnyPosition = position(of: "Sonny", in: items)
//////let bobPosition = position(of: "Bob", in: items)
////
////func albumReleased(year: Int) -> String? {
////    switch year {
////    case 2006: return "Taylor Swift"
////    case 2008: return "Fearless"
////    case 2010: return "Speak Now"
////    case 2012: return "Red"
////    case 2014: return "1989"
////    default: return nil
////    }
////}
////
////let album = albumReleased(year: 2006)
////if let unwrapped = album {
////    print("The album is \(unwrapped)")
////}
////
////enum Weather {
////    case sun, cloud, rain, snow
////}
//
//
////struct Person {
////    var clothes: String
////    var shoes: String
////    func describe() {
////        print("I like wearing \(clothes) and \(shoes)")
////    }
////}
////let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
////
////let other = Person(clothes: "short skirts", shoes: "high heels")
////
////var taylorCopy = taylor
////taylorCopy.shoes = "flip flops"
////print(taylor)
////print(taylorCopy)
////taylor.describe()
//
//
//class Person {
//
//    static var favoriteFood = "burger"
//
//    var clothes: String {
//        willSet {
//            updateUI("I'm changing my clother from \(clothes) to \(newValue)")
//        }
//        didSet {
//            updateUI("I just changed from \(oldValue) to \(clothes)")
//        }
//    }
//    var shoes: String
//
//    init(clothes: String, shoes:String) {
//        self.clothes = clothes
//        self.shoes = shoes
//    }
//
//    func hi() {
//        print("Hi!")
//    }
//    func updateUI(_ msg:String) {
//        print(msg)
//    }
//}
//var stas = Person(clothes: "sdfhks", shoes: "dsfdsf")
//class Worker: Person {
////    var work:String
//
////    super.init(work:String) {
////        self.work = work
////    }
//
//    override func hi() {
//        print("Hi, I'm worker")
//    }
//}
//
//var driver = Worker(clothes: "roba", shoes: "bots")
//
//driver.hi()
//
//class Directors: Person {
//    var money: Int
//
//    init(clothes: String, shoes: String, money: Int) {
//        self.money = money
//        super.init(clothes: clothes, shoes: shoes)
//    }
//}
//
//var petr = Directors(clothes: "jj", shoes: "sd", money: 23)
//petr.clothes = "newjj"
//petr.hi()
//
//
//


// Access control
//Public: this means everyone can read and write the property.
//Internal: this means only your Swift code can read and write the property. If you ship your code as a framework for others to use, they won’t be able to read the property.
//File Private: this means that only Swift code in the same file as the type can read and write the property.
//Private: this is the most restrictive option, and means the property is available only inside methods that belong to the type, or its extensions.
//class TaylorFan {
//    private var name: String?
//}



//class Album {
//    var name: String
//    init (name: String) {
//        self.name = name
//    }
//
//    func getPerfomance() -> String {
//        return "The album \(name) sold lots"
//    }
//}
//
//class StudioAlbum: Album {
//    var studio: String
//
//    init(name: String, studio: String) {
//        self.studio = studio
//        super.init(name: name)
//    }
//    override func getPerfomance() -> String {
//        return "The studio album \(name) sold lots"
//    }
//}
//
//class LiveAlbum: Album {
//    var location: String
//
//    init(location: String, name: String) {
//        self.location = location
//        super.init(name: name)
//    }
//    override func getPerfomance() -> String {
//        return "The live album \(name) sold lots"
//    }
//}
//
//var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The NY Studio")
//
//var fearless = StudioAlbum(name: "Fearless", studio: "Aimeland Studio")
//
//var iTunesLive = LiveAlbum(location: "NY", name: "iTunes live from SoHo")
//
//var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]
//
//
//for album in allAlbums {
//    print(album.getPerfomance())
//
//    if let studioAlbum = album as? StudioAlbum {
//        print(studioAlbum.studio)
//    }
//    else if let liveAlbum = album as? LiveAlbum {
//        print(liveAlbum.location)
//    }
//}

let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})
