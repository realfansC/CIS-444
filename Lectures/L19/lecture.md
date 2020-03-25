# CIS-444
 Lecture 19
 March 25, 2020



### Tab View Controller 

### Overview
A tab bar controller allows you to arrange your app according to distinct modes or sections. For example, the Clock app is divided into five modes: World Clock, Alarm, Bedtime, Stopwatch, and Timer.

![inline](https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L19/Screenshots/alarm-app.png)

As you'd expect, a tab bar interface features a tab bar view, which runs along the bottom of the app's screen. Each tab can contain its own independent navigation hierarchy, with the tab bar controller coordinating the navigation between the different view hierarchies. The tab bar distinguishes the currently selected tab with a different-colored icon and title.

### Technical Overview

<a href="https://imgur.com/WhoidE5"><img src="https://i.imgur.com/WhoidE5.gif" title="source: imgur.com" /></a>


Tab bar controllers are implemented by the [UITabBarController][uitabbarcontroller] class. They allow a user of to switch between multiple arbitrary view controllers by maintaining an [array of `UIViewControllers`][viewcontrollersprop]

They can be used to allow the user to navigate between entirely different parts of your application, or they can be used to display two different views of the same backing data. Tab bar controllers also have the built-in ability to display a "More..." interface when more than 5 tabs are added. They can also let the user customize which tabs are shown by on the main tab bar when there are more than 5 tabs. An example of this behavior is found in the standard iOS "Music" app (previously "iTunes").


### Add a tab bar controller
To practice building a tab bar interface, you'll create a simple app that navigates between several root view controllers. (This could be a good template for future projects that also use a tab bar controller.)
1. Create a new project called "RainbowTabs" using the Single View Application template.
2. Download  the PDF files [here]() 
3. Drag the assets into  the project's Assets.xcassets folder (The PDF's use vector-based images, which look great at any resolution). 
4.  Open Main.storyboard and
5. in the document outline, select View under View Controller. Using the Attributes inspector, set the view's background color to red.

6. Create the tab bar controller. With the red view selected, choose Editor > Embed In > Tab Bar Controller from the Xcode menu bar.

![inline](background-red.png)

This action places a tab bar controller at the beginning of the scene. 

The tab bar controller maintains a list of tabs through its `viewControllers` property, an array of the root view controllers displayed by the tab bar interface. 

That last step added the red view controller to the tab bar controller's array of root view controllers. For each root view controller, there's an associated  `UITabBarItem` instance. You now have a tab bar with one tab bar item.

![inline](embed-tab.png)

### Add a tab item

To add another tab bar item
1. Select View Controller in the Object library, and drag it onto the canvas. 

3. Give the view controller an orange background. 
4. Add the new view controller into the viewControllers array. Control-drag from the tab bar controller to the orange view controller, and release the mouse or trackpad button. In the popover, you can see "view controllers" listed under Relationship Segue. Choose this option.

![inline](viewcontrollers-array.png)

You should now see a second tab bar item on the tab bar controller. 

![inline](orange-view.png)

5. Build and run your app. Notice that you can switch between the two view controllers by selecting a different tab bar item.”

### Tab Bar Item Apperance

A tab bar item consists of two visual elements: an image and a label. The iOS SDK provides several iOS-style icons paired with system-defined text, referred to as system items. You can see a few of them on the App Store tab bar.
 
![inline](tab-bar-item-stock.png)

In your RainbowTabs project, select the tab bar item in the red view controller, and open the Attributes inspector. Choose any of the system items from the System Item pop-up menu. Notice how the tab bar item adjusts to your different selections.

![inline](device-orientation.png)

### Customize Tab Bar ITems

But maybe the system items don't make sense for your app. You can use the Attributes inspector to customize an item's label and its image, for both unselected and selected states.

1. Open `main.storyboard`

2. Select the red view. 
3. Type "Red" in the Title field and add "R" as the image.”

Make sure that you've added the PDF vector images from dropbox folder (download [here](https://www.dropbox.com/sh/r823hfpzv0xa16f/AABf2FKFmvTPi-nZs9NVN8cDa?dl=0) into the project's `Assets.xcassets` directory.) If you want, you can also customize the Selected Image attribute to distinguish the tab item's selected state.

![inline](bar-item-R.png)

4. Make changes to the tab bar item for the orange view controller.

![inline](bar-item-O.png)

5. If you want your tab bar item to indicate that new information is available for that view or mode, you can add a small red marker with white text, known as a badge, to the tab bar item. Use the Badge attribute to enter information.

![inline](bar-item-badge.png)

### Programmatic Customization
Storyboards are ideal for setting up initial, or default, view scenes; but they don't allow you to make runtime adjustments using the Attributes inspector. 

That's OK. You can accomplish any of these customizations in code

For example, imagine you want to alert your user that new information is available. Your app would have to update the badge at runtime. 

### Assign a custom badge in code
1. Set the badgeValue property to a non-nil string. 
2. You can access your view controller's UITabBarItem instance through its tabBarItem property. For more explanation, you can reference the [UIViewController Documentation](https://developer.apple.com/reference/uikit/uiviewcontroller).

