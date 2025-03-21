package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.Request.CreateShopRequest;
import com.Odyssey.Odyssey.dto.ShopDTO;
import com.Odyssey.Odyssey.model.Address;
import com.Odyssey.Odyssey.model.Shop;
import com.Odyssey.Odyssey.model.User;
import com.Odyssey.Odyssey.repository.AddressRepository;
import com.Odyssey.Odyssey.repository.ShopRepository;
import com.Odyssey.Odyssey.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;


@Service
public class ShopServiceImp implements ShopService {

    @Autowired
    private ShopRepository shopRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public Shop createShop(CreateShopRequest req, User user) {

        Address address = addressRepository.save(req.getAddress());

        Shop shop = new Shop();
        shop.setAddress(address);
        shop.setName(req.getShopName());
        shop.setDescription(req.getDescription());
        shop.setOwner(user);

        return shopRepository.save(shop);
    }

    @Override
    public Shop updateShop(Long shopId, CreateShopRequest updateRequest) throws Exception {
        Shop shop = findShopById(shopId);

        if (shop.getDescription() != null) {
            shop.setDescription(updateRequest.getDescription());
        }
        if (shop.getName() != null) {
            shop.setName(updateRequest.getShopName());
        }
        return shopRepository.save(shop);
    }

    @Override
    public void deleteShop(Long shopId) throws Exception {

        Shop shop = findShopById(shopId);

        shopRepository.delete(shop);

    }

    @Override
    public List<Shop> getAllShops() throws Exception {
        return shopRepository.findAll();
    }

    @Override
    public List<Shop> searchShops(String keyword) {
        return shopRepository.findBySearchQuery(keyword);
    }

    @Override
    public Shop findShopById(Long ID) throws Exception {

        Optional<Shop> opt = shopRepository.findById(ID);

        if(opt.isEmpty()){
            throw new Exception("Email already exists");
        }
        return opt.get();
    }

    @Override
    public Shop findShopByUserId(Long userId) throws Exception {

        Shop shop = shopRepository.findByOwnerId(userId);
        if(shop == null){
            throw new Exception("Shop not found");
        }
        return shop;
    }

    @Override
    public ShopDTO addToFavorites(Long shopId, User user) throws Exception {

        Shop shop = findShopById(shopId);

        ShopDTO dto = new ShopDTO();
        dto.setDescription(shop.getDescription());
        dto.setTitle(shop.getName());
        dto.setId(shop.getShop_id());

        if(user.getFavorites().contains(dto)){
            user.getFavorites().remove(dto);
        }

        else user.getFavorites().add(dto);

        userRepository.save(user);

        return dto;
    }

    @Override
    public Shop UpdateShopStatus(Long ID) throws Exception {

        Shop shop = findShopById(ID);

        //shop.setOnline(!shop.isOnline());

        return shopRepository.save(shop);
    }
}
