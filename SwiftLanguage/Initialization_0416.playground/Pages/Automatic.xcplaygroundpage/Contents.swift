
import Foundation

var greeting = "Hello, playground"

//Automatic Initializer Inheritance  자동적으로 이니셜라이저 상속받기
//As mentioned above, subclasses don’t inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met. In practice, this means that you don’t need to write initializer overrides in many common scenarios, and can inherit your superclass initializers with minimal effort whenever it’s safe to do so.’
//이니셜라이저 지동 상속 -> 기본적으로 서브 클래스는 슈퍼 클래스 이니셜라이저를 상속받지 않는다. 하지만 어떤 조건이 만족되면 자동으로 상속받는다. 이니셜라이저를 오버라이드 할 필요가 없다는 것이다. 구현하기가 최소 노력으로 가능하다.


//Rule 1
//If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
//서브 클래스가 어떤한 지정 이니셜라이저를 정의하지 않으면, 자동적으로 슈퍼 지정 이니셜라이저를 상속한다. 결국 서브 클래스에서 이니셜라이저 어떤 것도 지정을 하지 않으면 자동적으로 지정 이니셜라이저를 모두 상속한다.

//Rule 2
//If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
//서브 클래스가 모든 슈퍼클래스 지정 이니셜라이저 모두 구현 제공 하거나, rule 1을 적용되면, 즉 하나도 구현을 하지 않는 경우  자동적으로 모든 슈퍼클래스의 편의 이니셜라이저를 자동으로 상속한다.

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
    
    var description: String {
        return "Food: \(self.name)"
    }
}

let namedMeat = Food(name: "Bacon")
print(namedMeat.description)


//The Food class also provides a convenience initializer, init(), with no arguments. The init() initializer provides a default placeholder name for a new food by delegating across to the Food class’s init(name: String) with a name value of [Unnamed]:
//
let mysteryMeat = Food()
// mysteryMeat's name is "[Unnamed]’
print(mysteryMeat.description)

class RecipeIngredient: Food {
    
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    //여기서 주의해할 것은 init가 Food의 지정 이니셜라이저와 같다.같은 파라미터를 가진다. 
    override convenience init(name: String) {
        print("override convenience init")
        self.init(name: name, quantity: 1)
    }
    
    override var description: String {
        return "ReceipeIngredient: \(self.name) + \(self.quantity)"
    }
}

//In this example, the superclass for RecipeIngredient is Food, which has a single convenience initializer called init(). This initializer is therefore inherited by RecipeIngredient. The inherited version of init() functions in exactly the same way as the Food version, except that it delegates to the RecipeIngredient version of init(name: String) rather than the Food version.’

// ReceipeIngredient의 init()는 상속받은 convenience의 init() 암묵적으로 상속을 받은 initializer() 이다.

let oneMysteryItem = RecipeIngredient()
print(oneMysteryItem.description)   //


let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

print(oneBacon.description)
print(sixEggs.description)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    override var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}


//Because it provides a default value for all of the properties it introduces and doesn’t define any initializers itself, ShoppingListItem automatically inherits all of the designated and convenience initializers from its superclass.

//ShoppingListItem은 Rule 1에 으ㅐ해서 지정, 편의 이니셜라이저를 자동적으로 모두 상속 받는다.

var shoppingList = ShoppingListItem(name: "Bacon", quantity: 3)
print(shoppingList.description)


//ReceipeIngredient의 이니셜라이저를 모두 상속받는다.
shoppingList = ShoppingListItem()
print(shoppingList.description)

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘’

