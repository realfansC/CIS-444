## CIS-444
## Lecture 09
### Gestures & Animations 

---
# Today & Monday:
- Gesture Recognizers
-  Implement a controller
- Create a custom `UIView` subclass
- Drawing with Core Graphics and `UIBezierPath`
- `UIView`'s `contentMode` (i.e. `redraw` vs scaling the bits out `bounds` change)
- Drawing with transparency
- More `NSAttributedString` dictionary keys.. `UIFont` and `NSParagraphStyle`
- `UIFontMetric`s scaling for users who want larger fonts
- Managing subviews of your custom `UIVew`


---
# Today (cont):

- Using `isHidden`
- `CGAffineTransform`
- Constraint Priority
- `Assets.xcassets` and drawing with `UIImage`
- `@IBDesignable` and `@IBInspectable`
- Using `didSet` to ensure redraws and relayouts when properties change

---
## Gestures

## We've seen how to draw in a `UIView`, how do we get touches?

---
## Gestures

## We've seen how to draw in a `UIView`, how do we get touches?

1. We can get notified of the raw touch events (touch down, moved, up, etc)
2. We can react to certain predefined "gestures" 

---
## Gestures

## We've seen how to draw in a `UIView`, how do we get touches?

1. We can get notified of the raw touch events (touch down, moved, up, etc)
2. _This is the way to go:_
👉**We can react to certain predefined "gestures"**👈

---
## Gestures

Gesture recognizers are a powerful and easy to use tool for handling user gestures like tap or pinch and performing actions like triggering animations or view changes. 

--- 
## Gestures

There are many built-in gesture recognizers in iOS, and you can also create your own. 

---
## Available Gestures:

⭐️ UITapGestureRecognizer: Can be configured with the number of required taps to handle single, double, or more taps.

⭐️ UILongPressGestureRecognizer: Can be configured with the required delay to be considered along press. Defaults to 0.5 s.

⭐️ UIPanGestureRecognizer

(more..)

---
## Available Gestures (continued):

⭐️ UIPinchGestureRecognizer: Used for pinch in and pinch out, this gesture recognizer continuously outputs to a scale property as the user moves their finger.

⭐️ UIRotationGestureRecognizer: Continuously outputs to rotation in radians.

⭐️ UIScreenEdgePanGestureRecognizer: Can be configured with which edge to detect pans from. Only detects pan movements that begin from the specified edge.

---
## Add and Configure a Gesture Recognizer in Storyboard

Step 1️⃣: Choose a Gesture Recognizer

Choose a Gesture Recognizer from the Object Library based on the functionality your app needs.

