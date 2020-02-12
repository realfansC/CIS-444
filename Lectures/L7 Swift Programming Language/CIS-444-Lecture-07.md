# CIS-444
# Lecture-07: More Swift
---
#Today:

- "Help me I'm stuck" video guide series
- API Overview
- Mostly more Swift 
- Protocols 
- String
- `NSAttributedString`
- Closures (and functions as types in general)


--- 
## What is an API?

---
## What is an API?
- Not a 🍺
- Application Programming Interface

---
## What is an API?
- Not a 🍺
- Application Programming Interface
- Definition: An application programming interface (API) is a particular set of rules ('code') and specifications that software programs can follow to communicate with each other. It serves as an interface between different software programs and facilitates their interaction, similar to the way the user interface facilitates interaction between humans and computers.

---
## What is an API?

Example: Think of an API like a menu in a restaurant. The menu provides a list of dishes you can order, along with a description of each dish. When you specify what menu items you want, the restaurant’s kitchen does the work and provides you with some finished dishes. You don’t know exactly how the restaurant prepares that food, and you don’t really need to.

---
## What is an API?

It's a bunch of operations that a controller can use without knowing the nitty gritty details behind the scenes.


---
## What is an API

Say I want to give my user in our app (CaptionThat) the ability to upload a photo from their phone's photo library to our app.

---
## What is an API

Feature from user's perspective 
1. I open CaptionThat App,
2. I tap a button that says, "Add Photo"
3. Still in the app, a view pops up with my photo library available for me to see
4. I select a photo from my library
5. The photo library view disappears
6. And the photo I selected is in CaptionThat UIImageView

---
...looks like a lot of work. But it's not, because there's an API for that

![left](/Users/rebeccaslatkin/Desktop/Screenshot 2019-09-13 at 10.47.41 AM.png)

---
## What is an API?

Quickly:
UIImagePickerController

Using  `UIImagePickerController` API, the user has the ability to choose an image from the photo library, take a photo using out-of-box-controls from the UIImagePickerController API, and then display an image in the view after choosing.

---

```swift 
        self.pickerController = UIImagePickerController()
        pickerController?.delegate = self
        pickerController?.allowsEditing = true
        pickerController?.sourceType = .photoLibrary
```

![right](/Users/rebeccaslatkin/CIS-444/Lectures/L7 Swift Programming Language/Assets/Caption-That-Camera.png)

---

```swift
public protocol UIImagePickerControllerDelegate : NSObjectProtocol

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])

func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
```
---

```swift
extension ViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.generate(with: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            self.generate(with: nil)
            return
        }
        self.generate(with: image)
    }
}
```

--- 

# Data Structures

4 Essential Data Structure-building Concepts in Swift:
	1️⃣ `class`
	2️⃣ `**struct**`
	3️⃣ `enum`
	4️⃣ `**protocol**`


--- 
# struct

- One way to create your own custom data type in code. 

```swift
struct Sport {
    let numberOfPlayers: String
    let mascot: String
    let djskald
}
```

- `struct` can hold properties, define behavior as methods, and define initializers to setup its initial state.
- **Every** instance of a `struct` has it's own separate identity 

---
# struct

