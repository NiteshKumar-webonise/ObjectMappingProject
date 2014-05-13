//
//  Parser.h
//  ObjectMapping
//
//  Created by Webonise on 02/08/13.
//  Copyright (c) 2013 Webonise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

@property (nonatomic, retain) id classObject;

-(id)dictionaryToObjectMappingForObject:(id)obj fromDictionary:(NSDictionary*)dict;

//in keyWithAtrribute you can give key and attribte pair where your key is keyName from your dictionary and attribute is associtaed property name from your model in which you want to populate value from this key.
-(id)objectMappingForObject:(id)obj fromDictionary:(NSDictionary*)dict mapKeyPathsToAttributes:(NSString*)keyWithAtrribute,...;

+ (id)dictionaryWithKeysAndObjects:(id)firstKey, ... ;

@end
