import UIKit

var arr: [Int] = [ 1, 2, 3]

class Person {
    var name: String
    
    //初始化构造器 _（外部参数名字）
    init (_ name: String) {
        self.name = name
    }
    func walk() {
        print("走路")
    }
}

let person = Person("chen")
person.walk()
