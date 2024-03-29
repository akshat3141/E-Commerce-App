// ignore_for_file: deprecated_member_use
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:apper/main.dart';
import 'models/classFields.dart';
import 'package:apper/product_screen_body.dart';
import 'package:apper/providers/products_provider.dart';
import 'product_screen.dart';

class ProductCards extends StatefulWidget {
  // final Map<String,Object> _ratings = {'User Count':43, 'Aggregate Ratings':4.3};
  late ProductDetails pd;

  ProductCards(this.pd);

  @override
  State<ProductCards> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  late String _type, _name, _link, _id, _about;
  late String _weight;
  late double _qty, _userCount = 43, _rating, _price;

  @override
  void initState() {
    _about = widget.pd.productAbout;
    _id = widget.pd.productID;
    _name = widget.pd.productTitle;
    _type = widget.pd.productType;
    _price = widget.pd.productCost;
    _qty = 1;
    _weight = widget.pd.weight;
    _link = widget.pd.assetMap['productImage'] as String;
    _rating = widget.pd.productRating;
    super.initState();
  }

  void onclickProduct(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductScreen(
                _name, _price, _about, _qty, _weight, _type, _price)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: 0.96 * width,
      height: 120,
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(3, 3),
              )
            ],
            color: const Color(0xFFFFD2D2),
          ),
          child: Row(children: [
            Container(
              height: 250,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              padding: EdgeInsets.all(5),
              child: Image.asset(
                "assets/images/wheat.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 115,
              margin: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => onclickProduct(context),
                          child: Container(
                            width: 180,
                            child: RichText(
                              text: TextSpan(
                                  text: _name + '\t',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Merriweather',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2,
                                      wordSpacing: 2),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "(" + _type + ")",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Merriweather',
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Icon(
                            Icons.info,
                            size: 13,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 4),
                      height: 0.4,
                      color: Colors.black,
                      width: 130,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          width: 170,
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: Text(
                                    'Price: ₹ ${_price}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Merriweather',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1),
                                  )),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Quantity: ',
                                        style: TextStyle(
                                            fontSize: 10, letterSpacing: 1.4),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 3,
                                                offset: Offset(1, 1))
                                          ],
                                          color: Color(0xFFFADDDD),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      height: 20,
                                      child: Row(children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _qty = _qty + 1;
                                                });
                                                ;
                                              },
                                              child: Icon(
                                                Icons.add,
                                                size: 12,
                                              )),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 60,
                                          height: 20,
                                          child: Text(
                                            (_qty).toString() + ' ' + _weight,
                                            style: TextStyle(
                                                fontSize: 10,
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _qty =
                                                      _qty == 0 ? 0 : _qty - 1;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 12,
                                              )),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 3),
                                    child: Icon(
                                      Icons.star_border_outlined,
                                      size: 13,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 3),
                                    child: Icon(
                                      Icons.star_border_outlined,
                                      size: 13,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 3),
                                    child: Icon(
                                      Icons.star_border_outlined,
                                      size: 13,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 3),
                                    child: Icon(
                                      Icons.star_border_outlined,
                                      size: 13,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 3),
                                    child: Icon(
                                      Icons.star_border_outlined,
                                      size: 13,
                                    ),
                                  ),
                                  Container(
                                    height: 15,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          (4.3).toString(),
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Icon(
                                          Icons.star_rate,
                                          size: 10,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  offset: Offset(2, 2))
                            ],
                          ),
                          height: 55,
                          width: 48,
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () => Provider.of<ProductsProvider>(
                                    context,
                                    listen: false)
                                .changeCartItems(_id, true, context, _qty),
                            child: Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.shopping_cart_outlined),
                                Text(
                                  "Add to\nCart",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8),
                                )
                              ],
                            )),
                          ),
                        ),
                        Favorite(_id),
                      ],
                    )
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  final String _id;

  Favorite(this._id);

  @override
  Widget build(BuildContext context) {
    var isFavorite = Provider.of<ProductsProvider>(context).isFavorite(_id);
    Function setFavorite = Provider.of<ProductsProvider>(context).setFavorite;
    return isFavorite
        ? InkWell(
            onTap: () => setFavorite(_id),
            child: Container(
                margin: EdgeInsets.only(
                    left: 0.05 * MediaQuery.of(context).size.width),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                )),
          )
        : InkWell(
            onTap: () => setFavorite(_id),
            child: Container(
              margin: EdgeInsets.only(
                  left: 0.05 * MediaQuery.of(context).size.width),
              child: Icon(
                Icons.favorite_outlined,
                color: Colors.redAccent,
              ),
            ),
          );
  }
}
