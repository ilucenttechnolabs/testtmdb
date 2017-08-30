//
//  HomeVC.m
//  moviesApp
//
//  Created by Bhavik Darji on 29/08/17.
//  Copyright © 2017 Maulik Patel. All rights reserved.
//

#import "HomeVC.h"
#import "homeCell.h"
#import "Reachability.h"
#import "emptyCell.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.sampleData = @[ @{ @"description": @"New in Theatres",
                            @"articles": @[ @{ @"title": @"Article A1" },
                                            @{ @"title": @"Article A2" },
                                            @{ @"title": @"Article A3" },
                                            @{ @"title": @"Article A4" },
                                            @{ @"title": @"Article A5" }
                                            ]
                            },
                         @{ @"description": @"Popular",
                            @"articles": @[ @{ @"title": @"Article B1" },
                                            @{ @"title": @"Article B2" },
                                            @{ @"title": @"Article B3" },
                                            @{ @"title": @"Article B4" },
                                            @{ @"title": @"Article B5" }
                                            ]
                            },
                         @{ @"description": @"Highest Rated This Year",
                            @"articles": @[ @{ @"title": @"Article C1" },
                                            @{ @"title": @"Article C2" },
                                            @{ @"title": @"Article C3" },
                                            @{ @"title": @"Article C4" },
                                            @{ @"title": @"Article C5" }
                                            ]
                            },
                         ];
    
    // Register the table cell
    [self.tableview registerClass:[homeCell class] forCellReuseIdentifier:@"homeCell"];
    
    // Add observer that will allow the nested collection cell to trigger the view controller select row at index path
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
    
    [self popular_Api_Called];
    [self highestRating_Api_Called];
    [self theatres_Api_Called];
    
    
}
-(void)popular_Api_Called
{
    
    NSString *strApi=@"popular";
    NSString *apiKey=@"api_key=fe1d30f8225a5e669549bba40b21b4b0";
    [self api_callGetApi:strApi withparams:apiKey sucess:^(id response)
     {
         
         if([response objectForKey:@"results"])
         {
             arr_popularApiData =[response objectForKey:@"results"];
             [self.tableview reloadData];
         }
         else
         {
             arr_popularApiData =nil;
             [self.tableview reloadData];

         }
         
     } failure:^(NSError *error)
     {
         arr_popularApiData =nil;
         [self.tableview reloadData];
     }];

}
-(void)highestRating_Api_Called
{
    
    NSString *strApi=@"top_rated";
    NSString *apiKey=@"api_key=fe1d30f8225a5e669549bba40b21b4b0";
    [self api_callGetApi:strApi withparams:apiKey sucess:^(id response)
     {
         
         if([response objectForKey:@"results"])
         {
             arr_highestRatingApiData=[response objectForKey:@"results"];
             [self.tableview reloadData];
         }
         else
         {
             arr_highestRatingApiData=nil;
             [self.tableview reloadData];

         }
         
     } failure:^(NSError *error)
     {
         arr_highestRatingApiData=nil;
         [self.tableview reloadData];

     }];
    
}
-(void)theatres_Api_Called
{
    [self.indicator startAnimating];
    NSString *strApi=@"now_playing";
    NSString *apiKey=@"api_key=fe1d30f8225a5e669549bba40b21b4b0";
    [self api_callGetApi:strApi withparams:apiKey sucess:^(id response)
     {
         [self.indicator stopAnimating];

         if([response objectForKey:@"results"])
         {
             arr_theatresApiData=[response objectForKey:@"results"];
             [self.tableview reloadData];
         }
         else
         {
             arr_theatresApiData=nil;
             [self.tableview reloadData];

         }
         
     } failure:^(NSError *error)
     {
         
         [self.indicator stopAnimating];

         arr_theatresApiData=nil;
         [self.tableview reloadData];

     }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didSelectItemFromCollectionView" object:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    

    

    if(indexPath.section==0)
    {
        if(arr_theatresApiData==nil || [arr_theatresApiData count]==0)
        {
//            UITableViewCell *cellEmpty=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//            cellEmpty.textLabel.text=@"No theatre movie found...!!";
//            cellEmpty.textLabel.textAlignment=NSTextAlignmentCenter;
//            tableView.allowsSelection=NO;
//            return cellEmpty;
            
//            emptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
//            cell.textLabel.text=@"No theatre movie found...!!";
//            return cell;
            
            static NSString *CellIdentifier = @"emptyCell";
            emptyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"emptyCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.lblTitle.text=@"No theatre movie found...!!";
            
            return cell;

            
        }
        else
        {
        
            homeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
            [cell setCollectionData:arr_theatresApiData];
            return cell;

        }
        
        


    }
    else if(indexPath.section==1)
    {
        
        if(arr_popularApiData==nil || [arr_popularApiData count] == 0)
        {
//            UITableViewCell *cellEmpty=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//            cellEmpty.textLabel.text=@"No popular movie found...!!";
//            cellEmpty.textLabel.textAlignment=NSTextAlignmentCenter;
//            tableView.allowsSelection=NO;
//            return cellEmpty;
            
//            emptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
//            cell.textLabel.text=@"No popular movie found...!!";
            
            static NSString *CellIdentifier = @"emptyCell";
            emptyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"emptyCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.lblTitle.text=@"No popular movie found...!!";

            return cell;


        }
        else
        {
        
            homeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
            
            [cell setCollectionData:arr_popularApiData];
            return cell;
            
            
            

        }



    }
    else
    {
        
        if(arr_highestRatingApiData==nil || [arr_highestRatingApiData count] == 0)
        {
//            UITableViewCell *cellEmpty=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//            cellEmpty.textLabel.text=@"No highest rating movie found...!!";
//            cellEmpty.textLabel.textAlignment=NSTextAlignmentCenter;
//            tableView.allowsSelection=NO;
//            return cellEmpty;
//            emptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
//            cell.textLabel.text=@"No highest rating movie found...!!";
//            return cell;
            
            static NSString *CellIdentifier = @"emptyCell";
            emptyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"emptyCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.lblTitle.text=@"No highest rating movie found...!!";
            
            return cell;


            
        }
        else
        {
            homeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
            [cell setCollectionData:arr_highestRatingApiData];
            return cell;

        }
        

    }
        
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This code is commented out in order to allow users to click on the collection view cells.
    //    if (!self.detailViewController) {
    //        self.detailViewController = [[ORGDetailViewController alloc] initWithNibName:@"ORGDetailViewController" bundle:nil];
    //    }
    //    NSDate *object = _objects[indexPath.row];
    //    self.detailViewController.detailItem = object;
    //    [self.navigationController pushViewController:self.detailViewController animated:YES];
}



#pragma mark UITableViewDelegate methods


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSDictionary *sectionData = [self.sampleData objectAtIndex:section];
//    NSString *header = [sectionData objectForKey:@"description"];
//    return header;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-20, 20)];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    NSDictionary *sectionData = [self.sampleData objectAtIndex:section];
    NSString *header = [sectionData objectForKey:@"description"];
    /* Section header is in 0th index... */
    [label setText:header];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220.0;
}


