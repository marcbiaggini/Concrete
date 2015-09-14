//
//  ArtisDetailsViewController.m
//  Concrete
//
//  Created by TVTiOS-01 on 24/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "ArtistDetailsViewController.h"




@interface ArtistDetailsViewController ()
@property (nonatomic,strong) UIImageView *artistaImage;
@property  NSArray *tableData;


@end



@implementation ArtistDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.artistaCell = [[ArtistaTableViewCell alloc]init];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.exclusiveTouch=YES;
    self.tableData = [NSArray arrayWithObjects:@"Picture",@"Price", @"Contact",nil];
    self.view.backgroundColor = [UIColor clearColor];
    

    if(self.artistaDetails)
    {
        [self setArtistaView:self.artistaDetails];
        [self structureValidator];
        [self shareItems];

    }
    
    [self returnToMain];
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tableViewDetails.frame = self.view.frame;
    self.tableViewDetails.dataSource = self;
    self.tableViewDetails.delegate = self;
    [self.tableViewDetails setBackgroundView:nil];
    [self.tableViewDetails setBackgroundColor:[UIColor clearColor]];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    [self.tableViewDetails setLayoutMargins:contentInsets];

}

-(void)viewWillAppear:(BOOL)animated
{
    //[[self navigationController].navigationBar  setBackgroundImage:[UIImage imageNamed:@"colorsBG_converted.png"] forBarMetrics:UIBarMetricsDefault];
//    [self.view setBackgroundColor:[UIColor blackColor]];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorsBG.png"] ];
    backgroundView.alpha=0.8;
    backgroundView.frame = self.view.bounds;
    [[self view] addSubview:backgroundView];
    [[self view] sendSubviewToBack:backgroundView];
    self.view.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [[self navigationController].navigationBar  setBackgroundColor:[UIColor clearColor] ];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detalhes.png"]];
    [self setShadow:self.navigationItem.titleView];

    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[self navigationController].navigationBar.topItem setTitle:@"GO!"];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    //[self.backButton setTintColor:[UIColor whiteColor]];
    //[self.shareButton setTintColor:[UIColor whiteColor]];
}



-(BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) returnToMain
{
    self.backButton.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
        
        // present view controller
        ArtistTableViewController *viewController = [ArtistTableViewController new];
        
        LeftMenuTableViewController *viewController2 = [LeftMenuTableViewController new];
        viewController2.view.backgroundColor = [UIColor whiteColor];
        
        [kNavigationController setViewControllers:@[viewController2, viewController]];
        
        [kMainViewController hideLeftViewAnimated:YES completionHandler:nil];
        
        return [RACSignal empty];
    }];
}

-(void) shareItems
{
    self.shareButton.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
            
            
            NSLog(@"Postando: %@",@"Facebook");
        {
            self.mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
            self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
            
            /* NSString *FontName = [[UIFont systemFontOfSize:12] fontName];
             
             NSString *ArialBold = [[UIFont boldSystemFontOfSize:12] fontName];
             NSMutableAttributedString *adds= [[NSMutableAttributedString alloc] initWithString:address attributes:@{NSFontAttributeName: FontName}];
             
             
             NSMutableAttributedString *horario= [[NSMutableAttributedString alloc] initWithString:@"Horario de Atendimento: " attributes:@{NSFontAttributeName: ArialBold}];
             */
            NSString *vejaEuTitle = @"Veja Eu! Veja o que Eu Faço";
            NSString *descriptionArtist = [NSString stringWithFormat:@"%@",[self setStringfromHTMLFormat:self.artistaDetails.descricao]];
            NSString *contato = @"11-988776655";
            
            [self.mySLComposerSheet setTitle:vejaEuTitle];
            [self.mySLComposerSheet setInitialText:[NSString stringWithFormat:@"%@\n\n%@\n\n%@\n%@\n%@\n\n", vejaEuTitle,self.artistaDetails.title,descriptionArtist,@"Contato: ", contato]]; //the message you want to post
            UIImage *myImage = self.artistaImage.image;
            UIImageView  *FotoPromocao = [[UIImageView alloc] initWithImage: myImage];
            FotoPromocao.frame = CGRectMake(self.mySLComposerSheet.view.bounds.origin.x, self.mySLComposerSheet.view.bounds.origin.y, self.mySLComposerSheet.view.bounds.size.width *0.1, self.mySLComposerSheet.view.bounds.size.height *0.1);
            FotoPromocao.layer.masksToBounds = YES;
            FotoPromocao.layer.borderWidth = self.mySLComposerSheet.view.bounds.size.width/2;
            
            [self.mySLComposerSheet addImage:FotoPromocao.image];
        
           [self.mySLComposerSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/br/app/facebook/id284882215?mt=8"]];
            
            [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
        }
        [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Compartilhamento Cancelado";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Compartilhamento efetuado com Sucesso!";
                    break;
                default:
                    break;
            } //check if everything worked properly. Give out a message on the state.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }];
        
        return [RACSignal empty];
    
    }];
        
    
}



