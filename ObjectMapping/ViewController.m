//
//  ViewController.m
//  ObjectMapping
//
//  Created by Webonise on 13/05/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "Parser.h"
#import "Person.h"
#import "Address.h"
#import "Parser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *personAdr = [Parser dictionaryWithKeysAndObjects:@"personCity",@"Delhi",@"personState",@"UK",nil];
    NSDictionary *personDict = [Parser dictionaryWithKeysAndObjects:
                                @"personName", @"Sonam",
                                @"personAge", [NSNumber numberWithInt:24],
                                @"personAddress", personAdr,
         
                                nil];
    
    
    
    
    
    Person *person = [[Person alloc]init];
    Address *address = [[Address alloc]init];
    Parser *parser = [[Parser alloc]init];
    
    address = [parser objectMappingForObject:address fromDictionary:[personDict objectForKey:@"personAddress"]  mapKeyPathsToAttributes:@"personCity",@"city",@"personState",@"state"];
    
    person= [parser objectMappingForObject:person fromDictionary:personDict mapKeyPathsToAttributes:@"personName",@"name",@"personAge",@"age"];
    person.address = address;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
