### CIS 444 Reading Assignment #2: More Swift

## Objective
Focus is closures, functions as types, computed properties, initialization, access control, enums, associated data, and extension


### Tips
This is a lot of reading. Don't wait until the last minute to read it all in one sitting. Break it into pieces. 
If you don't understand a concept in the documentation, don't panic or give up. Take a break and re-read it again. _Slow down and take notes as you go_ If you're still stuck, utilize google  and search the topic you're having difficulty grasping. There are  endless sources and tutorials online to help communicate the concepts in a different way. Bring any extra questions you might have to class. 

## Materials

* The reading in this course comes from two online documents: [Swift Programming Language](https://docs.swift.org/swift-book/#) and the [Swift API Guidelines](https://swift.org/documentation/api-design-guidelines/)

## 1. Swift Programming Language 
 
 Read the sections described below in the [Swift Programming Language](https://docs.swift.org/swift-book/#).
 
 * :rotating_light: sections are VERY important and might be more difficult to understand. Go slow.
 * :exclamation: sections are important, but probably won't be as difficult to understand.
 * :no_mouth: sections aren't required for this week but might be in the future 
 
 _Don’t skim any NOTE text (inside gray boxes)—many of those things are
 important. However, if a NOTE refers to Objective-C or bridging, you can ignore it.
If there is a link to another section in the text, you don’t have to follow that link unless
what it links to is also part of this week’s reading assignment._

#### The Basics
- Constants and Variables
- Comments
- Semicolons
- Integers 
- Floating-Point Numbers
- Type Safety and Type Interface
- Numeric Literals
- Numeric Type Conversion
- Type Aliases
- Booleans
- :exclamation: Tuples
- Optionals
- :exclamation: Error Handling
- Assertions and Preconditions


### Basic Operators
- Terminology
- Assignment Operator
- Arithmetic Operators
- Compound Assignment Operators
- ✅ Comparison Operators
- Tenerary Conditional Operator
-  Nil-Coalescing Operator
- Range Operators
- Logical Operators


### Strings and Characters
- String literals
- Initalizing an Empty String
- String Mutability 
- Strings are Value Types
- Working with Characters
- Concatenating Strings and Characters
- String Interpolation
- Unicode
- Counting Characters
-  Accessing and Modifying a String
-  Substrings
- Comparing Strings 
-  Unicode Represenations of Strings

### Collection Types 
- Mutability of Collections
-  Arrays
- Sets
- Performing Set Operations

### Control Flow
* For-In Loops
* While Loops
1. Conditional Statements:
* Ifs
*  Switch
* No implicit Fallthrough
* Interval Matching
*  Tuples
*  Value Bindings
*  Where
* Compound Cases

2. Control Transfer Statements:
* :exclamation: continue
* ✅ Break
* Fallthrough
* :no_mouth: Labeled Statements

3. Early Exit
4. :exclamation: Checking API Availability

### Functions

* Defining and Calling Functions
1.Function Parameters and Return Values:
* Functions without Parameters
* Functions with Multiple Parameters
* Functions Without Return Values
* :exclamation: Functions with Multiple Return Values
2. Function Argument Labels and Parameter Names:
* Specifying Argument Labels
* Omitting Argument Labels
* Default Parameter Values
* :no_mouth: Variadic Parameters
* :no_mouth: In-Out Parameters

3. :rotating_light: Function Types
4. Nested Functions 

### :no_mouth: Closures

### :no_mouth: Enumerations

### Classes and Structures
* Comparing Classes and Structures
* :✅: Structures and Enumerations Are Value Types (ignore Enumerations)
* Classes are reference Types
* Choosing Between Classes and Structures
* Assignment and Copy Behavior for Strings, Arrays, and Dicitonaries

### Properties 
* Stored Properties
* :exclamation: Computed Properties
* Property Observers
* Global and Local Variables
* :✅: Type Properties

### Methods
1. Instance Methods
* The self Property
* Modifying Value Types wtihin  Instance Methods
* :exclamation: Assigning to self Within a Mutating Method

* :exclamation: Type Methods 

### :no_mouth: Subscripts

### Inheritance:
* Defining a Base Class
* Subclassing
1. Overriding
* Accessing Superclass Methods, Properties, and Subscripts
* ✅ Overriding Methods
* :no_mouth: Overriding Properties
2. Preventing Overrides

### Initalization:
* Setting Initial Values for Stored Properties
* ✅ Customizing Initialization 
* Default Initializers
* :exclamation: Class Inheritance and Initialization
* :exclamation: Failable Initializers
* :exclamation: Required Initializers
* :exclamation: Setting a Default Property Value with a Closure or Function



## 2. Swift API Guidelines

Read the [Swift API Guidelines](https://swift.org/documentation/api-design-guidelines/). Given that you are completely new to Swift, some of what is in this document will be a bit hard to fully absorb at first. But familiarizing yourself with what is in this document is crucial to writing good Swift code. So, for this assignment, the goal
is to know what’s there rather than completely and fully master the guidelines right off the bat. As the semester progresses, you should eventually become an expert namer of properties, methods and other Swift constructs. This will require you to refer back to this document often (even after 10 years, I still refer back to this document frequently!)

* Be sure to click everywhere that it says “MORE DETAIL”.
* Pay special attention to the “Write a documentation comment” section.
* Pay special attention to the “Follow case conventions” section.
* Pay special attention to the entire “Argument Labels” section.
* You can also ignore the final section (Special Instructions) for now.
