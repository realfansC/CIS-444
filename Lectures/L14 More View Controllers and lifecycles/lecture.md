
# CIS-444
### Lecture 14

🛑 Prior to beginning this lesson make sure you  completed everything in [lecture 13](Lecture-13). Your app should currently should look something like this:

![inline][cook-program-list-beg-img]
![inline][cook-program-details-beg-img]


## Protocols

A [protocol](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html) is a set of rules or procedures that define how things are done. Computers communicate with each other using protocols like HTTP (Hyper Text Transfer Protocol) and TCP/IP (Transmission Control Protocol/Internet Protocol). HTTP is a standard that defines how website data is communicated between two computers. TCP/IP is a communications standard that defines how computers find and send data to each other.  

In programming, a protocol defines the properties or methods that an object must have in order to complete a task. For example, the `Equatable` protocol says that a type must define a `==` method to check if two instances are equal to each other.

In this lesson, you'll learn what protocols are, when to use them, and how to write your own. You'll learn about delegation, a pattern for enabling objects to communicate with each other. You'll also learn how to extend protocols to provide shared functionality across multiple types.

### Learning Objectives:
* What protocols are and why they're used
* How to learn about and adopt Swift protocols 
* How to check if instances of your custom types are equal, greater than, or less than eachother
* How to print custom information about your custom objects to the console

### Vocabulary
* adopt
* `Codable`
* `Comparable`
* `CustomStringConvertible` 
* `Equatable`
* implementation
* protocol
* read-only
* read/write

 A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by another type, which provides the actual implementation for those requirements. Any type that satisfies the requirements of a protocol conforms to that protocol.


The Swift standard library defines many protocols that you'll use when building apps. In the following sections, you'll look at three of them: `CustomStringConvertible`, which allows you to control how your custom objects are printed to the console; `Equatable`, which allows you to define how instances of the same type are equal to each other; `Comparable`, which allows you to define how instances of the same type are sorted; and `Codable`, which allows you to easily encode your type's properties as key/value pairs that can then be saved between app launches.

When you adopt a protocol in Swift, **you're promising to implement all the methods required by that protocol.** The compiler will check that everything's in order and won't build your program if anything is missing.


## Printing information with `CustomStringConvertible`

You can begin to understand the role of a protocol by considering how objects are printed to the console using the `print()` function. We use `print` and `os_log` for debugging purposes. 

*Note: In the last lesson we used `os_log` to display debug information in our console. In this lesson we're going to use `print`  to display text in our console output. In the next section we're going to discuss the differences between `os_log` and `print` and when to use which.*


### Adding a `print()` statement to `CookProgramDetailsViewController`

Running the `print()` function on a variable will write the textual representation of the object to the console. You can print `String` values, `Int` values, and `Bool` values with predictable results:

1. In `CookProgramDetailsViewController.swiift` `viewDidLoad()`  just below         `super.viewDidLoad()` add the following

```swift
let string = "Hello, world!"
print(string)

let number = 42
print(number)
 
let boolean = false
print(boolean)
```


2. Run the app and select a cook program

The console [console](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/chapters/debugging_tools.html) output should look like this:

```console
Hello, world!
42
false
```

But what if we want to print our `CookProgram` object's properties?

```swift
class CookProgram {
    
    //MARK: Properties
    
    var name: String
    var id:   UUID
    var photo: UIImage?
    var description: String?
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, description: String?) {
        // Initialization should fail if there is no `name`
        guard !name.isEmpty else {
            return nil
        }

        
        // Initialize stored properties.
        self.name = name
        self.id   = UUID()
        self.photo = photo
        self.description = description
    }
}
```


3. Below the previous print statements you just added, add a print statement to display the textual representations of  `cookProgram`

```swift
print(cookProgram)
```

3. Run the app, select a cook program and view the console output

It should look something like this:

```console
Hello, world!
42
false
Optional(CookingPlus.CookProgram)
```

As you can see, this print statement isn't at all helpful. Swift defines a protocol called `CustomStringConvertible` to address this kind of situation. `CustomStringConvertible` has one required computed property, description, which returns a `String` representation of the instance. If you adopt the protocol, you control exactly how your custom types are represented as printable `String `values.

