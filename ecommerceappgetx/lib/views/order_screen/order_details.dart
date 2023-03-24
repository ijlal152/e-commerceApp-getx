import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/views/order_screen/component/order_placed_details.dart';
import 'package:ecommerceappgetx/views/order_screen/component/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: redColor, icon: Icons.done,
                  title: "Placed",
                  showDone: data['order_placed']
              ),
              orderStatus(
                  color: Colors.blue, icon: Icons.thumb_up,
                  title: "Order Confirmed",
                  showDone: data['order_confirmed']
              ),
              orderStatus(
                  color: Colors.yellow, icon: Icons.car_crash,
                  title: "On Delivery",
                  showDone: data['order_on_delivery']
              ),
              orderStatus(
                  color: Colors.purple, icon: Icons.done_all_outlined,
                  title: "Delivered",
                  showDone: data['order_placed']
              ),

              Divider(),
              10.heightBox,

              Column(
                children: [
                  orderPlacedDetails(title1: "Order Code",
                      title2: "Shipping Method",
                      d1: data['order_code'],
                      d2: data['shipping_method']
                  ),

                  orderPlacedDetails(title1: "Order Data",
                      title2: "Payment Method",
                      d1: intl.DateFormat("EEE, MMM d, yy").format(data['order_data'].toDate()),
                      d2: data['payment_method']
                  ),

                  orderPlacedDetails(
                      title1: "Payment Status",
                      title2: "Delivery Status",
                      d1: "Unpaid",
                      d2: "Order Placed"
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              30.heightBox,
                              "${data['total_amount']}".text.color(redColor).fontFamily(bold).make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),

              //const Divider(),
              10.heightBox,

              "Ordered Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
              
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tPrice'],
                        d1: "Quantity:  ${data['orders'][index]['qty']}",
                        d2: "Refundable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 10,
                          color: Color(int.parse(data['orders'][index]['color'])),
                        ),
                      ),
                      const Divider()
                    ],
                  );
                }).toList(),
              ).box.white.outerShadowMd.margin(const EdgeInsets.only(bottom: 4)).make(),

              10.heightBox,



            ],
          ),
        ),
      ),
    );
  }
}
