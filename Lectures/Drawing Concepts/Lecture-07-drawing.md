#CIS-444 
#Lecture-07

----
#Quick Review:

- Thrown errors 

---
#Review: Thrown Errors:

- In Swift, methods can throw errors


---
#Review: Thrown Errors:

- In Swift, methods can throw errors

- You always know that a method can `throw` because they'll have the keyword `throws` on the end

```swift
func save() throws
```

```swift 
fun getJSONData() throws -> Dictionary
```

---
#Review: Thrown Errors:

- You must put calls to functions like this in a do { } block and use the word `try` to call them

```swift 
do { 
   try content.save()
} catch let error {
	throw error
}
```

---
#Review: Thrown Errors:

- You must put calls to functions like this in a do { } block and use the word `try` to call them

```swift 
do { 
   try content.save()
} catch let error {
	// error will be something that implements the `Error` protocol, e.g, `NSError`
	// Usually these are enums that have associated values to get error details
	throw error // this would re-throw the error (only OK if the method we are in throws)
}
```

---
#Review: Thrown Errors:

- If you are certain a call will not `throw`, you can force `try` with `try!`

```swift 
try! context.save()
```

---
#Review: Thrown Errors:

- If you are certain a call will not `throw`, you can force `try` with `try!`

```swift 
try! context.save() // will crash your program if `save()` actually throws an `error`
```

---
#Review: Thrown Errors:

- Alternative Solution:
Use a conditional try, turning the return into an Optional (which will be `nil` if fail)

