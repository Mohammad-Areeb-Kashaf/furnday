import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/order/track_order_model.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:im_stepper/stepper.dart';

class MyOrderDetailScreen extends StatefulWidget {
  const MyOrderDetailScreen({Key? key}) : super(key: key);

  @override
  _MyOrderDetailScreenState createState() => _MyOrderDetailScreenState();
}

class _MyOrderDetailScreenState extends State<MyOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var trackOrderList = [
      TrackOrderModel(
          title: "Ordered", subtitle: "We are processing your order"),
      TrackOrderModel(title: "Shipped", subtitle: "Your order is now shipped"),
      TrackOrderModel(
          title: "Out for Delivery",
          subtitle: "Your order is out for delivery"),
      TrackOrderModel(title: "Delivered", subtitle: "Your order is delivered"),
    ];

    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'My Order Detail',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: scrollPhysics,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DecoratedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: AutoSizeText(
                                      'Bed',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      minFontSize: 16,
                                      maxFontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: AutoSizeText(
                                      '#1234567890',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      minFontSize: 16,
                                      maxFontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: const [
                                        AutoSizeText(
                                          'Deliver Date:',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 14,
                                          maxFontSize: 20,
                                        ),
                                        AutoSizeText(
                                          '16/04/2023',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          minFontSize: 16,
                                          maxFontSize: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        AutoSizeText(
                                          'qty:',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 14,
                                          maxFontSize: 20,
                                        ),
                                        AutoSizeText(
                                          '4',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          minFontSize: 14,
                                          maxFontSize: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        AutoSizeText(
                                          "Payment Method",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 16,
                                          maxFontSize: 19,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        AutoSizeText(
                                          "UPI",
                                          minFontSize: 13,
                                          maxFontSize: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          AutoSizeText(
                                            "Delivery Address",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            minFontSize: 16,
                                            maxFontSize: 19,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          AutoSizeText(
                                            "516 Lotus House, B Sv Road, Bandra (west), Mumbai, Maharashtra, 400050",
                                            minFontSize: 13,
                                            maxFontSize: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: borderRadiusCard,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width / 6,
                                child: IconStepper(
                                  direction: Axis.vertical,
                                  enableNextPreviousButtons: false,
                                  enableStepTapping: false,
                                  stepColor: Colors.green,
                                  activeStepBorderWidth: 0.0,
                                  activeStepBorderPadding: 0.0,
                                  lineColor: Colors.green,
                                  lineLength: 70.0,
                                  lineDotRadius: 2.0,
                                  stepRadius: 18.0,
                                  activeStep: trackOrderList.length,
                                  activeStepColor: Colors.grey,
                                  icons: const [
                                    Icon(
                                      Icons.check,
                                    ),
                                    Icon(
                                      Icons.check,
                                    ),
                                    Icon(
                                      Icons.check,
                                    ),
                                    Icon(
                                      Icons.check,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  physics: scrollPhysics,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: trackOrderList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 16.0),
                                            title: Text(
                                              trackOrderList[index].title,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              trackOrderList[index].subtitle,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
