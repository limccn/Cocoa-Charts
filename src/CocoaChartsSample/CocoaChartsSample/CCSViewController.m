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
#import "CCSMinusStickChartViewController.h"
#import "CCSMACDChartViewController.h"
#import "CCSAreaChartViewController.h"
#import "CCSStackedAreaChartViewController.h"
#import "CCSBandAreaChartViewController.h"
#import "CCSRadarChartViewController.h"


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
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
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
    else if (CCSChartTypeMinusStickChart == row)
    {
        cell.textLabel.text = @"MinusStickChart";
    }
    else if (CCSChartTypeMACDChart == row)
    {
        cell.textLabel.text = @"MACDChart";
    }
    else if (CCSChartTypeAreaChart == row)
    {
        cell.textLabel.text = @"AreaChart";
    }
    else if (CCSChartTypeStackedAreaChart == row)
    {
        cell.textLabel.text = @"StackedAreaChart";
    }
    else if (CCSChartTypeBandAreaChart == row)
    {
        cell.textLabel.text = @"BandAreaChart";
    }
    else if (CCSChartTypeRadarChart == row)
    {
        cell.textLabel.text = @"RadarChart";
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
        CCSSpiderWebChartViewController *spiderWebChartViewController = [[[CCSSpiderWebChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:spiderWebChartViewController animated:YES];
    }
    else if (CCSChartTypeMinusStickChart == row)
    {
        CCSMinusStickChartViewController *minusStickChartViewController = [[[CCSMinusStickChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:minusStickChartViewController animated:YES];
    }
    else if (CCSChartTypeMACDChart == row)
    {
        CCSMACDChartViewController *macdChartViewController = [[[CCSMACDChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:macdChartViewController animated:YES];
    }
    else if (CCSChartTypeAreaChart == row)
    {
        CCSAreaChartViewController *areaChartViewController = [[[CCSAreaChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:areaChartViewController animated:YES];
    }
    else if (CCSChartTypeStackedAreaChart == row)
    {
        CCSStackedAreaChartViewController *stackedAreaChartViewController = [[[CCSStackedAreaChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:stackedAreaChartViewController animated:YES];
    }
    else if (CCSChartTypeBandAreaChart == row)
    {
        CCSBandAreaChartViewController *bandAreaChartViewController = [[[CCSBandAreaChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:bandAreaChartViewController animated:YES];
    }
    else if (CCSChartTypeRadarChart == row)
    {
        CCSRadarChartViewController *radarChartViewController = [[[CCSRadarChartViewController alloc]init]autorelease];
        [appDelegate.viewController pushViewController:radarChartViewController animated:YES];
    }
    else
    {
        
    }
}

@end
