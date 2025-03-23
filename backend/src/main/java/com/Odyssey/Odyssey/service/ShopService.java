package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.Request.CreateShopRequest;
import com.Odyssey.Odyssey.dto.ShopDTO;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.model.User;

import java.util.List;

public interface ShopService {

    public Shop createShop(CreateShopRequest req, User user);

    public Shop updateShop(Long shopId, CreateShopRequest updateRequest) throws Exception;

    public void deleteShop(Long shopId) throws Exception;

    public List<Shop> getAllShops() throws Exception;

    public List<Shop> searchShops(String keyword);

    public Shop findShopById(Long ID) throws Exception;

    public Shop findShopByUserId(Long userId) throws Exception;

    public ShopDTO addToFavorites(Long shopId, User user) throws Exception;

    public Shop updateShopStatus(Long ID) throws Exception;


    //Shop getShopByUserID(Long userId) throws Exception;
}
