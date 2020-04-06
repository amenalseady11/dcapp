class BranchClass{
    int branchID;
    String branchName;
    String state;
    String city;
    String country;
    int parentId;
    String status;
//

  BranchClass({this.branchID, this.branchName, this.state, this.city,  this.country, this.parentId, this.status,});

  factory BranchClass.fromJson(Map<String, dynamic> json){

    return BranchClass(
      branchID: json["branchID"] as int,
      branchName: json["branchName"] as String,
      state: json["state"] as String,
      city: json["city"] as String,
      country: json["country"] as String,
      parentId: json["parentId"] as int,

     
      status: json["status"] as String,



    );
  }


}