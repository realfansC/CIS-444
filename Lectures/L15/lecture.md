
# Lecture 15
### CIS-444


## Recap

In the [previous lesson](https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L14%20More%20View%20Controllers%20and%20lifecycles/lecture.md)  we learned `Comparable` has two requirements: 

1. It requires that the type has adopted the `Equatable` protocol
2. it requires the developer to implement the `<` operator—which will return a `Bool` for whether the left-hand value is less than the right-hand value.

In the previous lesson we wanted to sort the cook program alphabetically by `name`. To do this  we implemented  `<` function to return  `true` if the first letter of the cook program name of the left-hand value is less than the first letter of the cook program `name` of the right-hand value:

```swift
## Previous Lesson
## CookProgram.swift 

static func < (lhs: CookProgram, rhs: CookProgram) -> Bool {
    return lhs.name < rhs.name
}
```

We then used the `sorted(by:)` function to return the array of cook programs sorted by name:

```swift
## Previous Lesson
## CookProgram.swift 

self.cookPrograms = unorderedCookPrograms.sorted(by: >)
```

We also used the `==` operator to check if two cook programs are equal to eachother. But because `CookProgram` is a custom type, we have to tell Swift exactly how to compare two instances for equatity:

```swift
## Previous Lesson
## CookProgram.swift 

static func == (lhs: CookProgram, rhs: CookProgram) -> Bool {
     return lhs.name == rhs.name
 }
 ```

Finally, we wrote a unit test confirming that two cook programs with the same `name` are  equal: 

```swift
func testCookProgramCompareShouldSucceed() {
       let cookProgram1 = CookProgram.init(name: "Pizza", photo: nil, description: nil)
       let cookProgram2 = CookProgram.init(name: "Pizza", photo: nil, description: nil)
       
       XCTAssertEqual(cookProgram1, cookProgram2)
   }
```


## Identifying Comparison limitations 
That wasn't a bad start at implementing an equality check. But it breaks down quickly. 