-(void) setArtistaDetails:(ShotsModel *)artistaDetails withImage:(UIImage*) artistaImage
{   self.artistaDetails = [[ShotsModel alloc]init];
    self.artistaDetails =artistaDetails;
    self.artistaImage=[[UIImageView alloc] initWithImage:artistaImage];
    NSLog(@"OK");
}

-(void)setArtistaView:(ShotsModel *)artista
{

}

-(NSString *) setStringfromHTMLFormat:(NSString *)htmlText
{
    if(htmlText&& ![htmlText isEqual:[NSNull null]])
    {NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlText dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        return [attrStr string];
        
    }else
        return @" ";
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    return YES;
}

-(void)structureValidator
{
    [[RACObserve(self.artistaDetails, descricao)
      filter:^BOOL(NSString *newDescricao) {
          return newDescricao.length==0;
      }]
     subscribeNext:^(NSString *newDescricao) {
         //self.artistaDescription.text = @"Description is not available for this artist!";
         NSLog(@"%@", newDescricao);
     }];
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

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return ((self.view.frame.size.height)*0.4);//22.f;
    else if(indexPath.row == 1)
        return (self.view.superview.frame.size.height)*0.37;
    else
        return (self.view.superview.frame.size.height)*0.14;

    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cellprincipal;
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    // Pega referencia da celula
    cellprincipal = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    self.artistaCell = (ArtistaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ArtistaCell"];
    
    
    
    self.priceCell = (PriceDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PriceCell"];
    
    self.contactCell =(ContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    // Verifica a referencia
    if (cellprincipal == nil)
    {
        // Inicializa a celula basica
        cellprincipal = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    
    
    
    
    if([[self.tableData objectAtIndex:indexPath.row] isEqualToString:@"Picture"])
    {
    
        if (self.artistaCell == nil)
        {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArtistaTableViewCell" owner:self options:nil];
        self.artistaCell = [nib objectAtIndex:0];
        
        }
        
        self.artistaCell.artistaTitle.text = self.artistaDetails.title;
        
        self.artistaCell.artistaViewCounter.text = [NSString stringWithFormat:@"%@",self.artistaDetails.views_count];
        self.artistaCell.artistaImage.image = self.artistaImage.image;
        
        [self.artistaCell likedObserver];
        

        
        //self.artistaDescription.text = [NSString stringWithFormat:@"%@",[self setStringfromHTMLFormat:artista.descricao]];
        cellprincipal = self.artistaCell;
    }
    
    
    
    
    if([[self.tableData objectAtIndex:indexPath.row] isEqualToString:@"Price"])
    {
        
        if (self.priceCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PriceDetailsTableViewCell" owner:self options:nil];
            self.priceCell = [nib objectAtIndex:0];
        }
        
        self.priceCell.descricaoTexto.text=[NSString stringWithFormat:@"%@",[self setStringfromHTMLFormat:self.artistaDetails.descricao]];
        
        cellprincipal = self.priceCell;
        
        
    }
    
    if([[self.tableData objectAtIndex:indexPath.row] isEqualToString:@"Contact"])
    {
        if (self.contactCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactTableViewCell" owner:self options:nil];
            self.contactCell = [nib objectAtIndex:0];
        }
//        if(self.artistaCell.playButton.selected)
//        self.contactCell.hidden=NO;
//        else
//        self.contactCell.hidden=YES;

        cellprincipal = self.contactCell;

    }

    
    
    return cellprincipal;
    
    
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
