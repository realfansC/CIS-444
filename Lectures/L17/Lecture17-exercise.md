## Lecture 17.0
March 11, 2020

## Pre-read:
* [Swift Docs: Enum](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)


## Learning Objectives

At the end of the lesson, you'll be able to:

* Enumeration (Enum) defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.

## Enumerations
As a programmer, you'll work with many situations that require you to assign values from a limited number of options. Imagine you're writing a program that allows passengers to select a seat from three options: window, middle, and aisle. In Swift, you'd do this with an enumeration.

An enumeration, or enum, is a special Swift type that allows you to represent a named set of options. In this lesson, you'll learn when enumerations are commonly used, how to define an enumeration, and how to work with enumerations using switch statements.

### What You'll Learn
* Why enumerations are a useful tool
* How to define simple enumerations
* How to define enumerations with raw values
* How to work with enumerations using the switch statement”


#### Adding `mealType` property

Imagine our user Noelle is going to a friend's house for a party. The host of the party asked Noelle to bring a dessert. She wants to use our app to bake something for the party. Pretend our app is wildly succesful and has thousands of reciepes. Noelle only really wants to see desserts. To do that, we will let our users filter recipes like this:

![inline]()

But first we need to make some additions and modifications to our `CookProgram.swift` class.


1. Open `CookProgram.swift`

2. Below `var programDescription: String?` add another  property 

