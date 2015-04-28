//
//  GRViewController.m
//  GitReference
//
//  Created by Douglas Voss on 4/27/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GRViewController.h"

@interface GRViewController ()

@end

@implementation GRViewController

static CGFloat margin = 15;
static NSString * const Command = @"command";
static NSString * const Reference = @"reference";
static NSString * const titleString = @"GitReference";


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
    CGRect scrollViewFrame = CGRectMake(0, 20, CGRectGetWidth(windowFrame), CGRectGetHeight(windowFrame));
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(windowFrame), CGRectGetHeight(windowFrame)*2.0);
    
    CGRect titleFrame = CGRectMake(0, 0, CGRectGetWidth(windowFrame), [self heightOfReferenceString:titleString]);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    [titleLabel setText:titleString];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:titleLabel];

    CGRect currentLineTextFrame;
    /*NSString *currentLineString;
    NSArray *textArray = [self gitCommands];
    for (int i=0; i<[textArray count]; i++) {
        //NSLog(@"textArray[%d] = %@", i, [textArray objectAtIndex:i]);
    }
    NSDictionary* dict = [NSDictionary dictionaryWithObjects:textArray
                                                     forKeys:[textArray valueForKey:@"command"]];
    NSLog(@"%@", dict);*/
    
    int i=1;
    CGRect commandLabelFrame;
    CGRect referenceLabelFrame;
    for (NSDictionary *gitCommand in [self gitCommands]) {
        NSString *command = gitCommand[Command];
        NSString *reference = gitCommand[Reference];
        
        //NSLog(@"command=%@; reference=%@", command, reference);
        
        commandLabelFrame = CGRectMake(0, (i*2)*[self heightOfReferenceString:command], CGRectGetWidth(scrollViewFrame), [self heightOfReferenceString:command]);
        UILabel *commandLabel = [[UILabel alloc] initWithFrame:commandLabelFrame];
        referenceLabelFrame = CGRectMake(0, ((i+1)*2)*[self heightOfReferenceString:reference], CGRectGetWidth(scrollViewFrame), [self heightOfReferenceString:reference]);
        UILabel *referenceLabel = [[UILabel alloc] initWithFrame:referenceLabelFrame];
        commandLabel.text = command;
        referenceLabel.text = reference;
        [scrollView addSubview:commandLabel];
        [scrollView addSubview:referenceLabel];
        i+=2;
    }
    
/*    NSDictionary *textDictionary = [self gitCommands];
    for (int i=0; i<[textDictionary count]; i++) {
        currentLineString = [textDictionary objectForKey:@"Command"];
        NSLog(@"currentLineString = %@", currentLineString);
        currentLineString = [textDictionary objectForKey:@"Reference"];
        NSLog(@"currentLineString = %@", currentLineString);
        currentLineTextFrame = CGRectMake(0, 40+(i*[self heightOfReferenceString:currentLineString]), CGRectGetWidth(windowFrame), [self heightOfReferenceString:currentLineString]);
        UILabel *line = [[UILabel alloc] initWithFrame:currentLineTextFrame];
        
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