### Adopting the `CustomStringConvertible` protocol 

Review the [CustomStringConvertible](https://developer.apple.com/documentation/swift/customstringconvertible) documentation

1. Navgiate to `CookProgram.swift`

2. Locate the class declaration:

```swift 
class CookProgram {
```

3. After `CookProgram` add a colon (:) and add `CustomerStringConvertible`

```swift
class CookProgram: CustomStringConvertible
```

Any class adhering to the `CustomStringConvertible` protocol requires (1) variable named `description` 

## To implement the  `description` computed property.

1. In `CookProgram.swift` before the last curly brace (}) add the following:

```swift

//MARK: CustomStringConvertible
```
This is a comment to help you (and anybody else who reads your code) know that the code in this section is related to `CustomStringConvertible` conformance


2. Below the comment, add this method:


```swift
var description: String {
    return "CookProgram(name: \(name), id: \(id), description: \(description)"
}
```

Now you will see a new Xcode compiler error:

```console
Invalid redeclaration of 'description'
```

Whoops. This is because we used the var `description`  as a property in `CookProgram`. 

```swift
//MARK: Properties
 
 var name: String
 var id:   UUID
 var photo: UIImage?
 var description: String?
 ```

### How to resolve Invalid redeclaration of `description`

1. In `CookProgram.swift` update our property `description` to `programDescription`

```swift
//MARK: Properties
 
 var name: String
 var id:   UUID
 var photo: UIImage?
 var programDescription: String?
 ```

But there's still a compiler error to deal with:

```console
Cannot assign to property: 'description' is a get-only property
```

2.  Update `CookProgram` 's `var description`  value to reference `programDescription` 
 
```swift
//MARK: CustomStringConvertible
var description: String {
    return "CookProgram(name: \(name), id: \(id), programDescription: \(programDescription)"
}
```


 4. Run the app, select the cook program and view the console output:
 
 ```console
 Optional(CookProgram(name: Roasted Carrots, id: 78F2340D-4E43-4907-AD2C-90E8473C8C31, programDescription: Optional("Buttery, tender carrots roasted with the best sauce!"))
```
 
 Note that the code prints out what looks like an initializer for each object. That's a common practice, because it enables you to see each property on the object in a familiar, concise format. However, you can print anything you want.
 
 ```swift
 var description: String {
       let doesOrDoesNot = photo != nil ? "does" : "does not"
       return "CookProgram(name: \(name), id: \(id) and \(doesOrDoesNot) have photo"
   }
```

console output:

```console
Optional(CookProgram(name: Roasted Asparagus, id: 649B7A0F-BD2E-4D73-A4AC-46B2D92B7D23 and does have photo)
```

✅Point: Run the app & select a cook program from the list and look at the view 

![inline][cook-program-description-wrong-img]

Does the information displayed look correct? Compare it with what it looked like at the beginning of this lesson: 

 |  | 
--- |  ---
![][cook-program-details-beg-img] | ![][cook-program-description-wrong-img]


Spot the difference:
*The text describing the dish has been replaced with our CustomStringConvertible value containing information that does not concern the user.*


### Fixing the display text

1. Go to `CookProgramDetailsViewController.swift`

2. in `viewDidLoad()` locate where we assign the  `descriptionLabel.text` value

```swift
descriptionLabel.text = cookProgram.description
```

3. Update the `descriptionLabel.text` to our `programDescription` value

```swift
descriptionLabel.text = cookProgram.programDescription
```
✅Point: Run the app and select a cook program. The cook program's detailed description should be restored. 