#pragma mark - NSNotification to select table cell

- (void) didSelectItemFromCollectionView:(NSNotification *)notification
{
    NSDictionary *cellData = [notification object];
    if (cellData)
    {
//        if (!self.detailViewController)
//        {
//            self.detailViewController = [[ORGDetailViewController alloc] initWithNibName:@"ORGDetailViewController" bundle:nil];
//        }
//        self.detailViewController.detailItem = cellData;
//        [self.navigationController pushViewController:self.detailViewController animated:YES];
    }
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)api_callGetApi:(NSString *)apiName withparams:(NSString *)parameters sucess:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    
    
    if ([self isInternetAvailable])
    {
        NSString *url=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?%@",apiName,parameters];
        NSLog(@"%@",url);
        /**/
        //        NSString *url = [NSString stringWithFormat:@"%@news_comment_add.php?user_id=%@&news_id=%@&comment=%@&secure_key=%@",app.str_url_v2,app.str_loginid,[reciveDict objectForKey:@"news_id"],textView.text,app.str_CompanyUniqueKey];
        
        NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:120];
        [request setHTTPMethod:@"GET"];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSMutableDictionary*dictData =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 NSLog(@"responce :: %@",dictData);
                 success(dictData);
                 
             }else
             {
                 NSLog(@"connectionError :: %@",connectionError);
                 failure(connectionError);
                 
                 NSInteger code=4294966291;
                 NSInteger code1=4294966295;
                 if(connectionError.code==code || connectionError.code==code1)
                 {
                     NSLog(@"Time OUT");
                 }
             }
             
         }];
        
    }
    else
    {
        [self.indicator stopAnimating];
    }
    
}


#pragma  mark check internet connectivity


-(BOOL)isInternetAvailable
{
    BOOL isInternetAvailable = false;
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
            isInternetAvailable = FALSE;
            break;
        case ReachableViaWWAN:
            isInternetAvailable = TRUE;
            break;
        case ReachableViaWiFi:
            isInternetAvailable = TRUE;
            break;
    }
    [internetReach stopNotifier];
    return isInternetAvailable;
}


@end
