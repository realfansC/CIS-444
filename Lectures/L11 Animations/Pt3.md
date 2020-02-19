STOP -- DO NOT PROCEED - THIS IS WIP 

## Work with View Controllers

In this section, you’ll continue to work on the [user interface (UI)](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW18) for the captioned scene in the CaptionedThat app. You’ll add an image view to the scene, and use the image the user selected in the first homework assignment 

## Learning Objectives

At the end of the lesson, you’ll be able to:

* Understand the view controller life cycle and its callbacks (for example, viewDidLoad, viewWillAppear and viewDidAppear) 
* Pass data between view controllers
* Dismiss a view controller
* Use gesture recognizers to generate events
* Anticipate object behavior based on the UIView/UIControl class hierarchy
* Use the asset catalog to add image assets to a project


## Understand the View Controller Lifecycle

So far, the CaptionThat app has multiple scene, whose user interface is managed by a navigation  controller. As you build more complex apps, you’ll create more scenes, and will need to manage loading and unloading views as they’re moved on and off the screen.

An object of the `UIViewController` class (and its subclasses) comes with a set of methods that manage its view hierarchy. iOS automatically calls these methods at appropriate times when a view controller transitions between states. When you create a view controller subclass (like the `CaptionedViewController` class you’ve been working with), it inherits the methods defined in UIViewController and lets you add your own custom behavior for each method. It’s important to understand when the system calls these methods, so you can set up or tear down the views you’re displaying at the appropriate step in the process—something you’ll need to do later in the lessons.

![inline][VCLifeCycle]

[VCLifeCycle]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_vclife_2x.png

iOS calls the `UIViewController` methods as follows:

* `viewDidLoad()` - Called when the view controller’s content view (the top of its view hierarchy) is created and loaded from a storyboard. The view controller’s outlets are guaranteed to have valid values by the time this method is called. Use this method to perform any additional setup required by your view controller.
   * Typically, iOS calls `viewDidLoad()` only once, when its content view is first created; however, the content view is not necessarily created when the controller is first instantiated. Instead, it is lazily created the first time the system or any code accesses the controller’s view property.

* `viewWillAppear()` — Called just before the view controller’s content view is added to the app’s view hierarchy. Use this method to trigger any operations that need to occur before the content view is presented onscreen. Despite the name, just because the system calls this method, it does not guarantee that the content view will become visible. The view may be obscured by other views or hidden. This method simply indicates that the content view is about to be added to the app’s view hierarchy.

* `viewDidAppear()` — Called just after the view controller’s content view has been added to the app’s view hierarchy. Use this method to trigger any operations that need to occur as soon as the view is presented onscreen, such as fetching data or showing an animation. Despite the name, just because the system calls this method, it does not guarantee that the content view is visible. The view may be obscured by other views or hidden. This method simply indicates that the content view has been added to the app’s view hierarchy.

* `viewWillDisappear()` — Called just before the view controller’s content view is removed from the app’s view hierarchy. Use this method to perform cleanup tasks like committing changes or resigning the first responder status. Despite the name, the system does not call this method just because the content view will be hidden or obscured. This method is only called when the content view is about to be removed from the app’s view hierarchy.

* `viewDidDisappear()` — Called just after the view controller’s content view has been removed from the app’s view hierarchy. Use this method to perform additional teardown activities. Despite the name, the system does not call this method just because the content view has become hidden or obscured. This method is only called when the content view has been removed from the app’s view hierarchy.

You’ll be using some of these methods in the CaptionThat app to load and display your data. In fact, if you recall, you’ve already written some code in the viewDidLoad() method of `CaptionedViewController`:

```swift
   override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        captionTextField.delegate = self

    }
```
This style of app design where view controllers serve as the communication pipeline between your views and your data model is known as [MVC (Model-View-Controller)](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW52). In this pattern, models keep track of your app’s data, views display your user interface and make up the content of an app, and controllers manage your views. By responding to user actions and populating views with content from the data model, controllers serve as a gateway for communication between the model and views. MVC is central to a good design for any iOS app, and so far, the FoodTracker app has been built along MVC principles.

As you keep the MVC pattern in mind for rest of the app’s design, it’s time to take your basic user interface to the next level, and display an image in the Captioned scene

# Add a Photo to caption

The next step in finishing the captioned scene is adding a way to display a photo a user may want to caption. For this, you’ll use an image view (UIImageView), a user interface element that displays a picture.

## To add an image view to your scene

1.  Open your [storyboard](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW8), `Main.storyboard`.

2. Open the [Object library](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW54) in the [utility area](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW72). (Alternatively, choose View > Utilities > Show Object Library.)














