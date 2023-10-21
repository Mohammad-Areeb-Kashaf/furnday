class CreateCustomOrderShiprocketModel {
  int? orderId;
  int? shipmentId;
  String? status;
  int? statusCode;
  int? onboardingCompletedNow;
  String? awbCode;
  String? courierCompanyId;
  String? courierName;

  CreateCustomOrderShiprocketModel(
      {this.orderId,
      this.shipmentId,
      this.status,
      this.statusCode,
      this.onboardingCompletedNow,
      this.awbCode,
      this.courierCompanyId,
      this.courierName});

  CreateCustomOrderShiprocketModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    shipmentId = json['shipment_id'];
    status = json['status'];
    statusCode = json['status_code'];
    onboardingCompletedNow = json['onboarding_completed_now'];
    awbCode = json['awb_code'];
    courierCompanyId = json['courier_company_id'];
    courierName = json['courier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['shipment_id'] = this.shipmentId;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['onboarding_completed_now'] = this.onboardingCompletedNow;
    data['awb_code'] = this.awbCode;
    data['courier_company_id'] = this.courierCompanyId;
    data['courier_name'] = this.courierName;
    return data;
  }
}
