// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MESContinent.h instead.

#import <CoreData/CoreData.h>


extern const struct MESContinentAttributes {
	__unsafe_unretained NSString *name;
} MESContinentAttributes;

extern const struct MESContinentRelationships {
	__unsafe_unretained NSString *countries;
} MESContinentRelationships;

extern const struct MESContinentFetchedProperties {
} MESContinentFetchedProperties;

@class MESCountry;



@interface MESContinentID : NSManagedObjectID {}
@end

@interface _MESContinent : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MESContinentID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *countries;

- (NSMutableSet*)countriesSet;





@end

@interface _MESContinent (CoreDataGeneratedAccessors)

- (void)addCountries:(NSSet*)value_;
- (void)removeCountries:(NSSet*)value_;
- (void)addCountriesObject:(MESCountry*)value_;
- (void)removeCountriesObject:(MESCountry*)value_;

@end

@interface _MESContinent (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveCountries;
- (void)setPrimitiveCountries:(NSMutableSet*)value;


@end
