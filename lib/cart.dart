
import 'package:flutter/material.dart';
import 'package:flutter_assignment/repocitory/save_data.dart';

class CartPage extends StatefulWidget {

  List<Map<String, dynamic>> added_prod;

  CartPage( this.added_prod);

  //final List<Map<String, dynamic>> added_prod;

  //CartPage(Key key, this.added_prod);


  @override
  _CartPageState createState() => _CartPageState(added_prod);
}

class _CartPageState extends State<CartPage>{
  final List<Map<String, dynamic>> added_prod;

  _CartPageState(this.added_prod);

  @override
  Widget build(BuildContext context) {

    //print('array ${added_prod}');

    //return Scaffold();

    return SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Ordered Items', style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.black54
                  ),),

                  SizedBox(height: 60,),

                  ListView.builder(
                      itemCount: added_prod.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [

                            Padding(
                                padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('${index+1}. ${added_prod[index]['prod']}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),


                                      SizedBox(width: 100,),

                                      Text('Quantity - ${added_prod[index]['quant']}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
/*
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(40),
                                  padding:  EdgeInsets.all(5),
                                  primary: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 10.0,
                                ),
                                onPressed: () {

                                  SaveData.clearPreff();

                                },
                                child: Text('clear')
                            ),

 */
                          ],
                        );
                      }
                  )
                ],
              ),
            ),
          ),
        )
    );


  }

}