## Comparing `CookProgram` instances
 
 In the last lesson we manually created cook programs in `CookProgramTableViewController.swift`
 
 ```swift
 private func loadSampleCookPrograms() {
     let photo1 = UIImage(named: "asparagus")
     let photo2 = UIImage(named: "bagel")
     let photo3 = UIImage(named: "brownies")
     let photo4 = UIImage(named: "carrots")
     
     guard let cookProgram1 = CookProgram(name: "Roasted Asparagus", photo: photo1, description: "Salty and savory, the roasting method kills the natural bitterness of asparagus. Try it next to grilled fish or lamb.") else {
         fatalError("Unable to instantiate cookProgram1")
     }
      
     guard let cookProgram2 = CookProgram(name: "Toasted Bagel", photo: photo2, description: "Creates a crust that's dense and chewy, but tender and easy to bite through.") else {
         fatalError("Unable to instantiate cookProgram2")
     }
      
     guard let cookProgram3 = CookProgram(name: "Chocolate Brownies", photo: photo3, description: "Perfect crisp crackly top, super fudgy centre, chewy or gooey in all the right places, studded with melted chunks of chocolate.") else {
         fatalError("Unable to instantiate cookProgram3")
     }
     
     guard let cookProgram4 = CookProgram(name: "Roasted Carrots", photo: photo4, description: "Buttery, tender carrots roasted with the best sauce!") else {
             fatalError("Unable to instantiate cookProgram3")

         }
     
     ......
 }
 ```

What if want to compare two cook programs to make sure we didn't add two of the same cook programs?


###  How to compare (`2`) cook programs

1.  Below the declaration of your cook programs, add the following code:

```swift

if cookProgram1 == cookProgram2 {
    print("Oh no! \(cookProgram1) and \(cookProgram2) are identical")
}
```

This code uses the `==` operation to compare `cookProgram1` and `cookProgram2` are equal. But because `CookProgram` is a custom type, you must tell Swift exactly how to compare two instances for equality.  You'll do this by adopting the `Equatable` protocol.


### Add `Equatable` protocol conformity to `CookProgram

2. In `CookProgram.swift` find the class declaration:

```swift
class CookProgram: CustomStringConvertible {
```

2. After  `CustomStringConvertible` add a comma and add `Equatable`
```swift
class CookProgram: CustomStringConvertible, Equatable {
```

The `Equatable` protocol requires you to provide an implementation for the `==` operator for your custom type.

```swift
<s>static func == (lhs: Self, rhs: Self) -> Bool</s>
static func == (lhs: CookProgram, rhs: CookProgram) -> Bool 
  
```

Conforming to the protocol requires a static `==` function that takes lhs (left-hand side) and rhs (right-hand side) parameters and returns a Bool that says whether the two values are equal:

### To implement the == `Equatable` method:

1. In `CookProgram.swift`  before the last curly brace (}), add the following:

```swift
//MARK: Equatable
```

This is a comment to help you (and anybody else who reads your code) know that the code in this section is related to equatable protocol

2. Below the comment, add this method:

```swift
static func == (lhs: CookProgram, rhs: CookProgram) -> Bool {
       
}
```

3. In `==(lhs:, rhs:)` add the following code:

```swift
return lhs.name == rhs.name
```
In this case we determine two cook programs are equal if they both have the same `name` value. 


🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑
✅Point: What's the easiest way to test this? A unit test of course.  Navigate to `CookingPlusTests.swift` and write a test that compares two cook programs with the same name. Refer back to previous lesson on unit testing or find the documentation online. 
Hint: `XCTAssertEqual`

Once you have a working solution and can explain it to me, raise your hand for me to confirm. Do not proceed until this is done.

## Sorting information with `Comparable`

In a previous lesson I asked you to present to the user a list of cook programs alphabetically by `name`. Most of you came up with solutions similar to this:

```swift
var unorderedCookPrograms = [CookProgram]()
       unorderedCookPrograms += [cookProgram1, cookProgram2, cookProgram3, cookProgram4]
       
       self.cookPrograms = unorderedCookPrograms.sorted { $0.name < $1.name}
```

An even better way to sort custom objects is using `Comparable`

Swift provides a protocol, called `Comparable`, that allows you to define how to sort objects using the `<`, `<=`, `>`, or `>=` operators.

### Add `Comparable` protocol conformity to `CookProgram`
 
 1. In  `CookProgram.swift` find the `class` line:


 2. After  `Equatable` add a comma (`,`) and `Comparable` to adopt the `Comparable` protocol
 
 ```swift
 class CookProgram: CustomStringConvertible, Equatable, Comparable {
 ```

 `Comparable` has two requirements: It requires that the type has adopted the `Equatable` protocol, and it requires the developer to implement the `<` operator—which will return a `Bool` for whether the left-hand value is less than the right-hand value.

