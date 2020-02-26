
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
* [x] Perform an unwind segue
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

2. 👀 Open your `Main.storyboard`, drag a new `UIViewController` scene onto the canvas

3. 👀 In the storyboard, set your new `UIViewController` class type to `CookProgramDetailsViewController`

At this point, your `main.storyboard` should look like this:

![inline][lecture-13-navigation-progress-img]


## 👀 Add a Segue to Navigate Forward

With data displaying as expected, it’s time to provide a way to navigate from the initial cook program list [scene][scene-documentation] to the cook program detail scene. Transitions between scenes are called [segues][segues-documentation].

Before creating a segue, you need to configure your scenes. First, you’ll put your table view controller inside of a navigation controller. A navigation controller manages transitions backward and forward through a series of view controllers. The set of view controllers managed by a particular navigation controller is called its navigation stack. The first item added to the stack becomes the root view controller and is never popped off (removed from) the navigation stack.

### 👀 To add a navigation controller to your cook program list scene

1. Open your storyboard, `Main.storyboard`.
2. Select the meal list scene by clicking on its [scene dock](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW63).
3. 👀 Choose Editor > Embed In > Navigation Controller.

Xcode adds a new navigation controller to your storyboard, sets the storyboard entry point to it, and assigns the meal list scene as its root view controller.

![inline][lecture-13-navigation-entry-img]

On the canvas, the icon connecting the controllers is the root view controller relationship. The table view controller is the navigation controller’s root view controller. The storyboard entry point is set to the navigation controller because the navigation controller is now a container for the table view controller.


You might notice that your table view has a bar on top of it now. This is a navigation bar. Every controller on the navigation stack gets a navigation bar, which can contain controls for backward and forward navigation. Next, you’ll add a button to this navigation bar to transition to the meal detail scene.


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

![inline][lecture-13-lecture-13-bar-button-item-img]

A button called Item appears where you dragged the bar button item.




[scene-documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW62

[segues-documentation]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW65


[lecture-13-navigation-progress-img]:resources/lecture-13-navigation-progress.png

[lecture-13-navigation-entry-img]:resources/lecture-13-navigation-entry.png

[lecture-13-navigation-bar-table-view-img]:resources/lecture-13-navigation-bar-table-view.png


[lecture-13-navigation-bar-title-img]:resources/lecture-13-navigation-bar-title.png

[lecture-13-navigation-bar-title-cookbook-img]:resources/lecture-13-navigation-bar-title-cookbook.png

[lecture-13-lecture-13-bar-button-item-img]:resources/lecture-13-bar-button-item.png
