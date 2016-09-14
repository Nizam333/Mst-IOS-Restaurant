//
//  Menu.m
//  Storyboard
//
//Just updated MainViewController and DrawerTableViewController (both programmed in Swift)
//to objectiveC version (MainViewControllerObjc and Menu), this way will be easier to implement on Objective-c Projects.
//
//  Created by Daniel Rosero on 22/01/16.
//  Copyright © 2016 Kyohei Yamaguchi. All rights reserved.
//

#import "Menu.h"
#import "MainViewControllerObjc.h"
#import "Restaurant-Swift.h"




@implementation Menu

- (void)viewDidLoad:(BOOL)animated{
    [super viewDidLoad];
    
    
    
       // [item release];
    //bar.item.title= @"jkdhsa"
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath{
    
   
    [tableView deselectRowAtIndexPath:newIndexPath animated:YES];
    
    KYDrawerController *elDrawer = (KYDrawerController*)self.navigationController.parentViewController;
    MainViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainController"];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:viewController];
    
    //NSString *myObjcData = @"from Objective-C";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
   

    
    
    switch ([newIndexPath row]) {
        
        case 0:{
            
            
            [defaults setValue:@0 forKey:@"data"];
            [defaults synchronize];
            
            //[viewController.view setBackgroundColor:[UIColor redColor]];
           // [viewController.navigationItem setTitle:@"Main Menu"];
            
            
            break;
        }
        case 1:{
            
            
           
            [defaults setValue:@1 forKey:@"data"];
            [defaults synchronize];

                     
            //[viewController.view setBackgroundColor:[UIColor redColor]];
            //[viewController.navigationItem setTitle:@"Main Menu"];
            
           
            break;
        }
        
        case 2:{
            
            [defaults setValue:@2 forKey:@"data"];
            [defaults synchronize];

             //[viewController.view setBackgroundColor:[UIColor blueColor]];
            // [viewController.navigationItem setTitle:@"My Order"];
            
            break;
        }
            
        case 3:{
            
            [defaults setValue:@3 forKey:@"data"];
            [defaults synchronize];
            //[viewController.view setBackgroundColor:[UIColor blackColor]];
           // [viewController.navigationItem setTitle:@"Reservations"];
            
            break;
        }
            
        case 4:{
            
            [defaults setValue:@4 forKey:@"data"];
            [defaults synchronize];
            
            //[viewController.view setBackgroundColor:[UIColor blackColor]];
             //[viewController.navigationItem setTitle:@"Rewards"];
            
            break;
        }
        case 5:{
            
            [defaults setValue:@5 forKey:@"data"];
            [defaults synchronize];
            //[viewController.view setBackgroundColor:[UIColor blackColor]];
           //  [viewController.navigationItem setTitle:@"Gift Cards"];
            
            break;
        }
        case 6:{
            
            [defaults setValue:@6 forKey:@"data"];
            [defaults synchronize];
           // [viewController.view setBackgroundColor:[UIColor blackColor]];
            // [viewController.navigationItem setTitle:@"My Profile"];
            
            break;
        }
        case 7:{
            [defaults setValue:@7 forKey:@"data"];
            [defaults synchronize];
           // [viewController.view setBackgroundColor:[UIColor blackColor]];
             //[viewController.navigationItem setTitle:@"Call Us"];
            
            break;
        }
        case 8:{
            
            [defaults setValue:@8 forKey:@"data"];
            [defaults synchronize];
           // [viewController.view setBackgroundColor:[UIColor blackColor]];
             //[viewController.navigationItem setTitle:@"Terms and Conditions"];
            
            break;
        }
            
        default:{
            
            [defaults setValue:@1 forKey:@"data"];
            [defaults synchronize];
            // [viewController.view setBackgroundColor:[UIColor whiteColor]];
            // [viewController.navigationItem setTitle:@"Main Menu"];
            
            
            break;
        }
            
            
            
        
    }
     elDrawer.mainViewController=navController;
    [elDrawer setDrawerState:DrawerStateClosed animated:YES];
}
@end
