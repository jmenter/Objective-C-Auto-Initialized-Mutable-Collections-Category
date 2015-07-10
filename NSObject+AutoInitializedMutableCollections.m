
#import "NSObject+AutoInitializedMutableCollections.h"
#import <objc/objc-runtime.h>

@implementation NSObject (AutoInitializedMutableCollections)

+ (instancetype)newWithAutoInitializedMutableCollections;
{
    id newObject = self.new;
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([newObject class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *rawPropertyType = [NSString stringWithUTF8String:property_copyAttributeValue(property, "T")];
        Class propClass = NSClassFromString([rawPropertyType substringWithRange:NSMakeRange(2, rawPropertyType.length - 3)]);
        
        if (propClass == NSMutableArray.class) { [newObject setValue:NSMutableArray.new forKey:propertyName]; }
        else if (propClass == NSMutableDictionary.class) { [newObject setValue:NSMutableDictionary.new forKey:propertyName]; }
        else if (propClass == NSMutableSet.class) { [newObject setValue:NSMutableSet.new forKey:propertyName]; }
        else if (propClass == NSMutableOrderedSet.class) { [newObject setValue:NSMutableOrderedSet.new forKey:propertyName]; }
        else if (propClass == NSMutableIndexSet.class) { [newObject setValue:NSMutableIndexSet.new forKey:propertyName]; }
    }
    return newObject;
}

@end
