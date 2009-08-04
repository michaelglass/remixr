Remixr.api_key = 'OU812' # get yours from http://remix.bestbuy.com/apps/register
client = Remixr::Client.new

# fetch first page of products on sale below 20 bucks
products = client.products({:salePrice => {'$lt' => 20.00}}).fetch.products

products.first
# => {"url"=>"http://www.bestbuy.com/site/olspage.jsp?skuId=7524468&type=product&id=1494684&cmp=RMX&ky=1uYnAnk1pohGgQVwEClo8PHv4SN4C5MeL", "inStoreAvailability"=>true, "albumLabel"=>nil, "genre"=>nil, "sku"=>7524468, "affiliateUrl"=>nil, "cjAffiliateAddToCartUrl"=>nil, "salesRankLongTerm"=>2451, "addToCartUrl"=>"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=1uYnAnk1pohGgQVwEClo8PHv4SN4C5MeL&qvsids=7524468", "remoteControlImage"=>nil, "affiliateAddToCartUrl"=>nil, "largeImage"=>nil, "new"=>false, "salePrice"=>15.99, "artistId"=>"BYPart1061717", "inStoreAvailabilityUpdateDate"=>"2007-07-27T20:20:50", "largeFrontImage"=>nil, "department"=>"VIDEO/COMPACT DISC", "artistName"=>"Purple City", "accessoriesImage"=>nil, "format"=>"CD", "customerReviewCount"=>nil, "regularPrice"=>15.99, "amgId"=>nil, "freeShipping"=>false, "salesRankShortTerm"=>250, "shortDescription"=>nil, "specialOrder"=>false, "nationalFeatured"=>false, "manufacturer"=>nil, "salesRankMediumTerm"=>570, "energyGuideImage"=>nil, "inStoreAvailabilityText"=>"Store Pickup: Limited Availability", "alternateViewsImage"=>nil, "mobileUrl"=>"http://m.bestbuy.com/r/1494684/7524468/", "subclass"=>"RAP", "name"=>"\"Paris to Purple City\"", "cjAffiliateUrl"=>nil, "image"=>"http://images.bestbuy.com/BestBuy_US/images/products/7524/7524468.jpg", "shippingCost"=>1.59, "subclassId"=>1009, "upc"=>"823979901426", "onlineAvailabilityText"=>"Shipping: Usually leaves our warehouse in 1 business day", "onlineAvailabilityUpdateDate"=>"2007-07-27T20:20:50", "topViewImage"=>nil, "class"=>"COMPACT DISC", "active"=>true, "classId"=>77, "parentalAdvisory"=>false, "thumbnailImage"=>"http://images.bestbuy.com/BestBuy_US/images/products/7524/7524468s.jpg", "leftViewImage"=>nil, "rightViewImage"=>nil, "productId"=>1494684, "source"=>"bestbuy", "customerReviewAverage"=>nil, "activeUpdateDate"=>"2007-07-27T20:20:50", "mediumImage"=>nil, "startDate"=>#<Date: 4906945/2,0,2299161>, "departmentId"=>8, "angleImage"=>nil, "albumVersion"=>nil, "spin360Url"=>nil, "priceUpdateDate"=>"2008-02-09T00:10:37", "categoryPath"=>[<Mash id="cat00000" name="Best Buy">, <Mash id="abcat0600000" name="Music & Movies">, <Mash id="cat02001" name="Music">, <Mash id="cat02012" name="Rap & Hip-Hop">, <Mash id="cat02719" name="Rap">], "printOnly"=>false, "releaseDate"=>#<Date: 4907365/2,0,2299161>, "search"=>nil, "copyright"=>nil, "onSale"=>false, "itemUpdateDate"=>"2009-02-03T03:50:13", "albumTitle"=>"\"Paris to Purple City\"", "type"=>"Music", "originalReleaseDat


# fetch only SKU and salePrice 
products = client.products({:salePrice => {'$lt' => 20.00}}).fetch.products
# => [{"salePrice"=>10.99, "sku"=>7000032}, {"salePrice"=>10.99, "sku"=>11467058}, {"salePrice"=>13.99, "sku"=>7873884}, {"salePrice"=>11.99, "sku"=>15444798}, {"salePrice"=>13.99, "sku"=>9113256}, {"salePrice"=>13.99, "sku"=>5797649}, {"salePrice"=>13.99, "sku"=>8890961}, {"salePrice"=>14.99, "sku"=>17338506}, {"salePrice"=>11.99, "sku"=>9242642}, {"salePrice"=>13.99, "sku"=>9171353}]