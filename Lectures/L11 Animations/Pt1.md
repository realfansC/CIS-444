## CIS-444
## Lecture 11

## Build the Basic UI

It’s time to build a basic interface of your Caption App. You’ll start by working on a user interface for the scene that lets you add a Captioned View to your caption making app, CaptionThat.


### Part 1 Goals: 
* Edit the attributes of UI elements in a storyboard using the Attributes inspector
* View and rearrange UI elements using the outline view
* Preview a storyboard UI using the Assistant editor’s Preview mode
Use Auto Layout to lay out a UI that automatically adapts to the user’s device size


### To add a text field to your `CaptionedViewController` scene

1. Choose Editor > Canvas, and make sure Show Bounds Rectangles is selected.
This setting causes Interface Builder to draw a blue bounding box around all the views in the canvas. Many views and controls have transparent backgrounds, making it difficult to see their actual size. Layout bugs occur when the system resizes a view so that it’s either larger or smaller than you anticipate. Enabling this setting helps you understand exactly what’s going on in your view hierarchy.

2. Open the Object library.

   The Object library appears at the bottom of the utility area on the right side of Xcode. If you don’t see the Object library, click its button, which is the third button from the left in the library selector bar. (Alternatively, choose View > Utilities > Show Object Library.)

![inline 50%][Show Object Library]
  
 A list appears showing each object’s name, description, and visual representation

[Show Object Library]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/object_library_2x.png
"Show Object Library"

3. In the Object library, type `text field` in the filter field to find the Text Field object quickly
4. Drag a Text Field object from the Object library to your scene

![inline 50%][Drag a Text Field]

[Drag a Text Field]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_drag_2x.png
"Drag a Text Field"

> If necessary, zoom in by choosing Editor > Canvas > Zoom.

5. Drag the text field so that it’s positioned in the top half of the scene and aligned with the left margin in the scene.
Stop dragging the text field when it snaps to the left margin.

![inline 50%][Snaps]

[Snaps]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_place_2x.png
"snaps to the left margin"


6. If necessary, click the text field to reveal the [resize handles](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW60).
You resize a user interface element by dragging its resize handles, which are small white squares that appear on the element’s borders. You reveal an element’s resize handles by selecting it. In this case, the text field should already be selected because you just stopped dragging it. If your text field looks like the one below, you’re ready to resize it; if it doesn’t, select it on the canvas.

![inline 50%][Resize]

[Resize]: hhttps://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_resizehandles_2x.png


7. Resize the left and right edges of the text field until you see three vertical layout guides: the left margin alignment, the horizontal center alignment, and the right margin alignment.

![inline 50%][Margin Align]

[Margin Align]:https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_textfield_finalsize_2x.png

   Although you have the text field in your scene, there’s no instruction to the user about what to enter in the field. Use the text field’s placeholder text to prompt the user to enter a caption.


### To configure the text field’s placeholder text

1. With the text field selected, open the Attributes inspector in the utility area.  
   The [Attributes inspector](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/GlossaryDefinitions.html#//apple_ref/doc/uid/TP40015214-CH12-SW19) appears when you click the fourth button from the left in the inspector selector bar. It lets you edit the properties of an object in your storyboard.
  
  ![inline][Placeholder]
  
2. In the Attributes inspector, find the field labeled Placeholder and type `Enter caption`. 
> In a production app, any String that can be seen by the user (such as the text field’s placeholder text) should be localized. For more information, see [Build Apps for the World](https://developer.apple.com/internationalization/)

3. Press Return to display the new placeholder text in the text field.

   ![inline][AddText]
   
   While you’re editing the text field’s attributes, you can also edit the attributes of the system keyboard that’s displayed when a user selects the text field.

[Placeholder]: https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_inspector_attributes_2x.png
[AddText]: https://i.imgur.com/JDLU9dv.png

### To configure the text field’s keyboard

1. Make sure the text field is still selected
2. In the Attributes inspector, find the field labeled Return Key and select Done (scroll down if necessary).

This change will make the default Return key on the keyboard more pronounced to the user by changing it into a Done key.  

3. In the Attributes inspector, select the Auto-enable Return Key checkbox (again, scroll down if necessary).

This change makes it impossible for the user to tap the Done key before typing text into the text field, ensuring that users can never enter an empty string as a caption.

![inline][DoneKey]

[DoneKey]: https://i.imgur.com/yVHKn9v.png

Next, add a label (UILabel) at the top of the scene. A label isn’t interactive; it just displays static text in the user interface. To help you understand how to define interaction between elements in the user interface, you’ll configure this label to display the text the user enters into the text field. It’ll be a good way to test that the text field is taking the user input and processing it appropriately.

### To add a label to your scene 

(Review:) 
1. In the Object library, type label in the filter field to find the Label object quickly.

2. Drag a Label object from the Object library to your scene.

3. Drag the label so that it’s right above the text field and aligned with the left margin in the scene.
   Stop dragging the label when it snaps to the guidelines.

 
![inline][AddLabel]

[AddLabel]: https://i.imgur.com/gEqpi82.png

4. Double-click the label and type Caption

![inline][SetCaptionLabel]

[SetCaptionLabel]: https://i.imgur.com/FRvJDYU.png

5. Press Return to display the new text in the label.
  
   Now, add a button (UIButton) to the scene. A button is interactive, so users can tap it to trigger an action that you define. Later, you’ll create an action to reset the label text to a default value.

### To add a button to your scene

1. In the Object library, type button in the filter field to find the Button object quickly.
2. Drag a Button object from the Object library to your scene.
3. Drag the button so that it’s right below the text field and aligned with the left margin in the scene.
   Stop dragging the button when it snaps to the guidelines.

![inline][AddButton]

[AddButton]: https://media.giphy.com/media/KAvWjYWswGluZyB0ZC/giphy.gif

4. Double-click the button and type Set Default Label Text.
5. Press Return to display the new text in the button.
6. Reposition the button, if necessary.

![inline][SetDefaultText]

[SetDefaultText]: https://i.imgur.com/62zxiFU.png
