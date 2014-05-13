//
//  Parser.m
//  ObjectMapping
//
//  Created by Webonise on 02/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import "Parser.h"
#import <objc/runtime.h>
@implementation Parser
@synthesize classObject;
-(id)dictionaryToObjectMappingForObject:(id)object fromDictionary:(NSDictionary*)dict
{
    
    unsigned count,testCount;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSLog(@"present key:-%@",key);
        if([[object valueForKey:key] isKindOfClass:[NSObject class]]){
            id test1Obj=[object valueForKey:key];
            objc_property_t *testProperties=class_copyPropertyList([test1Obj class], &testCount);
            //for composite objects
            if(testCount>1){
                test1Obj=[self dictionaryToObjectMappingForObject:test1Obj fromDictionary:[dict objectForKey:key]];
                //NSLog(@"%@",test);
                [object setValue:test1Obj forKey:key];
                continue;
            }
            
            //for an object which is an array
            if([[object valueForKey:key] isKindOfClass:[NSArray class]]){
                
                id test2Obj =[object valueForKey:key];
                
                NSArray *testDictArr=[dict objectForKey:key];
                unsigned arrCount=[testDictArr count];
                NSMutableArray *objectArr=[[NSMutableArray alloc]initWithCapacity:arrCount];
                for(int i = 0 ;i < arrCount ; i++){
                    Class modelClass=[[test2Obj objectAtIndex:0] class];
                    id tempobj=[[modelClass alloc]init];
                    id obj=[self dictionaryToObjectMappingForObject:tempobj fromDictionary:[testDictArr objectAtIndex:i]];
                    [objectArr addObject:obj];
                }
                
                //NSLog(@"the array of dictinary is :-%@",testDictArr);
                [object setValue:objectArr forKey:key];
                continue;
            }
            
        }
        
        [object setValue:[dict valueForKey:key] forKey:key];
    }
    
    return object;
}

-(id)objectMappingForObject:(id)obj fromDictionary:(NSDictionary*)dict mapKeyPathsToAttributes:(NSString*)keyPathWithAtrribute,...{
    va_list args;
    va_start(args,keyPathWithAtrribute);
    for (NSString* keyPath = keyPathWithAtrribute; keyPath != nil; keyPath = va_arg(args, NSString*)) {
        NSString* attributeKeyPath = va_arg(args, NSString*);
        NSAssert(attributeKeyPath != nil, @"Cannot map a keyPath without a destination attribute keyPath");
        [obj setValue:[dict objectForKey:keyPath]  forKey:attributeKeyPath];
    }
    classObject = obj;
    return obj;
}

+ (id)dictionaryWithKeysAndObjects:(id)firstKey, ... {
	va_list args;
    va_start(args, firstKey);
	NSMutableArray* keys = [NSMutableArray array];
	NSMutableArray* values = [NSMutableArray array];
    for (id key = firstKey; key != nil; key = va_arg(args, id)) {
		id value = va_arg(args, id);
        [keys addObject:key];
		[values addObject:value];
    }
    va_end(args);
    
    return [NSDictionary dictionaryWithObjects:values forKeys:keys];
}

- (void)mapKeyPathsToAttributes:(NSString*)firstKeyPath, ... {
    va_list args;
    va_start(args, firstKeyPath);
    for (NSString* keyPath = firstKeyPath; keyPath != nil; keyPath = va_arg(args, NSString*)) {
		NSString* attributeKeyPath = va_arg(args, NSString*);
        NSAssert(attributeKeyPath != nil, @"Cannot map a keyPath without a destination attribute keyPath");
        //[self mapKeyPath:keyPath toAttribute:attributeKeyPath];
        // TODO: Raise proper exception here, argument error...
    }
    va_end(args);
}


@end
