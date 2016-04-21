//
//  ViewController.h
//  Task1
//
//  Created by HeenalShah on 26/02/16.
//  Copyright © 2016 HeenalShah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
    IBOutlet UITableView *table;
     NSData *imageData;
    
}

@property(weak,atomic)NSURLConnection *connection;
@property(weak,nonatomic)NSMutableData *receivedData;




@end

