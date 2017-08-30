//
//  HomeVC.h
//  moviesApp
//
//  Created by Bhavik Darji on 29/08/17.
//  Copyright © 2017 Maulik Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController
{
    NSArray *arr_popularApiData,*arr_highestRatingApiData,*arr_theatresApiData;

}
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *sampleData;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@end
