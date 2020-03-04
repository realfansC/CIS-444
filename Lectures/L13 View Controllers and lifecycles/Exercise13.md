
## CIS-444
### Lecture 13

## Implement Navigation

In this lesson, you use navigation controllers and segues to create the navigation flow of the cooking app. At the end of the lesson, you’ll have a complete navigation scheme and interaction flow for the app.

Some of this is a reivew. A great opportunity to test what you have learned so far. Review previous lectures, guides, and documentation if you can't remember how to do something.

👀: Denotes a step that you have already done in previous lessons. Review to previous guides, lectures and lessons to remember how to do so. 

## Learning Objectives


At the end of the lesson, you’ll be able to:

* [x] Embed an existing view controller within a navigation controller in a storyboard
* [x] Create segues between view controllers
* [x] Edit the attributes of a segue in a storyboard using the Attributes inspector
* [x] Pass data between view controllers using the `prepare(for:sender:)` method
* [x] Use stack views to create robust, flexible layouts

## Setting up our details view

Before creating a segue, we need to create a screen displaying a cook program's details.

1. 👀 *Create a new UIViewController*
Create a new Cocoa Touch class with a subclass of `UIViewController` class named `CookProgramDetailsViewController`

It should look similar to this: 
```swift
//
//  CookProgramDetailsViewController.swift
//  CookingPlus
//
//  Created by Rebecca  Slatkin on 2/26/20.
//  Copyright © 2020 Syracuse University. All rights reserved.
//

import UIKit

class CookProgramDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
```

2. Above `viewDidLoad()` add a `//MARK: Properties` 

3. Add a property below `//MARK: Properties` :  `var cookProgram: CookProgam`

```swift
// MARK: Properties
var cookProgram: CookProgram?
```


2. 👀 Open your `Main.storyboard`, drag a new `UIViewController` scene onto the canvas

3. 👀 In the storyboard, set your new `UIViewController` class type to `CookProgramDetailsViewController`

At this point, your `main.storyboard` should look like this:

![inline][lecture-13-navigation-progress-img]

4.  👀 In the `CookProgramDetailsViewController` scene, make the `CookProgramDetailsViewController` scene look like this.:


![inline][lecture-13-lecture-13-cook-program-details-layout-img]

This is very similar to last week's exercise with some tweaks. Refer back to [Part 1](https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/Pt1.md) and [Part 2](https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L11%20Animations/Pt2.md) and [Part 2](https://github.com/SyracuseUniversity-CIS444/Coding-Assigment-03/blob/master/Pt1-HW-03.md#to-add-auto-layout-constraints-to-the-caption-scene)
do the following...
* Add an image view to the scene (`cookProgramImageView`)
* Drag an Image View object from the Object library to your scene the button.
* Add  two labels below the image view
* Emebed the image view, and 2 labels into a stack view
* Set the stack view's  spacing field  to `10` (Need help? [Here.](https://github.com/SyracuseUniversity-CIS444/Coding-Assigment-03/blob/master/Pt1-HW-03.md#to-add-auto-layout-constraints-to-the-caption-scene))
* Set the image view's `intrinsic content size` to `Placeholder` with values height: `320` and width: `320`
* Ensure the label texts do not run off the screen 


