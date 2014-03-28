// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MESLanguage.m instead.

#import "_MESLanguage.h"

const struct MESLanguageAttributes MESLanguageAttributes = {
	.name = @"name",
	.numSpeakers = @"numSpeakers",
	.sample = @"sample",
};

const struct MESLanguageRelationships MESLanguageRelationships = {
	.countries = @"countries",
};

const struct MESLanguageFetchedProperties MESLanguageFetchedProperties = {
};

@implementation MESLanguageID
@end

@implementation _MESLanguage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MESLanguage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MESLanguage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MESLanguage" inManagedObjectContext:moc_];
}

- (MESLanguageID*)objectID {
	return (MESLanguageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"numSpeakersValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numSpeakers"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic name;






@dynamic numSpeakers;



- (float)numSpeakersValue {
	NSNumber *result = [self numSpeakers];
	return [result floatValue];
}

- (void)setNumSpeakersValue:(float)value_ {
	[self setNumSpeakers:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveNumSpeakersValue {
	NSNumber *result = [self primitiveNumSpeakers];
	return [result floatValue];
}

- (void)setPrimitiveNumSpeakersValue:(float)value_ {
	[self setPrimitiveNumSpeakers:[NSNumber numberWithFloat:value_]];
}





@dynamic sample;






@dynamic countries;

	
- (NSMutableSet*)countriesSet {
	[self willAccessValueForKey:@"countries"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"countries"];
  
	[self didAccessValueForKey:@"countries"];
	return result;
}
	






@end
