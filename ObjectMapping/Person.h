//
//  Person.h
//  RestKitSample
//
//  Created by Webonise on 12/02/14.
//  Copyright (c) 2014 Webonise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface Person : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *age;
@property (nonatomic, retain) Address *address;

@end
