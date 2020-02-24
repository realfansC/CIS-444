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

It makes sense to have the cook program list be the first thing users see when they launch your app, so tell Xcode that’s your intent by setting the cook program list as the first scene.

✅ point: Set your new cook program list as the initial scene in the storyboard. If you don't remember how to do that, google it or refer back to your coding assignment guide

 🛑Do not advance until your table view controller is the initial view controller. If done correctly, it should look something like this:

![inline][initial-scene-table-img]

The table view controller is set as the initial view controller in your storyboard, making the cook program list the first scene that loads on app launch.

✅ point: Run your app. Instead of the seeing a blank screen, you should now see an empty table view—a screen with a number of horizontal dividers to separate it into rows, but with no content in each row.

![inline][empty-table-controller-img]


You need to change a few settings on this table view so you can use it in your app.

### To configure the table view

1. In your storyboard, open the [outline view](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW56) and expand the [utility area](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW72).

2. In the outline view, select Table View.
    The table view is nested under Table View Controller Scene > Table View Controller. You may have to click the disclosure triangles next to those objects to see the nested table view.

![inline][table-view-in-navigator-img]

3. With the table view selected, open the Size inspector in the utility area.
Size Inspector: 

![inline](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/inspector_size_2x.png)

4. In the Size inspector, find the field labeled Row Height and type `90`. Press Return.

You’ll come back to working on the table view itself in a little while, after you design an interface for what the table view displays: its table view cells.


## Design Custom Table Cells

The individual rows in a table view are managed by table view cells (`UITableViewCell`), which are responsible for drawing their contents. Table view cells come with a variety of predefined behavior and default cell styles; however, because you have more content to display in each cell than the default styles allow, you’ll need to define a custom cell style.

### To create a subclass of UITableViewCell

1. Expand the Navigator area and open the Project navigator.
2. Choose File > New > File (or press Command-N).
3. At the top of the dialog that appears, select iOS.
4. Select Cocoa Touch Class, and click Next.
5. In the Class field, type `CookProgram`
6. In the “Subclass of” field, select  `UITableViewCell`.
The class title changes to `CookProgramTableViewCell`.  Xcode makes it clear from the naming that you’re creating a custom table view cell, so leave the new name as is.
7. Make sure the Language option is set to Swift.
8. Click Next.
The save location defaults to your project directory.
The Group option defaults to your app name, YourAppName.
9. In the Targets section, make sure your app is selected and the tests for your app are unselected.
10. Click Create.
Xcode creates a file that defines the `CookProgramTableViewCell` class: `CookProgramTableViewCell.swift`
11. In the Project navigator, reposition the   `CookProgramTableViewCell.swift` file under the other Swift files, if necessary.

✅point: Your `CookProgramTableViewCell.swift` should look like this

```swift
import UIKit

class CookProgramTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
```

Now, open your storyboard again.

If you look at the cook program list scene in your storyboard, you’ll notice that it shows a single table view cell.

![inline][empty-table-view-storyboard-img]

This cell is a prototype cell for the table. You can define the design and behavior of this cell. The table can then create instances of this cell. But first, you need to connect the table view cell in your scene to the custom cell subclass you just created.

### To configure a custom cell for your table view

1. In the outline view, select Table View Cell.

The cell is nested under Table View Controller Scene > Table View Controller > Table View. You may have to disclose those objects to see the table view cell.

![inline][table-view-cell-storyboard-img]


2. With the table view cell selected, open the Attributes inspector in the utility area.

3. In the Attributes inspector, find the field labeled Identifier and type `CookProgramTableViewCell`. Press Return.

You will use this identifier to create instances of this prototype cell.


4. Open the Size inspector

5. In the Size inspector, find the field labeled Row Height and type `90`. Make sure the `Automatic` checkbox next to this field is selected.

6. Open the Identity inspector

![inline][identity-inspector-img]

7. In the Identity inspector, find the Class field and select `CookProgramTableViewCell`.

![inline][cook-program-as-cell-img]

With the cell configured, you can design its custom user interface directly in the storyboard. You’ll need two labels and an image view. 

### Add a default photo

First, drag the below default image  below into your xcode project. Add it to your asset library and name it `defaultPhoto`.
🛑 If you don't remember how to add an image to your asset library, google it. 
![inline](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/defaultphoto_2x.png)


### To design the interface of the custom table cell
1. Use the Object library to find an Image View object and drag it onto the table cell.

2. Drag and resize the image view so that it’s square, flush against the left, top, and bottom of the cell.

![inline](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CTV_imageview_resize_2x.png)

3. With the image view selected, open the Attributes inspector in the Utility area.


4. Once you have a In the Attributes inspector, find the Image field and select `defaultPhoto`. 

![inline](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CTV_imageview_setdefault_2x.png)


5. Use the Object library to find a Label object and drag it onto the table cell. You will use the label to show the cook program's name.

6. Drag the label so that its lined up with the guidelines to the right side of the image view and to the top margin of the table view cell.

![inline](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CTV_label_drag_2x.png)

7. Resize the label so that its right edge stretches to the cell’s right margin.

![inline](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CTV_label_resize_2x.png)


✅point: Run your app. The table view cells now look taller. But even though you added all the necessary user interface elements to your table view cells, they’re showing up empty, just like before. Why’s that?

![inline](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CTV_sim_wideemptycells_2x.png)

In a storyboard, you can configure a table view to display static data (supplied in the storyboard) or dynamic data (programmatically supplied by the table view controller). By default, the table view controller uses dynamic data. This means the interface you created in the storyboard is simply a prototype for your cell. You still need to create instances of this cell in code and fill them with your app’s data.


✅point: *Preview your interface*  (if you don't rememebr how to do that, refer to the guide in Wednesday's lecture)
Note: If you see the wrong scene in the preview, make sure to select the table view scene by clicking its scene [dock](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW63).

### 



[added-table-view-controller-img]:added-table-view-controller

[table-view-controller-obj-img]:table-view-controller-obj

[initial-scene-table-img]: initial-scene-table

[empty-table-controller-img]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CTV_sim_emptytv_2x.png

[table-view-in-navigator-img]: table-view-in-navigator

[empty-table-view-storyboard-img]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/CTV_singletvcell_2x.png

[table-view-cell-storyboard-img]:table-view-cell-storyboard

[cook-program-as-cell-img]:cook-program-as-cell

[identity-inspector-img]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/inspector_identity_2x.png
