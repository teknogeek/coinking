//
//  DetailViewController.h
//  coinking
//
//  Created by CG3 on 6/26/14.
//  Copyright (c) 2014 CoinKing.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
