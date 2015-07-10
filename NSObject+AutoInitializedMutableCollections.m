
#import "NSObject+AutoInitializedMutableCollections.h"
#import <objc/objc-runtime.h>

@implementation NSObject (AutoInitializedMutableCollections)

+ (instancetype)newWithAutoInitializedMutableCollections;
{
    id newObject = [self new];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([newObject class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];

        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *rawPropertyType = [NSString stringWithUTF8String:property_copyAttributeValue(property, "T")];
        Class propertyClass = NSClassFromString([rawPropertyType substringWithRange:NSMakeRange(2, rawPropertyType.length - 3)]);
        
        Class array = [NSMutableArray class];
        Class dictionary = [NSMutableDictionary class];
        Class set = [NSMutableSet class];
        Class orderedSet = [NSMutableOrderedSet class];
        Class indexSet = [NSMutableIndexSet class];
        
        if (propertyClass == array) {
            [newObject setValue:array.new forKey:propertyName];
        } else if (propertyClass == dictionary) {
            [newObject setValue:dictionary.new forKey:propertyName];
        } else if (propertyClass == set) {
            [newObject setValue:set.new forKey:propertyName];
        } else if (propertyClass == orderedSet) {
            [newObject setValue:orderedSet.new forKey:propertyName];
        } else if (propertyClass == indexSet) {
            [newObject setValue:indexSet.new forKey:propertyName];
        }
    }

    return newObject;
}

@end