```swift
let x = try? errorProneFunctionThatReturnsAnInt()` // x will be Int?
```

---
#New: `Any` and `AnyObject`

- `Any` and `AnyObject` are special types

---
#`Any` and `AnyObject`

- `Any` and `AnyObject` are special types

- Commonly __used__ to be commonly used for compatibility with old Objective-C APIs
- But not so much anymore in iOS 13 since these old Objective-C APIs have been updated 

---
#`Any` and `AnyObject`

- Variables of type `Any` can hold something of any type (`AnyObject` holds `classes` only)
- Swift is strongly typed language, though, so you can't invoke a method on an `Any`
- You have to convert it into a concrete type **first**

---
#`Any` and `AnyObject`

- One of the beauties of Swift is its strong typing, so generally you want to avoid `Any` (sometimes that's impossible. So use it sparingly)

---
#`Any` and `AnyObject`

- Where will you see it in iOS?


---
#`Any` and `AnyObject`
### Situation #1: NSAttributedString

```swift
let attributes: [NSAttributedStringKey:Any] = _
```

---
#`Any` and `AnyObject`
### Situation #1: NSAttributedString


```swift
let attributes: [NSAttributedStringKey:Any] = _
```

The attributes of `NSAttributedString` can be different things (`UIColor`, `UIFont`) so the type `Any` was used as the type of the values in the attributes `Dictionary`

---
#`Any` and `AnyObject`
### Situation #2: Function argument

- Sometimes (rarely-ish) `Any` will be the type of a functional argument

---
#`Any` and `AnyObject`
### Situation #2: Function argument

Here's a `UIViewController` method that includes a sender (which can be of any type)

```swift
func prepare(for segue: UIStoryboardSegue, sender: Any?)
```

---
#`Any` and `AnyObject`
### Situation #2: Function argument

```swift
func prepare(for segue: UIStoryboardSegue, sender: Any?)
```

- The `sender` is a thing that caused the `segue` (i.e. a move to another MVC) to occur

- The `sender` might be a `UIButton` or a `UITableViewCell` or some custom thing in your code

- It's an `Optional` because it's OK for a segue to happen without a `sender` being specified (I actually did not know/never made this connection before)

---
#`Any` and `AnyObject`

```swift
func prepare(for segue: UIStoryboardSegue, sender: Any?)
```
- `prepare` is an old API
- In Swift we would probably use an `enum` with associated data or a protocol


---
#`Any` and `AnyObject`
### How do we use a variable of type `Any`?

---
#`Any` and `AnyObject`
### How do we use a variable of type `Any`? **We don't.**

---
#`Any` and `AnyObject`

- You can't use `Any` directly (since we don't know what type it really is.)
Instead, we must convert it to another, __known__ type
- The conversion is done with the **`as?`** keyword in Swift

----
#`Any` and `AnyObject`

- This conversions might **NOT** be possible,  as the conversion generates an `Optional`
- You an also _check_ to see if something can be converted with the **is** keyword (true/false)

We almost always use `as?` it with `if let ...`

```swift
let unknown: Any = ...  // we can't send unknown a message because it's "typeless"
if let foo = unknown as? MyType {
// foo is of type MyType in here
// so we can invoke MyType methods or access MyType vars in foo
// if unknown was not of type: `MyType`, then we'll never get here
}
```

----
#Casting
- BTW, casting with `as?` is not just for `Any` & `AnyObject`
You can cast any type with `as?` into any other type that makes sense
Mostly this would be casting an object from one of its superclasses down to a subclass
But it would also be used to cast any type to a `protocol` it implements (more later on this)



---
#Casting 

Example of down casting from a superclass down to a subclass

```swift
let vc: UIViewController = CapThatViewController()
```

---
#Casting 

```swift
let vc: UIViewController = CapThatViewController()
```

The type of `vc` is `UIViewController` (b/c we explicitly typed it to be.)
And the assignment is legal because a `CapThatViewController` __is a__ UIViewController.

---
#Casting

However...

```swift
let vc: UIViewController = CapThatViewController()
vc.populateCaptions() // This would not compile 🚫
```

**Why?** vc is typed as a `UIViewController`

---
#Casting 

However (again), if we cast `vc` to be a `CapThatViewController`... 

```swift
if let ctvc = vc as CapThatViewController {
   ctvc.populateCaptions() // This would work  👍
}
```

**Why?** ctvc is typed as a `CapThatViewController` so it has access to all `CapThatViewController` exposed methods and properties

---
#Other Interesting Classes

- `NSObject`: 
	Base class for all Objective-C classes
	Some advanced features will require you to subclass from `NSObject` (and it can't hurt to do so.)


---
#Other Interesting Classes

- NSNumber:
	Generic number-holding class (i.e., reference type)
	
	```swift
	let n = NSNumer(35.5)
	// or let n: NSNumber = 35.5
	let intified: Int = n.intValue // also doubleValue, boolValue, etc.
	```

---
#Other Interesting Classes

- Date:
	Value type used to find out the date and time right now or to store past or future 	dates.
	If you are displaying a date in your UI, there are localization ramifications, so 	check these out!

---
#Other Interesting Classes

- Data:
	A value type Bag-O-Bits. Used to save/restore/transmit raw data throughout the iOS 	SDK

---
#Views

---
#Views

- View: A view (i.e. `UIView` subclass) represents a rectangular area
	(a) Defines a coordinate space
	(b) For drawing
	(c) Handling touch events
 
---
#Views

- Hierarchical:
	(a) A view has only 1️⃣ superview ... `var superview: UIView?`
	(b) ✋ BUT it can have many (or zero) subviews ... `var subviews: [UIView]`
	(c) The order in the subviews array matter: those later in the array are on top of those earlier 
	(d) A view can clip its subviews to its own bounds or not (the default is _not_ to)

---
#Views

- UIWindow
	(a) The `UIView` at the very, very top of the view hierarchy (even includes status 	bar)
	(b) Usually only one `UIWindow` in an entire iOS application .. it's about views 	__NOT__ windows

---
#Views

- The hierarchy is most often constructed in Xcode graphically (**Storyboard!**)
	(a) Even custom views are usually added to the hierarchy using Xcode

- But it can be done in code as well:
	
```swift
func addSubview(_view: UIView) // sent to the view's (soon-to-be) superview
Func removeFromSuperView() // send to the view you want to remove (not its superview)
```

- Where does the hierarchy start?
	(a) The top of the (useable) view hierarchy is the Controller's `var view: UIView`
	(b) 🚨 This simple property is a very important thing to understand!! 🚨
	(c) The view is the one whose bounds will change programmatically add subviews (if you ever do that)
	(d) All your MVC's `UIView`s will have this `view` as an ancestor.
	(e) It's automatically hooked up for you when you create a MVC in Xcode.

---
#Initializing a UIView

- As always, try to avoid an `init`ializer if possible 
	(a) But having one in `UIView` is slightly more common than having a `UIViewController` 	initializer 

---
#Initializing a UIView

- A `UIView`'s initializer is different if it comes out of a storyboard

```swift
	init(frame: CGRect) // initializer if the UIView is created in code
	init(code: NSCoder) // initializer if the UIView comes out of a storyboard
