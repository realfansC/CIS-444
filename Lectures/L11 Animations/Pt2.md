## CIS-444
## Lecture 11: Part 2

In this section, you’ll connect the basic user interface (UI) of the CaptionThat app to code and define some actions a user can perform in that UI.

## Learning Objectives

At the end of the lesson, you’ll be able to:

* (Review) Explain the relationship between a scene in a storyboard and the underlying view controller
* (Review) Create outlet and action connections between UI elements in a storyboard and source code
* Process user input from a text field and display the result in the UI
* Make a class conform to a protocol
* Understand the delegation pattern
* Follow the target-action pattern when designing app architecture

## Connect the UI to Source Code
### This is review from concepts you already know but a more detailed explanation step-by-step guide

Elements in a [storyboard](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW8) are linked to source code. It’s important to understand the relationship that a storyboard has to the code you write.  

In a storyboard, a [scene](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW62) represents one screen of content and typically one view controller. [View controllers](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW7) implement your app’s behavior. A view controller manages a single content view with its hierarchy of subviews. View controllers coordinate the flow of information between the app’s [data model](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW35), which encapsulates the app’s data, and the views that display that data, manage the life cycle of their content views, handle orientation changes when the device is rotated, define the navigation within your app, and implement the behavior to respond to user input. All view controller objects in iOS are of type UIViewController or one of its subclasses.  

You define the behavior of your view controllers in code by creating and implementing custom view controller [subclasses](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW14). You can then create a connection between those classes and scenes in your storyboard to get the behavior you defined in code and the user interface you defined in your storyboard.

In your first coding assignment, you created such classes, `LandingViewController.swift` and `CaptionedViewController.swift`, and connected them to the scenes you’re working on in your storyboard right now. You added these scenes by making the connections yourself in the Identity inspector. The Identity inspector let you edit properties of an object in your storyboard related to that object’s identity, such as what class the object belongs to.

![inline][IDInspector]

[IDInspector]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CUIC_inspector_identity_2x.png


At runtime, your storyboard creates an instance of ViewController, your custom view controller subclass. The scene from your storyboard appears on the device’s screen, and the user interface’s behavior is defined in `LandingViewController.swift` and `CaptionedViewController.swift`

As you know, the scene connection is not the only connection that needs to be made. To define interaction in your app, your view controller source code needs to be able to communicate with the views in your storyboard. You do this by defining additional connections—called outlets and actions—between the views in the storyboard and the view controller source code files.

## Create Outlets for UI Elements

[Outlets](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW55) provide a way to reference interface objects—the objects you added to your storyboard—from source code files. To create an outlet, Control-drag from a particular object in your storyboard to a view controller file. This operation creates a [property](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW58) for the object in your view controller file, which lets you access and manipulate that object from code at runtime.

You’ll need to create outlets for the text field and label in your user interface to be able to reference them.

## To connect the text field to the `CaptionedViewController.swift` code

1. Open your storyboard, `Main.storyboard`.

2. Open the [assistant editor](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW76)

![inline][AsstEditor]

[AsstEditor]: https://i.imgur.com/OU2JHXA.png

3. If you want more space to work, collapse the [project navigator](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW57) and [utility area](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW72) by clicking the Navigator and Utilities buttons in the Xcode toolbar.

![inline][CollapseSides]

[CollapseSides]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/navigator_utilities_toggle_on_2x.png

4. In the outline view, select `CaptionedViewControllerScene`

5. In the editor selector bar, which appears at the top of the assistant editor, change the assistant editor from Preview to Automatic > `CaptionedViewController.swift`

![inline][PreviewCaptioned]

[PreviewCaptioned]: https://i.imgur.com/b0E82lu.png
   
   `CaptionedViewController.swift` displays in the editor on the right.


6. In  `CaptionedViewController.swift`, find the class line, which should look like this:


```swift
   class CaptionedViewController: UIViewController {
```

7. Below the `class` line, add the following:

```swift
   //MARK: Properties
```

   You just added a [comment](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW31) to your source code. Recall that a comment is a piece of text in a source code file that doesn’t get compiled as part of the program but provides context or useful information about individual pieces of code.
A comment that begins with the characters //MARK: is a special type of comment that’s used to organize your code and to help you (and anybody else who reads your code) navigate through it. You’ll see this in action later. Specifically, the comment you added indicates that this is the section of your code that lists properties.


   A comment that begins with the characters `//MARK:` is a special type of comment that’s used to organize your code and to help you (and anybody else who reads your code) navigate through it. You’ll see this in action later. Specifically, the comment you added indicates that this is the section of your code that lists properties.

8. In your storyboard, select the text field.

9. Control-drag from the text field on your canvas to the code display in the editor on the right, stopping the drag at the line below the comment you just added in `CaptionedViewController.swift`.


