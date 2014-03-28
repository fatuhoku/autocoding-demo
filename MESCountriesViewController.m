//
//  MESCountriesViewController.m
//  BDDReactiveCocoa
//
//  Created by Hok Shun Poon on 25/03/2014.
//  Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import "MESCountriesViewController.h"
#import "MESCountry.h"
#import "MESLanguagesViewController.h"
#import "MESContinent.h"
#import "MESJsonViewController.h"
#import "HRCoder.h"

static NSString *kCountrySortKey = @"name";

@interface MESCountriesViewController () <UIAlertViewDelegate, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation MESCountriesViewController

#pragma mark - View Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create buttons
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(didTouchNewCountryButton:)];
    UIBarButtonItem *jsonButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                target:self
                                                                                action:@selector(didTouchJsonButton:)];
    self.navigationItem.rightBarButtonItems = @[addButton, jsonButton];

    // The below performs an initial fetch.
    // TODO Determine whether this caches or not
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"continent == %@", self.continent.objectID];
    self.fetchedResultsController = [MESCountry MR_fetchAllSortedBy:kCountrySortKey
                                                          ascending:YES
                                                      withPredicate:predicate
                                                            groupBy:nil
                                                           delegate:self];

    // RAC bindings
    RAC(self, title) = [RACObserve(self, continent.name) map:^(NSString *name){
       return [NSString stringWithFormat:@"Countries in %@", name];
    }];

    // Notification bindings
//    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(managedObjectDidChange:)
//                                                 name:NSManagedObjectContextObjectsDidChangeNotification
//                                               object:context];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.isViewLoaded && self.view.window){
        if (viewController == [navigationController viewControllers][0]) {
            // TODO Excellent. Perform Parse upload here.
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segue_languages"]) {
        MESLanguagesViewController *upcoming = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        upcoming.country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    } else if ([segue.identifier isEqualToString:@"seg_show_json"]) {
        MESJsonViewController *jsonViewController = segue.destinationViewController;
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:[HRCoder archivedJSONWithRootObject:self.continent]
                                            options:NSJSONWritingPrettyPrinted
                                              error:&error];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        jsonViewController.jsonText = string;
    }
}

#pragma mark - Helper Methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    MESCountry *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ languages", @([country.officialLanguages count])];
}


- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"£££ Context successfully saved.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

#pragma mark - Actions

- (void)didTouchJsonButton:(id)didTouchJsonButton {
    [self performSegueWithIdentifier:@"seg_show_json" sender:self];
}

- (IBAction)didTouchNewCountryButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name your new country..."
                                                    message:@"  "
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark - Alert View Delegate

// An alert view to create a new country. Simples.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // OK button
        NSString *name = [alertView textFieldAtIndex:0].text;
        MESCountry *newCountry = [MESCountry MR_createEntity];
        newCountry.name = name;
        // Set up relationship
        newCountry.continent = self.continent;
        [self.continent addCountriesObject:newCountry];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:(NSUInteger) section];
        return [sectionInfo numberOfObjects];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ruid_country"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MESCountry *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [country MR_deleteEntity];
        [self saveContext];
    }
}

#pragma mark — Fetched Results Controller Delegate Boilerplate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [tableView                   deleteRowsAtIndexPaths:[NSArray
                    arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView                      insertRowsAtIndexPaths:[NSArray
                    arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    [self saveContext];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
