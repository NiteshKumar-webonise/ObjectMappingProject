
Guidlines :

step 1: #import "Parser.h"

step 2: initialise your model objects

step 3: initialise Parser 

for "-(id)objectMappingForObject:(id)obj fromDictionary:(NSDictionary*)dict mapKeyPathsToAttributes:(NSString*)keyWithAtrribute,...;"  what you should have :
 
 a. initialised object
 
 b. dictionary from which you are going to parse
 
 c. list of strings which in pair of keyPath and attributeMName 

 this method returns populated (parsed) object.