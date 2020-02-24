# CIS-444 
February 24, 2020


### Pair Programming Review:
* Review Pair Programming [Tuple Guide][]

#### Driver Basics
* **Driver** types the code and stays focused on the current task
  * At the keyboard
  * When you are the driver trust that your navigator knows what they are telling you. If you don't understand what they are telling you ask questions, but if you don't understand why they are telling you something don't worry about it until you've finished the method or section of code. The right time to discuss and challenge design decisions is after the solution is out of the navigators head or when the navigator is confused and unable to navigate.
 
#### Navigator Basics
  * **Navigator** thinks ahead, ponders edge cases, spots bugs, suggests refactorings, asks good questions, stays zoomed out.

#### Navigator Job #1:

**Give the next instruction to the driver the instant they are ready to implement it**. 
The navigator is essentially managing a ToDo list in their heads. As you go through the code you keep adding things to the list and as the driver is typing you keep removing the completed items from the list. The key is while you are handling and tracking 2-20 things at a time, the driver is only ever responsible for 1 thing. This is the key to allowing the driver stay in a state of flow. This is the number one main job for the navigator; Manage the big picture details so the driver can stay focused on the code they are typing. 

#### Navigator Job #2:
**Talk in the highest level of abstraction the driver can understand** 
The second job of the navigator is to speak at the highest level of abstraction that the driver is able to digest at the moment. This will change by driver, of course, but it will also change during the day for the same driver. 

For example, a navigator might tell the the driver "extract that method" to which they might get a blank stare. The navigator should then restate that intention at a low level of abstraction. Such as "ctrl+alt+m" or even "highlight lines 14-20 and then press ctrl+alt+m". After doing that a few times the navigator should be able to revert back to the higher level of "extract that method" but always realize that later the driver might be tired or just plain forgetful, adjust accordingly. 

It is the navigators responsibility to communicate in a meaningful way. This means you shouldn't be speaking above the drivers understanding. However, it is also the navigators responsibility to be ever increasing the the level of communication and understanding. Stay mindful of the driver and be constantly adjusting to them.

**"Just do it"**
Although you are the navigator, you are going to make mistakes and bad decisions. Correct them when you do but don't sit around and plan to try to avoid. 

#### Problems I saw last week:
 * Pairs copying and pasting code from the guide
   * These detailed instructions are going away soon. The only way to get better and obtain a deeper understanding of these concepts, you must implement that
 * 1 person working and 1 watching
   * If your navigator isn't engaged then you really are not even pairing. 

#### New App: Cooking+ (Suggestions welcome on better name)
Step by Step recipe app to educate & remove the complexity of the cooking process
Simple Recipe apps are boring but with a few basic things in iOS development, we can create a rich guided cooking experience. Our app will display a recipe's ingredients, tips, equipment required, guided instructions, and clean up steps. This project will span over multiple classes. Caption That app will be used as a base for homework assignments applying concepts practiced in class and eventually be retired.


## Define Your Data Model
In this lesson, you’ll define and test a [data model][Data Model] for our guided cooking app.
A data model represents the structure of the information stored in an app.

### Learning Objectives
- [x] Create a data model
- [X] Write failable initializers for a custom class
- [X] Demonstrate a conceptual understanding of the difference between failable and nonfailable initializers
- [X] Test a data model by writing and running unit tests


### Create a new project

We have covered this many times but quick review:
1. Open Xcode from the /Applications directory

![inline 50%][Welcome-to-Xcode-Img]

2. In the welcome window, click “Create a new Xcode project” (or choose File > New > Project).
Xcode opens a new window and displays a dialog in which you choose a template.

3. Select iOS at the top of the dialog.

4. In the Application section, select Single View Application and then click Next.

![inline 50%][Single-View-Application-Img]

5. Name the app `GuidedCooking` and make sure the value of **User Interface** is **Storyboard**

![inline 50%][Project-Settings-img]

✅point: Run the app on the simulator. Does it work?


### Create a Data Model

Now you’ll create a model to store the information that your scenes will use to display information. To start, define a simple Cook Program instance with a name, an identifier (id), a photo, and a description (we will add new properties to this later)


#### To create a new data model class

1. Choose File > New > File (or press Command-N).
2. At the top of the dialog that appears, select iOS.
3. Select Swift File, and click Next.
4. In the Save As field, type `CookProgram`
5. The save location defaults to your project directory.
The Group option defaults to your app name.
In the Targets section, your app is selected and the tests for your app are unselected.
6. Leave these defaults as they are, and click Create.
Xcode creates a file called CookProgram.swift. In the Project navigator, drag the CookProgram.swift file and position it under the other Swift files, if necessary.

