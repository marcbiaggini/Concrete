//
//  ArtistTableViewController.m
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "ArtistTableViewController.h"
#import "AppDelegate.h"
#import <UIScrollView+InfiniteScroll.h>



@interface ArtistTableViewController ()

@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,assign) NSUInteger noCells;
@property (nonatomic,assign) NSUInteger pagina;
@property (nonatomic,strong) ArtistaTableViewCell * artistaCell;
@property (nonatomic,strong) ShotsModel *artistaDetails;
@property (nonatomic,strong) UIImageView *artistaImage;
@property (nonatomic,strong) UIWindow* currentWindow ;
@property (nonatomic, strong) NSMutableSet *shownIndexes;
@property (nonatomic, assign) CATransform3D initialTransform;


@end


@implementation ArtistTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.5];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorsBG.png"]];
    tempImageView.alpha = 1;
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBarHidden=NO;
    self.artistaCell = [[ArtistaTableViewCell alloc]init];
    self.tableData = [[NSMutableArray alloc ] init];
    self.pagina = 1;
    [self getValues:[NSString stringWithFormat:@"%@",@(self.pagina)]];
    [self infiniteScroll];
  
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pushViewControllerAction:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
     [self checkNavItemButtonsWithInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation];
   
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.stockSearchBar.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.view.frame.size.width, 75);
    self.tableView.scrollIndicatorInsets = contentInsets;
    [self.tableView setLayoutMargins:contentInsets];
    //[self.tableView style:UITableViewStyleGrouped];

    [self.navigationController.view insertSubview:self.stockSearchBar aboveSubview:self.tableView];

}


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization.
    }
    return self;
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)checkNavItemButtonsWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stock.png"]];
    [self setShadow:self.navigationItem.titleView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"menured.png"]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"questionmark_blue.png"]];

    
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
        
        [kMainViewController showLeftViewAnimated:YES completionHandler:nil];
        return [RACSignal empty];
    }];
    
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
        //[self showCurtain];
        return [RACSignal empty];
    }];
    
    
}

-(void)showCurtain
{
    //[self.tableView setUserInteractionEnabled:NO];
    
        
       [self.navigationController.view addSubview:self.realTimeBlur];
    //[self.view sendSubviewToBack:self.tableView];
       // [self.view bringSubviewToFront:self.realTimeBlur];
        [self.navigationController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.realTimeBlur
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1
                                                                    constant:-self.navigationController.view.frame.size.height*0.001]];
        [self.navigationController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.realTimeBlur
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:-self.navigationController.view.frame.size.height]];
        [self.navigationController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.realTimeBlur
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1
                                                                    constant:-self.navigationController.view.frame.size.width*0.001]];
        [self.navigationController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.realTimeBlur
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1
                                                                    constant:-self.navigationController.view.frame.size.width*0.01]];
        
            [self.navigationController.view layoutIfNeeded];
    

    
}
-(void)getValues:(NSString*)page
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",@"http://api.dribbble.com/shots/popular?",[NSString stringWithFormat:@"%@%@",@"page=",page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    
    AFHTTPRequestOperation *operationArtista = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operationArtista.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationArtista setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *parsedObject = responseObject;
        NSDictionary *shots = [parsedObject objectForKey:@"shots"];
        if([shots isKindOfClass:[NSArray class]])
        {
            NSMutableArray *values = [[NSMutableArray alloc] init];
            values = [shots copy];
            NSMutableArray *artistData = [[NSMutableArray alloc] init];

            
            for(int i =0; i<values.count; i++)
            {
                NSDictionary *artist = [values objectAtIndex:i];
                
                ShotsModel * dataArtist = [[ShotsModel alloc]init];
                dataArtist.title = [artist objectForKey:@"title"];
                dataArtist.image_url = [artist objectForKey:@"image_url"];
                dataArtist.views_count = [artist objectForKey:@"views_count"];
                dataArtist.idArtist = [NSString stringWithFormat:@"%@",[artist objectForKey:@"id"]];
                dataArtist.descricao = [artist objectForKey:@"description"];

                [self validWSData:dataArtist];
                [artistData addObject:dataArtist];
                self.noCells = [artistData count];
                
            }
            [self.tableData addObjectsFromArray:artistData];
            self.pagina=self.pagina+1;
            [self.tableView reloadData];


            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                       message:[error localizedDescription]                                                       delegate:nil
                                             cancelButtonTitle:@"Retry"
                                             otherButtonTitles:@"Exit", nil];
        [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *buttonIndex) {
            if ([buttonIndex isEqual:@0]) {
                [self getValues:page];
            }else if ([buttonIndex isEqual:@1])
            {
                exit(0);
            }
        }];
        [alert show];
        
    }];
    [operationArtista start];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if([self.tableData count]>0)
        
        return [self.tableData count];
    else
        
        return self.noCells;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *simpleTableIdentifier = @"ArtistaCell";
        self.artistaCell = (ArtistaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    

  
    
    
    if (self.artistaCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArtistaTableViewCell" owner:self options:nil];
        
        self.artistaCell = [nib objectAtIndex:0];
        
    }

        if([self.tableData count]>0)
        {
            
            ShotsModel *imageCache = [self.tableData objectAtIndex:indexPath.row];
                        
            self.artistaCell.artistaTitle.text = [NSString stringWithFormat:@"%@",imageCache.title];
            [self.artistaCell likedObserver];

            self.artistaCell.artistaViewCounter.text = [NSString stringWithFormat:@"%@",imageCache.views_count];
            
            [self.artistaCell .artistaImage sd_setImageWithURL:[NSURL URLWithString:imageCache.image_url]
                              placeholderImage:[UIImage imageNamed:imageCache.idArtist]];
            
        }
        return self.artistaCell ;
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableData.count>0)
        return ((self.view.superview.frame.size.height)/2) - (self.view.superview.frame.size.height)*0.043;
    else
        return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selectionStyle = UITableViewCellSelectionStyleNone;
    ArtistaTableViewCell *cell = (ArtistaTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIImage *image = cell.artistaImage.image;
    self.artistaImage = [[UIImageView alloc] initWithImage:image];
    self.artistaDetails =[self.tableData objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       
                       
                       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                       
                       ArtistDetailsViewController *dest = [storyboard instantiateViewControllerWithIdentifier:@"ArtistDetails"];
                       
                       [dest setArtistaDetails:self.artistaDetails withImage:self.artistaImage.image];
                       
                       UINavigationController * navcont = [[UINavigationController alloc] initWithRootViewController: dest];
                       navcont.modalPresentationStyle = UIModalPresentationFullScreen;
                       navcont.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                       
                        UIViewController *viewController = [UIViewController new];
                        viewController.view.backgroundColor = [UIColor clearColor];

                       
                        [kNavigationController pushViewController:dest animated:YES];
                        [kMainViewController hideLeftViewAnimated:YES completionHandler:nil];
                       
                   });

}


