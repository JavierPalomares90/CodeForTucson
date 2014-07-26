//
//  ViewController.m
//  DriveNoText
//
//  Created by Javier Palomares on 26/7/14.
//  Copyright (c) 2014 CodeForTucson. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h> // Import for maps


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.;
    // Initialization for location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    currLocation = [locations lastObject];
    NSLog(@"NewLocation %f %f", currLocation.coordinate.latitude, currLocation.coordinate.longitude);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)destinationButtonClick:(id)sender {
    // Launch instance of Map application
    // Save Final destination
    CLLocationCoordinate2D currLocationCoord = currLocation.coordinate;
    //Apple Maps, using the MKMapItem class
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:currLocationCoord addressDictionary:nil];// set to final destination
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = @"Current Location";
    [item openInMapsWithLaunchOptions:nil];
}

-(void)openActionSheet:(id)sender {

    //give the user a choice of Apple or Google Maps
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Open in Maps" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //coordinates for the place we want to display
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake(31.20691,121.477847);
    if (buttonIndex==0) {
        //Apple Maps, using the MKMapItem class
        MKPlacemark *placemark = nil; // set to final destination
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        item.name = @"ReignDesign Office";
        [item openInMapsWithLaunchOptions:nil];
    } else if (buttonIndex==1) {
        //Google Maps
        //construct a URL using the comgooglemaps schema
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%f,%f",rdOfficeLocation.latitude,rdOfficeLocation.longitude]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            NSLog(@"Google Maps app is not installed");
            // Open the Google Maps mobile website instead!
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