In Swift, you can represent the CookProgram `name` using a `String`, the photo using a `UIImage`, the id as a `UUID`, and description as a `String`. Because a `CookProgram` always has a name and identifier but might not have a photo or a description, make the UIImage an optional.

> *Navigators* google `Swift UUID` and explain and discuss what a UUID is with your partner and why I decided to use it here. Understand the pitfalls of it, pros and cons, it's underlying data type, etc.  ***Determine the syntax to instantiate an instance of a UUID***

#### To define a data model for a cook program

1. If the [assistant editor][Assistant-Editor-Guide] is open, return to the standard editor by clicking the Standard button.

2. Open `CookProgram.swift`
3. Change the important statement to import UIKit instead of Foundation

```swift
import UIKit
```

When Xcode creates a new Swift file, it imports the Foundation framework by default, letting you work with Foundation data structures in your code. You’ll also be working with a class from the UIKit framework, so you need to import UIKit. However, importing UIKit also gives you access to Foundation, so you can remove the redundant import to Foundation.


4. Below the import statement, add the following code:

```swift

class CookProgram {
    
    //MARK: Properties
    
    let name: String
    let id:   UUID
    let photo: UIImage?
    let description: String?
    
}
```
This code defines the basic properties for the data you need to store. You’re making these constants (let) instead of variables (vars) because they do not need to change throughout the course of a CookProgram's object’s lifetime.

5. Below the properties, add this code to declare an initializer:

```swift
//MARK: Initialization
init(name: String, photo: UIImage?, description: String?) {
        
}
```

6. Recall that an [initializer][doc-initializer] is a method that prepares an instance of a class for use, which involves setting an initial value for each [property][doc-property] and performing any other setup or initialization.

```swift
 //MARK: Initialization
    init(name: String, photo: UIImage?, description: String?) {
        // Initialize stored properties.
        self.name = name
        self.id   = UUID()
        self.photo = photo
        self.description = description
    }
```

But what happens if you try to create a CookProgram with incorrect values, like an empty name? You’ll need to return [nil][doc-nil] to indicate that the item couldn’t be created, and has set to the default values. You need to add code to check for those cases and to return nil if they fail.

7. Add the following code just above the code that initializes the stored properties.

```swift
// Initialization should fail if there is no name
        if name.isEmpty  {
            return nil
        }
```

This code validates the incoming parameters and returns nil if they contain invalid values.
Note, the compiler should complain with an error stating, “Only failable initializers can return ‘nil’.”


8. Click the error icon to bring up the fix-it.

![inline][failiable-error-img]

9. Double-click the fix it to update your initializer. The initializer’s signature should now look like this:

```swift
    init?(name: String, photo: UIImage?, description: String?) {
```

Failable initializers always start with either `init?` or `init!`. These initializers return [optional][doc-optionals] values or implicitly unwrapped optional values, respectively. Optionals can either contain a valid value or `nil`. You must check to see if the optional has a value, and then safely unwrap the value before you can use it. [Implicitly unwrapped optionals][doc-implicitly-unwrapped] are optionals, but the system implicitly unwraps them for you.

In this case, your initializer returns an optional `CookProgram?` object.


10. At this point, your `init?(name: String, photo: UIImage?, description: String?)` initializer should look like this:

```swift
init?(name: String, photo: UIImage?, description: String?) {
        // Initialization should fail if there is no `name`
        if name.isEmpty  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.id   = UUID()
        self.photo = photo
        self.description = description
    }
```

> As you will see in later lessons, failable initializers are harder to use because you need to unwrap the returned optional before using it. Some developers prefer to enforce an initializer’s contract using assert() or precondition() methods. These methods cause the app to terminate if the condition they are testing fails. This means that the calling code must validate the inputs before calling the initializer.