3. In  `ViewController.swift`, insert the following line to the viewDidLoad() function:


```swift
tabBarItem.badgeValue = "!"
```
Run your app in Simulator. You'll notice the red tab item now has a badge.

![inline][tab-bar-with-badge.png]

The badge will draw your user's attention to that tab. After they've viewed the new information, the badge is no longer necessary. To remove the badge, assign a `nil` value to the `badgeValue` property.


```swift
tabBarItem.badgeValue = nil
```
### “Even More Tab Items
You've probably noticed that the current version of your project doesn't live up to its "RainbowTabs" name. Try adding three more colors in three more tab items. A tab bar will display all tab bar items as long as there's enough horizontal space.

1. Select View Controller in the Object library

2. Add three of them to the canvas. 

3. Set the background color of one view controller to yellow, another to green, and the third to blue.

If you find it helpful, you can reposition the view controllers on the canvas to match the order on the tab bar.

![inline](rainbow-tabs.png)


4. Add each of these view controllers to the viewControllers property of the tab bar controller.

![inline](rainbow-array.png)

Feel free to update the new tab bar items with images from the Assets Catalog. 

Run your app in Simulator on an iPhone device. With five items on the tab bar, there isn't much space left. _What do you think will happen if you add a final purple view controller to the tab bar controller?_

![inline](yellow.png)


5. Drag another view controller onto the canvas

6. Update its background color to purple

7. Add it to the tab bar controller's array of view controllers. 

You'll notice, in your tab bar controller scene, the fifth tab is replaced with a More tab item.

![inline](more-storyboard.png)

8. Run the app on the simulatlor. What just happened? 

![inline](more-simulator.png)

Whenever you add more view controllers than the tab bar can display, the tab bar controller inserts a special view controller, known as the More view controller. This view controller lists the omitted view controllers in a table, which can expand to accommodate any number of items.


### About More view controller
The More view controller is unusual. *It can't be customized or selected.* It doesn't appear among the view controllers managed by the tab bar controller. It appears only when needed and is otherwise separate from the rest of your content. 

The More view controller can be quite useful for displaying additional tab items, but also consider that a More tab requires more time and effort from the user. _A much better practice is to plan your app carefully so that you include only essential tabs—the minimum number necessary for your app and its information hierarchy. For iPhone apps, five is generally considered the maximum; for iPad-only apps, you can add a few more._


### More View Controllers

Currently, only the controller with the red view can be customized with code, because it's the only controller that uses a `UIViewController` subclass. That subclass is called `ViewController`, and it was created as part of the Single View Application template. 

At some point, you're going to want to add new functionality into the other view controllers, such as fetching data or managing a user account. Regardless of the view controller's responsibilities, there is a high chance you'll need to use code in order to perform a task. This means you'll need additional `UIViewController` subclasses, one for each of the different colored screens.

1. Rename the existing ViewController class to something more descriptive: RedViewController. 
2. Update the class definition, then rename the  `ViewController.swift` file to `RedViewController.swift`. (Note: The filename does not have to match the class name, but it makes the class definition easier to locate in the future for yourself or other members of your team.)

```swift
class RedViewController : UIViewController {
 
}
```

![inline](redviewcontroller.png)

3. 👀 You'll need to update the red view's controller class from ViewController to RedViewController as well, since the ViewController class no longer exists. Highlight the red view's controller in the Document Outline, then use the Identity inspector to set the custom class to the new name.

![inline](rename-class.png)

Now you're ready to add new view controllers to your project. 

1. Select File -> New -> File (Command-N) from the Xcode menubar. 
2. Select "Cocoa Touch Class" as your starting template, then click Next. 
3. Set the subclass of your new class to `UIViewController`
4. then give your class a new name, `OrangeViewController`. (It is convention to append "ViewController" to the end of your class name so it's clear what type of object you're subclassing.)
5. Click Next, then Create, to finalize the subclass creation.

![inline](Orange-view-controller.png)

Now that you have a new view controller to work with, you can update the controller of the orange view to `OrangeViewController`. 

6. Open `Main.storyboard` and select the orange view's controller in the Document Outline. 
7. Use the Identity inspector to set the custom class to `OrangeViewController`.
8. Repeat the steps of creating a new UIViewController subclass for every tab, and assign each view controller a unique custom class.

### Tabs with navigation controllers

1. Change the tab bar controller to use three navigation controllers as its viewControllers.

Each navigation controller's root view controller should be one of the colored view controllers. 


[] ✏️ When you're done, submit your project to `RCSlatki@syr.edu` by April 30, 2020


[viewcontrollersprop]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBarController_Class/#//apple_ref/occ/instp/UITabBarController/viewControllers
[uitabbarcontroller]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBarController_Class/





### Due and submitted to me by end of class (`rcslatki@syr.edu`):
* [ ] 
* [ ] Create an app that displays distinct types of information about yourself in separate tabs.

#### Example:

![inline 50%](https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L19/Screenshots/L19-Home.png)

![inline 50%](https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L19/Screenshots/L19-Family.png)

![inline 50%](https://github.com/SyracuseUniversity-CIS444/CIS-444/blob/master/Lectures/L19/Screenshots/L19-Hobbies.png)

