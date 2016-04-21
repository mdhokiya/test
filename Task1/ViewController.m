//
//  ViewController.m
//  Task1
//
//  Created by HeenalShah on 26/02/16.
//  Copyright © 2016 HeenalShah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end
NSDictionary *jsondic;
NSArray *keyarr;
NSMutableArray *sectionarr,*arr1;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.sportonapp.com/AndroidWebService/SportsOn.asmx/GetNFLMatchFromDate"]];
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = @"Date=2016-02-25&Timezone=05:30&Timezonestring=plus";
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
   
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    [connection start];
    NSURLResponse *response = [[NSURLResponse alloc] init];
    [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
    NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@" ,htmlSTR);
    NSData *jsonData = [htmlSTR dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary *jsondic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    keyarr=[jsondic allKeys];
    arr1=[jsondic valueForKey:@"date4"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //test comment
    
    return arr1.count;
//    if (keyarr.count>0)
//    {
//        sectionarr=[jsondic valueForKey:[keyarr objectAtIndex:section]];
//        return sectionarr.count;
//    }
//    else        return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if (arr1.count>0)
    {
        
        
          UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100,50,70,70)];
        label.text =[NSString stringWithFormat:@"%@",[[arr1 objectAtIndex:indexPath.row] valueForKey:@"HomeTeamName"]];
         label.backgroundColor = [UIColor whiteColor];
         label.textAlignment = NSTextAlignmentCenter;
         label.textColor = [UIColor blackColor];
         label.numberOfLines = 2;
        [label setFont: [label.font fontWithSize:12]];
         label.lineBreakMode = UILineBreakModeWordWrap;
         [cell addSubview:label];
        
        UIImageView *Image=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width*0.10,tableView.frame.size.height*0.10,60,60)];
        [cell addSubview:Image];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[arr1 objectAtIndex:indexPath.row] objectForKey:@"HomeTeamLogo"]]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error)
        {
           if (!error)
           {
               Image.image = [UIImage imageWithData:data];
           }
            
        }];
    }
    

        return cell;
}

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return keyarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}

//http://www.goalserve.com/getfeed/4084236268d146eb8dfa5e7eed01f108/soccerstats/team/9260
//where 9260 is a team id
//aa URL ma image kari ne tag 6e
//aano use kari ne image set kari
//for team flag you have to use this url http://www.sportonapp.com/AppData/images/Soccer/soccer_team_(teamid).png
@end