> For more information on initializers, see Initialization. For information on adding inline sanity checks and preconditions to your code, see [assert(_:_:file:line:)](https://developer.apple.com/documentation/swift/1541112-assert) and [precondition(_:_:file:line:)](https://developer.apple.com/documentation/swift/1540960-precondition).


✅point: Build your project by choosing Product > Build (or pressing Command-B). You’re not using your new class for anything yet, but building it gives the compiler a chance to verify that you haven’t made any typing mistakes. If you have, fix them by reading through the warnings or errors that the compiler provides, and then look back over the instructions in this lesson to make sure everything looks the way it’s described here.

## Test Your Data

Although your data model code builds, you haven’t fully incorporated it into your app yet. As a result, it’s hard to tell whether you’ve implemented everything correctly, and if you might encounter edge cases that you haven’t considered at runtime.

To address this uncertainty, you can write unit tests. [Unit tests](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW71) are used for testing small, self-contained pieces of code to make sure they behave correctly. The `CookProgram` class is a perfect candidate for unit testing.

Xcode has already created a unit test file as part of the Single View Application template.

### To look at the unit test file for your guided cook program app

1. Open the `YourAppNameTests` folder in the project navigator by clicking the disclosure triangle next to it

![inline][UI-Test-Location-img]

2. Open the `YourAppNameTests.swift`

Take a moment to understand the code in the file so far.

```swift
import XCTest
@testable import CookingPlus

class CookingPlusTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
```
> Navigators: Engage with your driver and walk through the methods together. Discuss the syntax.

The code starts by importing both the XCTest framework and your app.

Note that the code uses the `@testable` attribute when importing your app. This gives your tests access to the internal elements of your app’s code. Remember, Swift defaults to internal access control for all the types, variables, properties, initializers, and functions in your code. If you haven’t explicitly marked an item as file private or private, you can access it from your tests.

The XCTest framework is Xcode’s testing framework. The unit tests themselves are defined in a class, `CookingPlusTests`, which inherits from XCTestCase. The code comments explain the setUp() and tearDown() methods, as well as the two sample test cases: testExample() and testPerformanceExample().

The main types of tests you can write are functional tests (to check that everything is producing the values you expect) and performance tests (to check that your code is performing as fast as you expect it to). Because you haven’t written any performance-heavy code, you’ll only want to write functional tests for now.

Test cases are simply methods that the system automatically runs as part of your unit tests. To create a test case, create a method whose name starts with the word _test_. It’s best to give your test cases descriptive names. These names make it easier to identify individual tests later on. For example, a test that checks the `CookProgram`'s class’s initialization code could be named `testCookProgramlInitialization`.

### To write a unit test for Meal object initialization

1. In `CookingPlusTests.swift`, you don’t need to use any of the template’s stub methods for this lesson. Delete the template’s methods. Your food tracker tests should appear as shown below:

```swift
import XCTest
@testable import CookingPlus

class CookingPlusTests: XCTestCase {

}
```

2. Before the last curly brace (}), add the following:

```swift
//MARK: `CookProgram` Class Tests
```

This is a comment to help you (and anybody else who reads your code) navigate through your tests and identify what they correspond to.

3. Below the comment, add a new test case:

// Confirm that the `CookProgram` initializer returns a `CookProgram` object when passed valid parameters.

```swift
func testCookProgramlInitializationSucceeds() {
    
}
```

The system automatically runs this test case when the unit tests are run.

4. Add tests to the test case that use a name with a string

```swift
// string name
 let stringNameCookProgram = CookProgram.init(name: "Cheeseburger", photo: nil, description: nil)
XCTAssertNotNil(stringNameCookProgram)
```

If the initializer is working as expected, these calls to `init(name:, photo:, description:)` should succeed. XCTAssertNotNil verifies this, by checking that the returned `CookProgram` object is not nil.

5. Now add a test case where the `CookProgram` class’s initialization should fail. Add the following method under the testCookProgramlInitializationSucceeds() method.

```swift
   // Confirm that the `CookProgram` initializer returns nil when passed an empty name.
    func testCookProgramInitializationFails() {
        
    }
```

Again, the system automatically runs this test case when the unit tests are run.

6. Now add tests to the test case that calls the initializer with invalid parameters.

```swift 
 // Confirm that the `CookProgram` initializer returns nil when passed an empty name.
    func testCookProgramInitializationFails() {
        // Empty String
        let emptyStringCookProgram = CookProgram.init(name: "", photo: nil, description: nil)
        XCTAssertNil(emptyStringCookProgram)
    }
```

If the initializer is working as expected, these calls to `init(name:, photo:, description:)` should fail. XCTAssertNil verifies this by checking that the returned CookProgram object is nil.

7. So far, all of the tests should succeed. Now add a test that will fail. Add the following code between `testCookProgramlInitializationSucceeds()` and `testCookProgramInitializationFails()`:

```swift
  // Confirm that the `CookProgram` initializer returns nil when passed an emoji wrapped in a string as the name
    func testCookProgramInitializationWithEmojiFails() {
        let emojiCookProgram = CookProgram.init(name: "🍔", photo: nil, description: nil)
        XCTAssertNil(emojiCookProgram)
    }
```

You can add additional `XCTestCase` subclasses to your `CookingPlusTests` target to add additional test cases. Run all of your unit tests at the same time by choosing Product > Test (or pressing Command-U). You can also run an individual test.

✅point: Run your unit test.  Run your unit tests by selecting the Product > Test menu item. The `testCookProgramlInitializationSucceeds()` and `testCookProgramInitializationFails()` test case should succeed, while the `testCookProgramInitializationWithEmojiFails()` test case fails.

