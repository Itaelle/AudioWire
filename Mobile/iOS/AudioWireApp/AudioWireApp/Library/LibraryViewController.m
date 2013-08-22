//
//  LibraryViewController.m
//  AudioWireApp
//
//  Created by Derivery Guillaume on 8/3/13.
//  Copyright (c) 2013 Derivery Guillaume. All rights reserved.
//

#import "ArtistViewController.h"
#import "SubPlayer.h"
#import "LibraryViewController.h"

@implementation LibraryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Library", @"Library");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setUpNavLogo];
    
    // Loading View
    [super setUpLoadingView:_tb_list_artist];

    tableData = [NSArray arrayWithObjects:@"AC/DC",
                 @"Edith Piaf",
                 @"Electro Dance Party",
                 @"Gipsy King",
                 @"Infected Mushroom",
                 @"Jacques Prévert",
                 @"Justin Bieber",
                 @"Kamini",
                 @"Lorie",
                 @"Manau",
                 @"Nostradamus",
                 @"NTM",
                 @"Ozone",
                 @"PitBull",
                 @"Piwies",
                 @"Rolling Stones",
                 @"System of a down",
                 @"Taylor Swift",
                 @"U",
                 @"V",
                 nil];
    
    _tb_list_artist.delegate = self;
    _tb_list_artist.dataSource = self;
    
    SubPlayer *miniPlayer = [[[NSBundle mainBundle] loadNibNamed:@"SubPlayer" owner:self options:nil] objectAtIndex:0];
    [_viewForMiniPlayer addSubview:miniPlayer];
    [miniPlayer myInit];
    
    // Loading View
    [super cancelLoadingView:_tb_list_artist];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];

    // Go To Artiste Controller
    ArtistViewController *artist_controller = [[ArtistViewController alloc] initWithNibName:@"ArtistViewController" bundle:nil];
    [self.navigationController pushViewController:artist_controller animated:true];
    
    [artist_controller setTitle:[tableData objectAtIndex:indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"10 tracks";
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *alphabetical_indexes = [[NSMutableArray alloc] init];

    for (NSString *str in tableData)
    {
        NSString *temp = [str substringWithRange:NSMakeRange(0, 1)];

        if ([alphabetical_indexes containsObject:temp] == false)
        {
            [alphabetical_indexes insertObject:temp atIndex:[alphabetical_indexes count]];
        }
    }
    
    return alphabetical_indexes;
    //[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger newRow = [self indexForFirstChar:title inArray:tableData];

   // NSLog(@"Index to scroll to : %u", newRow);

    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRow inSection:0];
    [tableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];

    return index;
}

- (NSInteger)indexForFirstChar:(NSString *)character inArray:(NSArray *)array
{
    NSUInteger count = 0;
    for (NSString *str in array)
    {
        if ([str hasPrefix:character])
        {
            return count;
        }
        count++;
    }
    return 0;
}

@end