5. Create three outlets connecting the two labels and imageView in your scene to  `CookProgramDetailsViewController.swift`
(Need help? [Here.](https://github.com/SyracuseUniversity-CIS444/Coding-Assigment-03/blob/master/Pt2-HW-03.md#create-outlets-for-ui-elements))

After you're done you should have three outlets connected.

![inline][lecture-13-outlet-scene-state-img]


## 👀 Add a Segue to Navigate Forward

With data displaying as expected, it’s time to provide a way to navigate from the initial cook program list [scene][scene-documentation] to the cook program detail scene. Transitions between scenes are called [segues][segues-documentation].

Before creating a segue, you need to configure your scenes. First, you’ll put your table view controller inside of a navigation controller. A navigation controller manages transitions backward and forward through a series of view controllers. The set of view controllers managed by a particular navigation controller is called its navigation stack. The first item added to the stack becomes the root view controller and is never popped off (removed from) the navigation stack.

### 👀 To add a navigation controller to your cook program list scene

1. Open your storyboard, `Main.storyboard`.
2. Select the cook program list scene by clicking on its [scene dock](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW63).
3. 👀 Choose Editor > Embed In > Navigation Controller.

Xcode adds a new navigation controller to your storyboard, sets the storyboard entry point to it, and assigns the cook program list scene as its root view controller.

![inline][lecture-13-navigation-entry-img]

On the canvas, the icon connecting the controllers is the root view controller relationship. The table view controller is the navigation controller’s root view controller. The storyboard entry point is set to the navigation controller because the navigation controller is now a container for the table view controller.


You might notice that your table view has a bar on top of it now. This is a navigation bar. Every controller on the navigation stack gets a navigation bar, which can contain controls for backward and forward navigation. Next, you’ll add a button to this navigation bar to transition to the cook program detail scene.


✅point: Run your app. Above your table view you should now see extra space. This is the navigation bar provided by the navigation controller. The navigation bar extends its background to the top of the status bar, so the status bar doesn’t overlap with your content anymore.


![inline][lecture-13-navigation-bar-table-view-img]

## Configure the Navigation Bar for the Scenes

Now, you’ll add the cook program list title and a button (to add additional cook programs) to the navigation bar. Navigation bars get their title from the view controller at the top of the navigation stack—they don’t have a title themselves. Each view controller has a `navigationItem` property. This property defines the navigation bar’s appearance for that view controller.

In Interface Builder, you can configure a view controller’s navigation item by editing the navigation bar in the view controller’s scene.

### To configure the navigation bar in the cook program list

1. Double-click the navigation bar in the cook program list scene.

![inline][lecture-13-navigation-bar-title-img]


A cursor appears in a text field, letting you enter text.

2. Type `Cookbook` and press Return. This sets the title for the table view controller’s navigation item.

![inline][lecture-13-navigation-bar-title-cookbook-img]

## Configure Navigation Bar item 

We want to add the ability to create a new cook program from the list of cook programs. We can do this by adding a bar button item to the right of the title. 

### To add a new bar button item 
1. 👀 Open the Object library. `+` sign in the toolbar or  Choose View > Show Library
2. Drag a Bar Button Item object from the list to the far right of the navigation bar in the cook program list scene.

![inline][lecture-13-bar-button-item-img]

A button called Item appears where you dragged the bar button item.

![inline][lecture-13-add-bar-button-item-gif]

3. Select the bar button item and open the Attributes inspector

4. In the Attributes inspector, choose Add from the pop-up menu next to the System Item option.

The button changes to an Add button (+).

![inline][lecture-13-inspector-add-button-img]

✅point: Run your app. The navigation bar should now have a title and display an Add button (+). The button doesn’t do anything yet.

If you don't see a (+) sign, go to your `CookProgramTableViewController.swift` class and make sure 
in the `viewDidLoad()` function,  `self.navigationItem.rightBarButtonItem = self.editButtonItem` is commented out or deleted.

![inline][lecture-13-progress-02-img]


## View details of Cook Program

Right now our `CookProgram` object doesn't have much to show. Eventually a `CookProgram` we will have cook steps, videos, images, ingredients, equipment, etc. Far too much information to show in the list view. 

When the user taps on a cook porgram in the list scene, you'll display the cook program in the detail scene. The user can then view the cook program details. modify, share with friends, etc. 

Let's start by setting up the  `segue`s between cook program list items and the cook program detail scene.

### To configure the table view cell

1. If the assistant editor is open, return to the standard editor by clicking the Standard button.

2. Open your storyboard, `Main.storyboard`.

3. On the canvas, select the table view cell in the cook program list (Cookbook) scene.

3. Control-drag from the table view cell to the cook porgram  detail scene.

4. A shortcut menu titled Selection Segue appears in the location where the drag ended.

5. Choose Show from the Selection Segue menu. This causes the navigation controller to push the cook program detail scene onto the navigation controller’s stack.

![inline][lecture-13-cell-details-segue-gif]

6. On the canvas, select the newly added segue (the segue that runs directly from the cook program list (Cookbook) scene to the cook porgram detail scene).

7. In the Attributes inspector, type `ShowDetail` in the Identifier field. Press Return.

![inline][lecture-13-cell-details-segue-img]


You use the identifier when referring to the segue in code.

When the user taps a row in the cook program list, this segue is triggered. The segue pushes the view controller for the cook program detail scene onto the navigation stack that contains the cook program list scene. The app then animates the transition from the cook program list scene to the cook program detail scene.


8. ✅point: Run your app. Tap on a cook program from the cook program  list. The app navigates to the cook program detail scene.

![inline][lecture-13-navigation-detail-demo]


Recall from  your early [2nd coding assignment](https://github.com/SyracuseUniversity-CIS444/Coding-Assignment-02#part-9-we-will-use-the-segue-we-created-in-step-8-to-pass-along-the-picture-we-created-in-landingviewcontroller-to-captionedviewcontroller)  `prepare(for:sender:)` method is called before any segue gets executed. You can use this method to identify which segue is occurring, and display the appropriate information in the cook program detail scene. You’ll differentiate the segues based on the identifiers you assign to them: `AddItem` when adding new cook program (we'll do this next week) and `ShowDetail` when viewing an existing cook program.

### To identify which segue is occurring

1. Open `CookProgramTableViewController.swift`

2. At the top of the file, immediately following the import of UIKit, import the unified logging system.

```swift
import os.log
```

3. In `CookProgramTableViewController.swift`, find and uncomment the `prepareForSegue(_:sender:)` method. (To uncomment the method, remove the /* and */ characters surrounding it.)
After you do that, the template implementation looks like this:

```swift
//MARK: - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
}
```

Because `CookProgramTableViewController` is a subclass of `UITableViewController`, the template implementation comes with a skeleton for `prepare(for:sender:)`.
```swift
/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
```

Delete the two lines of comments, and replace them with a call to the superclass’s implementation.

```swift
super.prepare(for: segue, sender: sender)
```
After the call to `super.prepare(for:sender:)`, add this switch statement:

```swift
switch(segue.identifier ?? "") {
    
}
```

A `switch` statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully. Use switch statements instead of `if` statements when selecting between multiple options.

The code above examines the segue’s identifier. If the identifier is `nil`, the nil-coalescing operator (`??`) replaces it with an empty string (`""`). This simplifies the switch statement’s logic, since you won’t need to deal with optionals inside the cases.

4. Add the `AddItem` case to the switch.


```swift
case "AddItem":
os_log("Adding a new cook program.", log: OSLog.default, type: .debug)
```

If the user is adding an cook program to the cook program list, you don’t need to change the cook program detail scene’s appearance. Just log a simple debug message to the console. This will help you track the app’s flow if you have to debug your code.

5. Add the `ShowDetail` case to the switch.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    switch(segue.identifier ?? "") {
    case "AddItem":
        os_log("Adding a new cook program.", log: OSLog.default, type: .debug)
        
    case "ShowDetail":
        guard let cookProgramDetailsViewController = segue.destination as? CookProgramDetailsViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        guard let selectedProgramCell = sender as? CookProgramTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        guard let indexPath = tableView.indexPath(for: selectedProgramCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedCookProgram = cookPrograms[indexPath.row]
        cookProgramDetailsViewController.cookProgram = selectedCookProgram
    }
}
```
If you are viewing an existing cook program, you need to display the cook program's data in the cook program detail scene. This code starts by getting the destination view controller, the selected cook program cell, and the index path of the selected cell. The guard statements check that all the downcasts work as expected, and all optionals contain non-`nil` values. Here, the guard statements simply act as a sanity check. If your storyboard is set up correctly, none of these `guard` statements will fail.  

As soon as you have the index path, you can look up the cook program object for that path and pass it to the destination view controller.



6. Add the default case.

```swift
default:
         fatalError("Unexpected Segue Identifier: \(segue.identifier)")
```
Again, if your storyboard is set up correctly, the default case never executes. However, if you later add another segue from your Cookbook scene and forget to update the `prepare(for:sender:)` method, the new segue’s identifier won’t match either the `AddItem` or the `ShowDetail` case. In this case, the switch statement prints an error message to the console and terminates the app.


Your `prepare(for:sender:)` method should look something like this:

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    switch(segue.identifier ?? "") {
    case "AddItem":
        os_log("Adding a new cook program.", log: OSLog.default, type: .debug)
        
    case "ShowDetail":
        guard let cookProgramDetailsViewController = segue.destination as? CookProgramDetailsViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        guard let selectedProgramCell = sender as? CookProgramTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        guard let indexPath = tableView.indexPath(for: selectedProgramCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedCookProgram = cookPrograms[indexPath.row]
        cookProgramDetailsViewController.cookProgram = selectedCookProgram

    default:
        fatalError("Unexpected Segue Identifier: \(segue.identifier)")
    }
}
```

Now that you have the logic implemented, open `CookProgramDetailsViewController.swift` and make sure the user interface (UI) updates correctly. Specifically, when an instance of `CookProgramDetailsViewController` (the cook program detail scene) gets created, its views should be populated with data from its cook program property, if that data exists. You do this type of setup work is in the `viewDidLoad()` method.


### To update the implementation of viewDidLoad

1. Open `CookProgramDetailsViewController.swift`
2. In `CookProgramDetailsViewController.swift`, find the `viewDidLoad()` method.
3.  Below the `super.viewDidLoad` line, add the following code. If the cook program property is non-nil, this code sets each of the views in `CookProgramDetailsViewController` to display data from the cookProgram property. The cookProgram property will only be non-nil when an existing cookProgram is being viewed.


```swift
// Set up views if viewing an existing CookProgram.
if let cookProgram = cookProgram {
    navigationItem.title = cookProgram.name
    titleLabel.text = cookProgram.name
    descriptionLabel.text = cookProgram.description
    imageView.image = cookProgram.photo
}
```

4. Your `viewDidLoad()` should look like this:

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // Set up views if viewing an existing CookProgram.
    if let cookProgram = cookProgram {
        navigationItem.title = cookProgram.name
        titleLabel.text = cookProgram.name
        descriptionLabel.text = cookProgram.description
        imageView.image = cookProgram.photo
    }
}
```
✅point: Run your app. Click a cook program from the cook porgram list to navigate to the cook program detail scene. The detail scene should be prepopulated with data about the cook program.



[scene-documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW62

[segues-documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW65


[lecture-13-navigation-progress-img]:resources/lecture-13-navigation-progress.png

[lecture-13-navigation-entry-img]:resources/lecture-13-navigation-entry.png

[lecture-13-navigation-bar-table-view-img]:resources/lecture-13-navigation-bar-table-view.png


[lecture-13-navigation-bar-title-img]:resources/lecture-13-navigation-bar-title.png

[lecture-13-navigation-bar-title-cookbook-img]:resources/lecture-13-navigation-bar-title-cookbook.png

[lecture-13-bar-button-item-img]:resources/lecture-13-bar-button-item.png

[lecture-13-add-bar-button-item-gif]:resources/lecture-13-add-bar-button-item.gif

[lecture-13-inspector-add-button-img]:resources/lecture-13-inspector-add-button.png

[lecture-13-progress-02-img]:resources/lecture-13-progress-02.png

[lecture-13-cell-details-segue-gif]:resources/lecture-13-cell-details-segue.gif


 
[lecture-13-cell-details-segue-img]:resources/lecture-13-show-detail-segue.png

[lecture-13-navigation-detail-demo]:resources/lecture-13-navigation-detail-demo.gif

[lecture-13-lecture-13-cook-program-details-layout-img]:resources/lecture-13-cook-program-details-layout.png

[lecture-13-outlet-scene-state-img]:lecture-13-outlet-scene-state.png