```

---
#Initializing a UIView

- If you need an initializer, implement them **both**...

```swift
	func setup() { ... }

	override init(frame: CGRect) { // a designated initializer
		super.init(frame: frame)
		setup()			// might have to be before super.init
	}

	func init?(coder aDecoder: NSCoder) { // a required, failable initializer
		super.init(coder: aDecoder)
		setup()
	}
```

---
#Initializing a UIView
### `override func awakeFromNib()`

- Another alternative to initializers in `UIView`...
	👉 This is called if the `UIView` come out of a storyboard
	👉 This is not an initializer (it's called immediately after initialization is complete)
	👉 All objects that inherit from `NSObject` in a storyboard are sent this
	👉 Order is not guaranteed so you **cannot** message any other objects in the storyboard here


---
#Coordinate System Data Structures
- `CGFloat`
- `CGPoint`
- `CGSize`

---
#Coordinate System Data Structures

- `CGFloat`
	👉 Always use this instead of Double or Float for anything to do with a `UIView`'s 	coordinate system 
	👉 You can convert to/from a Double or Float using initializers 

```swift
let cgm = CGFloat(aDouble)
```

---
#Coordinate System Data Structures

- `CGPoint`
	👉 Simply a struct with 2️⃣ `CGFloat`s in it: x and y

```swift
var point = CGPoint(x: 37.0, y: 55.2)
point.y -= 30
point.x += 20.0
```

---
#Coordinate System Data Structures

- `CGSize`
	👉 Also a `struct` with 2️⃣ `CGFloat`s in it: `width` and `height`

```swift
var size = CGSize(width: 100.0, height: 50.0)
size.width += 42.5
size.height += 75.
```

---
#Coordinate System Data Structures

- `CGRect`
	👉 A `struct` with a CGPoint and a `CGSize` in it...

```swift
struct CGRect {
	var origin: CGPoint
	var size: CGSize

let rect = CGRect(origin: aCGPoint, size: aCGSize) // there are other inits as well
```

--- 
#Coordinate System Data Structures

Lots of convenient properties and functions on `CGRect` like...

```swift
	var minX: CGFloat	// left edge

	var midY: CGFloat	// midpoint vertically

	intersects(CGRect) -> Bool // Does this CGRect intersect this other one?

	intersect(CGRect)	// clip the CGRect to the intersection with the other one

