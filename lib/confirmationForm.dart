import 'package:flutter/material.dart';

class ConfirmationForm extends StatelessWidget {
  var vendorSet;
  var itemSet;
  var total;
  ConfirmationForm(
      {Key key,
      @required this.vendorSet,
      @required this.itemSet,
      @required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    vendorSet = new List<String>.from(vendorSet);
    itemSet = new List<String>.from(itemSet);
    total = new List<String>.from(total);

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Info"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Text(
                      "Vendor".toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: vendorSet.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      trailing: Text(
                        vendorSet[index],
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    "Items".toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemSet.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.list),
                      trailing: Text(
                        itemSet[index].toString(),
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    "Total".toUpperCase(),
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: total.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      trailing: Text(
                        total[index],
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Expanded(
                      child: Center(
                        child: ElevatedButton.icon(
                            icon: Icon(Icons.arrow_forward),
                            label:
                                Text("Confirm", style: TextStyle(fontSize: 10)),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Colors.green, width: 2.0)))),
                            onPressed: () => Null),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: ElevatedButton.icon(
                            icon: Icon(Icons.edit),
                            label: Text("Edit", style: TextStyle(fontSize: 10)),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Colors.red, width: 2.0)))),
                            onPressed: () => Null),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
