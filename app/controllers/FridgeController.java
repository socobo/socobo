package controllers;


import biz.fridge.FridgeService;
import com.fasterxml.jackson.databind.JsonNode;
import datalayer.FridgeRepository;
import models.fridge.Fridge;
import models.fridge.Item;
import play.mvc.*;

import javax.inject.Inject;
import javax.inject.Named;
import javax.inject.Singleton;

import static play.libs.Json.fromJson;
import static play.libs.Json.toJson;

@Named
@Singleton
@Security.Authenticated(Authenticator.class)
public class FridgeController extends Controller {

    private final FridgeRepository fridgeRepository;

    private final FridgeService fridgeService;

    @Inject
    public FridgeController(FridgeRepository fridgeRepository, FridgeService fridgeService) {
        this.fridgeRepository = fridgeRepository;
        this.fridgeService = fridgeService;
    }

    @With(UsernameValidator.class)
    public Result showItem(Long id, String userId) {
        Item item = fridgeService.retrieveItem(id, userId);
        return item != null ? ok(toJson(item)) : notFound("No such Item in fridge");
    }


    @With(UsernameValidator.class)
    public Result fridge(final String userName) {
        final Fridge fridge = fridgeService.getFridgeForUser(userName);
        return fridge != null ? ok(toJson(fridge)) : notFound("No fridge found for this user");
    }

    @With(UsernameValidator.class)
    @BodyParser.Of(BodyParser.Json.class)
    public Result addItem(final String userName) {
        if (!userName.equals(request().username())) {
            return forbidden();
        }

        final JsonNode node = request().body().asJson();
        if (node == null) return badRequest("received non-valid json");
        final Item item = fromJson(node, Item.class);

        response().setContentType("application/json");

        return ok(toJson(fridgeService.addItem(userName, item)));
    }

    public Result listProduce() {
        return notFound();
    }

    @With(UsernameValidator.class)
    @BodyParser.Of(BodyParser.Json.class)
    public Result editItem(final String userName, final Long id) {
        final JsonNode node = request().body().asJson();
        if (node == null) return badRequest("received non-valid json");
        final Item item = fromJson(node, Item.class);
        fridgeService.editItem(id, userName, item);
        return noContent();
    }
}
