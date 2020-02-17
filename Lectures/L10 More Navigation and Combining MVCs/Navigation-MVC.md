CIS-444 
Lecture 10: App Architecture 

---
Today:

* App Architecture
	* Overview
* Container View Controllers
	* Navigation Controller

---

## App Architecture

* An iOS project is composed of many files that define different aspects of the application.  
* Today will cover a high level overview of the most common components of an application and how they fit together.[^0]  

[^0]: A more comprehensive guide by Apple can be found [here][appguide].

[appguide]: https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html

----

### UIApplication 

![inline](https://miro.medium.com/max/1088/1*n8zDfF0RCd3keeFqAqWBGA.png)

---
## Structure of a `UIApplication`

* All iOS applications are instances of [`UIApplication`][uiapplication].

* Each application has a number of events in its lifecycle (e.g. launched, went into the background, terminated).  

![right 55%](https://miro.medium.com/max/1088/1*n8zDfF0RCd3keeFqAqWBGA.png)


[uiapplication]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplication_Class/

---

## Structure of a `UIApplication`

* As with other classes in the UIKit framework, you control how the application will respond to these events by providing it with a [delegate][delegatepattern]. 

* A `UIApplication`'s delegate must implement the [`UIApplicationDelegate`][uiapplicationdelegate] protocol.

![right 55%](https://miro.medium.com/max/1088/1*n8zDfF0RCd3keeFqAqWBGA.png)

[delegatepattern]: http://en.wikipedia.org/wiki/Delegation_pattern
[uiapplicationdelegate]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/index.html

---

## Structure of a `UIApplication`

* When you create a new application in Xcode, the IDE automatically sets up the code to instantiate a `UIApplication` when the project is run.[^1]

* It also generates a class that implements `UIApplicationDelegate` called `AppDelegate` and sets the application's [delegate property][uiapplicationdelegateprop] to an instance of this class.

[^1]: This is done via the `@UIApplicationMain` [attribute][attribute]

[uiapplicationdelegate]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/index.html
[uiapplication]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplication_Class/
[uiapplicationdelegateprop]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplication_Class/#//apple_ref/occ/instp/UIApplication/delegate
[attribute]: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Attributes.html
---

### The entry point to your application

* Of the methods that you can implement in your `UIApplicationDelegate`,
the most important is [didFinishLaunchingWithOptions][didfinishlaunching]. 

* This method will be called once iOS has done most of the system initialization for your
app. It is commonly used as an entry point where you can implement custom logic that initializes your application and sets up the first view controller. 
[didfinishlaunching]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/index.html#//apple_ref/occ/intfm/UIApplicationDelegate/application:didFinishLaunchingWithOptions:

---

### The entry point to your application

For example, in applications that require log ins, this is a good place to check whether there is a current user and initialize different view controllers depending on the "logged in" state.

--- 

### The root view controller

The `UIApplicationDelegate` also provides a reference to the application's main [window][mainwindow] object.  Of particular importance is the ability to set the main window's _root view controller_.  

[mainwindow]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/index.html#//apple_ref/occ/intfp/UIApplicationDelegate/window

---

### The root view controller

This is the first view controller that will load and
present its view to the user.

----

#### The root view controller in storyboard applications

In simple storyboard applications, you can avoid working with the `UIApplicationDelegate` and simply set the root view controller directly in your `Main.storyboard`.  


---

#### The root view controller in storyboard applications

* By default Xcode will generate an initial view controller for you and set it to be the root view controller.  

![inline 200%](https://i.imgur.com/winIGnhl.png)


^This is indicated by the arrow that points to the view controller.  Once you start adding more view controllers to your application, you can change the root view controller by dragging this arrow around. You can also select a view controller and set it to be the root view controller by using the `Is Initial View Controller` checkbox in the Attributes Inspector.


---

#### Programmatically setting the root view controller

* In applications not using storyboards, you must programmatically set the root view controller.  This is done in your `UIApplicationDelegate` implementation's `didFinishLaunchingWithOptions` method.

---

#### Programmatically setting the root view controller


```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let vc = UIViewController()

        let label = UILabel()
        label.text = "hello, world!"
        label.frame = vc.view.frame

        // by default a UIViewController's .view property is set to an instance of UIView
        // of course you can set this to any custom subclass of UIView
        // one way to do this is subclass UIViewController and override the loadView method
        vc.view.backgroundColor = UIColor.cyan
        vc.view.addSubview(label)

        window = UIWindow(frame: UIScreen.main.bounds)

        // This can be set to any subclass of UIViewController. You can also use conditional
        // logic here to set up different view controllers depending on application state
        window?.rootViewController = vc
        window?.makeKeyAndVisible()

        return true
    }
    ...
}
```

----

#### Programmatically setting the root view controller

![inline 200%](https://i.imgur.com/fXE9BWwl.png)

----

### Other hooks in the application lifecycle

* The `UIApplicationDelegate` protocol provides many other hooks into the application's lifecycle giving you opportunities to things like respond differently depending on how your application was launched, set up and tear down temporary state depending whether your app is in the foreground, and persist data before exiting.[^2]

[^2]: A detailed discussion of the application lifecycle can be found [here][applifecycle].

[applifecycle]: https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html#//apple_ref/doc/uid/TP40007072-CH2-SW3

----
### Recap: Model-View-Controller in iOS 

![inline](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/cocoa_mvc.gif)

---

### Recap: Model-View-Controller in iOS

* Most applications you write for iOS will use a model-view-controller (MVC) architecture similar to the one described by Apple [here][applemvc][^3]. 

* This is a proven design that helps to break up your application into manageable parts with clean separation of concerns. 

[^3]: This description of MVC is actually slightly different than the one
originally described by [Krasner and Pope][smalltalkmvc] in the 1980s,
and is closer to what some people would call a model-view-presenter pattern. An interesting discussion of the
evolution of MVC architecture over time by Martin Fowler can be found [here][fowlermvc].

[smalltalkmvc]: https://www.lri.fr/~mbl/ENS/FONDIHM/2013/papers/Krasner-JOOP88.pdf
[fowlermvc]: http://martinfowler.com/eaaDev/uiArchs.html
[applemvc]: https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html

---

### Review: Models

Model objects encapsulate a logical unit of domain specific data in your application.  In a photo-sharing social network, they might include entities like "Users" and "Photos". Models may have relationships with other models.  For example, a "Photo" might have been "posted by" a "User". The model layer will generally contain any domain specific logic for manipulating your data and relationships.  

---
### Review: Models

_For example if a User has a field keeping track of the number of Photos she has posted, this field will have to update once she posts a new Photo._

---

### Review: Models

* Often in an iOS application, much of the core logic around manipulating models and their relationships is offloaded to a remote API (e.g. a REST API).  In these cases, the models in your iOS project will generally be some Swift representation of the resources defined by the API.

---

### Review: Models

* The model layer is responsible for knowing how to perform [CRUD][crud] operations on models. 
* This can include having Swift bindings to write API endpoints and implementing logic to serialize/deserialize models from/into the different data formats.

[Mantle](https://github.com/Mantle/Mantle) and
[RestKit](https://github.com/RestKit/RestKit) are two popular libraries
that help to define the model layer&mdash;specially the
serialization/deserialization logic when working with REST APIs.

[crud]: http://en.wikipedia.org/wiki/Create,_read,_update_and_delete

---

### Review: Models


* In the model-view-controller pattern the model is responsible for notifying related controllers that there has been a change in its state. This happens for example when the model layer has finished loading
data from a remote service and informs the view controller so that it can transition out of the loading state and notify the views to display the data.

---

### Review: Views

* Views are responsible for displaying data (literally [drawing themselves][drawrect] on the screen) and responding to user actions.  Every view in an iOS application will be a subclass of [`UIView`][uiview]

[uiview]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/index.html
[drawrect]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/index.html#//apple_ref/occ/instm/UIView/drawRect:


---

### Review: Views

UIKit comes with a selection of [predefined views][viewcatalog] that are fairly comprehensive and, used creatively, can implement many UI designs.

[viewcatalog]: https://developer.apple.com/library/content/navigation/#section=Topics&topic=User%20Experience

---

### Review: Views

- You can also create custom views by subclassing any `UIView` class. Custom views are generally composed of one or more built-in views.  If this is the case, the layout for a custom view can be defined using Interface Builder in a [storyboard] or [nib], or done programatically in the view's class.

[nib]: https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/NibFile.html
[storyboard]: https://developer.apple.com/library/ios/documentation/General/Conceptual/Devpedia-CocoaApp/Storyboard.html

---

### Review: Views


* You'll find yourself working with two kinds of views: 
1️⃣ Reusable components that are fairly generic (e.g. `UITableView`)
2️⃣ specific views that meant for presenting a specific model (e.g. a [custom cell
class](Table-View-Guide#creating-customized-cells) in a `UITableView`).

---

### Review: Views

1️⃣ Reusable components that are fairly generic (e.g. `UITableView`)

* In this case, you will want to design a good interface so that your
view can be reused in many situations. 

---

### Review: Views

2️⃣ specific views that meant for presenting a specific model (e.g. a [custom cell class](Table-View-Guide#creating-customized-cells) in a `UITableView`).

* In this case it is OK for your view to be tightly coupled to your model since its only purpose is to present a visual representation of the model.

---

### Review: Views

* A view may be responsible for managing the instantiation and layout of its subviews. 
* However as you traverse up the [view hieararchy][viewhierarchy] ultimately you'll find some parent view that was instantiated by and inserted into the view hierarchy by a view controller.
* View controllers are responsible for creating views and notifying views when they need to refresh themselves with the latest data from the model.

[viewhierarchy]: https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/CreatingViews/CreatingViews.html#//apple_ref/doc/uid/TP40009503-CH5-SW47

---

### Review: Views


* Conversely, views are responsible for responding to user actions and propagating events to view controllers so that they can handle them appropriately, for example by updating the model.

* Often views will translate a low level event into a semantic event. 
For example a table cell view responsible for displaying a Tweet might translate the low level of the event button tap on the "star button" into the semantic event of "user favorited Tweet".  The view would then pass this high level message to the view controller who might then have the model layer make an API call to complete the "favoriting".

---

### Review: Views

* The [delegate pattern] is useful for this kind of event propagation and is used widely throughout iOS frameworks.

[delegate pattern]: https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/Delegation.html

---

### Review: View Controllers

The controller sits between your model and view.  It coordinates the interaction between the model and the view by passing on _state_ changes from model to the view and propagating _events_ from the view to the model.  This relationship can be summarized as follows:

---

### Review: View Controllers

```
                                             update view
     -- state change -->                 -- with new state -->
Model                     View Controller                     View
     <-- handle event --                 <-- interpret and ---
      by updating model                     propagate event

```

---

### Review: View Controllers

* Your view controllers will always subclass from `UIViewController`.
* Each view controller usually manages one "screen" within your app.  

---

### Review: View Controllers

* For instance, an email client might have an `AccountsListViewController`. If you clicked on an account, it would push in to an `InboxViewController`, which displays a list of emails. If you tapped an email, it would display the full email within an `EmailDetailsViewController`.

---

### Review: View Controllers

There is a notion of Container View Controllers that manage the multiple view controllers and their interactions.  The most common built-in container view controller is the Navigation Controller which you saw in your first homework


----

### Container View Controllers
#### Overview

* Traditionally in iOS a view controller corresponded to one "screen" in the application.  



---
### Container View Controllers
#### Overview

* To help developers manage multiple view controllers and navigate between them Apple provided a few [container view controllers][containercatalog].

* The most prominent examples of these are the [navigation controller](Navigation-Controller#) and [tab bar controller](Tab-Bar-Controller-Guide#).

![right 50%](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-container-acting-as-root-view-controller_2-2_2x.png)


[containercatalog]: https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Introduction.html

---
## Container - Navigation Controller

![inline](https://docs-assets.developer.apple.com/published/83ef757907/navigation_interface_2x_8f059f7f-2e2f-4c86-8468-7402b7b3cfe0.png)

---
## Container - Navigation Controller
When you create a navigation interface, you need to decide how you intend to use a navigation interface. Because it imposes an overarching organization on your data, you should only use it in these specific ways:

* Install it directly as a window’s root view controller.
* Install it as the view controller of a tab in a tab bar interface.
* Install it as one of the two root view controllers in a split view interface. (iPad only)
* Present it modally from another view controller.
* Display it from a popover. (iPad only)

---

## Container - Tab Bar Controller

![inline](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/tabbar_controllerviews.jpg)


---
## Container - Tab Bar Controller 

![inline](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/vc_tabbar_objects.jpg)

---

## Container - Tab Bar Controller 

![inline](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Art/tabbar_objects_2x.png)

---

### Container View Controllers

* You can also define your own custom container view controllers.  

`https://github.com/SyracuseUniversity-CIS444/L10-SourceCode`

[Download sample code](https://github.com/SyracuseUniversity-CIS444/L10-SourceCode)

---

### Custom Container View Controllers

* Allow great flexibility in the design of your user interface.  
* It also encourages you to break up what previously might have been very large view controllers, managing multiple aspects of an application, into smaller view controllers with a coherent logical responsibility in the app.

---

### View controller life cycle and events

* Aside from encapsulating a logical portion of the application and managing the related events between the models and views, a view controller is also responsible for responding to events it receives from the system:

--- 

### View controller life cycle and events


* These include life cycle events like `viewDidLoad`, `viewWillAppear`, `viewDidDisappear`, etc. 

* They also include changes in the associated view's size (say due to a change in the orientation of
the device) such as [`viewWillTransitionToSize`](viewwilltransitiontosize).

* When implementing a custom container view controller we must be careful to forward these events to any child view controllers.

[viewwilltransitiontosize]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIContentContainer_Ref/index.html#//apple_ref/occ/intfm/UIContentContainer/viewWillTransitionToSize:withTransitionCoordinator:

---

## Example: implementing a custom drop down menu

* To demonstrate how to implement a custom container view controller, we'll implement a simple drop down menu that allows the user to switch to any view controller in the list.

![inline 80%](https://i.imgur.com/LbIigQw.gif)


---
## Example: implementing a custom drop down menu

![inline 100%](https://i.imgur.com/LbIigQw.gif)

---

### Creating a nib and custom view controller class


* We start out by creating a new subclass of `UIViewController` called `MenuViewController`.[^4]  

* Here we also create the associated [nib file](Custom-Views#nibs-and-how-they-are-loaded) by marking the `Also create XIB file` in the wizard.


[^4]: We do this by selecting `File -> New -> File... -> Source -> Cocoa Touch Class`.

---

### Creating a nib and custom view controller class

![inline 100%](https://i.imgur.com/MlrDQDm.png)

---


### Creating a nib and custom view controller class

*  Now we can open up our `MenuViewController.xib` and lay out our views. 
*  We add a navigation bar, and "Menu" bar button item.  We add a blank view (colored pink on right) as a container for the views of our child view controllers. 
*  Finally we add the table view that will display our menu.
*  Each cell in this table will be an item the user can select in the menu.

![right 75%](https://i.imgur.com/MlrDQDm.png)

---

### Creating a nib and custom view controller class


* Next we set the custom class of the [file's owner](Custom-Views#the-files-owner-object) object to `MenuViewController` and create these outlets from the file's owner using the assistant editor (tuxedo view).  
* Then create an `@IBAction` to handle the event of the menu button being tapped.

```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activeViewContainer: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    ...
    @IBAction func didTapMenuButton(sender: AnyObject) {
    }
    ...
}
```

---

### Maintaining a list of view controllers

---

```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ...
    private var viewControllerArray: [UIViewController] = []

    var viewControllers: [UIViewController]  {
        get { // getter returns read only copy
            let immutableCopy = viewControllerArray
            return immutableCopy
        }
        set {
            viewControllerArray = newValue

            // set the active view controller to the first one in the new array if the current one is not in there
            if activeViewController == nil || viewControllerArray.index(of:activeViewController!) == nil {
                activeViewController = viewControllerArray.first
            }
        }
    }
    ...
}
```
---

```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   /// We'll have to be able to maintain a list of view controllers that are available in the menu. 
   /// We'll keep a private array `viewControllerArray` and will allow consumers 
   /// to set this array via the `viewControllers` property.   
      private var viewControllerArray: [UIViewController] = []
...

```

---

```swift
	...
 	/// To keep the implementation simple we won't support dynamically modifying the 
       	///`viewControllers` array by inserting into the array. 

     var viewControllers: [UIViewController]  {

 	/// Calling the getter will return an immutable copy.
        get { // getter returns read only copy
            let immutableCopy = viewControllerArray
            return immutableCopy
        }
        ...
}
```
---

```swift
	set {
	    /// Finally we reset the `activeViewController` if `viewControllers` is set to a
	    /// new array that does not contain the current `activeViewController`.
            viewControllerArray = newValue

            // set the active view controller to the first one in the new array if the current one is not in there
            if activeViewController == nil || viewControllerArray.index(of:activeViewController!) == nil {
                activeViewController = viewControllerArray.first
            }
        }
```

--- 
```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ...
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }

    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if isViewLoaded() {
            if let inActiveVC = inactiveViewController {
                inActiveVC.willMoveToParentViewController(nil)
                inActiveVC.view.removeFromSuperview()
                inActiveVC.removeFromParentViewController()
            }
        }
    }

    private func updateActiveViewController() {
        if isViewLoaded() {
            if let activeVC = activeViewController {
                addChildViewController(activeVC)
                activeVC.view.frame = activeViewContainer.bounds
                activeViewContainer.addSubview(activeVC.view)
                navItem.title = activeVC.title
                activeVC.didMoveToParentViewController(self)
            }
        }
    }
    ...
}
```

---

### Adding and removing child view controllers


```swift
 ...
/// In order to keep track of which view controller is currently being displayed, 
/// we'll maintain an `activeViewController` variable.  

///  When this variable is set we'll remove the previous view controller's view 
/// and swap in the new active view controller's **view** 
/// and set the navigation bar title to the the new active view controller's title.
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }
```
---

### Adding and removing child view controllers

```swift
...
 private func updateActiveViewController() {
	/// In order for the view controller's life cycle events and other system events 
	/// to propagate properly we have to call `addChildViewController` before
	/// adding a child view controller's view as a subview of our view. 
        if isViewLoaded() {
            if let activeVC = activeViewController {
                addChildViewController(activeVC)
                activeVC.view.frame = activeViewContainer.bounds
                activeViewContainer.addSubview(activeVC.view)
                navItem.title = activeVC.title
                ...
            }
        }
    }
```

See more on [`addChildViewController`][addchildviewcontroller]

[addchildviewcontroller]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIViewController_Class/index.html#//apple_ref/occ/instm/UIViewController/addChildViewController:

---

```swift
...
 private func updateActiveViewController() {
	/// To notify the child view controller that we finished adding
	/// its view to the view hierarchy we have to call `didMoveToParentViewController` afterwards.
        if isViewLoaded() {
            if let activeVC = activeViewController {
		...
               activeVC.didMoveToParentViewController(self)
            }
        }
    }
```

. `didMoveToParentViewController`[^6]

[^6]: See more on [`didMoveToParentViewController`][didmovetoparent]

[didmovetoparent]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIViewController_Class/index.html#//apple_ref/occ/instm/UIViewController/didMoveToParentViewController:

---

### Adding and removing child view controllers

* Likewise when removing a child view controller's view from the hierarchy, we first have to notify it we will do this by calling [`willMoveToParentViewController`][willmovetoparent] with `nil` as the new parent view controller.

```swift 
  private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if isViewLoaded() {
            if let inActiveVC = inactiveViewController {
                inActiveVC.willMoveToParentViewController(nil)
			
		...
            }
        }
    }
```

[willmovetoparent]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIViewController_Class/index.html#//apple_ref/occ/instm/UIViewController/willMoveToParentViewController:

---

### Adding and removing child view controllers

```swift
inActiveVC.removeFromParentViewController()
```

* After we are done removing the child view we have to also remove its view controller from our set of child view controllers by calling its [`removeFromParentViewController`][removefromparent] method.

[removefromparent]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIViewController_Class/index.html#//apple_ref/occ/instm/UIViewController/removeFromParentViewController

* [^5]

[^5]: More information on child view controller management and implementing custom view controllers can be found in [guide from Apple][applecustomvcguide].

[applecustomvcguide]: https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html

---

### Showing and hiding the menu

We use the height constraint on `tableView` to show and hide our menu. We hide it initially in `viewDidLoad` and then animate it open/close
every time the menu button is tapped.

---

```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: view did load
      override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.rowHeight =  50
        // menu is hidden to start
        self.tableViewHeightConstraint.constant = 0
        updateActiveViewController()
    }

    // MARK: menu button handler
    @IBAction func didTapMenuButton(sender: AnyObject) {
        if (tableViewHeightConstraint.constant == 0) {
            showMenu()
        } else {
            hideMenu()
        }
    }

     private func hideMenu() {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.tableViewHeightConstraint.constant = 0
            self.tableView.layoutIfNeeded()
        });
        print("-- hideMenu self.tableViewHeightConstraint.constant: \(self.tableViewHeightConstraint.constant)" )
    } // hideMenu


     private func showMenu() {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            let totalHeight = self.tableView.rowHeight * CGFloat(self.tableView.numberOfRows(inSection: 0))
            self.tableViewHeightConstraint.constant = totalHeight
            self.tableView.layoutIfNeeded()
        });
        print("-- showMenu self.tableViewHeightConstraint.constant: \(self.tableViewHeightConstraint.constant)" )
    } // showMenu
    ...
}
```

---

### Displaying and handling selection of menu items

* Finally we use our table view data source and delegate methods to populate our menu table with one cell for each view controller in the `viewControllerArray`. 

* When the user selects a cell we set the corresponding view controller to be the active view controller and hide the menu.

* Notice that the observer on `activeViewController` will do the swapping in/out of the child view controllers for us.


---

```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ...
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("-- numberOfRowsInSection: \(viewControllerArray.count)")
        return viewControllerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = viewControllerArray[indexPath.row].title
        print("-- cellForRowAt indexPath.row: \(indexPath.row)")
        print("-- cellForRowAt title: \(String(describing: viewControllerArray[indexPath.row].title))")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("-- didDeselectRowAt indexPath.row: \(indexPath.row)")
        activeViewController = viewControllerArray[indexPath.row]
        hideMenu()
    } // didDeselectRowAt
}
```

---


### Using custom container view controllers
### Relationship segues don't exist for custom container view controllers

Built-in container view controllers such as the [navigation controller](Navigation-Controller#) and [tab bar controller](Tab-Bar-Controller-Guide#), require storyboard _relationship segue_ (e.g. to the navigation controller's root view controller).
**Unfortunately there is no way to create a custom relationship segue for your custom container view controllers.**

This means that is difficult to set custom container view controllers as the root view of your storyboard.  We can try something like implementing `initWithCoder` to load our nib and then setting the custom class of a view controller in the storyboard (see the [custom views guide](Custom-Views#) for more information).

---

Proposed plan to use custom container view controller as the root view of your storyboard: 

```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ...
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "MenuViewController", bundle: nil)
    }
}
```

---

Proposed plan to use custom container view controller as the root view of your storyboard:  


👎 However because there is no way to create relationship segues, the only place to initialize the other view controllers that will be in our `viewControllers` array is in `viewDidLoad`.  However, if we want to make our `MenuViewController` reusable, this clearly breaks encapsulation.  


```swift
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    ...
  required init(coder aDecoder: NSCoder) {
        print("-- init(coder aDecoder: NSCoder)")
        super.init(nibName: "MenuViewController", bundle: nil)
    } 
```

---

### Setting up in the AppDelegate

One way we can solve this problem is to manually set up the root view controller in the `AppDelegate` (the way it was done before storyboards existed). 


----

Proposed plan to set up the root view controller in the `AppDelegate`: 

```swift
@UIApplicationMain
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        vc1.title = "First"
        vc2.title = "Second"
        vc3.title = "Third"
        vc1.view.backgroundColor = UIColor.blue
        vc2.view.backgroundColor = UIColor.green
        vc3.view.backgroundColor = UIColor.yellow

        // Or instantiate customer VCs using identifiers in storyboard like this
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewControllerWithIdentifier("IdentifierThatWasSetInStoryboard") as MyViewControllerClass
        
        let menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        
        // the window object is already created for us since this is a storyboard app
        // we would have to initialize this manually in non-storyboard apps
        window?.rootViewController = menuViewController
        
        menuViewController.viewControllers = [vc1, vc2, vc3]
        
        return true
    }
```
---


Notice that we instantiated our `MenuViewController` by calling [`initWithNibName`][initwithnibname].  We can also load in other view controllers (say the items in our menu) this way.  
Since this was a demo app we just instantiated the child view controllers as instances of `UIViewController`. 

If we had needed to instantiate a view controller from the storyboard we could have done something like this

```swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let viewController = storyboard.instantiateViewControllerWithIdentifier("IdentifierThatWasSetInStoryboard") as MyViewControllerClass
```

[initwithnibname]: https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/ViewLoadingandUnloading/ViewLoadingandUnloading.html#//apple_ref/doc/uid/TP40007457-CH10
---


[Download sample code](https://github.com/SyracuseUniversity-CIS444/L10-SourceCode)