- Value type (`struct`s don't live in the heap and are passed around by **copying** them)
- Very efficient "copy on write" is automatic in Swift
- This copy on write behavior requires you to mark `mutating` methods

--- 
# struct

- No inheritance (of data) 

```swift
struct Sport {
    let numberOfPlayers: String
    let mascot: String
    let djskald
}

struct Soccer: Sport { 🚫 // this will not compile
...
}
```

--- 
# struct

- Mutability controlled via `let` (e.g. you can't add elements to an `Array` assigned by `let`)

---
# struct

- Supports functional programming design 
- Examples: `Caption.swift`, `Array`, `Dictionary`, `String`, `Character`, `Int`, `Double`, `UInt32`


---
# struct

💥 We've already written two `struct`s:

```swift
struct Caption {
    let text: String
    let author: String
}

struct Photo {
    let name: String
}
```

---

## If we can't do this with a struct, what are our options?
 
 ```swift
struct Sport {
    let numberOfPlayers: String
    let mascot: String
    let djskald
}

struct Soccer: Sport { 🚫 // this will not compile
...
}
```

---
# protocol

---
# protocol

- A **type** which is a declaration of **functionality only**
- No data storage of any kind (so it doesn't make sense to say it's a *value* or *reference* type)
- Essentially provides multiple inheritance (of functionality only, not storage) in Swift

---
# Protocols = 🤯

---
# Protocols


- Protocols are a way to express an API more concisely 

- Instead of forcing the caller of an API to pass a specific `class`, `struct`, or `enum`, an API can let callers pass **any** `class`/`struct`/`enum` that **the caller wants**

- The API expresses the functions or variables it wants the caller to provide using a `protocol`

- So a `protocol` is simply a collection of method and property **declarations**

---
# What is a `protocol` good for?

- Making API more flexible and expressive
- Blind, structured communication between view and controller (delegation)
- Mandating behavior (e.g. the keys of a `Dictionary` must be washable)
- Sharing functionality in disparate types (`String`, `Array`, `CountableRange` are all `Collections`)
- Multiple inheritance (of functionality, not data)

---
# Protocols

- Remember: A `protocol` is a TYPE
- It can be used almost anywhere any other type is used: `var`s, `function` parameters, etc.


--- 
# Protocols 

### There are 3️⃣ aspects to a protocol 
 
---
# Protocols

Aspect #1️⃣:  The protocol __declaration__ (which properties and methods are in the `protocol`)

---
# Protocols

Aspect #2️⃣: A `class`, `struct`, or `enum` declaration that makes the **claim** to implement the `protocol`

---
# Protocols

Aspect #3️⃣: The **code** is said `class`, `struct`, or `enum` (or `extension`) that implements the `protocol`

---
# Protocols
### Optional methods in a protocol

---
# Protocols
### Optional methods in a protocol

- Normally any `protocol` implementor must implement **all** the methods/properties in the protocol 

However.... It **is** possible to mark some methods in a protocol `optional`
(Don't get confused with the type Optional, a totally different thing)

---
# Protocols
### Optional methods in a protocol

- Any `protocol` that has `optional` methods must be marked with `@objc`

- AND any `class` that *implements* an optional `protocol` must inherit from **NSObject**

- These sorts of `protocol`s are used often in iOS for **delegate** (more later on this)

---
# Protocols
### Optional methods in a protocol

- Except for delegation, a `protocol` with `optional` methods is rarely (if ever_ used
- As you can tell from the `objc` designation, it's mostly for backwards compatibility

---
# Protocols

```swift
// Declaration of the `protocol` itself
protocol SomeProtocol: InheritedProtocol1, InheritedProtocol2 {
   var someProperty: Int { get set }
   func aMethod(arg1: Double, anotherArgument: String) -> SomeType
   mutating func changeIt()
   init(arg: Type)
}
```

---
# Protocols

```swift
// Declaration of the `protocol` itself
// 📌 Anyone that implements `SomeProtocol` must also implement 
// `InheritedProtocol1` and `InheritedProtocol2`
protocol SomeProtocol: InheritedProtocol1, InheritedProtocol2 {
   var someProperty: Int { get set }
   func aMethod(arg1: Double, anotherArgument: String) -> SomeType
   mutating func changeIt()
   init(arg: Type)
}
```

---
# Protocols

```swift
// Declaration of the `protocol` itself
// 📌 Anyone that implements `SomeProtocol` must also implement 
// `InheritedProtocol1` and `InheritedProtocol2`
protocol SomeProtocol: InheritedProtocol1, InheritedProtocol2 {
   // 📌 You must specify whether a property is `get` only 
   // or both `get` and `set`
   var someProperty: Int { get set }    
   func aMethod(arg1: Double, anotherArgument: String) -> SomeType
   mutating func changeIt()
   init(arg: Type)
}
```

---
# Protocols

```swift
// Declaration of the `protocol` itself
// 📌 Anyone that implements `SomeProtocol` must also implement 
// `InheritedProtocol1` and `InheritedProtocol2`
protocol SomeProtocol: InheritedProtocol1, InheritedProtocol2 {
   // 📌 You must specify whether a property is `get` only 
   // or both `get` and `set`
   var someProperty: Int { get set }    
   func aMethod(arg1: Double, anotherArgument: String) -> SomeType
   // 📌 Any functions that are expected to mutate the receiver should be marked `mutating`
   mutating func changeIt()
   init(arg: Type)
}
```
---
# Protocols

```swift
// Declaration of the `protocol` itself
// 📌 Anyone that implements `SomeProtocol` must also implement 
// `InheritedProtocol1` and `InheritedProtocol2`
protocol SomeProtocol : 🚨class🚨, InheritedProtocol1, InheritedProtocol2 {
   // 📌 You must specify whether a property is `get` only 
   // or both `get` and `set`
   var someProperty: Int { get set }    
   func aMethod(arg1: Double, anotherArgument: String) -> SomeType
   // 📌 Any functions that are expected to mutate the receiver should be marked `mutating`
   // 📌 UNLESS you are going to restrict your protocol to class implementers only with `class` keyword
   mutating func changeIt()
   init(arg: Type)
}
```

---
# Protocols

```swift
// Declaration of the `protocol` itself
// 📌 Anyone that implements `SomeProtocol` must also implement 
// `InheritedProtocol1` and `InheritedProtocol2`
protocol SomeProtocol : 🚨class🚨, InheritedProtocol1, InheritedProtocol2 {
   // 📌 You must specify whether a property is `get` only 
   // or both `get` and `set`
   var someProperty: Int { get set }    
   func aMethod(arg1: Double, anotherArgument: String) -> SomeType
   // 📌 Any functions that are expected to mutate the receiver should be marked `mutating`
   // 📌 UNLESS you are going to restrict your protocol to class implementers only with `class` keyword
   mutating func changeIt()
   //📌 You can even specify that implementers must implement a given `init`ializer 
   init(arg: Type)
}
```

---
## Protocols
## How can implementer say, "I implement that protocol"⁉️⁉️⁉️⁉️

---
## Protocols
### type: `class`

- How can an implementer of type `class` say, "I implement that protocol"?

```swift
class SomeClass: SuperclassOfSomeClass, ➡️SomeProtocol⬅️, ➡️AnotherProtocol⬅️ {
   // implementation of SomeClass here
   // which **must** include all the properties and 
   // methods in `SomeProtocol` and `AnotherProtocol`
}
```

- Claims of conformance to protocols are listed after the superclass of a class

---
## Protocols
### type: `enum`

- Obviously, `enum`s and `struct`s would not have the superclass part 

- How can an implementer of type `enum` say, "I implement that protocol"?

```swift
enum SomeEnum: SomeProtocol, AnotherProtocol {
    // implementation of SomeEnum here
    // which must include all the properties and methods in SomeProtocol & AnotherProtocol
}
```

---
# Protocols
### type: `struct`

- How can an implementer of type `struct` say, "I implement that protocol"?

```swift
struct SomeStruct: SomeProtocol, AnotherProtocol {
    // implementation of SomeStruct here
    // which must include all the properties and methods in SomeProtocol & AnotherProtocol
}
```

---
# Protocols 
### type: (more) `class`

```swift
class SomeClass: SuperclassOfSomeClass, ➡️SomeProtocol⬅️, ➡️AnotherProtocol⬅️ {
   // implementation of SomeClass here
   // which **must** include all the properties and 
   // methods in `SomeProtocol` and `AnotherProtocol`
   //📌 In a class, `init`s must be marked `required` (or otherwise a subclass might not conform) 
   required init(..)
}
```


---
# Protocols 
### type: `class`, `struct`, or `enum`


- How can an implementer of type `struct` say, "I implement that protocol"?

** You ARE allowed to add protocol conformance via an `extension` **

```swift 
extension Something: SomeProtocol {
   // implementation of SomeProtocol here
   // no stored properties though
}
```

---

```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()
```

---

- Use protocols like the type that they are! 

```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius
```

----

```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius

```

---

```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius
thingToMove.move(to: ...)

```

---
```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius
thingToMove.move(to: ...)
thingToMove.changeOil()

```

---
```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius
thingToMove.move(to: ...)
thingToMove.changeOil()
thingToMove = square

```

---
```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius
thingToMove.move(to: ...)
thingToMove.changeOil()
thingToMove = square
let thingsToMove: [Movable] = [prius, square]

```

---
```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius
let thingsToMove: [Movable] = [prius, square]

func slide(slider: Movable) {
   let positionToSlideTo = ...
   slider.move(to: positionToSlideTo)
}

slide(prius)
slide(square)
```
---
```swift
protocol Movable {
   mutating func move(to point: CGPoint)
}

class Car: Movable {
   func move(to point: CGPoint) { .. }
   func changeOil()
}

struct Shape: Movable {
   mutating func move(to point: CGPoint) { ... }
   func draw() 
}

let prius: Car = Car()
let square: Shape = Shape()

var thingToMove: Movable = prius
let thingsToMove: [Movable] = [prius, square]

func slide(slider: Movable) {
   let positionToSlideTo = ...
   slider.move(to: positionToSlideTo)
}

slide(prius)
slide(square)

func slipAndSlide(x: Slippery & Movable) 
slipeAndSlide(prius)
```

---
# Delegation

- A very important use of protocols 
- It's a way to implement a "blind communication" between a View and its Controller



---
# Delegation

How it plays out ...
1. A View declares a delegation protocol (i.e. what the View wants the Controller to do for it)
2. A View's API has a `weak delegate` property whose type is that delegation protocol
3. The View uses the delegate property to get/do things it can't own or control on its own
4. The Controller delcares that it implements the `protocol`
5. The Controller sets `delegate` of the View to itself using the property in #2 above
6. The Controller implements the `protocol` (probably has lots of `optional` methods in it)

---
# Delegation

- Now the View is hooked up to the Controller
(But the View still has no idea what the Controller is, so the View remains generic/reusable)

---
# Delegation 

- This mechanism (delegation) is found throughout iOS

However, it was designed pre-closures in Swift. Closures are sometimes a better option. (Closures soon!)

---
# Delegate

Example: `UIScrollView` has a `delegate` property...

```swift
weak var delegate: UIScrollViewDelegate?

// The UIScrollViewDelegate protocol looks like this..
@objc protocol UIScrollViewDelegate {
   optional func scrollViewDidScroll(scrollView: UIScrollView)
   Optional func viewForZooming(in scrollView: UIScrollView) -> UIView
/// and many more
}
```

---
# Delegate

A Controller with a `UIScrollView` in its View would be declared like this..

```swift 
Class MyViewController : UIViewController, UIScrollViewDelegate { .. }
.. probably in the `IBOutlet` `didSet` for the scroll view, the Controller would do..
scrollView.delegate = self
..and the Controller then would implement any of the `protocol`'s methods it is interested in
```

---
# Another Use of Protocols

- Being a `key` in a `Dictionary`
👉 To be a key in a `Dictionary`, you have to be able to be unique
👉 A `key` in a `Dictionary` does this by providing an `Int` that is very probably unique (a hash)
And then also by implementing equality testing to see if two keys are, in fact, the same.

This is enforced by requiring that a `Dictionary`'s keys implement the `Hashable` protocol

---
# Another Use of Protocols

```swift
protocol Hashable: Equatable {
   var hashValue: Int { get }
}
```
Very simple. Note, though, that Hashable inherits from `Equatable` ...

---
# Protocol with Dictionary

- That means that to be `Hashable` , you also have to implement `Equatable`

---
# Protocol with Dictionary

- That means that to be `Hashable` , you also have to implement `Equatable`

The `Equatable` protocol looks like this.. 

```swift
protocol Equatable {
   static func ==(lhs: Self, rhs: Self) -> Bool
} 
```

---

# Equatable..WT..?

---
# Equatable (Quickly)

- Types that conform to `Equatable` have to have a type function (note that `static`) called == 
- The arguments to == are both of the same type (I.e. `Self` of the type is the type itself)

- The == operator also happens to look for such a `static` method to provide its implementation!

---
# Back to `Protocol`s &  `Dictionary`

- Being a `key` in a `Dictionary` 
`Dictionary` is then declared like this: Dictionary<Key: Hashable, Value>

- This restricts keys to be things that conform to `Hashable` (there's no restriction on values)


---
# Protocols 

💥 Part of your homework this week is to make `Caption` and `Picture` `Hashable`
💥 As a bonus we'll be able to compare `Caption`s and `Picture`s directly because they'll be Equatable 
💥 This will even allow us to make `identifier` in `Caption` to be `private`, which makes a lot of sense 


---
# Advanced use of Protocols

- "Multiple inheritance" with `protocol`s

👉 `CountableRange` Implements many `protocol`s, but here are a couple of important ones...
👉 `Sequence` - makeIterator (and thus supports `for in`)
👉 `Collection` - subscription (i.e. []) `index(offsetBy:)`, `index(of:)`, etc).

---
# Advanced use of Protocols

Why do it this way?

Because `Array`, for example, also implements these protocols

So now Apple can create generic code that operates on a `Collection` and it will work on both!
`Dictionary` is also a `Collection`, as is `Set` and `String` 

---
# Advanced Use of Protocols

Why do it this way?

Because `Array`, for example, also implements these protocols

So now Apple can create generic code that operates on a `Collection` and it will work on both!
`Dictionary` is also a `Collection`, as is `Set` and `String` 

&&& they don't just inherit the **fact** that they implement the methods in `Collection`, they actually inherit an **implementation** of many of the methods in `Collection`

---
# Advanced Use of Protocols

- Using `extension` to provide `protocol` implementation

-> We said that `protocol` implementation is provided by implementing types (`struct`, `enum`, `class`)
However, an `extension` can be used to add **default implementation** to a `protocol` 

-> Since there's no storage, said implementation has to be in terms of other API in the `protocol`
(And any `API` in any `protocol` that `protocol` inherits from, of course


---
# Advanced Use of Protocols (continued)

- For example, for the `Sequence` protocol, you really only need to implement `makeIterator`
- An integrator implements the `IteratorProtocol` which just has the method `next()`

- If you do, you will automatically get **implementations** for all these other methods in Sequence:

```swift
contains(), forEach(), joined(separator:), min(), 
max(), filter(), map(), etc
```

---
# Advanced Use of Protocols (continued)

```swift
contains(), forEach(), joined(separator:), min(), 
max(), filter(), map(), etc
```

All of the 👆 are implemented via an **extension to the Sequence protocol**

---
# Advanced Use of Protocols 

This extension (provided by Apple) uses only `Sequence` `protocol` methods in its implementation

```swift
Extension Sequence {
   func contains(_ element: Element) -> Bool { }
   // etc 
}
```

---
# Advanced use of Protocols
### Functional Programming

- By combining `protocol`s with generics and `extension`s (default implementations),
You can build code that focuses more on the **behavior** of data structures than the storage!

- This approach to development is called **FUNCTIONAL PROGRAMMING**

- It is different than OBJECT-ORIENTED-PROGRAMMING (it's sort of an evolution thereof)
- You won't be learning functional programming, but you're getting a taste of it
- What's great about about Swift is that it supports both paradigms 


---
# String 

- The characters in a `string`
- A `String` is made up of Unicodes, but there's also the concept of a `Character` 
- A `Character` is what a human would perceive to be a single lexical character
- This is true even if a single `Character` is made up of multiple **Unicodes**

---
# String 

For example, there is a Unicode which is "apply an accent to the previous character."
But there is also a Unicode which is é (the letter `e` with an accent on it.)
So the string: `touché` might be 6 Unicodes (t-o-u-c-h-é) or 7 Unicodes (t-o-u-c-h-e-´)

In either case, we perceive it as 6 `Character`s 

B/c of this ambiguity, the index into a `String` **cannot** be an Int.
Is the `m` in "Touché my friend" at index 7️⃣ or index 8️⃣ ? Depends on the é.

---
# String 

Indices into `String`s are therefore of a different type..

```swift
`String.Index`
``` 

The simplest ways to get an index are `startIndex`, `endIndex`, and `index(of:)`
There are other ways (see the documentation for more)
To move to another index, use

```swift
index(String.Index, offsetBy: Int)
```

---
# String 

The characters in a `String`

```swift
let barronsQuote = "Touché Ms Lane"
let firstCharacterIndex = barronsQuote.startIndex // of type String.Index
Let fourthCharacterIndex = barronsQuote.index(firstCharacterIndex, offsetBy: 5)
let fourthCharacter = barronsQuote[fourthCharacterIndex] // é 

if let firstSpace = barronsQuote.index(of: " ") { // returns nil if " "  not found
    let secondWordIndex = barronsQuote.index(firstSpace, offsetBy: 1)
    let secondWord = barronsQuote[secondWordIndex..<barronsQuote.endIndex]
}
```

---
Note the `..<`:

```swift
    let secondWord = barronsQuote[secondWordIndex..<barronsQuote.endIndex]
```

This is a `Range` of `String.Index`
Range is a generic type (like `Array` is)
It doesn't have to be a range of `Int`s

---
# String 

Another way to find the second word:

```swift
let barronsQuote = "Touché Ms Lane"
let firstCharacterIndex = barronsQuote.startIndex // of type String.Index
Let fourthCharacterIndex = barronsQuote.index(firstCharacterIndex, offsetBy: 5)
let fourthCharacter = barronsQuote[fourthCharacterIndex] // é 

if let firstSpace = barronsQuote.index(of: " ") { // returns nil if " "  not found
    let secondWord = barronsQuote.components(separatedBy: " ")[1]
    🚨 components(separatedBy:) returns an Array<String> (might be empty, though, BE CAREFUL)🚨
}
```

---
# String

The characters in a `String`

- `String` is also a `Collection` in the same sense that an `Array` is a Collection) of `Character`s
- All the indexing stuff (`index(of:)`, etc) is part of `Collection`
- A `Collection` is also a `Sequence` so you can do things like..

```swift
for c in s { } // Iterate through all `Character`s in `s`
let characterArray = Array(s) // Array<Character>

(Array has an `init` that takes any Sequence as an argument.)
```

---
# String

- A `String` is a value type (it's a `struct`) 
- AND we usually work with immutable Strings (i.e. let s = ...)
- But there are mutating methods on `String` as well
- Example:

```swift
var b = barronsQuote //  makes a mutable copy of `barronsQuote` (because it's value type!)
b.insert(contentsOf: " I apologize", at: b.index(of: " " )!) // Touché I apologize Ms Lane
// the `type` of `contentsOf:` argument in any `Collection` of `Character` (which `String` is)
```


---
# Other `String` Methods (read documentation for full list)

```swift
func hasPrefix(String) -> Bool
func hasSuffix(String) -> Bool
var localizedCapitalized: String

func replaceSubrange(Range<String.Index>, with: Collection of Character)
// e.g. s.replaceSubrange(..<s.endIndex, with: "new contents")
// Note the ..< Range appears to have no start. It defaults to the start of the String
```

---
# NSAttributedString

- A `String` with attributes attached to each other -
-- Conceptually, an object that pairs a `String1 and a `Dictionary` of attributes for each `Character`
-- The `Dictionary`'s keys are things like "the font" or "the color", etc
-- The `Dictionary`'s values depends on what the key is (`UIFont` or `UIColor` or whatever)
-- Many times (almost always), large ranges of `Character`s have the **same** Dictionary
-- Often the entire `NSattributedString` uses the same `Dictionary`
-- You can put `NSAttributedString`s  on `UILabel`s, `UIButton`s, etc


---
# NSAttributedString

- Creating and using an `NSAttributedString`

---
# Function Types


---
# Function types

- Functions are types too! 
- You can declare a variable (or parameter to a method or whatever) to be of type function
- You'll declare it with the types of the functions arguments (and return type) included
- You can do this anywhere any other type is allowed


---
# Function types...wut

---

Let's backup for a second

---
In Swift, there are 2 kinds of "Types" 
🔲 Named Types
🔲 Compound Types

---

Good news, you already know `Named Types`! 

---
# Named Types

- Named Types are those which are defined and identified by the __name__ that they're given:
✅ `Classes` e.g.: `class SomeNewClassType {}`
✅ `structs` e.g.: `struct SomeNewStructType {}` 
🚫 `enums` (we'll talk more in-depth about these later) e.g.: `enum SomeNewEnumType {}`
✅ `protocols` fit this category of Type e.g.: `protocol SomeNewProtocolType {}`


---

In Swift, there are 2 kinds of "Types":

✅ Named Types
🔲 Compound Types


---
# Compound Types

`Compound` Types on the other hand, don't have names.

---
# Compound Types

- `Compound` Types on the other hand, don't have names.
- Instead, they have "signatures" that define and identify them as Types
 
---
# Compound Types

- `Compound` Types on the other hand, don't have names.
- Instead, they have "signatures" that define and identify them as Types
- Two compound types: 
🔲 functions
🔲 tuples


---

Whoa, whoa, but Rebecca, "Functions have names..."

---

- Yes, yes functions do have haves but when thinking in terms of their Type-ness, you must look beyond the __name___ to the function's __signature__ characteristics


```swift
func relaxationTechnique(for timeRebeccaLostMe: Date, currentTime: Date) -> BreathingExercise
```

---
# Compound Types

```swift
func relaxationTechnique(for timeRebeccaLostMe: Date, currentTime: Date) -> BreathingExercise
// 📌 the __name__ of the function `relaxationTechnique` is simply how we 
//    __refer__ to the function in code to execute it or
//    pass it around as an argument 
```

---
# Compound Types

```swift
func relaxationTechnique(for timeRebeccaLostMe: Date, currentTime: Date) -> BreathingExercise
// 📌 the __name__ of the function `relaxationTechnique` is simply how we 
//    __refer__ to the function in code to execute it or
//    pass it around as an argument 

// 📌 the __signature__ of the function, however, is the part that characterizes the 
//.   function as a __Type___
```

---
# Type-ness / signature 

What makes up a function's Type-ness or "signature"?
1️⃣ The Type(s) of its **parameters**
2️⃣ The Type that the function **returns**

---
# Type-ness / signature 

What makes up a function's Type-ness or "signature"?
1️⃣ The Type(s) of its **parameters** 
2️⃣ The Type that the function **returns**


```swift
func relaxationTechnique(for timeRebeccaLostMe: (1️⃣)Date,  currentTime: (1️⃣)Date) -> 2️⃣ BreathingExercise
```

---
# Function Types

```swift
func relaxationTechnique(for timeRebeccaLostMe: (1️⃣)Date,  currentTime: (1️⃣)Date) -> 2️⃣ BreathingExercise
```

- Combining the Types(s) that the function receives as inputs (1️⃣) with the Type that the function returns (2️⃣) composes to give the function its Type/ "Signature"


---

# Function Type

// Example: a function that takes a Caption and a Picture 
// and spits out a CaptionThatCard 

```swift
func generateCard(caption: Caption, picture: Picture) -> CaptionThatCard
```

---
# Function Type

```swift
func generateCard(caption: Caption, picture: Picture) -> CaptionThatCard
```
Question: "What is `generateCard`'s function Type?"
Answer: `generateCard` is a function Type that has 2 parameters. The first parameter is of type `Caption` and the 2nd parameter is of type: `Picture` and returns a value of Type `CaptionThatCard`

---
# Function Type Notation

- Rather than write out the paragraph describing the function's Type, it's far more convenient to indicate that the Type of a function using a standard notation. 

- This is the syntax that the Swift compiler uses when trying to work with function Types

---
# Function Type Notation

- Function Type notation boils down to stripping away the function's name and the parameter names to leave behind the raw Type information that composes to give the function its Type.

---
# Function Type Notation

- Function Type notation boils down to stripping away the function's name and the parameter names to leave behind the raw Type information that composes to give the function its Type.


~~func generateCard~~(~~caption:~~ Caption, ~~picture:~~ Picture) -> CaptionThatCard


---
# Function Type Notation

- Function Type notation boils down to stripping away the function's name and the parameter names to leave behind the raw Type information that composes to give the function its Type.


~~func generateCard~~(~~caption:~~ Caption, ~~picture:~~ Picture) -> CaptionThatCard
(Caption, Picture) -> CaptionThatCard

- Tells the compiler everything you need to know to be able to identify the Type of that Function 

---
# More examples:

func getHelp(for person: Person) -> Help { .. } 
~~func getHelp~~ (~~for person:~~ Person) -> Help
(Person) -> Help

func dogWalker(for dog: Dog) -> DogWalker { .. }
~~func dogWalker~~ (~~for dog:~~ Dog) -> DogWalker
(Dog) -> DogWalker

func coach(for sport: Sport) -> Coach { .. }
~~func coach~~ (~~for sport:~~ Sport) -> Coach
(Sport) -> Coach

--- 

# Function Type Gotchas...

----
# Function Type Syntax

- If a function takes **no parameters**, the "parameter portion" of the Type notation will simply be () with nothing between the parenthesis. 

func needWatering() -> \[Plant\] { .. }
~~func needWatering~~() -> \[Plant\]
() -> \[Plant\]

func returnHelloString() -> String { .. }
~~func returnHelloString~~() -> String
() -> String

---
# Function Type Syntax

- If a function has no return type (i.e. it doesn't return anything) the return type portion of the Type notation will be `-> Void`


---
# Function Type Syntax

- If a function has no return type (i.e. it doesn't return anything) the return type portion of the Type notation will be `-> Void`

**Example:**
func jump() { .. }
~~func jump~~ 
() -> Void // takes no parameters and returns nothing

---
# Storing a function in a variable

- You read that correctly. You can declare a variable (or parameter to a method or whatever) to be of type "function". 
- Another way to look at it: You can store a function in a variable

- You'll declare a variable with the types of the functions arguments (and return type) included
- You can do this anywhere any other type is allowed

---
# Functions as variables...next week!




