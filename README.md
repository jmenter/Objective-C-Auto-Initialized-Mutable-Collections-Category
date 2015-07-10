# Objective-C-Auto-Initialized-Mutable-Collections-Category
A class method category on NSObject that automatically initializes any property (public or private) whose type is mutable collection.

Import the header into your .pch and any class in your project can benefit from a new class initialization method:

    + (instancetype)newWithAutoInitializedMutableCollections;

This will return a new instance with all properties that are mutable collections initialized with empty mutable collections. This applies to the following mutable collection types:

* NSMutableArray
* NSMutableDictionary
* NSMutableSet
* NSMutableOrderedSet
* NSMutableIndexSet

Why? I have no idea.