copy the console output into a shared document (email, google doc, etc that you can email me) Label it: **Unit Test Console Output**

Notice that Xcode automatically opens the Test navigator on the left, and highlights the test that failed.

![inline][unit-test-fail-img]

The editor window shows the results of the currently open file. In this case, a test case fails if one or more of its test methods fail. A test method fails if one or more of its tests fail. In this example, only the `XCTAssertNil(emojiCookProgram)` test actually failed.

The Test navigator also lists the individual test methods, grouped by test case. Click the test method to navigate to its code in the editor. The icon to the right shows whether the test method succeeded or failed. You can rerun a test method by moving the mouse over the success or failure icon. When it turns into a play arrow icon, click it.


As you see, unit testing helps catch errors in your code. They also help to define your class’s expected behavior. In this case, the `CookProgram` class’s initializer fails if you pass an empty string, but doesn’t fail if you pass an emoji  wrapped in a string. 

✅point: How might you prevent the ability to set an emoji as a `CookProgram` name? First, you need to figure out how to check if a string contains an emoji character

*Navigators* [Google around](https://www.google.com/search?client=safari&rls=en&q=swift+test+for+emoji&ie=UTF-8&oe=UTF-8) for a solution. Talk it through with your driver is needed


### To fix the validation error

1. When you think you have a solution, in your `CookProgram.swift` class find your `init?(name: String, photo: UIImage?, description: String?)` method and add in the validation method to prevent an emoji from being set as the `CookProgram` name.

```swift
 //MARK: Initialization
    init?(name: String, photo: UIImage?, description: String?) {
        // Initialization should fail if there is no `name`
        if name.isEmpty  {
            return nil
        }
    /**
     Add your logic to prevent emoji as name here
    **/
        
        // Initialize stored properties.
        self.name = name
        self.id   = UUID()
        self.photo = photo
        self.description = description
    }
```

2.Make sure your logic uses a  [guard](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW130) statement instead of another `if` statement

A `guard` statement declares a condition that must be true in order for the code after the guard statement to be executed. If the condition is false, the guard statement’s else branch must exit the current code block (for example, by calling return, break, continue, throw, or a method that doesn’t return like `fatalError(_:file:line:)`).

```swift
Replace this code:
 // Initialization should fail if there is no `name`
        if name.isEmpty  {
            return nil
        }

    /**
     Add your logic to prevent emoji as name here
    **/


```

With the following:

```swift
 // Initialization should fail if there is no `name`
        guard !name.isEmpty else {
            return nil
        }

    /**
     Add your logic to prevent emoji as name here
    **/

```

Your `init` method should look something like this:

```swift
//MARK: Initialization
    init?(name: String, photo: UIImage?, description: String?) {
        // Initialization should fail if there is no `name`
        guard !name.isEmpty else {
            return nil
        }
        
        /**
            Add your logic to prevent emoji as name here
        **/
        
        // Initialize stored properties.
        self.name = name
        self.id   = UUID()
        self.photo = photo
        self.description = description
    }
```


✅point: Your app runs with the unit test you just wrote. All test cases should pass. 

🛑Do not advance until `testCookProgramInitializationWithEmojiFails()` passes. ***Raise your hand when you believe you have a working solution and I will review it before you proceed 🛑 

Unit testing is an essential part of writing code because it helps you catch errors that you might otherwise overlook. As implied by their name, it’s important to keep unit tests modular. Each test should check for a specific, basic type of behavior. If you write unit tests that are long or complicated, it’ll be harder to track down exactly what’s going wrong.


## Wrapping Up

In this lesson, you built a model class to hold your app’s data. You also examined the difference between regular initializers and failable initializers. Finally, you added a couple of unit tests to help you find and fix bugs in your code.

In later lessons, you will use CookProgram objects in your app’s code to create and manage the list of CookPrograms. However, before you do that, you need to learn how to display a list of cook programs using a table view.



#### Sources:
* [Pair Programming](http://llewellynfalco.blogspot.com/2014/06/llewellyns-strong-style-pairing.html)


[Tuple Guide]:https://tuple.app/pair-programming-guide/styles
[Data Model]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW35

[Assistant-Editor-Guide]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW76

[doc-optionals]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW11

[doc-implicitly-unwrapped]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW50

[doc-nil]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW5

[doc-initializer]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW2

[doc-property]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW58

[failiable-error-img]: resources/failable-error.png
[Welcome-to-Xcode-Img]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_welcomewindow_2x.png

[Single-View-Application-Img]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_singleviewapp_template_2x.png

[Project-Settings-img]:resources/projects-settings.png

[UI-Test-Location-img]:resources/UI-Test-Location.png

[unit-test-fail-img]:resources/unit-test-fail.png
