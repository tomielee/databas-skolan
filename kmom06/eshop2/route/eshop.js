/**
* Route for views/eshop/... fil.
*
* @author Jen Lee
*/
"use strict";
const express = require("express");
const router  = express.Router();
const bodyParser = require("body-parser");
//hämtar ut body i vårt request objekt (se create account post)
const urlencodedParser = bodyParser.urlencoded({ extended: false });


const eshop    = require("../src/eshop.js");
const customer = require("../src/customer.js")
const order = require("../src/order.js")


// FÖRSTA SIDAN
router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | The Shop"
    };

    res.render("eshop/index", data);
});

// ABOUT
router.get("/about", async (req, res) => {

    res.redirect(`/eshop/about`);
});

// CATEGORIES
router.get("/category", async (req, res) => {
    let data = {
        title: "Categories | The Shop"
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

// PRODUCTS
router.get("/products", async (req, res) => {
    let data = {
        title: "Products | The Shop"
    };

    data.res = await eshop.showAllProducts();

    res.render("eshop/products", data);
});

// ADMIN
router.get("/admin", async (req, res) => {
    let data = {
        title: "Admin | The Shop"
    };

    data.res = await eshop.showAllProducts();

    res.render("eshop/admin", data);
});

// // ADD PRODUCT
// SHOW A FORM ADD INFO ON NEW PRODUCT
router.get("/add", async (req, res) => {
    let data = {
        title: "Add a product | The shop"
    };

    res.render("eshop/add", data);
});

router.post("/add", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.addProduct(
        req.body.id,
        req.body.title,
        req.body.info,
        req.body.price,
        req.body.shelf,
        req.body.items
    );

    res.redirect("/eshop/products");
});

// // EDIT PRODUCT
router.get("/edit/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Product ${id}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-edit", data);
});

router.post("/edit", urlencodedParser, async (req, res) => {
    await eshop.editProduct(
        req.body.id,
        req.body.title,
        req.body.info,
        req.body.price,
        req.body.items
    );
    res.redirect(`/eshop/admin`);
});

// // DELETE PRODUCT
router.get("/delete/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Product ${id}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-delete", data);
});

router.post("/delete", urlencodedParser, async (req, res) => {
    await eshop.deleteProduct(
        req.body.id
    );
    res.redirect(`/eshop/admin`);
});

// // SHOW CUSTOMERS
// >> to be able to create orders
router.get("/customers/", async (req, res) => {
    let data = {
        title: "Customers | The Shop"

    };

    data.customers = await customer.showAllCustomers();

    res.render("eshop/customers", data);
});

// // SHOW CUSTOMER ORDERS
// user has clicked orders
// show orders and status
// can shoose to order or add more orderrows (products) to order
router.get("/orders/:id", async (req, res) => {
    let id = req.params.id; //customerid
    let data = {
        title: "Customer orders | The Shop",

    };
    data.customer = await customer.showCustomer(id);
    console.log(data.customer);
    data.orders = await order.showCustomersOrders(id);
    data.status = await order.showOrderStatus(id);

    res.render("eshop/orders", data);
});

// CREATE AN ORDER
router.get("/order-create/:id", async (req, res) => {
    let customerid = req.params.id;
    let data = {
        title: "Create an order | The Shop",
    };

    let orderid = await order.createOrder(customerid);

    //console.log(orderid[0].orderid);

    res.redirect(`/eshop/order-add-product/${orderid[0].orderid}`);
});


// SHOW AN ORDER
router.get("/order/:id", async (req, res) => {
    let orderid = req.params.id; // order id

    console.info(orderid);

    let data = {
        title: "Your order| The Shop",
    };
    data.order = await order.showOrder(orderid);
    data.status = await order.showOrderStatus(orderid);

    res.render("eshop/order", data);
});

// ADD PRODUCTS
router.get("/order-add-product/:id", async (req, res) => {
    let id = req.params.id; // order id
    let data = {
        title: "Shop more| The Shop",

    };
    data.products = await eshop.showAllProducts();
    data.order = await order.showOrder(id);


    res.render("eshop/order-add-product", data);
});

router.post("/order-add-product", urlencodedParser, async (req, res) => {

    let id = req.body.orderid; // order id

    console.log(req.body.orderid);
    console.log(req.body.prodid);
    console.log(req.body.amount);

    await order.addToOrder(
        req.body.orderid,
        req.body.prodid,
        req.body.amount
    );

    res.redirect(`/eshop/order/${id}`);
});

// EDIT AMOUNT OF PRODUCTS
router.post("/order-edit", urlencodedParser, async (req, res) => {
    let id = req.body.orderid; // order id
    console.log(req.body.amount);
    console.log(req.body.prodid);
    await order.editOrder(
        req.body.orderid,
        req.body.prodid,
        req.body.amount
    );

    res.redirect(`/eshop/order/${id}`);
});

// ORDER - FINISH THE ORDER
router.get("/order-fini/:id/:cid", async (req, res) => {
    let orderid = req.params.id //orderid
    let customerid = req.params.cid; // customer id

    await order.finishOrder(orderid);

    res.redirect(`/eshop/orders/${customerid}`);
});

// DELETE - FINISH THE ORDER
router.get("/order-del/:id/:cid", async (req, res) => {
    let orderid = req.params.id //orderid
    let customerid = req.params.cid; // customer id

    await order.deleteOrder(orderid);

    res.redirect(`/eshop/orders/${customerid}`);
});

// ALL ORDERS
router.get("/orders-all", async (req, res) => {

    let data = {
        title: "All orders| The Shop",

    };
    data.orders = await order.showAllOrders();


    res.render("eshop/orders-all", data);
});



module.exports = router;
