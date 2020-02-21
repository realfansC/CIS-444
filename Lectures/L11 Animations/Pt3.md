

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

3. In the Object library, type image view in the filter field to find the Image View object quickly.

4. Drag an Image View object from the Object library to your scene so that it’s in the stack view below the button.

5. With the image view selected, open the Size inspector in the utility area

Recall that the [Size inspector](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW82) appears when you select the fifth (or sixth depending on Xcode version) button from the left in the inspector selector bar. It lets you edit the size and position of an object in your storyboard.

![inline][SizeInspector]

[SizeInspector]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_inspector_size_2x.png

6. In the Intrinsic Size field, select Placeholder. (This field is at the bottom of the Size inspector, so you’ll need to scroll down to it.)

7. Type `320` in both the Width and Height fields. Press Return.

![inline][InstrinsicSize]

[InstrinsicSize]: https://i.imgur.com/vyau2S4.png

A view’s [intrinsic content size](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW110) is the preferred size for the view based on its content. An empty image view doesn’t have an intrinsic content size. As soon as you add an image to a view, its intrinsic content size is set to the image’s size. Providing a placeholder size gives the image a temporary intrinsic content size that you can use while designing your user interface. This value is only used while designing your interface in Interface Builder; at runtime, the layout engine uses the view’s actual intrinsic content size instead.

![inline][InstrinsicSize2]

[InstrinsicSize2]:https://i.imgur.com/n95M54n.png


8. On the bottom right of the canvas, open the Pin menu.

![inline][PinMenu]


[PinMenu]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/AL_pinmenu_2x.png

9. Select the checkbox next to Aspect Ratio.


10. 

![inline][AddNewConstraints_]

[AddNewConstraints_]:https://i.imgur.com/dvPMX0i.png


11. In the Pin menu, click the Add 1 Constraints button.
Your image view now has a 1:1 aspect ratio, so it will always be a square.


![inline][Square]


[Square]:https://i.imgur.com/jXI5Ggw.png


12. With the image view selected, open the Attributes inspector image:

![inline][AttributesInspector]

[AttributesInspector]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/inspector_attributes_2x.png

Recall that the [Attributes inspector](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW19) appears when you select the fourth button from the left in the inspector selector bar. It lets you edit the properties of an object in your storyboard.


13. In the Attributes inspector, find the Interaction field and select the User Interaction Enabled checkbox.
You’ll need this feature later to let users interact with the image view.

![inline][UserInteractionEnabled]

[UserInteractionEnabled]:https://i.imgur.com/1CeyMnt.png


## Display a Default Photo

Add a placeholder image to let users know that they can interact with the image view to select a photo. (Use the one below or use one of your own. Drag it to your desktop)

![inline][NoPhotoSelected]

[NoPhotoSelected]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/defaultphoto_2x.png


### To add an image to your project

1. In the [project navigator](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW57), select Assets.xcassets to view the asset catalog.  
The [asset catalog](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW69) is a place to store and organize your image assets for an app.

2. In the bottom left corner, click the plus (+) button and select New Image Set from the pop-up menu.

![inline][NewImageAsset]

[NewImageAsset]: https://i.imgur.com/XZVUle5.png

3. Double-click the image set name and rename it to `defaultPhoto`.

4. On your computer, select the image you want to add.

5. Drag and drop the image into the 2x slot in the image set.

![inline][AddDefaultPhoto]

[AddDefaultPhoto]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/WWVC_defaultphoto_drag_2x.png

`2x` is the display resolution for the iPhone 7 [Simulator](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW128) that you’re using in these lessons, so the image will look best at this resolution.

With the default placeholder image added to your project, set the image view to display it.


### To display a default image in the image view

1. Open your storyboard.
2. In your storyboard, select the image view.
3. With the image view selected, open the Attributes inspector in the utility area.
4. In the Attributes inspector, find the field labeled Image and select `defaultPhoto`.

**Checkpoint**: Preview your view in the storyboard (if you dont remember, go back to instructions in Pt 1 & 2 on previewing in storyboards)


**Checkpoint**: Run your app. The default image displays in the image view.

![inline][CP]

[CP]: https://i.imgur.com/5cZ8dXg.png

### Connect the Image View to Code

Now, you need to implement the functionality to change the image in this image view at runtime. First, you need to connect the image view to the code in `CaptionedViewController.swift`.

#### To connect the image view to the `CaptionedViewController.swift` code

1. Click the Assistant button in the Xcode toolbar near the top right corner of Xcode to open the assistant editor.

![inline][AssistantEditor2]

[AssistantEditor2]:https://i.imgur.com/yxmnwLk.png


2. If you want more space to work, collapse the project navigator and utility area by clicking the Navigator and Utilities buttons in the Xcode toolbar.

![inline][NavigatorToggle]

[NavigatorToggle]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/navigator_utilities_toggle_on_2x.png

3. You can also collapse the outline view.

4. In your storyboard, select the image view.

5. Control-drag from the image view on your canvas to the code display in the editor on the right, stopping the drag at the line just below the existing outlets in `CaptionedViewController.swift`.


6. In the dialog that appears, for Name, type photoImageView. Leave the rest of the options as they are.

7. 

![inline](PhotoImageViewOutlet)

[PhotoImageViewOutlet]:https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/gifs/PhotoImageView-gif.gif


