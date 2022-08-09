import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:admin_app/http/custome_http_request.dart';
import 'package:admin_app/model/order_model.dart';
import 'package:admin_app/widget/brand_colors.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<OrderModel> allOrder = [];
  getHomeData() async {
    var data = await CustomHttpRequest.fetchHomeData();
    var decodeData = jsonDecode(data);
    for (var i in decodeData) {
      OrderModel orderModel = OrderModel.fromJson(i);
      setState(() {
        allOrder.add(orderModel);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: allOrder.isEmpty
            ? spinkit
            : Container(
                padding: EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Total order is :${allOrder.length.toString()}",
                        style: myStyle(20, Colors.black),
                      ),
                      ListView.builder(
                        itemCount: allOrder.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "${allOrder[index].id}",
                              style: myStyle(20, Colors.black),
                            ),
                            subtitle: Text(
                              "${allOrder[index].user!.name}",
                              style: myStyle(20, Colors.black),
                            ),
                            leading: allOrder[index]
                                        .orderStatus!
                                        .orderStatusCategory!
                                        .id ==
                                    1
                                ? Icon(
                                    Icons.ac_unit,
                                    color: Colors.red,
                                  )
                                : allOrder[index]
                                            .orderStatus!
                                            .orderStatusCategory!
                                            .id ==
                                        2
                                    ? Icon(
                                        Icons.delivery_dining,
                                        color: Colors.orange,
                                      )
                                    : Icon(
                                        CupertinoIcons.xmark_circle_fill,
                                        color: Colors.green,
                                      ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ));
  }
}