1. 👀 Download the image assets [here](https://www.dropbox.com/sh/zm5cipp40apwdaf/AABDKSCVnOinK5pIOkim_a_5a?dl=0)  or drag the images below to your desktop.


![inline][choc-chip-cook-img]

![inline][sugar-cooking-img]


2. 👀 Add the images to your project's asset catalog. (Hint: `Assets.xcassets`)

3.  👀 Give each new image a descriptive name

![inline][cookie-asset-img]

4. 👀 Open `CookingPlusTests.swift` 

5. 👀 Below the test case you wrote, add a new test case:

```swift

// Confirm that two `CookProgram`s with different names or  photo , or `programDescription`s are deemed inequal
func testKnownDifferentCookPrograms() {

}
```
The system automatically runs this test case when the unit tests are run.

6. Add tests to the test case using two different images and and `programDescription`s` but the *same name*:

```swift
// Sugar cookie
let cookieProgram1 = CookProgram.init(name: "Cookie", photo: UIImage(named:"chocolate-chip-cookie"), description: "Crisp edges, chewy middles.")

// Chcoolate chip cookie
let cookieProgram2 = CookProgram.init(name: "Cookie", photo: UIImage(named:"sugar-cookie"), description: "Glistens with sugar crystals, and packed with a sweet vanilla-wheat flavor.")

XCTAssertNotEqual(cookieProgram1, cookieProgram2)

```
✅point: Run your unit tests by selecting the Product > Test menu item.
`testKnownDifferentCookPrograms()`  What happens? It failed. We created two very different cook programs with different images and descriptions. They're clearly two very different cook programs. Discuss.

As you see, unit testing helps catch our flawed logic in our code. Two cook programs with the same `name` but different `photo` and `programDescription` values should not be viewed as equal. 


To fix this we need to design a better check to see if two `CookProgram` instances are equal.

### Fixing our comparison loigc

1. Go to `CookProgram.swift`

2. Locate our `==` method

3. Update our `==` to check for `name`, `photo`, `programDescription`

```swift
//MARK: Equatable
static func == (lhs: CookProgram, rhs: CookProgram) -> Bool {
    return lhs.name == rhs.name && lhs.photo == rhs.photo &&  lhs.programDescription == rhs.programDescription
}
```
4. Run our unit test again.  This time it should pass. 

As you grow as a programmer, you'll start to recognize these types of edge cases and you'll learn how to account for them in your code. 

*Why did we not use our `id` property in our comparison method?* Discuss.

🛑🛑🛑🛑🛑
🛑🛑🛑With the above question answered, and a passing unit test,  raise your hand and i will review it before you can move on.


Our cook programs are still in their infancy. Eventually, a cook program should have a list of ingredients. Additionally, the user should be able to select the ingredients they have at home and find cook programs that way. To do this, we need to define a simple `struct` with a name.

### To create a new data model: `Ingredient`

1. 👀Choose File > New > File (or press Command-N).
2. 👀At the top of the dialog that appears, select iOS.
3. 👀Select Swift File, and click Next.
You’re using a different process to create this class than the RatingControl class you created earlier (iOS > Source > Cocoa Touch Class), because you’re defining a base class for your data model, which means it doesn’t need to inherit from any other classes.

4. 👀In the Save As field, type `Ingredient`
5.  👀The save location defaults to your project directory.

The Group option defaults to your app name, `CookingPlus`.
In the Targets section, your app is selected and the tests for your app are unselected.
Leave these defaults as they are, and click Create.

Xcode creates a file called `Ingredient.swift`. In the Project navigator, drag the `Ingredient.swift` file and position it under the other Swift files, if necessary.

In Swift, you can represent the name using a `String`


### To define a data model for an ingredient

1. 👀 Open Ingredient.swift.
2. 👀 Change the import statement to import UIKit instead of Foundation:

```swift
import UIKit
``` 
👀 When Xcode creates a new Swift file, it imports the Foundation framework by default, letting you work with Foundation data structures in your code. You’ll also be working with a class from the UIKit framework, so you need to import UIKit. However, importing UIKit also gives youaccess to Foundation, so you can remove the redundant import to Foundation.

3. Below the import statement, add the following code:

```swift 
import UIKit

struct Ingredient {
    
    //MARK: Properties
    let name: String
}
```
This code defines the basic properties for the data you need to store. You’re making `name` a constant (let) instead of a variable (var) because they will not need to change throughout the course of an `Ingredient` instance.

4. Go to `CookProgramTableViewController.swift` to the method where you created  your cook programs
```swift
private func loadSampleCookPrograms() {
```

5. After the curly bracket (`{`) hit return 

6.  Add the following

`// Ingredients`


7. Below `// Ingredients` begin typing your new ingredient instance and notic what Xcode tries to do for you:

![inline][struct-instance-gif]

Remember: we didn't create an initalizer in `Ingredient`
One of the many nice things about `struct`s is that the compiler will generate a memberwise `init` for free if you don't provide your own init method. 

8. Initialize (3) new `Ingredient`  instances. (Create whatever ingredients you want) 

```swift
let parsley = Ingredient(name: "Parsley")
let salt = Ingredient(name: "Salt")
let pepper = Ingredient(name: "Pepper")
```

9. It should look like this:

```swift
private func loadSampleCookPrograms() {
       
       //  Ingredients
       let parsley = Ingredient(name: "Parsley")
       let salt = Ingredient(name: "Salt")
       let pepper = Ingredient(name: "Pepper")
       ...
```

That's good for now. We will use these ingredients later.


### Encoding and Decoding Objects with Codable

Many apps save user input so that the data still exists the next time the user opens the app. To save user data, the values that live in memory must to be encoded to a form of data that can be written to a file. The `Codable` protocol makes this simple by creating key/value pairs from your object's property names and values that can then be used by an `Encoder` or `Decoder` object.

1. Go to `Ingredient.swift`

Most Swift types that you use from the standard library already conform to `Codable`. If our `Ingredient` type's properties conform to `Codable` then all we have to do is add `Codable` to the type declaration and the Swift compiler will autogenerate the necessary implementation. 

2. After `Ingredient` add a colon (`:`) and `Codable`

```swift
struct Ingredient: Codable
```
This lets an `Encoder` or `Decoder` object know that your type has all of the information it needs to be able to encode or decode your object to or from a certain data format.

3. Go back to `CookProgramTableViewController.swift` and navigate to your method `loadSampleCookPrograms()` 

4. Right below where you initalized your ingredient instances add the following:

```swift
let jsonEncoder = JSONEncoder()
if let jsonData = try? jsonEncoder.encode(parsley), let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}
```

The `encode(_:)` method on `JSONEncoder` is considered a throwing function, a special type of Swift function that can return specific types of errors. 

The`try?` syntax in the following  allows the function to return an optional value. If there's no error, the optional will hold the expected value; if there is an error, the optional will be `nil`.  If you get an error saying "Use of unresolved identifier `\JSONEncoder\`," make sure you import Foundation, the framework in which `JSONEncoder` is defined.

The string printed to the console allows you a glimpse of how your object was converted into a different format but still represents the same information. By using `Codable`, you can easily convert your app's information to and from a variety of formats. The `Codable` protocol will come in handy in future lessons when we save user data or import data from   web services.



[choc-chip-cook-img]:resources/chocolate-chip-cookie.png
[sugar-cooking-img]:resources/sugar-cookie.png

[cookie-asset-img]:resources/cookie-asset-catalog.png

[struct-instance-gif]:resources/struct-auto-complete.gif
