
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_assignment/bloc/MenuBloc.dart';
import 'package:flutter_assignment/bloc/MenuEvent.dart';
import 'package:flutter_assignment/bloc/MenuState.dart';
import 'package:flutter_assignment/cart.dart';
import 'package:flutter_assignment/model/menu_m.dart';
import 'package:flutter_assignment/repocitory/api_service.dart';
import 'package:flutter_assignment/repocitory/save_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage>{
  
  MenuBloc _menuBloc = MenuBloc();

  int quant = 0;

  List resp = [];
  Map<String, dynamic> new_map;

  final List<Map<String, dynamic>> added_prod = [];

  var total_amount = 0;

  List<dynamic> prd;

  @override
  void initState() {
    super.initState();

    initial();

    _menuBloc.add(MenuFetchEvent());
  }

  Future<void> initial() async {

    var parsed = await SaveData.getCatrData();

    prd = await SaveData.getProductName();


    print('checkdata  ${prd}');

    setState(() {
      if(parsed == null){
        print('no data available');
      } else {
        print('shared_preff- ${parsed}');
      }
    });

  }


  

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => _menuBloc,
      child: BlocListener<MenuBloc, MenuState>(
          listener: (context, state) {
            if (state is MenuErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<MenuBloc, MenuState> (
            builder: (context, state) {
              if (State is MenuInitState) {
                return Center(child: Text('Init state Loading...'),);
              } else if (state is MenuLoadingState) {
                return Center(child: Text('Loading...'),);
              } else if (state is MenuLoadedState) {
                return Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      //mainAxisAlignment : MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      ExpansionTile(
                                        title: Text(
                                          state.items.keys.elementAt(index),// cat
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        children: [

                                          Padding(
                                            padding: EdgeInsets.all(6),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state.items.values.elementAt(index).length,
                                                itemBuilder: (context, index2) {

                                                  return Padding(
                                                    padding: EdgeInsets.all(2),
                                                    child: new InkWell(
                                                      onTap: () {


                                                      },
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 70,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(3),
                                                            ),
                                                            child:
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        flex: 4,
                                                                        child: Column(
                                                                          children: [

                                                                            Row(
                                                                              children: [
                                                                                Text('${state.items.values.elementAt(index).elementAt(index2).name}',
                                                                                  style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.black
                                                                                  ),
                                                                                ),

                                                                                SizedBox(width: 12,),

                                                                                if(prd == null || prd.isEmpty)...[
                                                                                  Container()
                                                                                ]else...[
                                                                                  for ( var i in prd ) i.toString() == state.items.values.elementAt(index).elementAt(index2).name ?
                                                                                  Text('Popular Item',
                                                                                    style: TextStyle(
                                                                                        fontSize: 12,
                                                                                        color: Colors.deepOrangeAccent,
                                                                                        fontWeight: FontWeight.w500
                                                                                    ),
                                                                                  ) : Container(),
                                                                                ]

                                                                              ],
                                                                            ),

                                                                            SizedBox(height: 6,),

                                                                            Row(
                                                                              children: [
                                                                                Text('\$${state.items.values.elementAt(index).elementAt(index2).price}',
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    color: Colors.black54,
                                                                                  ),
                                                                                  textAlign: TextAlign.left,
                                                                                ),
                                                                              ],
                                                                            ),

                                                                            SizedBox(height: 6,),

                                                                            Row(
                                                                              children: [
                                                                                state.items.values.elementAt(index).elementAt(index2).instock == false ?
                                                                                Text('Out of stock',
                                                                                  style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      color: Colors.red
                                                                                  ),
                                                                                ) : Container(),
                                                                              ],
                                                                            ),

                                                                          ],
                                                                        )
                                                                    ),

                                                                    Expanded(
                                                                        flex: 6,
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                ClipOval(
                                                                                  child: Material(
                                                                                    color: Colors.orange, // Button color
                                                                                    child: InkWell(// Splash color
                                                                                      onTap: () async {

                                                                                        if(state.items.values.elementAt(index).elementAt(index2).instock == false) {
                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                            SnackBar(
                                                                                              content: Text('out of stock'),
                                                                                            ),
                                                                                          );
                                                                                        } else {
                                                                                          if(added_prod.length > 0) {
                                                                                            final ind = added_prod.indexWhere((element) => element["prod"] == state.items.values.elementAt(index).elementAt(index2).name);

                                                                                            if (ind != -1 ) {

                                                                                              if (added_prod[ind]['quant'] > 1) {

                                                                                                print('Remove-index1 ${added_prod[ind]['quant']}');
                                                                                                setState(() {
                                                                                                  quant = added_prod[ind]['quant'];
                                                                                                });

                                                                                                print('quant ${added_prod[ind]}');

                                                                                                added_prod[ind].update('quant', (value) => quant - 1);

                                                                                                setState(() {
                                                                                                  quant--;
                                                                                                });
                                                                                              }  else {
                                                                                                added_prod.removeWhere( (item) => item["prod"] == state.items.values.elementAt(index).elementAt(index2).name );

                                                                                                setState(() {
                                                                                                  quant--;
                                                                                                });
                                                                                                print('no items');
                                                                                              }

                                                                                            }

                                                                                          }

                                                                                          SaveData.addProdtoSharedPref(added_prod);

                                                                                          total_amount = await SaveData.getTotalAmount();
                                                                                        }


                                                                                      },
                                                                                      child: SizedBox(width: 24, height: 24, child: Icon(Icons.remove)),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(width: 4,),

                                                                                if(added_prod.isEmpty)...[
                                                                                  Text('0',
                                                                                    style: TextStyle(
                                                                                        fontSize: 18,
                                                                                        color: Colors.black54,
                                                                                        fontWeight: FontWeight.w500
                                                                                    ),
                                                                                  ),
                                                                                ]else...[

                                                                                  added_prod.indexWhere((element) => element["prod"] == state.items.values.elementAt(index).elementAt(index2).name) != -1 ?
                                                                                  Text('${added_prod[added_prod.indexWhere((element) => element["prod"] == state.items.values.elementAt(index).elementAt(index2).name)]['quant']}') :
                                                                                  added_prod.indexWhere((element) => element["prod"] == state.items.values.elementAt(index).elementAt(index2).name) == -1 ?
                                                                                  Text('${0}') : Text('${0}')

                                                                                ],

                                                                                SizedBox(width: 4,),
                                                                                ClipOval(
                                                                                  child: Material(
                                                                                    color: Colors.orange, // Button color
                                                                                    child: InkWell(// Splash color
                                                                                      onTap: () async {

                                                                                        if(state.items.values.elementAt(index).elementAt(index2).instock == false) {

                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                            SnackBar(
                                                                                              content: Text('out of stock'),
                                                                                            ),
                                                                                          );

                                                                                        }else {

                                                                                          if(added_prod.isEmpty) {
                                                                                            added_prod.add(
                                                                                                {
                                                                                                  'prod': state.items.values.elementAt(index).elementAt(index2).name,
                                                                                                  'rate': state.items.values.elementAt(index).elementAt(index2).price,
                                                                                                  'quant': quant + 1
                                                                                                }
                                                                                            );
                                                                                            setState(() {
                                                                                              quant++;
                                                                                            });
                                                                                          } else {
                                                                                            final ind = added_prod.indexWhere((element) => element["prod"] == state.items.values.elementAt(index).elementAt(index2).name);

                                                                                            if (ind != -1) {
                                                                                              //print("Index ${ind}");
                                                                                              if(added_prod[ind]['prod'] == state.items.values.elementAt(index).elementAt(index2).name){

                                                                                                setState(() {
                                                                                                  quant = added_prod[ind]['quant'];
                                                                                                });

                                                                                                added_prod[ind].update('quant', (value) => quant + 1);

                                                                                                setState(() {
                                                                                                  quant++;
                                                                                                });
                                                                                              }
                                                                                            } else {
                                                                                              setState(() {
                                                                                                quant = 0;
                                                                                              });
                                                                                              added_prod.add(
                                                                                                  {
                                                                                                    'prod': state.items.values.elementAt(index).elementAt(index2).name,
                                                                                                    'rate': state.items.values.elementAt(index).elementAt(index2).price,
                                                                                                    'quant': quant + 1
                                                                                                  }
                                                                                              );
                                                                                            }
                                                                                          }

                                                                                          SaveData.addProdtoSharedPref(added_prod);

                                                                                          total_amount = await SaveData.getTotalAmount();

                                                                                          print('tot - ${total_amount}');

                                                                                        }

                                                                                      },
                                                                                      child: SizedBox(width: 24, height: 24, child: Icon(Icons.add)),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        )
                                                                    ),


                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                    ),
                                                  );

                                                }
                                            ),
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                );
                              }
                          ),
                        ),


                        Align(
                          alignment: Alignment.bottomCenter,
                          child:ElevatedButton(
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

                              if(added_prod.isEmpty || added_prod == null ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please add some product.'),
                                  ),
                                );

                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CartPage(added_prod)),
                                );
                              }

                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text('Place Order',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:


                                    Text('\$${total_amount}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700
                                      ),),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),


                      ],
                    ),
                  )

                );
                //return buildMenuList(context, state.items);
              } else if (state is MenuErrorState) {
                return Center(child: Text('Error'),);
              }  else {
                return Center(child: Text('Else Part'),);
              }
            },
          )
      ),
    );
  }


}