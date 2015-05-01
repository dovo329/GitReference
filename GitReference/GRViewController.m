//
//  GRViewController.m
//  GitReference
//
//  Created by Douglas Voss on 4/27/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GRViewController.h"

static const CGFloat margin = 15;
static const CGFloat topMargin = 20;
static const CGFloat kStatusBarHeight = 20;
static NSString * const Command = @"command";
static NSString * const Reference = @"reference";
static NSString * const titleString = @"GitReference";


@interface GRViewController ()

@end

@implementation GRViewController


- (NSArray *)gitCommands {
    
    return @[@{Command: @"git status", Reference: @": shows changed files"},
             @{Command: @"git diff", Reference: @": shows actual changes"},
             @{Command: @"git add .", Reference: @": adds changed files to the commit"},
             @{Command: @"git commit -m \"notes\"", Reference: @": commits the changes"},
             @{Command: @"git push origin _branch_", Reference: @": pushes commits to branch named _branch_"},
             @{Command: @"git log", Reference: @": displays progress log"},
             @{Command: @"git comment --amend", Reference: @": re-enter last commit message"}
             ];
    
}

- (CGFloat)heightOfReferenceString:(NSString *)reference {
    
    CGRect bounding = [reference boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                              context:nil];
    
    return bounding.size.height;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    CGRect scrollViewFrame = CGRectMake(0, topMargin, self.view.frame.size.width, self.view.frame.size.height-topMargin);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    [self.view addSubview:scrollView];
    
    CGRect titleFrame = CGRectMake(0, 0, CGRectGetWidth(windowFrame), 2.0*[self heightOfReferenceString:titleString]);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    [titleLabel setText:titleString];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:30];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [scrollView addSubview:titleLabel];


    //int currentY=statusBar+heightOfTitleLabel;
    int currentY=kStatusBarHeight + titleFrame.size.height;
    CGRect commandLabelFrame;
    CGRect referenceLabelFrame;
    for (NSDictionary *gitCommand in [self gitCommands]) {
        NSString *commandString = [gitCommand valueForKey:@"command"];
        NSString *referenceString = [gitCommand valueForKey:@"reference"];
        
        //NSLog(@"currentY=%d; command=%@; reference=%@", currentY, commandString, referenceString);
        
        commandLabelFrame = CGRectMake(margin, currentY, CGRectGetWidth(scrollViewFrame)-(2.0*margin), [self heightOfReferenceString:commandString]);
        UILabel *commandLabel = [[UILabel alloc] initWithFrame:commandLabelFrame];
        commandLabel.text = commandString;
        commandLabel.numberOfLines = 0;
        [commandLabel sizeToFit];
        [scrollView addSubview:commandLabel];
        currentY += CGRectGetHeight(commandLabelFrame)+margin;
        
        referenceLabelFrame = CGRectMake(margin, currentY, CGRectGetWidth(scrollViewFrame)-(2.0*margin), [self heightOfReferenceString:referenceString]);
        UILabel *referenceLabel = [[UILabel alloc] initWithFrame:referenceLabelFrame];
        referenceLabel.text = referenceString;
        referenceLabel.numberOfLines = 0;
        [referenceLabel sizeToFit];
        [scrollView addSubview:referenceLabel];
        
        currentY += CGRectGetHeight(referenceLabelFrame)+(margin*2.0);
    }
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(windowFrame), currentY);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