```swift 
let mealType: String
```
We made `mealType` a constant (`let`) because it does *not* need to change throughout the course of a `CookProgram` object’s lifetime. (Note: `name`, `id`, `photo` , & `programDescription` will not change throughout the course of the cook program's lifetime either and can be changed  to `let`)

```swift 
let name: String
let id:   UUID
let photo: UIImage?
let programDescription: String? 
let mealType: String
```

4. Build the codebase ( `Product > Build` or keyboard shortcut `Command + B`)
Xcode gives us an error:

`Variable 'self.mealType' used before being initialized`

If you're not sure what to do here, google the error or search [swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#).


5. Adjust the `CookProgram.swift`  initializer to accept a `mealType` parameter as part of the iniitalizer's definition:

```swift
init?(name: String, photo: UIImage?, description: String?, mealType: String) {
```
Build the codebase ( `Product > Build` or keyboard shortcut `Command + B`)

Shoot. Xcode is still throwing the same error:

`Variable 'self.mealType' used before being initialized`

This is because we added the `mealType` initialization parameter as part of our `CookProgram`'s initializer’s definition. However, we didn't assign our property `mealType` to the new parameter `mealType`

6. In the initializer, assign the property `self.mealType` to our parameter `mealType`

```swift
self.mealType = mealType
```

Your `CookProgram.swift`'s initializer should look like this:

```swift
//MARK: Initialization
  init?(name: String, photo: UIImage?, description: String?, mealType: String) {
      // Initialization should fail if there is no `name`
      guard !name.isEmpty else {
          return nil
      }

      // Initialize stored properties.
      self.name = name
      self.id   = UUID()
      self.photo = photo
      self.programDescription = description
      self.mealType = mealType
  }
```


7. Build the codebase ( `Product > Build` or keyboard shortcut `Command + B`)

🤬 We still have compiler errors.  

``Missing argument for parameter 'mealType' in call``

Let's try to make sense of it.

Go to the origin of the compiler error:
`CookProgramTableViewController.swift` instance method: `func loadSampleCookPrograms()` 


Recall a few classes ago we used this method to instiante several `CookProgram` instances. Think carefully about what the error is saying related to the changes we just made to the `CookProgram` initalizer.

``Missing argument for parameter 'mealType' in call``

This makes sense. in `CookProgram.swift` we added a new parameter `mealType`  in the initailizer. However, we haven't set that value in our cook program instances.

8. Add `mealType` parameter to our cook instance. After our `description` value  comma (`,`)  `mealType` colon `:` and the meal type for your `CookProgram` instance. 

Example:

```swift
guard let cookProgram1 = CookProgram(name: "Roasted Asparagus",
                                         photo: photo1, description: "Salty and savory, the roasting method kills the natural bitterness of asparagus. Try it next to grilled fish or lamb.", mealType: "Appetizer")
```

Fix the rest of the cook program instances  
🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑
Do not proceed until you fix all your cook program instances with `mealType` parameter and value.  Don't proceed until your project compiles. If you're having trouble: try googling the error or message me directly on Slack.
🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑


### Stringly Typed vs Strongly Typed

Now that your code compilers, do you notice a problem with the following `CookProgram` `mealType`  instance?

example: 

```swift
guard let cookProgram3 = CookProgram(name: "Chocolate Brownies", photo: photo3, description: "Melted chunks of chocolate.", mealType: "Desseert") else {
          fatalError("Unable to instantiate cookProgram3")
}
```

Many Swift developers would say that `mealType` is "stringly typed" instead of "strongly typed." What they're referencing is the fact that `mealType` is prone to all the errors that `String` values face—and one them is incorrect spelling. Imagine you wrote code to fetch all the cook programs with meal type `Dessert`.

```swift
var unorderedCookPrograms = [CookProgram]()
unorderedCookPrograms += [cookProgram1, cookProgram2, cookProgram3, cookProgram4]
let desserts = unorderedCookPrograms.filter({ $0.mealType == "Dessert" })
```

✏️ Explain why the above query would or would not return `cookProgram3`


As a better practice, we could assign `mealType` a value from an enumeration called `Meal`. 


## Create a meal type `enum`

Enumerations define a common type for a group of related values.
Consider the possible meal type a recipe could have: `Side`, `Dessert`, `Lunch`, `Dinner`, `Snack`, `Appetizer`, `Brunch`, `Breakfast`, `Beverage`. The enum can help users view  cook programs of a specific meal type. 

You define a new enumeration using the keyword `enum`. 

### Creating a meal type enum

1. Choose File > New > File (or press Command-N).
2. At the top of the dialog that appears, select iOS.
3. Select Swift File, and click Next.
You’re defining a base class for your data model, which means it doesn’t need to inherit from any other classes.
4. In the Save As field, type `Meal`.
5. The save location defaults to your project directory.
The Group option defaults to your app name, `CookingPlus`.
In the Targets section, your app is selected and the tests for your app are unselected.
6. Leave these defaults as they are, and click Create.
Xcode creates a file called `Meal.swift`. In the Project navigator, drag the `Meal.swift` file and position it under the other Swift files, if necessary.

In Swift, you can represent the name using an enum

### Define a enum meal

1. If the [assistant editor](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW76) is open, return to the standard editor by clicking the Standard button.

2. Open `Meal.swift`.

3. Below the import statement, add the following code:

```swift

enum Meal {
    case side
    case dessert
    case lunch
    case dinner
    case snack
    case appetizer
    case brunch
    case breakfast
    case beverage
}
```

The `enum` defines the type, and the case options define the available values allowed with the type. It's best practice to capitalize the name of the enumeration and to lowercase the case options.
You can also define the available cases, separated by commas, on a single line:

```swift
enum Meal {
    case side, dessert, lunch, dinner, snack, appetizer, brunch, breakfast, beverage
}

```

Once you've defined the enumeration, you can start using it like any other type in Swift. Just specify the enumeration type along with the value:

```swift

var mealType = Meal.dessert
// The compiler assigns `mealType` as a `Meal` by 
type inference. 

// or 

var mealType: Meal = .dessert
// The compiler assigns `mealType` as a `Meal` 
because of the type annotation. The value can then be assigned 
with dot notation.
```

Now that the type of `mealType` is set, you can change the value to another meal type  using the shorter dot notation:

```swift
mealType = .lunch
```

### Control Flow

In previous lessons you learned how to use `if` statements and `switch` statements to respond to `Bool` values. You can use the same control flow logic when working with different cases of an enumeration.

Consider the code below that prints a different sentence based on which `Meal` is set to the `mealType` constant:

```swift
    var mealType = Meal.dessert
    
    switch mealType {
    case .side:
        print("side")
    case .dessert:
        print("dessert")
    case .lunch:
        print("lunch")
    case .dinner:
        print("dinner")
    case .snack:
        print("snack")
    case .appetizer:
        print("appetizer")
    case .brunch:
        print("brunch")
    case .breakfast:
        print("breakfast")
    case .beverage:
        print("beverage")
        
    }
```
### Type Safety Benefits

Enumerations are especially important in Swift because they allow you to represent information, such as strings or numbers, in a type-safe way.

Update your `CookProgram` `mealType` type to `Meal`

1. `CookProgram.swift` modify the existing `mealType` property value to `Meal`

```swift
let mealType: Meal
```

Your `CookProgram` properties should look like this:

```swift
//MARK: Properties

let name: String
let id:   UUID
let photo: UIImage?
let programDescription: String?
let mealType: Meal
```

2.  Build the codebase ( `Product > Build` or keyboard shortcut `Command + B`)

🤬 Compiler error:
`Cannot assign value of type 'String' to type 'Meal'`  

Remember in our `CookProgram` initailizer we pass in a `String` and assign it to our `mealType` property:

```swift
init?(name: String, photo: UIImage?, description: String?, mealType: String) {
```

However, our `mealType` is *no longer a `String`*.
mealType: <s>String</s>
mealType: Meal

3. Update our `CookProgram` initializer to accept a `Meal` type.

```swift
init?(name: String, photo: UIImage?, description: String?, mealType: Meal) {
```

4. Fix our CookProgram instances to pass in a `Meal` type

Go to `CookProgramTableViewController.swift` to our method:
`loadSampleCookPrograms()` and update the value we pass in `mealType` to of `Meal` type

```swift
guard let cookProgram1 = CookProgram(name: "Roasted Asparagus",
                                           photo: photo1, description: "Salty and savory, the roasting method kills the natural bitterness of asparagus. Try it next to grilled fish or lamb.", mealType: Meal.side)
                                           
                                           // or
guard let cookProgram1 = CookProgram(name: "Roasted Asparagus",
                                           photo: photo1, description: "Salty and savory, the roasting method kills the natural bitterness of asparagus. Try it next to grilled fish or lamb.", mealType: .side)
                                           
```

🛑🛑🛑🛑🛑
Fix the rest of the cookProgram instances with `meal`  type passed in the initailizers. 

✏️ Below  our assignment of ordered array of cookPrograms: `self.cookPrograms = unorderedCookPrograms.sorted(by: >)`  use the `filter` method on `cookPrograms` to retrieve  all cookprograms of `mealType` `.dessert`

✏️ Create a new enum: `SkillLevel` with 
