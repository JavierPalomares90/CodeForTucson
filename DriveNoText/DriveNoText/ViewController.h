//
//  ViewController.h
//  DriveNoText
//
//  Created by Javier Palomares on 26/7/14.
//  Copyright (c) 2014 CodeForTucson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> // Location core

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UIButton *destinationButton;


@end
CLLocation *currLocation;
CLLocation *desiredLocation;