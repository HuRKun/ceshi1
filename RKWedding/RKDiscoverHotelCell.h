//
//  RKDiscoverHotelCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKDiscoverHotel.h"
#import "RKDiscoverCompany.h"
#import "RKDiscoverTeam.h"
@interface RKDiscoverHotelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *default_imageView;

@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tablesLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberImage;

- (void)configeDataForCellWithIndexPath:(NSIndexPath *)indexPath hotel:(RKDiscoverHotel *)hotel;

- (void)configeDataForCellWithIndexPath:(NSIndexPath *)indexPath company:(RKDiscoverCompany *)company;

- (void)configeDataForCellWithIndexPath:(NSIndexPath *)indexPath team:(RKDiscoverTeam *)team;
@end
