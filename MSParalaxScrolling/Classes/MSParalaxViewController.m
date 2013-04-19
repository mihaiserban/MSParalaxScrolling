//
//  MSParalaxViewController.m
//
//  Created by Mihai Serban on 4/20/13.
//  Copyright (c) 2013 http://flavors.me/mihaiserban. All rights reserved.
//  Distribuited under MIT License
//

#import "MSParalaxViewController.h"

@interface MSParalaxViewController () <UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *layerAScroll;
@property (nonatomic, retain) IBOutlet UIScrollView *layerBScroll;
@property (nonatomic, retain) IBOutlet UIScrollView *layerCScroll;

@end

@implementation MSParalaxViewController
@synthesize layerAScroll;
@synthesize layerBScroll;
@synthesize layerCScroll;

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View methods

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [layerAScroll setContentSize:CGSizeMake(1568, CGRectGetHeight(layerAScroll.frame))];
    [layerBScroll setContentSize:CGSizeMake(1825, CGRectGetHeight(layerBScroll.frame))];
    [layerCScroll setContentSize:CGSizeMake(2165, CGRectGetHeight(layerCScroll.frame))];
    
    [layerAScroll setDelegate:self];
    [layerBScroll setDelegate:self];
    [layerCScroll setDelegate:self];
    
    [self setupLayerA];
    [self setupLayerB];
    [self setupLayerC];
}

#pragma mark - Methods

-(void)setupLayerA
{
    //1568
    [self addImageViewAtPoint:CGPointMake(100, 100) andImage:[UIImage imageNamed:@"1.jpg"] onView:layerAScroll];
    [self addImageViewAtPoint:CGPointMake(260, 400) andImage:[UIImage imageNamed:@"2.jpg"] onView:layerAScroll];
    [self addImageViewAtPoint:CGPointMake(500, 200) andImage:[UIImage imageNamed:@"3.jpg"] onView:layerAScroll];
    [self addImageViewAtPoint:CGPointMake(730, 320) andImage:[UIImage imageNamed:@"4.jpg"] onView:layerAScroll];
}

-(void)setupLayerB
{
    //1825
    [self addImageViewAtPoint:CGPointMake(300, 370) andImage:[UIImage imageNamed:@"5.jpg"] onView:layerBScroll];
    [self addImageViewAtPoint:CGPointMake(1600, 450) andImage:[UIImage imageNamed:@"6.jpg"] onView:layerBScroll];
    [self addImageViewAtPoint:CGPointMake(1020, 230) andImage:[UIImage imageNamed:@"7.jpg"] onView:layerBScroll];
}

-(void)setupLayerC
{
    //2165
    [self addImageViewAtPoint:CGPointMake(100, 600) andImage:[UIImage imageNamed:@"8.jpg"] onView:layerCScroll];
    [self addImageViewAtPoint:CGPointMake(500, 400) andImage:[UIImage imageNamed:@"9.jpg"] onView:layerCScroll];
    [self addImageViewAtPoint:CGPointMake(1200, 300) andImage:[UIImage imageNamed:@"10.jpg"] onView:layerCScroll];
    [self addImageViewAtPoint:CGPointMake(1700, 250) andImage:[UIImage imageNamed:@"11.jpg"] onView:layerCScroll];
}

#pragma mark - Private Methods

-(UIImageView*)addImageViewAtPoint:(CGPoint)origin andImage:(UIImage*)image onView:(UIView*)view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(origin.x, origin.y, image.size.width, image.size.height)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [view addSubview:imageView];
    
    return imageView;
}

#pragma mark - UIScrollView delegate

-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender == layerCScroll) {
        
        CGSize contentSizeC = layerCScroll.contentSize;
        float widthC = contentSizeC.width - CGRectGetWidth(self.view.frame);
        float percentageC = sender.contentOffset.x * 100 / widthC;
        
        NSLog(@"%f content offset, percentage scroll = %f", sender.contentOffset.x,percentageC);
        
        //get content offset for layer b
        CGSize contentSizeB = layerBScroll.contentSize;
        float widthB = contentSizeB.width - CGRectGetWidth(self.view.frame);
        float contentOffsetB = widthB * percentageC / 100;
        
        [layerBScroll setContentOffset:CGPointMake(contentOffsetB, 0) animated:NO];
        //get content offset for layer a
        CGSize contentSizeA = layerAScroll.contentSize;
        float widthA = contentSizeA.width - CGRectGetWidth(self.view.frame);
        float contentOffsetA = widthA * percentageC / 100;
        
        [layerAScroll setContentOffset:CGPointMake(contentOffsetA, 0) animated:NO];
    }
    
}

#pragma mark - Other

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
