import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;

  int _personConter = 1 ;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30.0),
              height: 150,
              //width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(15.0),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Per Person",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$ ${calculateTotalPerPerson(_billAmount, _personConter, _tipPercentage)}",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blueGrey.shade100,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey, fontSize: 20.0),
                    decoration: InputDecoration(
                      icon: Icon(Icons.attach_money),
                      prefixText: "Bill Amount : ",
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);

                      } catch (exception) {
                              _billAmount = 0.0;
                      }
                    },
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 20.0,
                        ),
                      ),

                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(_personConter>1){
                                  _personConter--;
                                  print(_personConter);
                                }
                              });

                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text("-",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personConter",
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),

                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personConter++;
                              });

                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              child: Center(
                                child: Text("+",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Tip",style:
                        TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700
                        ),),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("\$ ${calculateTotalTip(_billAmount, _personConter, _tipPercentage)}",style:
                          TextStyle(
                              fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text("$_tipPercentage %",
                    style: TextStyle(

                      color: Colors.grey.shade700,
                      fontSize:22.0,
                    ),
                  ),
                  Slider(
                      min: 0,
                      max: 100,
                      activeColor: Colors.purple,
                      inactiveColor: Colors.grey,
                      divisions: 10,
                      value: _tipPercentage.toDouble(),
                      onChanged: (double persontage){
                          setState(() {
                            _tipPercentage = persontage.toInt();
                          });
                      }
                  )

                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPersontage){

    double totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPersontage) + _billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);

  }

  calculateTotalTip(double billAmount,int spitBy,int tipPercentage){

    double totalTip = 0.0;

    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){
      print("invalid input");
    }else{
      totalTip = (billAmount * _tipPercentage)/100;
    }

    return totalTip;
    

  }

}
