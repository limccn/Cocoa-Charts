//
//  CCSViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
//

#import "CCSViewController.h"
#import "CCSAppDelegate.h"
#import "CCSGridChartViewController.h"
#import "CCSLineChartViewController.h"
#import "CCSStickChartViewController.h"
#import "CCSMAStickChartViewController.h"
#import "CCSCandleStickChartViewController.h"
#import "CCSMACandleStickChartViewController.h"
#import "CCSPieChartViewController.h"
#import "CCSPizzaChartViewController.h"
#import "CCSSpiderWebChartViewController.h"


@interface CCSViewController ()

@end

@implementation CCSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Cocoa-Charts";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
        
    NSUInteger row = indexPath.row;
//    NSLog(@"%d",row);
    
    if (CCSChartTypeGridChart == row)
    {
        cell.textLabel.text = @"GridChart";
    }
    else if (CCSChartTypeLineChart == row)
    {
        cell.textLabel.text = @"LineChart";
    }
    else if (CCSChartTypeStickChart == row)
    {
        cell.textLabel.text = @"StickChart";
    }
    else if (CCSChartTypeMAStickChart == row)
    {
        cell.textLabel.text = @"MAStickChart";
    }
    else if (CCSChartTypeCandleStickChart == row)
    {
        cell.textLabel.text = @"CandleStickChart";
    }
    else if (CCSChartTypeMACandleStickChart == row)
    {
        cell.textLabel.text = @"MACandleStickChart";
    }
    else if (CCSChartTypePieChart == row)
    {
        cell.textLabel.text = @"PieChart";
    }
    else if (CCSChartTypePizzaChart == row)
    {
        cell.textLabel.text = @"PizzaChart";
    }
    else if (CCSChartTypeSpiderWebChart == row)
    {
        cell.textLabel.text = @"SpiderWebChart";
    }
    else
    {
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CCSAppDelegate *appDelegate = (CCSAppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSUInteger row = indexPath.row;
    //    NSLog(@"%d",row);

    if (CCSChartTypeGridChart == row)
    {
        CCSGridChartViewController *gridChartViewController = [[[CCSGridChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:gridChartViewController animated:YES];
    }
    else if (CCSChartTypeLineChart == row)
    {
        CCSLineChartViewController *lineChartViewController = [[[CCSLineChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:lineChartViewController animated:YES];
    }
    else if (CCSChartTypeStickChart == row)
    {
        CCSStickChartViewController *stickChartViewController = [[[CCSStickChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:stickChartViewController animated:YES];
    }
    else if (CCSChartTypeMAStickChart == row)
    {
        CCSMAStickChartViewController *MAStickChartViewController = [[[CCSMAStickChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:MAStickChartViewController animated:YES];
    }
    else if (CCSChartTypeCandleStickChart == row)
    {
        CCSCandleStickViewController *candleStickChartViewController = [[[CCSCandleStickViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:candleStickChartViewController animated:YES];
    }
    else if (CCSChartTypeMACandleStickChart == row)
    {
        CCSMACandleStickChartViewController *MACandleStickChartViewController = [[[CCSMACandleStickChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:MACandleStickChartViewController animated:YES];
    }
    else if (CCSChartTypePieChart == row)
    {
        CCSPieChartViewController *pieChartViewController = [[[CCSPieChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:pieChartViewController animated:YES];
    }
    else if (CCSChartTypePizzaChart == row)
    {
        CCSPizzaChartViewController *pizzaChartViewController = [[[CCSPizzaChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:pizzaChartViewController animated:YES];
    }
    else if (CCSChartTypeSpiderWebChart == row)
    {
        CCSSpiderWebChartViewController *pizzaChartViewController = [[[CCSSpiderWebChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:pizzaChartViewController animated:YES];
    }
    else
    {
        
    }
}

@end