We already adopted the `Equatable` protocol leaving us to implement the `<` operator. 

* [x]  Adopt `Equatable` protocol
* [ ] Implement `<` operator

3. In `CookProgram.swift` , before the last curly brace (`}`) add the following:

```swift
//MARK: Comparable
```

This is a comment to help you (and anyone else who reads your code) know that code in this section is related to `Comparable` protocol 

4. Below the comment, add this method:

```swift
static func < (lhs: CookProgram, rhs: CookProgram) -> Bool {

}
```

5. In the `<(lhs:, rhs)` method, add the following code:

```swift
return lhs.name < rhs.name
```

In this case, you want to sort the cook programs alphabetically by name. You can implement the < function to return true if the first letter of the cook program name of the left-hand value is less than the first letter of the cook program name of the right-hand value:

WIth this logic we no longer need to handle name sorting in `CookProgramTableViewController`. 

6. Go to `CookProgramTableViewController.swift` 

7. Locate the logic you wrote in last class where you sorted cook programs alphabetically

```swift
private func loadSampleCookPrograms() {
...
     
     var unorderedCookPrograms = [CookProgram]()
     unorderedCookPrograms += [cookProgram1, cookProgram2, cookProgram3, cookProgram4]
     
     self.cookPrograms = unorderedCookPrograms.sorted { $0.name < $1.name}
 }
```

8. Delete the sorted logic you wrote last class

<del>self.cookPrograms = unorderedCookPrograms.sorted { $0.name < $1.name}</del>


9. Add the following:

```swift
self.cookPrograms = unorderedCookPrograms.sorted(by: <)
```

✅Point: Run your code. Confirm your cook programs are still presented alphabetically

🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑
🛑 In the same method, add a loop displaying all your cook programs and print their properties using the `description` value we added. BEFORE MOVING ON: Raise your hand and allow me to confirm your console  output. Depending on your `description`, your console output should look something like this:

```
CookProgram(name: Chocolate Brownies, id: 4248D59B-86E1-4837-B77D-BD4E44163341 and Does have photo
CookProgram(name: Roasted Asparagus, id: CFE9DEF9-AB2E-4F94-BB89-A803C47C7451 and Does have photo
CookProgram(name: Roasted Carrots, id: 3E50C9E2-94E6-4ABE-9A3B-52DF60E19396 and Does have photo
CookProgram(name: Toasted Bagel, id: E7716AF4-7221-46A9-8D1F-7D524AF01C74 and Does have photo
```

## Using other comparison operations 

Swift is smart. It can use both the `==` operator and the `<` operator that you defined in the Equatable and Comparable protocols to provide functionality for the `<=`, `>`, and `>=` operators as well.

### How to display your list of cook programs in descending order:

1. In `CookProgramTableViewController.swift` find the logic the comparison logic we  wrote in the last section

```swift
self.cookPrograms = unorderedCookPrograms.sorted(by: <)
```

2. Replace `<` with `>` 

3. Run the app

✅Point: Run your code. Confirm your cook programs are now displaying in descending order

Console output:

```
CookProgram(name: Toasted Bagel, id: DA9D0C57-6506-4443-83BE-D2B6099BAC33 and Does have photo
CookProgram(name: Roasted Carrots, id: EEF9D4DB-BDC8-481B-B078-D809B6323BEB and Does have photo
CookProgram(name: Roasted Asparagus, id: 89E55329-52D9-479D-9F08-D3E47434286A and Does have photo
CookProgram(name: Chocolate Brownies, id: A0A7C745-F527-469B-94C3-F89BEDCB9219 and Does have photo
```


[Lecture-13]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L13%20View%20Controllers%20and%20lifecycles/Exercise13.md


<!--- Images ---> 

[cook-program-details-beg-img]:resources/l14-cook-details-beginning.png
[cook-program-list-beg-img]:resources/l14-cook-list-beginning.png
[cook-program-description-wrong-img]:resources/l14-description-wrong.png
