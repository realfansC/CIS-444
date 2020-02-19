
### Overview

There are three basic types of Navigation mechanism in iOS :

1. Push Navigation
2. Modal Navigation
3. Tab Navigation

### Push Navigation

A push Segue is adding another View Controller to the navigation stack. This assumes that the View Controller that originates the push is part of the same navigation controller that the View Controller that is being added to the stack belongs to. Memory management is not an issue with navigation controllers and a deep stack. As long as you are taking care of objects you might be passing from one View Controller to another, the compiler will take care of the navigation stack. See the image for a visual indication:

![Push Navigation](https://media.giphy.com/media/ZG5ib5i0iYvm0cORFk/giphy.gif)

### Modal Navigation

A modal Segue is just one View Controller presenting another View Controller modally. The View Controllers don't have to be part of a navigation controller and the View Controller being presented modally is generally considered to be a "child" of the presenting (parent) View Controller. The modally presented View Controller is usually sans any navigation bars or tab bars. The presenting View Controller is also responsible for dismissing the modal VC it created and presented.

![Modal](https://media.giphy.com/media/LLwJiCwfF2eBMIoW6g/giphy.gif)

### Tab Bar Navigation

Tab bar controllers are simple to use navigation controllers. They are generally used, when there are different logical flow in your app and you want to switch from one controller to another.  

![Tab bar](https://media.giphy.com/media/XbTxOrwkV4lFZSZMcy/giphy.gif)