-(void)validWSData:(ShotsModel *)artist
{
    if([artist.descricao isEqual:[NSNull null]])
    {
        artist.descricao = @"";
    }
    if([artist.image_url isEqual:[NSNull null]])//![artist.image_url isEqual:[NSNull null]]
    {
        artist.image_url = @"";
    }
    if([artist.title isEqual:[NSNull null]])//![artist.title isEqual:[NSNull null]]
    {
        artist.title = @"";
    }
    if([artist.views_count isEqual:[NSNull null]])//![artist.views_count isEqual:[NSNull null]]
    {
        artist.views_count = @"";
    }
    if([artist.idArtist isEqual:[NSNull null]])//![artist.idArtist isEqual:[NSNull null]]
    {
        artist.idArtist = @"";
    }
}

-(void)infiniteScroll
{
    self.tableView.delegate = self;
    
    // change indicator view style to white
    self.tableView.infiniteScrollIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    
    // setup infinite scroll
    [self.tableView addInfiniteScrollWithHandler:^(UITableView* tableView) {
        
        [self getValues:[NSString stringWithFormat:@"%@",@(self.pagina)]];
        
        // finish infinite scroll animation
        [self.tableView finishInfiniteScroll];
    }];
    
}

- (void)pushViewControllerAction:(UISwipeGestureRecognizer *)recognizer
{
    UIViewController *viewController = [UIViewController new];
    viewController.view.backgroundColor = [UIColor clearColor];
    viewController.title = @"Test";
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)setShadow:(UIView *) view
{
    CGSize shadowOffset = CGSizeMake(1.0, 1.0);
    float shadowOpacity = 0.5;
    CGColorRef shadowColor = [UIColor blackColor].CGColor;
    float shadowRadius = 0.6;
    
    view.layer.shadowOffset = shadowOffset;
    view.layer.shadowOpacity = shadowOpacity;
    view.layer.shadowColor = shadowColor;
    view.layer.shadowRadius = shadowRadius;
    
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    //[self.filteredCandyArray removeAllObjects];
    // Filter the array using NSPredicate
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    //filteredCandyArray = [NSMutableArray arrayWithArray:[candyArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
  
    
}*/

@end
