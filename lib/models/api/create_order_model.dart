class CreateOrderModel {
  var orderId;
  var cfOrderId;
  var paymentSessionId;
  var orderStatus;

  CreateOrderModel(
      {this.orderId, this.cfOrderId, this.paymentSessionId, this.orderStatus});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    cfOrderId = json['cf_order_id'];
    paymentSessionId = json['payment_session_id'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['cf_order_id'] = cfOrderId;
    data['payment_session_id'] = paymentSessionId;
    data['order_status'] = orderStatus;
    return data;
  }
}