	contains(CGPoint) -> Bool // Does the CGRect contain the given CGPoint
```

...and many more (make yourself a `CGRect` and type . After it to see more)

---
#View Coordinate System

---
# View Coordinate System
[MISSING GRAPHIC]
S
- Origin is upper left

---
# View Coordinate System
- Units are **points** not pixels
	👉 **Pixels** are the minimum-sized unit of drawing your device is capable of
	👉 Points are the units in the coordinate system
	👉 Most of the time there are 2️⃣ pixels per point, but it could be only 1 or even 3
	👉 How many pixels per point are there? `UIView`'s `var contentScaleFactor: CGFloat`

---
# View Coordinate System

- The boundaries of where drawing happens
	👉 `var bounds: CGRect` // a view's internal drawing space's origin and size
	👉 This is the rectangle containing the drawing space **in its own coordinate system**
	👉 It is up to your view's implementation to interpret what `bounds.origin` means 	(often nothing)

---
# View Coordinate System

- Where is the `UIView`? 

```swift
var center: CGPoint // the center of a UIView **in its superview's coordinate system**
var frame: CGRect // the rect containing a UIView in its superview's coordinate system
```

---
# View Coordinate System
### bounds vs frame

---
# View Coordinate System
### bounds vs frame [MISSING GRAPHIC]

- Use `frame` and/or `center` to **position** a `UIView`
	👉 These are **never used to draw** inside a view's coordinate system
	👉 You might think `frame.size` is always equal to `bounds.size`, but you'd be wrong...

---
# View Coordinate System
### bounds vs frame [MISSING GRAPHIC]

- Views can be rotated (and scaled and translated)


View B's middle in its own coordinates is..

```swift
// View B's bounds = ((0,0),(200,250))
// View B's frame = ((140,65),(320,320))
// View B's center = (300,225)

(bounds.midX, bounds.midY) = (100,125)
```
👉 Views are rarely rotated, but don't misuse `frame` or `center anyway by assuming that

---
# Creating Views

- Most often your views are created via your **storyboard** (`.storyboard`)
- Xcode's Object Palette has a **generic** `UIView` you can drag out
- After you do that, you must use the **Identity Inspector** to change its class to your subclass 

---
# Creating Views

- On a rare occasion, you will create a `UIView` via code

```swift
// you can use the frame initializer:
let newView = UIView(frame: myFrameView)
// or you can just use 
let newView = UIView() // frame will be CGRect.zero)
```

--- 
# Creating Views

```swift
// Example of adding a label to my UIViewController's view:

label labelRect = CGrect(x: 20, y: 20, width: 100, height: 50)
let label = UILabel(frame: labelRect) // UILabel is a subclass of UIView
label.text = "Hello"
view.addSubview(label)
```

---
# Custom Views

- 🧐 When would I create my own `UIView` subclass?
	👨‍🎨 I want to do some custom drawing on screen 
	👆 I need to handle touch events in a special way (i.e. different than a button or 	slider does) ⭐️ We'll talk about handling touch events in a bit. For now, lets focus on 	drawing⭐️

---
# Custom Views

- To draw, create a `UIView` subclass and `override draw(CGRect)`

```swift
override func draw(_ rect: CGRect)
// You can draw outside the rect, but it's never required to do so
// The rect is purely an optimization
// It is our `UIView`'s **bounds** that describe the entire drawing area (the rect is a subarea)
```

---
# Custom Views

🚨🚨🚨🚨 NEVER call `draw(CGRect)`. EVER. PLEASE 🚨🚨🚨🚨


---
# Custom Views

Instead, if your view needs to be redraw, let the system know that by calling..

```swift
setNeedsDisplay()
setNeedsDisplay(_ rect: CGRect) // rect is the area that needs to be redrawn

// iOS will then call your draw(CGRect) at an appropriate time
```

---
# Custom Views

- 🧐 So how do I implement my `draw(CGRect)`?
	👉 Option 1: Get a drawing context and tell it what to draw
	👉 Option 2: Create a path of drawing using `UIBezierPath` class

---
# Custom Views
### Option 1: Get a drawing context and tell it what to draw

- Core Graphics Concepts
	Step 1️⃣: **Get a context to draw into** (other contexts including printing, off-screen buffer, etc.). The function `UIGraphicsGetCurrentContext()` gives you a context you can use in `draw(CGRect)`
	Step 2️⃣: Create paths (out of lines, arcs, etc.)
	Step 3️⃣: Set drawing attributes like colors, fonts, textures, linewidths, linecaps, etc.
	Step 4️⃣: Stroke or fill the above-created paths with the given attributes

---
# Custom Views
### Option 2: Create a path of drawing using `UIBezierPath` class

- UIBezierPath
	✋ Same as Core Graphics **but** UIBezierPath captures all the drawing with a 	`	UIBezierPath` instance. 
	👉 `UIBezierPath` automatically draws into the current context (preset up for you 	in `draw(CGRect))` 
	👉 `UIBezierPath` has methods to draw (lineto, arcs, etc) and to set attributes (linewidth, etc.)
	👉 Use `UIColor` to set stroke and fill colors
	👉 `UIBezierPath` has methods to stroke and/or fill


---
# Defining a Path

```swift
// Create a `UIBezierPath`
let path = UIBezierPath()
```

---
# Defining a Path

```swift
// Create a `UIBezierPath`
let path = UIBezierPath()
```

--- 
# Defining a Path

```swift
// Create a `UIBezierPath`
let path = UIBezierPath()

// Move around, add lines or acts to the path
path.move(to: CGPoint(80, 50))
path.addLine(to: CGPoint(140, 150))
path.addLine(to: CGPoint(10, 150))

// Close the path (if you want)
path.close()
```

---
# Defining a Path

```swift
// Create a `UIBezierPath`
let path = UIBezierPath()

... 

// Close the path (if you want)
path.close()

// Now that you have a path, set the attributes and stroke/fill:
UIColor.green.setFill() // 📝: setFill is a method in UIColor, `UIBezierPath`
UIColor.red.setStroke() // 📝: `setStroke` is a method in `UIColor`, not `UIBezierPath`
path.linewidth = 3.0	// `linewidth` **is** is a property in `UIBezierPath` not `UIColor`
path.fill()		// `fill` is a method in `UIBezierPath`
path.stroke()		// `stroke` method in `UIBezierPath`
```
---
# Drawing

- You can also draw common shapes with `UIBezierPath`:

```swift
let roundedRect = UIBezierPath(roundedRect: CGRect, cornerRadius: CGFloat)
let oval = UIBezierPath(ovalIn: CGRect)
// Many others available
```

- Clipping your drawing to a `UIBezierPath`'s path:

```swift
addClip()
// For example, you could clip to a rounded rect to enforce the edges of a playing card
```

- Hit detection

```swift
func contains(_ point: CGPoint) -> Bool // Returns whether the point is inside the path
// the path must be closed. The winding rule can be set with `usesEvenOddFilleRule` property
```

- Etc.
Lots of other stuff. Check out documentation

---
# UIColor

- Colors are set using `UIColor`
	👉 There are type (aka `static`) vars for standard colors, e.g.:

```swift
Let green = UIColor.green
// you can create colors from RGB, HSB, or even pattern (using UIImage)
```

---
# UIColor

- Background color of `UIView`

```swift
var background = UIColor // used in our `CapThatViewController`
```

---
# UIColor

- Colors can have alpha (transparency)

```swift
let semiTransparentYellow = UIColor.yellow.withAlphaComponent(0.5) 
// Alpha is between 0.0 (fully transparent) and 1.0 (fully opaque)
```

---
# UIColor

- If you want to draw in your view with transparency you must let the system
known by setting the `UIView` 

```swift
var opaque = false
```

---
# UIColor

- You can make your entire `UIView` transparent

```swift
var alpha: CGFloat
```

--- 
# Layers

- Underneath `UIView` is a drawing mechanism called `CALayer`

--- 
# Layers

- Underneath `UIView` is a drawing mechanism called `CALayer`
	👉 You usually do not care about this but.. there are some useful APIs there

- You can access a `UIView`'s "layer" using this var ..

```swift
var layer: CALayer
```

- The CA in `CALayer` stands for Core Animation

- Mostly we can do animation in a `UIView` without accessing this layer directly

- But it is where the actual **animation** functionality of `UIView` is coming from
(We'll talk about animation later)


---
# Layers
### CALayers

- `CALayer` can do some cool non-animation oriented things 

```swift
var cornerRadius: CGFloat // make the background a rounded rect
var borderWidth: CGFloat  // draw a border around the view
var borderColor: CGColor? // the color of the border (if any)

// You can get a `CGColor` from a `UIColor` using a `UIColor`'s `cgColor` var
```

---
# View Transparency

- What happens when views overlap and have transparency?
	👉 As previously mentioned, `subview`s list order determines who is in front
	👉 Lower ones (earlier in the array) can show through transparent views on top of
	them
	👉 Transparency is not cheap so use it wisely

---
# View Transparency

- Completely hiding a view without removing it from hierarchy:

```swift 
var isHidden: Bool
// An `isHidden view will draw nothing on screen and get no events either
// Not as uncommon as you might think to temporarily hide a view
```

---
# Drawing Text

- Usually we use `UILabel` to put text on screen
	👉 Some occasions we want to draw text in our `draw(CGRect)`


---
# Drawing Text

- To draw in `draw(CGRect)`, use `NSAttributedString`

```swift
let text = NSAttributedString(string: "hello!") // probably would set some attributes
text.draw(at: aCGPoint) // or draw(in: CGRect)
let textSize: CGSize = text.size	// how much space the string will take up
```

---
# Drawing Text

- Accessing a range of characters in an `NSAttributedString`

```swift
// NSRange has an `init` which can handle the String vs NSString weirdness..

let footballStadium = "Carrier Dome"
var attrString = NSMutableAttributedString(string: footballStadium)
let firstWordRange = footballStadium.startIndex..<footballStadium.indexOf(" ")!
let nsrange = NSRange(firstWordRange, in: footballStadium) // converts Range<String.Index>
attrString.addAttribute(.strokeColor, value: UIColor.orange, range: nsrange)
```

---
# Fonts

- Fonts in iOS are very important to get right
They are fundamental to the look and feel of the UI

[MISSING IMAGE]


--- 
# Fonts

- Usually you set fonts in UI elements like `UIButton`, `UILabel`, etc
	👉 Be sure to choose a "preferred font" for **user content** in the Inspector in 	`.storyboard`
	👉 User content is information generated by or requested by the user (not button 	titles, etc.)
	👉 You might want to set a font in an `NSAttributedString` too...

---
# Fonts

- Simple way to get a font in code
	👉 Get preferred font for a given text style (e.g. body, etc.) using `UIFont` type method..

```swift
static func preferredFont(forTextStyle: UIFontTextStyle) -> UIFont
```

	👉 See the styles of `UIFontDescriptor` documentation for more ..

```swift
UIFontStyle.headline
UIFontStyle.body
UIFontStyle.footnote
```

---
# Fonts

- Importantly the size of the font you get is determined by user settings (esp for Accessibility)
- You'll want to make sure your UI looks good with all size fonts

---
# Fonts

- More advanced way:
	👉 Choose a specific font by name..

```swift
let font = UIFont(name: "Helvetica", size: 36.0)
/// Your an also use the `UIFontDescriptor` class to get the font you want
```

---
# Fonts

```swift
let font = UIFont(name: "Helvetica", size: 36.0)
/// Your an also use the `UIFontDescriptor` class to get the font you want

// Now get the metrics for the text style you want and scale font to the user's desired size
let metrics = UIFontMetrics(forTextStyle: .body) // or UIFontMetrics.default
let fontToUse = metrics.scaledFont(for: font)
```

---
# Fonts

- There are also "system fonts"

```swift
// These appear usually on things like buttons

static func systemFont(ofSize: CGFloat) -> UIFont
static func boldSystemFont(ofSize: CGFloat) -> UIFont

// but again don't use these for your user's **content** Use preferred fonts for that
```

---
# Drawing Images

- There is a `UILabel` -equivalent for images: `UIImageView`

---
# Drawing Images

- There is a `UILabel` -equivalent for images: `UIImageView`
	🤔 Again, you might want to draw the image inside your `draw(CGRect)`...

---
# Drawing Images

```swift
// Creating a `UIImage` object
let image: UIImage? = UIImage(named: "blah") // not that it's an Optional
// You add foo.png to your project in `Assets.xcassets` file
// Images will have different resolutions for different devices (all managed in `Assets.xcassets`)


---
# Drawing Images

- You can also create one from files in the file system

```swift
let image: UIImage? = UIImage(contentOfFile: pathString)
Let image: UIImage? = UIImage(data: aData) // raw jpg, png, tiff, etc image data
```

---
# Drawing Images

- You can even create one by drawing with Core Graphics 
See documentation for `UIGraphicsBeginImageContext(CGSize)`

---
# Drawing Images

- Once you have a `UIImage`, you can blast its bits on screen

```swift
let image = UIImage = ...
image.draw(at point: aCGPoint) // the upper left corner put at aCGPoint
image.draw(in rect: aCGRect)  // scales the image to fit a aCGRect
image.drawAsPattern(in rect: aCGRect) // tiles the image into aCGRevt
```


---
# Redraw on `bounds` change


- By default, when a UIView's bounds changes, there is **no redraw**
	👉 Instead, the bits of the existing image re scaled to the new bounds size

- This is often not what you want..
	👉 Luckily, there is a UIView property to control this! (It can be set in Xcode too!)

```swift
var contentMode: UIViewContentMode
```

--
# UIViewContentMode

- `UIViewContentMode`
	👉 If you don't want to scale the view, place the bits (intact) somewhere:
	`.left`/`.right`/`.top`/`.bottom`/`.topRight`/`.topLeft`/`.bottomRight`/`.bottomLeft`/`.center`
	👉 Scale the "bits" of the view:
	`.scaleToFill`/`.scaleAspectFill`/`.scaleAspectFit` // .scaledToFill is the default
	👉 Redraw by calling `draw(CGRect)` again (costly, but for certain content, better results...
	👉 `.redraw`

