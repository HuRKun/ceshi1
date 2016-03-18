//
//  RKDiscoverHotelCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKDiscoverHotelCell.h"
#import "RKGlobalDefine.h"
#import <MapKit/MapKit.h>
@implementation RKDiscoverHotelCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)configeDataForCellWithIndexPath:(NSIndexPath *)indexPath hotel:(RKDiscoverHotel *)hotel
{
    CGFloat lon = [[RKLocationCity shareManager].lon doubleValue];
    CGFloat lat = [[RKLocationCity shareManager].lat doubleValue];
    // 计算距离
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:lat  longitude:lon];
    CLLocation *dis = [[CLLocation alloc] initWithLatitude:[hotel.lat doubleValue] longitude:[hotel.lng doubleValue]];
    CLLocationDistance distance = [orig distanceFromLocation:dis];
    [self.default_imageView sd_setImageWithURL:[NSURL URLWithString:hotel.default_image_m]];
    self.hotelNameLabel.text = hotel.hotel_name;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSArray *arr = [NSString extractWithRegionName:hotel.region_name];
    self.addressLabel.text = [arr lastObject];
    self.levelNameLabel.text = hotel.level_name;
    self.collectsLabel.text = hotel.collects;
    self.tablesLabel.text = [NSString stringWithFormat:@"%@桌",hotel.tables_num];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1fkm",distance/1000];
}

- (void)configeDataForCellWithIndexPath:(NSIndexPath *)indexPath company:(RKDiscoverCompany *)company
{
    [self.default_imageView sd_setImageWithURL:[NSURL URLWithString:company.default_image_m]];
    self.hotelNameLabel.text = company.company_name;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSArray *arr = [NSString extractWithRegionName:company.region_name];
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",arr[0],arr[1]];
    NSArray *leve = [NSString extractWithRegionName:company.cate_name];
    self.levelNameLabel.text = [leve firstObject];
    self.collectsLabel.text = company.collects;
    self.tablesLabel.text = [NSString stringWithFormat:@"作品 %@",company.product_num];
}

- (void)configeDataForCellWithIndexPath:(NSIndexPath *)indexPath team:(RKDiscoverTeam *)team
{
    [self.default_imageView sd_setImageWithURL:[NSURL URLWithString:team.default_image_m]];
    self.hotelNameLabel.text = team.team_name;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSArray *arr = [NSString extractWithRegionName:team.region_name];
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",arr[0],arr[1]];
    self.levelNameLabel.text = team.belong_company;
    self.collectsLabel.text = team.collects;
    self.tablesLabel.text = [NSString stringWithFormat:@"作品 %@",team.product_num];
}

@end
