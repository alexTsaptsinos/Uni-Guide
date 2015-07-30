//
//  CompareCollectionViewLayout.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 18/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "CompareCollectionViewLayout.h"

//#define NUMBEROFCOLUMNS 3

@interface CompareCollectionViewLayout ()
@property (strong, nonatomic) NSMutableArray *itemAttributes;
@property (strong, nonatomic) NSMutableArray *itemsSize;
@property (nonatomic, assign) CGSize contentSize;
@end

@implementation CompareCollectionViewLayout

@synthesize numberOfColumns;

- (void)prepareLayout
{
    NSArray *comparesArray = [Compares readAllObjects];
    if (comparesArray.count == 0) {
        self.numberOfColumns = 0;
    } else if (comparesArray.count == 1) {
        self.numberOfColumns = 2;
    } else {
        self.numberOfColumns = 3;
    }
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    
    NSUInteger column = 0; // Current column inside row
    CGFloat xOffset = 0.0;
    CGFloat yOffset = 0.0;
    CGFloat contentWidth = 0.0; // To determine the contentSize
    CGFloat contentHeight = 0.0; // To determine the contentSize
    
    if (self.itemAttributes.count > 0) { // We don't enter in this if statement the first time, we enter the following times
        for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
            NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            for (NSUInteger index = 0; index < numberOfItems; index++) {
                if (section != 0 && index != 0) { // This is a content cell that shouldn't be sticked
                    continue;
                }
                UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section]];
                if (section == 0) { // We stick the first row
                    CGRect frame = attributes.frame;
                    frame.origin.y = self.collectionView.contentOffset.y;
                    attributes.frame = frame;
                    
                }
                if (index == 0) { // We stick the first column
                    CGRect frame = attributes.frame;
                    frame.origin.x = self.collectionView.contentOffset.x;
                    attributes.frame = frame;
                }
            }
        }
        
        return;
    }
    
    // The following code is only executed the first time we prepare the layout
    self.itemAttributes = [@[] mutableCopy];
    self.itemsSize = [@[] mutableCopy];
    
    // Tip: If we don't know the number of columns we can call the following method and use the NSUInteger object instead of the NUMBEROFCOLUMNS macro
    // NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    
    // We calculate the item size of each column
    if (self.itemsSize.count != self.numberOfColumns) {
        [self calculateItemsSize];
    }
    
    // We loop through all items
    for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
        NSMutableArray *sectionAttributes = [@[] mutableCopy];
        for (NSUInteger index = 0; index < self.numberOfColumns; index++) {
            CGSize itemSize = [self.itemsSize[index] CGSizeValue];
            
            // We create the UICollectionViewLayoutAttributes object for each item and add it to our array.
            // We will use this later in layoutAttributesForItemAtIndexPath:
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            
            if (section == 0 && index == 0) {
                attributes.zIndex = 1024; // Set this value for the first item (Sec0Row0) in order to make it visible over first column and first row
            } else if (section == 0 || index == 0) {
                attributes.zIndex = 1023; // Set this value for the first row or section in order to set visible over the rest of the items
            }
            if (section == 0) {
                CGRect frame = attributes.frame;
                frame.origin.y = self.collectionView.contentOffset.y;
                attributes.frame = frame; // Stick to the top
            }
            if (index == 0) {
                CGRect frame = attributes.frame;
                frame.origin.x = self.collectionView.contentOffset.x;
                attributes.frame = frame; // Stick to the left
            }
            
            [sectionAttributes addObject:attributes];
            
            xOffset = xOffset+itemSize.width;
            column++;
            
            // Create a new row if this was the last column
            if (column == self.numberOfColumns) {
                if (xOffset > contentWidth) {
                    contentWidth = xOffset;
                }
                
                // Reset values
                column = 0;
                xOffset = 0;
                yOffset += itemSize.height;
            }
        }
        [self.itemAttributes addObject:sectionAttributes];
    }
   // NSLog(@"attributes %@ and length: %lu",self.itemAttributes,(unsigned long)self.itemAttributes.count);
   // NSLog(@"sizes: %@ and length: %lu",self.itemsSize,self.itemsSize.count);
    
    // Get the last item to calculate the total height of the content
    UICollectionViewLayoutAttributes *attributes = [[self.itemAttributes lastObject] lastObject];
    contentHeight = attributes.frame.origin.y+attributes.frame.size.height;
    self.contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemAttributes[indexPath.section][indexPath.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [@[] mutableCopy];
    for (NSArray *section in self.itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
            return CGRectIntersectsRect(rect, [evaluatedObject frame]);
        }]]];
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES; // Set this to YES to call prepareLayout on every scroll
}

- (CGSize)sizeForItemWithColumnIndex:(NSUInteger)columnIndex
{
    NSString *text;
    switch (columnIndex) { // This only makes sense if the size of the items should be different
        case 0:
            text = @"Col 0";
            break;
        case 1:
            text = @"Col 1";
            break;
        case 2:
            text = @"Col 2";
            break;
        case 3:
            text = @"Col 3";
            break;
        case 4:
            text = @"Col 4";
            break;
        case 5:
            text = @"Col 5";
            break;
        case 6:
            text = @"Col 6";
            break;
        case 7:
            text = @"Col 7";
            break;
            
        default:
            break;
    }
//    CGSize size = [text sizeWithAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]}];
//    if (columnIndex == 0) {
//        size.width -= 32; // In our design the first column should be the widest one
//    }
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    CGFloat widthFloat = screenBound.size.width;
   // CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    //return CGSizeMake([@(size.width + 50) floatValue], 80); // Extra space of 9px for all the items
    if (columnIndex == 1) {
        return CGSizeMake(widthFloat/3-14, 80);
    } else {
    return CGSizeMake(widthFloat/3+7, 80);
    }
}

- (void)calculateItemsSize
{
    for (NSUInteger index = 0; index < self.numberOfColumns; index++) {
        if (self.itemsSize.count <= index) {
            CGSize itemSize = [self sizeForItemWithColumnIndex:index];
            NSValue *itemSizeValue = [NSValue valueWithCGSize:itemSize];
            [self.itemsSize addObject:itemSizeValue];
        }
    }
}


@end
