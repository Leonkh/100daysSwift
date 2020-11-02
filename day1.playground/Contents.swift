import UIKit

var str = "Hello, playground" // var задаёт переменные
str = "Goodbye" // Swift сам может определять тип переменной
//
var age = 38 // int
var population = 8_000_000 // int

var str1 = """
this goes
over multiple
lines
""" // multi-line str (на выводе будет в множество строк)

var str2 = """
This goes \
over multiple \
lines
"""  // на выводе будет в одну строку
print (str1)
print (str2)

var pi = 3.141 // double
var awesome = true // bool

var score = 85
var str3 = "Your score is \(score)"
print (str3)
var results = "The test results are here: \(str3)"
print(results)

let taylor = "swift" // let задаёт константы

let albim: String = "Reputation" // можно задавать тип переменной или константы явно через :

var fl: Float = 3.3432
type(of: fl)
//var hl: CShort = 
