package com.ntu.igts.service;

import com.ntu.igts.model.Commodity;
import com.ntu.igts.model.container.CommodityQueryResult;
import com.ntu.igts.model.container.Query;

public interface CommodityService {

    public Commodity getCommodityById(String token, String commodityId);

    public CommodityQueryResult getCommoditiesBySearchTerm(String token, Query query);

}