![right 95%](https://camo.githubusercontent.com/dcf704c89ab7bfee08f856c2bb266bd9e680236e/68747470733a2f2f692e696d6775722e636f6d2f657651717a414c2e676966)

---
## Add and Configure a Gesture Recognizer in Storyboard
- Step ✌️ Drag and Drop a Gesture Recognizer into your view

![inline](https://camo.githubusercontent.com/7dd0179a7de799c9546efbf08ee71125cc05f581/68747470733a2f2f692e696d6775722e636f6d2f597638574f63502e676966)


--- 
## Add and Configure a Gesture Recognizer in Storyboard
- Step 3️⃣: Create an action for your Gesture Recognizer

![inline](https://camo.githubusercontent.com/91ea279c2b7e14ed41009e305038848235eff8e8/68747470733a2f2f692e696d6775722e636f6d2f646475323855352e676966)

---
## Add and Configure a Gesture Recognizer in Storyboard

- Step 3️⃣ (Continued) Ctrl-drag from your Gesture Recognizer to the ViewController swift file to create an action. It's often easier to drag from the Gesture Recognizer in the Document Outline.

![inline](https://camo.githubusercontent.com/91ea279c2b7e14ed41009e305038848235eff8e8/68747470733a2f2f692e696d6775722e636f6d2f646475323855352e676966)


---

## Add and Configure a Gesture Recognizer in Storyboard

- Step 3️⃣ (Continued):
1. Be sure to change the type from AnyObject to the specific Gesture Recognizer you are using. i.e. UIPanGestureRecognizer, etc..
2. Make sure the view you attached the gesture to has User Interaction Enabled
![inline](https://camo.githubusercontent.com/3f5491f3dcbb0a159ef74f204220a418b4e2471d/68747470733a2f2f692e696d6775722e636f6d2f66755a496349502e706e67)

![right 80%](https://camo.githubusercontent.com/91ea279c2b7e14ed41009e305038848235eff8e8/68747470733a2f2f692e696d6775722e636f6d2f646475323855352e676966)

---
## Programmatically Add and Configure a Gesture Recognizer

## Step 1: Implement the event handler method

When the gesture recognizer detects the gesture, it will call the event handler method on the target. Declare the method you want called by the gesture recognizer.

---
## Programmatically Add and Configure a Gesture Recognizer
## Step 1: Implement the event handler method

Gesture recognizers call the same selector as it transitions through various states. For example, a pan gesture recognizer calls the selector when the user first touches down on the view, and then it calls the selector repeatedly as the user drags their finger across the screen, and finally it calls the selector one last time when the user lifts their finger off the screen.

---

### Example: Tap gesture recognizer

```swift
func didTap(sender: UITapGestureRecognizer) {
   let location = sender.location(in: view)
   // User tapped at the point above. Do something with that if you want.
}
```

---
### Example: Pan gesture recognizer

```swift
func didPan(sender: UIPanGestureRecognizer) {
   let location = sender.location(in: view)
   let velocity = sender.velocity(in: view)
   let translation = sender.translation(in: view)
    
   if sender.state == .began {
      print("Gesture began")
   } else if sender.state == .changed {
      print("Gesture is changing")
   } else if sender.state == .ended {
      print("Gesture ended")
   }
}
```

---
## Example: Pinch gesture recognizer

```swift
func didPinch(sender: UIPinchGestureRecognizer) {
   // get the scale value from the pinch gesture recognizer
   let scale = sender.scale 
}
```

---
## Example: Screen edge pan gesture recognizer

```swift
func didScreenEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
   // Do something when the 
   // user does a screen edge pan.
}
```

---
# Step 2: Instantiate the gesture recognizer

It is common to create the gesture recognizers in the `viewDidLoad()` method, as shown below. After you create the gesture recognizer, attach it to the view you want to detect gestures on.

---
## Example: Tap gesture recognizer

```swift
   // The didTap: method will be defined in Step 3 below.
   let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))

   // Optionally set the number of required taps,
   // e.g., 2 for a double click
   tapGestureRecognizer.numberOfTapsRequired = 2

   // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
   yourView.isUserInteractionEnabled = true
   yourView.addGestureRecognizer(tapGestureRecognizer)
```

---
## Example: Pan gesture recognizer

```swift
   // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
   let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))

   // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
   yourView.isUserInteractionEnabled = true
   yourView.addGestureRecognizer(panGestureRecognizer)
```

---
## Example: Screen edge pan gesture recognizer

```swift
// Instantiate and initialize the screen edge pan gesture recognizer
let screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didScreenEdgePan(sender:)))

// Configure the screen edges you want to detect.
screenEdgePanGestureRecognizer.edges = UIRectEdge.left

// Attach the screen edge pan gesture recognizer to some view.
yourView.isUserInteractionEnabled = true
yourView.addGestureRecognizer(screenEdgePanGestureRecognizer)
```

---
### Common properties to access from each gesture recognizer
#### Tap Gesture Recognizer

```swift
let location = sender.location(in: view)
``` 

---
### Common properties to access from each gesture recognizer
#### Pan Gesture Recognizer

```swift
let location = sender.location(in: view)
let translation = sender.translation(in: view)
let velocity = sender.velocity(in: view)
```

---
### Common properties to access from each gesture recognizer
#### Pinch Gesture Recognizer

```swift
var scale = sender.scale
var velocity = sender.velocity
```

---
### Common properties to access from each gesture recognizer
#### Rotation Gesture Recognizer
   
```swift
var rotation = sender.rotation 
var velocity = sender.velocity
```

---
# Gestures 

# Gestures are recognized by instances of `UIGestureRecognizer`

- The base class is "abstract" We only actually use concrete subclasses to recognize

---
# Gestures

# There are 2️⃣ sides to using a gesture recognizer:

1️⃣  Adding a gesture recognizer to a `UIView` (asking the `UIView` to "recognize" that gesture)

2️⃣ Providing a method to "handle" that gesture (not necessarily handled by the `UIView`)

---
# Gestures

1️⃣  Adding a gesture recognizer to a `UIView` (asking the `UIView` to "recognize" that gesture)


- Usually this is done by a Controller
- Though occasionally, a `UIView` will do this itself if the gesture is integral to its existence

---
# Gestures 

2️⃣ Providing a method to "handle" that gesture (not necessarily handled by the `UIView`)

- This is provided by the `UIView` or a `Controller`
- Depending on the situation. 


---
# Gestures

- Adding a gesture recognizer to a `UIView`

Imagine we wanted a `UIView` in our Controller's view to recognize a pan gesture.

We can configure it to do so in the property observer for the outlet to that `UIView`

---
# Pan Gesture Example
We can configure it to do so in the property observer for the outlet to that `UIView`


```swift
@IBoutlet weak var pannableView: UIView {
    didSet { 
	let panGestureRecognizer = UIPanGestureRecognizer(target: self, 
				action: #selector(ViewController.pan(recognizer:))
	)
	pannableView.addGestureRecognizer(panGestureRecognizer)
     }
}
```

---


```swift
@IBoutlet weak var pannableView: UIView {
    didSet { 
// 📌 The property observer's `didSet` code gets called
//  when iOS hooks up this outlet at runtime
	let panGestureRecognizer = UIPanGestureRecognizer(target: self, 
				action: #selector(ViewController.pan(recognizer:))
	)
	pannableView.addGestureRecognizer(panGestureRecognizer)
     }
}
```

---

```swift
@IBoutlet weak var pannableView: UIView {
// 📌 The property observer's `didSet` code gets called
//  when iOS hooks up this outlet at runtime

    didSet { 
// 📌 here we are creating an instance of a concrete 
// subclass of `UIGestureRecognizer` (for pans)

	let panGestureRecognizer = UIPanGestureRecognizer(target: self, 
				action: #selector(ViewController.pan(recognizer:))
	)
	pannableView.addGestureRecognizer(panGestureRecognizer)
     }
}
```
---


```swift
@IBoutlet weak var pannableView: UIView {
// 📌 The property observer's `didSet` code gets called
//  when iOS hooks up this outlet at runtime

    didSet { 
// 📌 here we are creating an instance of a concrete 
// subclass of `UIGestureRecognizer` (for pans)

// 📌 The `target` gets notified when the gesture is recognized
// (Here it's the controller itself)
	let panGestureRecognizer = UIPanGestureRecognizer(target: self, 
				action: #selector(ViewController.pan(recognizer:))
	)
	pannableView.addGestureRecognizer(panGestureRecognizer)
     }
}
```

---

```swift
@IBoutlet weak var pannableView: UIView {
// 📌 The property observer's `didSet` code gets called
//  when iOS hooks up this outlet at runtime

    didSet { 
// 📌 here we are creating an instance of a concrete 
// subclass of `UIGestureRecognizer` (for pans)

// 📌 The `target` gets notified when the gesture is recognized
// (Here it's the controller itself)
// 📌 The `action` is the method invoked on recognition (that method's argument? The recognizer)
	let panGestureRecognizer = UIPanGestureRecognizer(target: self, 
				action: #selector(ViewController.pan(recognizer:))
	)
	pannableView.addGestureRecognizer(panGestureRecognizer)
     }
}
```

--- 

```swift
@IBoutlet weak var pannableView: UIView {
// 📌 The property observer's `didSet` code gets called
//  when iOS hooks up this outlet at runtime

    didSet { 
// 📌 here we are creating an instance of a concrete 
// subclass of `UIGestureRecognizer` (for pans)

// 📌 The `target` gets notified when the gesture is recognized
// (Here it's the controller itself)
// 📌 The `action` is the method invoked on recognition (that method's argument? The recognizer)
	let panGestureRecognizer = UIPanGestureRecognizer(target: self, 
				action: #selector(ViewController.pan(recognizer:))
	)
// 📌 Here we ask the `UIView` to actually start trying to recognize
//  this gesture in its bounds

	pannableView.addGestureRecognizer(panGestureRecognizer)
     }
}
```
---
# Gesture Handling

- A handler for a gesture needs gesture-specific information


---
# Gesture Handling

- A handler for a gesture needs gesture-specific information
👉 So each concrete subclasses provides special methods for handling that type of gesture

---
# Gesture Handling

For example, `UIPanGestureRecognizer` provides 3️⃣ methods:

---
# Gesture Handling - `UIPanGestureRecognizer`


// Cumulative since start of recognition
1️⃣ `func translation(in: UIView?) -> CGPoint`


---
# Gesture Handling - `UIPanGestureRecognizer`

//  How fast the finger is moving (points/s)
2️⃣ `func velocity(in: UIView?) -> CGPoint`

---
# Gesture Handling - `UIPanGestureRecognizer`

// `setTranslation` allows you to **reset** the translation so far 
// By resetting the translation to zero all the time, you 
// end up getting "incremental" translation
3️⃣ `func setTranslation(CGPoint, in: UIView?)

---
# `UIGestureRecognizerState`


```swift
var state: UIGestureRecognizerState { get }
```

👉An abstract superclass also provides state information

👉 This sits around in `.possible` until recognition starts
👉 For a continuous gesture (e.g. pan), it moves from `.began` thru repeated
`.changed` to `.ended`
👉 For a discrete (e.g swipe) gesture, it goes straight to `.ended` or `.recognized`
👉 It can go to `.failed` or `.cancelled` too!!

---
What a pan handler might look like:

```swift

@IBoutlet weak var pannableView: UIView {
    didSet { 
	let panGestureRecognizer = UIPanGestureRecognizer(target: self, 
				action: #selector(ViewController.pan(recognizer:))
	)
	pannableView.addGestureRecognizer(panGestureRecognizer)
     }
}

👉 func pan (recognizer: UIPanGestureRecognizer) {
   switch recognizer.state {
	case .changed: fallthrough
	case .ended
		let translation. = recognizer.translation(in: pannableView)
		// update anything that depends on the pan gesture using translation.x
		// and .y
	recognizer.setTranslation(CGPoint.zero, in: pannableView)
	default: break
	}
}
```
---

```swift
func pan (recognizer: UIPanGestureRecognizer) {
// 👉 We are only going to do anything when the finger moves or lifts up 
// off the device's surface
   switch recognizer.state {
	case .changed: fallthrough
	case .ended
		let translation. = recognizer.translation(in: pannableView)
		// update anything that depends on the pan gesture using translation.x
		// and .y
	recognizer.setTranslation(CGPoint.zero, in: pannableView)
	default: break
	}
}
```


---

```swift
func pan (recognizer: UIPanGestureRecognizer) {
// 👉 We are only going to do anything when the finger moves or lifts up 
// off the device's surface
   switch recognizer.state {
// 👉 `fallthrough` is "execute the code for the next case down" (case .changed, .ended, OK too)
	case .changed: fallthrough
	case .ended
		let translation. = recognizer.translation(in: pannableView)
	// update anything that depends on the pan gesture using translation.x & .y
	recognizer.setTranslation(CGPoint.zero, in: pannableView)
	default: break
	}
}
```

---

## Specifically...
```swift
let translation. = recognizer.translation(in: pannableView)
```

👉 This is how we get the location of the pan in the `pannableView`'s coordinate system

---
## Specifically...
```swift
let translation. = recognizer.translation(in: pannableView)
```

👉 This is how we get the location of the pan in the `pannableView`'s coordinate system
👉 Now we do whatever we want with that information 


---
## Specifically...

```swift
let translation. = recognizer.translation(in: pannableView)
```

👉 This is how we get the location of the pan in the `pannableView`'s coordinate system
👉 Now we do whatever we want with that information 
👉 By resetting the `translation`, the next one we get will be **incremental** movement


---
## Other Gestures - `UIPinchGestureRecognizer `

```swift
var scale: CGFloat // Not read-only (can reset
var velocity: CGFloat { get } // scale factor per second
```

---
## Other Gestures - `UIRotationGestureRecognizer`

```swift
var rotation: CGFloat // **Note** read-only (can reset); in radians
var velocity: CGFloat { get } // radians per second
```
---
## Other Gestures - `UISwipeGestureRecognizer `

```swift
// set the direction and number of fingers you want
var direction: UISwipeGestureRecognizerDirection // swipe directions you want
var numberOfTouchesRequired: Int` // Finger count
```

---
## Other Gestures - `UITapGestureRecognizer `

- This is discrete but you should check for `.ended` to actually do something
- Set the # of taps and fingers you want...

```swift
var numberOfTapsRequired: Int // single tap, double tap, etc
var numberOfTouchesRequired: Int // Finger count
```

---
## Other Gestures - `UILongPressRecognizer `

This is continuous (not discrete) gesture (i.e. you'll get `.changed` if the finger moves)
You can still configure it up-front..

```swift
var minumumPressDuration: TimeInterval` // How long to hold before its recognized
var numberOfTouchesRequired: Int` // finger count
var allowableMovement: CGFloat // How far finger can move and still recognize 
```

***important to pay attention to `.cancelled` because of drag and drop***


---

## Other Gesture Recognizer Tasks

---
## Other Gesture Recognizer Tasks
### Common tasks that you might have with gesture recognizers.

---
### Using Simultaneous Gesture Recognizers

By default, it won't work if you add multiple gesture recognizers to the same view. In order to do that, you have to specifically enable it.

---
### Using Simultaneous Gesture Recognizers
#### Step 1: Set the Gesture Recognizer delegate

For example, if you want to use a pinch and rotate gesture recognizer simultaneously, choose either the pinch or the rotate gesture recognizer (it doesn't matter which one). If you created the gesture recognizer in Interface Builder, create an IBOutlet for it by Ctrl-dragging from the nib.

```swift
pinchGestureRecognizer.delegate = self

```

---
### Step 2: Implement the Gesture Recognizer protocol

Go to the header file of the view controller and add UIGestureRecognizerDelegate to the list of protocols, as shown below.

```swift
class MainViewController : UIViewController, UIGestureRecognizerDelegate
...
@end

```

---
### Implement the following UIGestureRecognizerDelegate method in your Swift file.

```swift
func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
 shouldRecognizeSimultaneouslyWithGestureRecognizer 
otherGestureRecognizer: UIGestureRecognizer) -> Bool {
return true
}
```
---

###Now the pinch and scale gesture recognizers should work simultaneously.

---
# Use Case: Slide Out Tray
![inline](https://camo.githubusercontent.com/9522459d5a4a7e0434b6a735b94e485dc4d37c65/68747470733a2f2f692e696d6775722e636f6d2f503476366948612e676966)

---
![right 90%](https://camo.githubusercontent.com/9522459d5a4a7e0434b6a735b94e485dc4d37c65/68747470733a2f2f692e696d6775722e636f6d2f503476366948612e676966)

Slide out trays, Hamburger menus, and any other view you want to move by sliding your finger can be configured using a UIPanGesture Recognizer.

The following steps describe the process of creating a **vertically** sliding Tray. If you would like to make a Hamburger style **horizontally** sliding View, use the same concepts described below, but use the x-components of the translation in place the y-components. If you want a view that can be panned in all directions, use both x and y-components of the translation.

---
### Step 1: Add a UIView to Serve as Your Tray
- You can [add a View in Storyboard](https://guides.codepath.com/ios/Creating-Nested-Views#step-1-add-the-parent-view) or [add a view programmatically](https://guides.codepath.com/ios/Programmatically-Creating-Views)
- If you added a view in Storyboard, create an outlet for your view. We will name the outlet `trayView`.
 
---
### Step 2: Add and Configure your Pan Gesture Recognizer.
- Attach a UIPanGestureRecognizer to your Tray view and create an Action/Method. We will call our method, `didPanTray`. You can [add a Gesture Recognizer in Storyboard](https://guides.codepath.com/ios/Using-Gesture-Recognizers#add-and-configure-a-gesture-recognizer-in-storyboard) or [add a Gesture Recognizer programmatically](https://guides.codepath.com/ios/Using-Gesture-Recognizers#programmatically-add-and-configure-a-gesture-recognizer)

---
### Step 3: Define a Variable to Hold the Initial Position of the View
Define an **Instance Variable** that can be accessed throughout the View Controller. We define these variables at the top of the ViewController Swift file, right above the `viewDidLoad` method.

```swift
var trayOriginalCenter: CGPoint!
```

---
### Step 4: Make the Tray Draggable
![inline](https://i.imgur.com/sI6gV8c.gif)

---
### Step 4: Make the Tray Draggable
![right 90%](https://i.imgur.com/sI6gV8c.gif)

- The code to make the Tray draggable will go inside our `didPanTray` method.
- NOTE: If you created your Gesture Recognizer and added an Action in Storyboard, the method will be proceeded by `@IBAction`.

```swift
@IBAction func didPanTray(sender: UIPanGestureRecognizer) {
    
}
```
---
### Step 4: Make the Tray Draggable

- Within the `didPanTray` method, we want to access the **translation** property of the UIPanGestureRecognizer and store it in a variable. This will tell us how far our finger has moved from the original "touch-down" point as we drag. We will also print the translation value to the console to get a feel for what it means. You should see that the translation is a **CGPoint** with values for the x and y components. 

```swift
let translation = sender.translation(in: view)
print("translation \(translation)")
```

---
### Step 4: Make the Tray Draggable

- Create a conditional statement to check for the current gesture state during the pan: .began, .changed or .ended
   - `.began` is called once at the very beginning of each gesture recognition.
   - `.changed` is called continuously as the user is in the process of "gesturing".
   - `.ended` is called once at the end of the gesture.
   - HINT: You will use this conditional statement to check gesture states SO often, that is extremely helpful to [create a Code Snippet](https://guides.codepath.com/ios/Using-Custom-Code-Snippets) for quick access in the future!  

```
if sender.state == .began {
            
} else if sender.state == .changed {
            
} else if sender.state == .ended {
            
}
```

---
### Step 4: Make the Tray Draggable

- When the gesture begins (`.began`), store the tray's center into the trayOriginalCenter variable: 
```swift
trayOriginalCenter = trayView.center
```

---
### Step 4: Make the Tray Draggable

- As the user pans (`.changed`), change the `trayView.center` by the translation. Note: we ignore the x translation because we only want the tray to move up and down: 

```swift
trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
```

---
### 5: Animate Tray to Open or Closed Positions
![inline](https://i.imgur.com/P4v6iHa.gif)

---
### 5: Animate Tray to Open or Closed Positions

When a user stops panning the Tray, we want the tray to animate to an up or down position. We will infer that if the users last gesture movement was downward, they intend to close the tray to it's down position. Conversely, if they are NOT panning down, they must be panning up, and intend to open the tray to it's up position.  

![right 95%](https://i.imgur.com/P4v6iHa.gif)  

---
### 5: Animate Tray to Open or Closed Positions

We can tell which way a user is panning by looking at the gesture property, **velocity**. Like translation, velocity has a value for both x and y components. If the **y component** of the velocity is a **positive** value, the user is **panning down**. If the **y component** is **negative**, the user is **panning** up.

![right 95%](https://i.imgur.com/P4v6iHa.gif)  

---
### 5: Animate Tray to Open or Closed Positions

Since we are focusing on the user's **last** gesture movement, we will check for the velocity in the `.ended` condition of our gesture state conditional statement.
![right 95%](https://i.imgur.com/P4v6iHa.gif)  

---
### 5: Animate Tray to Open or Closed Positions

- Get the velocity: `let velocity = sender.velocity(in: view)`. [Pan Gesture Recognizer](https://guides.codepath.com/ios/Using-Gesture-Recognizers#example-2-pan-gesture-recognizer-1)
- Define Instance variables to store the tray's position when it's "up" and "down" as well as the offset amount that the tray will move down when it is in it's down position.
     
```swift
var trayDownOffset: CGFloat!
var trayUp: CGPoint!
var trayDown: CGPoint!
```
---
### 5: Animate Tray to Open or Closed Positions

     
- Within the `viewDidLoad` method, assign values to the `trayDownOffset`, `trayUp` and `trayDown` variables . The `trayDownOffset` will dictate how much the tray moves down. 160 worked for my tray, but you will have to adjust this value to accommodate the specific size of your tray. 

```swift
trayDownOffset = 160
trayUp = trayView.center
trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
```

---
### 5: Animate Tray to Open or Closed Positions

- Back in your `didPanTray(_:)` method, within the gesture state, `.ended`, create a conditional statement to check the y component of the velocity. In the case that the tray is moving down, animate the tray position to the `trayDown` point, otherwise, animate it towards the `trayUp` point. (We will talk about animating views Monday!)

```swift
if velocity.y > 0 {
   UIView.animate(withDuration: 0.3) { 
      trayView.center = trayDown
   }   
} else {
   UIView.animate(withDuration: 0.3) {
      trayView.center = trayUp                 
   }
}
```  
---
### 5: Animate Tray to Open or Closed Positions

You can also try animating the ending tray motion with a bounce using the damping ratio and initial spring velocity. (We will discuss spring animations Monday!)

---
## Use Case: Scaling and Rotating a View

 ![inline](https://i.imgur.com/NH2U4m1.gif)

---
- This Use-Case will explore using multiple gesture recognizers 
simultaneously to scale and rotate an ImageView. 

![right 90%](https://i.imgur.com/NH2U4m1.gif)
 

---
### Step 1: Add an ImageView

- You can [add an ImageView from The Media Library](https://guides.codepath.com/ios/Creating-Nested-Views#step-1-add-the-parent-view) to the Storyboard or [add a view programmatically](https://guides.codepath.com/ios/Programmatically-Creating-Views)
- Make sure that the Image View has **user interaction enabled**.

---
### Step 2: Add and Configure the Gesture Recognizers

- Attach a **UIPinchGestureRecognizer** and a **UIRotationGestureRecognizer** to your Image View and create an Action/Method for each one. We will call our methods, `didPinch` and `didRotate`. You can add a Gesture Recognizer in Storyboard or add a Gesture Recognizer programmatically

---
### Step 3: Allow for Simultaneous Gesture Recognizers

Since we will be using multiple gesture recognizers at the same time, we will need to configure our ViewController to support Simultaneous Gesture Recognizers

---
### Step 4: Make the Image View Scalable 

![inline](https://i.imgur.com/AkacSCN.gif)

---
### Step 4: Make the Image View Scalable 
![right 90%](https://i.imgur.com/AkacSCN.gif)

Within the `didPinch` method... 
- Access the **scale** parameter of the Pinch Gesture Recognizer and store it in a constant.

---
### Step 4: Make the Image View Scalable 

- Access the view that was pinched and store it in a constant.
   - `sender.view` returns a generic UIView so we need to specify that we are working with a UIImageView using `as! UIImageView`.
- Store the previous transform state of the imageView in a constant.

---
### Step 4: Make the Image View Scalable 

- Modify the scale component of the imageView's transform property.
   - NOTE: We use `'CGAffineTransform.scaledBy(x:y:)` instead of `CGAffineTransformMakeScale`. This is because `'CGAffineTransform.scaledBy(x:y:)` allows us to add to the previous transform state as an argument, `previousTransfrom` whereas `CGAffineTransformMakeScale` will overwrite it completely. 


---
### Step 4: Make the Image View Scalable 

- Set the scale of the UIPinchGestureRecognizer back to 1.
   - Resetting the scale is necessary because we are adding the scale to the `previousTransform` each time the method is called. If we didn't reset the scale, each time around the scale that was added to the `previousTransform` would be doubled and our Image View would scale out of control!

---
### Step 4: Make the Image View Scalable 

```swift
@IBAction func didPinch(sender: UIPinchGestureRecognizer) {
let scale = sender.scale
let imageView = sender.view as! UIImageView
imageView.transform = CGAffineTransformScale(imageView.transform, scale, scale)
sender.scale = 1
}
```

---
### Step 5: Make the Image View Rotatable 
 
![inline](https://i.imgur.com/aqzTp2A.gif)

---
### Step 5: Make the Image View Rotatable 


Within the `didRotate` method... 
- Access the **rotation** parameter of the Rotation Gesture Recognizer and store it in a constant.
- Access the view that was rotated and store it in a constant.
   - `sender.view` returns a generic UIView so we need to specify that we are working with a UIImageView using `as! UIImageView`.

---
### Step 5: Make the Image View Rotatable 
- Store the current transform state of the imageView
- Modify the rotation component of the imageView's transform property.
- Set the rotation of the UIRotationGestureRecognizer back to 0.  


---
# Animations

---
# Animations

## Introduction

iOS was built from the ground up to support animation. It is absolutely required to maintain the illusion of a touch-based interface.

It's best to start out using Springs-and-Struts layout. Later in the guide we'll cover Auto-Layout, with requires a little more abstract thinking.

---
## Simple Animation with UIKit

Most of the time, you will perform animation by working directly with UIKit. Say you have a view, `myView`, and you want to animate its movement from its current position to a new position, the `myNewFrame` rect. You simply call:

```swift
UIView.animate(withDuration: 0.35, animations: {
    self.myView.frame = myNewFrame
})
```
---
# Animations

Behind the scenes, it is making calls to a lower layer in the stack, **Core Animation.** You work with Core Animation directly when you need to create complex animation, or do something performance intensive.

---
# Animation

There are more complex animation methods available to avoid going lower. If you need to call code with the animation completes:

---
# Animations

```swift
UIView.animate(withDuration: 0.35, animations: {
    self.myView.frame = myNewFrame
}, completion: { finished in
    print("Animation completed.")
})
```

---
# Animations

If you want to pass even more options, such as the animation curve:

```swift
UIView.animate(withDuration: 0.35, delay: 0.5, options: .curveEaseInOut, animations: {
    self.myView.frame = myNewFrame
}, completion: { finished in
    print("Animation completed.")
})
```

---
# Animations

This style of animation, where you just specify new attributes and let Core Animation figure it out for you is **implicit** animation. To create complex animation, you need to delve directly into layers.

---
# Animations

## Understanding Layers

Core Animation is a misnomer for the framework. Its original name was *LayerKit.* It is a framework for displaying a hierarchy of layers on screen.

---
# Animations
## Understanding Layers

A layer is a container for a bitmap image. Layers are rendered on screen via the GPU, which makes it super fast to render most animation.

---
# Animations

UIKit's view hierarchies are backed by a near-identical layer hierarchy. In fact, every UIView has a `.layer` property for accessing its corresponding layer. Behind the scenes, UIView populates layer's contents for you. So while a UILabel displays text, it is ultimately flattened to a bitmap and handed over to its associated layer.

---
# Animations

Views are are so tightly associated to layers that many attributes are shared; for instance, if you change the layer's `opacity` value, then the view's `alpha` will also change.

---
# Animations

The big difference between a view and a layer is a view can receive events. If you don't need the overhead, you can managed your layer's sublayers yourself. This might improve performance if you're dealing with hundreds of layers on screen at once, such as if you're building a particle system. Most of the time, this is overkill.

---
# Animations

### Implicit Animation in Layers

When layers exist by themselves, not attached to a view, most property changes are animated by default. However, layers attached to views have this default animation turned off. When you call `UIView`'s `animatedWithDuration`, implicit animation is turned on again.

---
# Animations

### Transactions

All animation changes are bundled together in a transaction. This is usually invisible, as there's usually one created for you with every pass through the run loop. This lets you make a bunch of changes that are batched together at once in the end.

---
# Animations

Imagine you make two changes to your layer:

```swift
myLayer.opacity = 0.0
myLayer.opacity = 1.0
```

---
# Animations

The first change has no effect. There is no momentary "blip" of 0.0 opacity. Instead, after all your code is run, Core Animation looks at all the final values to create the animation.


---
# Animations

## Explicit Animation

An explicit animation allows you to construct more complex animations, such as animating a view animate along a bezier path.


---
# Animations

To construct a basic animation:

```swift
myView.layer.position = endPosition
let animation = CABasicAnimation(keyPath: "position")
animation.fromValue = NSValue(cgPoint: startPosition)
animation.toValue = NSValue(cgPoint: endPosition)
animation.duration = 1.0
myView.layer.add(animation, forKey: "MyAnimationKey")
```

---
# Animations

The `position` key is the name of the property you want animated. The key in the `addAnimation` method is a made-up key you will use to identify the animation in flight.

--- 
# Animations

One caveat from the above example is that we made sure to update the underlying `layer.position` value in addition to applying the animation. Otherwise, the animation would have completed and then the layer would have immediately jumped back to initial position. 
