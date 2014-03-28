// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MESCountry.h instead.

#import <CoreData/CoreData.h>


extern const struct MESCountryAttributes {
	__unsafe_unretained NSString *name;
} MESCountryAttributes;

extern const struct MESCountryRelationships {
	__unsafe_unretained NSString *continent;
	__unsafe_unretained NSString *officialLanguages;
} MESCountryRelationships;

extern const struct MESCountryFetchedProperties {
} MESCountryFetchedProperties;

@class MESContinent;
@class MESLanguage;



@interface MESCountryID : NSManagedObjectID {}
@end

@interface _MESCountry : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MESCountryID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MESContinent *continent;

//- (BOOL)validateContinent:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *officialLanguages;

- (NSMutableSet*)officialLanguagesSet;





@end

@interface _MESCountry (CoreDataGeneratedAccessors)

- (void)addOfficialLanguages:(NSSet*)value_;
- (void)removeOfficialLanguages:(NSSet*)value_;
- (void)addOfficialLanguagesObject:(MESLanguage*)value_;
- (void)removeOfficialLanguagesObject:(MESLanguage*)value_;

@end

@interface _MESCountry (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (MESContinent*)primitiveContinent;
- (void)setPrimitiveContinent:(MESContinent*)value;



- (NSMutableSet*)primitiveOfficialLanguages;
- (void)setPrimitiveOfficialLanguages:(NSMutableSet*)value;


@end
