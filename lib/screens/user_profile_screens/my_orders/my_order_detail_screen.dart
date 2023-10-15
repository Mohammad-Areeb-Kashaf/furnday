import 'package:furnday/constants.dart';

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
          title: const Text(
            'My Order Detail',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: kScrollPhysics,
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
                                      maxLines: 1,
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
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        AutoSizeText(
                                          'Deliver Date:',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 14,
                                          maxFontSize: 20,
                                          maxLines: 1,
                                        ),
                                        AutoSizeText(
                                          '16/04/2023',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          minFontSize: 16,
                                          maxFontSize: 22,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          'qty:',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 14,
                                          maxFontSize: 20,
                                          maxLines: 1,
                                        ),
                                        AutoSizeText(
                                          '4',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          minFontSize: 14,
                                          maxFontSize: 20,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          "Payment Method",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          minFontSize: 16,
                                          maxFontSize: 19,
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        AutoSizeText(
                                          "UPI",
                                          minFontSize: 13,
                                          maxFontSize: 16,
                                          maxLines: 1,
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
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            "Delivery Address",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            minFontSize: 16,
                                            maxFontSize: 19,
                                            maxLines: 1,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          AutoSizeText(
                                            "516 Lotus House, B Sv Road, Bandra (west), Mumbai, Maharashtra, 400050",
                                            minFontSize: 13,
                                            maxFontSize: 16,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // const Expanded(
                              //   child: ProductImg(
                              //     images: [],
                              //   ),
                              // ),
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
                                  physics: kScrollPhysics,
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
                          const Divider(
                            thickness: 2.0,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                AutoSizeText(
                                  "Subtotal",
                                  minFontSize: 16,
                                  maxFontSize: 19,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                AutoSizeText(
                                  "₹14000",
                                  minFontSize: 16,
                                  maxFontSize: 19,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                AutoSizeText(
                                  "Delivery Charges",
                                  minFontSize: 16,
                                  maxFontSize: 19,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                AutoSizeText(
                                  "Free",
                                  minFontSize: 16,
                                  maxFontSize: 19,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                AutoSizeText(
                                  "Total",
                                  minFontSize: 16,
                                  maxFontSize: 19,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                AutoSizeText(
                                  "₹14000",
                                  minFontSize: 16,
                                  maxFontSize: 19,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
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
