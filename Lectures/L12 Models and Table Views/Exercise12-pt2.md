# CIS-444 Lecture-12 Pt.2

# Create a Table View

In this lesson, you create a second, table view-based scene, that lists the cook programs . This cook program list becomes the initial scene for your app. You also design custom table cells to display each cook program.


## Learning Objectives

At the end of the lesson, you’ll be able to:

[x] Create a second storyboard scene
[x] Understand the key components of a table view
[x] Create and design a custom table view cell
[x] Understand the roles of table view delegates and data sources
[x] Use an array to store and work with data
[x] Display dynamic data in a table view

## Create the Cook Program List

So far, the guided cook program app has a single [scene](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW62), that is, a single screen of content. In a storyboard, each scene contains views managed by that a view controller, and any items added to the controller or its views (for example, Auto Layout constraints). A view is a rectangular region that can draw its own content and respond to user events. Views are instances of the `UIView` `class or one of its subclasses. In the CaptionThat app, we had a  scene containing the view controller’s content view, and all of the subviews you added in Interface Builder (the stack view, label, text field, image view).


Now it’s time to create another scene that shows the entire list of cook programs. Fortunately, iOS comes with a built-in class, `UITableView`, designed specifically to display a scrolling list of items. A table view is managed by a table view controller (`UITableViewController`). `UITableViewController` is a [subclass](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW14) of `UIViewController`, which is designed to handle table view-related logic. You’ll create the new scene using a table view controller. The controller displays and manages a table view. In fact, the table view is the controller’s content view, and fills the entire space available to the scene.

### To add a scene with a table view to your storyboard

1. Open your [storyboard](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW8), `Main.storyboard`.
2. Open the [Object library](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW54) in the utility area. (Alternatively, choose View > Utilities > Show Object Library.)
3. In the Object library, find a Table View Controller object.
4. Drag a Table View Controller object from the list, and drop it on the [canvas](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW6) to the left of the existing scene.

If you try to drag the table view to the canvas and nothing happens, you’re probably dragging a table view object rather than a table view controller object. The table view object is just a view representing the table itself. Like other view objects, it must be added as a subview to an existing scene. On the other hand, the table view controller is a full scene. It includes both a table view and the controller that manages the table view.

![inline][table-view-controller-obj-img]


You now have two scenes, one for displaying the cook programs list and that does nothing

![inline][added-table-view-controller-img]



[added-table-view-controller-img]
