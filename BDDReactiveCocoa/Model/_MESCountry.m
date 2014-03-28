// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MESCountry.m instead.

#import "_MESCountry.h"

const struct MESCountryAttributes MESCountryAttributes = {
	.name = @"name",
};

const struct MESCountryRelationships MESCountryRelationships = {
	.continent = @"continent",
	.officialLanguages = @"officialLanguages",
};

const struct MESCountryFetchedProperties MESCountryFetchedProperties = {
};

@implementation MESCountryID
@end

@implementation _MESCountry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MESCountry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MESCountry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MESCountry" inManagedObjectContext:moc_];
}

- (MESCountryID*)objectID {
	return (MESCountryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic continent;

	

@dynamic officialLanguages;

	
- (NSMutableSet*)officialLanguagesSet {
	[self willAccessValueForKey:@"officialLanguages"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"officialLanguages"];
  
	[self didAccessValueForKey:@"officialLanguages"];
	return result;
}
	






@end
