// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MESContinent.m instead.

#import "_MESContinent.h"

const struct MESContinentAttributes MESContinentAttributes = {
	.name = @"name",
};

const struct MESContinentRelationships MESContinentRelationships = {
	.countries = @"countries",
};

const struct MESContinentFetchedProperties MESContinentFetchedProperties = {
};

@implementation MESContinentID
@end

@implementation _MESContinent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MESContinent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MESContinent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MESContinent" inManagedObjectContext:moc_];
}

- (MESContinentID*)objectID {
	return (MESContinentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic countries;

	
- (NSMutableSet*)countriesSet {
	[self willAccessValueForKey:@"countries"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"countries"];
  
	[self didAccessValueForKey:@"countries"];
	return result;
}
	






@end
