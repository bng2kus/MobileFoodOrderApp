import 'package:flutter/material.dart';
import 'package:nav/order_screen.dart';
import 'about_screen.dart';
import 'order.dart';
import 'order_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //prices
  var _price = 0.00;
  var _priceOut = "3.14";

  //drop down vars
  //sizes
  var _currentSize = "Small";

  //flavors
  var _currentFlavor = "Vanilla";

  //checkbox vars
  var _peanuts = false;
  var _almonds = false;
  var _strawberries = false;
  var _gummy = false;
  var _mm = false;
  var _brownie = false;
  var _oreo = false;
  var _marshmallow = false;

  //slider fudge
  var _sliderValue = 1;


  //orders
  List<Order> _orders = [];


  //functions
  void handleCheckBox(String name, bool value){
    setState(() {
      switch(name){
        case 'Peanuts':
          _peanuts = value;
          break;
        case 'Almonds':
          _almonds = value;
          break;
        case 'Strawberries':
          _strawberries = value;
          break;
        case 'Gummy Bears':
          _gummy = value;
          break;
        case 'M&Ms':
          _mm = value;
          break;
        case 'Brownies':
          _brownie = value;
          break;
        case 'Oreos':
          _oreo = value;
          break;
        case 'Marshmallows':
          _marshmallow = value;
          break;
      }
    });
  }

  void theWorks(){
    //toppings
    _peanuts = true;
    _almonds = true;
    _strawberries = true;
    _gummy = true;
    _mm = true;
    _brownie = true;
    _oreo = true;
    _marshmallow = true;

    //fudge
    _sliderValue = 3;

    //size
    _currentSize = 'Large';

    calculatePrice();
  }

  void reset(){
    _peanuts = false;
    _almonds = false;
    _strawberries = false;
    _gummy = false;
    _mm = false;
    _brownie = false;
    _oreo = false;
    _marshmallow = false;

    //fudge
    _sliderValue = 1;

    //size
    _currentSize = 'Small';

    //flavor
    _currentFlavor = 'Vanilla';

    calculatePrice();
  }

  void order(){
    buildOrderList();
    reset();
  }

  void calculatePrice(){
    setState(() {
      _price = 0.00;

      //sizes
      if(_currentSize == "Small"){
        _price += 2.99;
      }
      else if(_currentSize == "Medium"){
        _price += 3.99;
      }
      else if(_currentSize == "Large"){
        _price += 4.99;
      }

      //fudge
      if(_sliderValue == 1){
        _price += 0.15;
      }
      else if(_sliderValue == 2){
        _price += 0.25;
      }
      else if(_sliderValue == 3){
        _price += 0.30;
      }
      else{
        _price += 0;
      }

      //toppings
      if(_peanuts){
        _price += 0.15;
      }
      if(_almonds){
        _price += 0.15;
      }
      if(_strawberries){
        _price += 0.20;
      }
      if(_gummy){
        _price += 0.20;
      }
      if(_mm){
        _price += 0.25;
      }
      if(_brownie){
        _price += 0.20;
      }
      if(_oreo){
        _price += 0.20;
      }
      if(_marshmallow){
        _price += 0.15;
      }

      _priceOut = (_price).toStringAsFixed(2);

    });
  }


  void choiceAction(String choice){
    print(choice);
  }


  void buildOrderList(){
    //_orders.clear();
    _orders.add(Order(_currentFlavor, _currentSize, _priceOut));
  }



  void gotoAboutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutScreen(),
      ),
    );
  }

  void gotoOrdersScreen() {
    //buildOrderList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersScreen(
          orders: _orders,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ice Cream Sundae'),
        actions: [
          PopupMenuButton(
            onSelected: (choice) {
              if (choice == 'About') {
                gotoAboutScreen();
              } else if (choice == 'Order History') {
                gotoOrdersScreen();
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'Order History',
                  child: Text('Order History'),
                ),

                const PopupMenuItem(
                  value: 'About',
                  child: Text('About'),
                ),
              ];
            },
          ),
        ],
      ),


      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //row of title and image
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/sundae.png',
                      height: 100,
                      width: 100,
                    ),

                    Text(
                      'Sundae Maker',
                      style: TextStyle(
                        fontSize: 36.0,


                      ),
                    ),
                  ],
                ),
              ),
            ),






            //Column for the price
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      r'$' + '$_priceOut',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),

                  ],
                ),
              ),
            ),






            //Row for sizes
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sizes: '),
                    DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('Small'),
                            value: 'Small',
                          ),

                          DropdownMenuItem(
                            child: Text('Medium'),
                            value: 'Medium',
                          ),

                          DropdownMenuItem(
                            child: Text('Large'),
                            value: 'Large',
                          ),
                        ],

                        value: _currentSize,
                        onChanged: (String? str){
                          _currentSize = str!;
                          calculatePrice();
                        }
                    ),
                  ],
                ),
              ),
            ),






            //Row for flavors
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ice Cream: '),
                    DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('Vanilla'),
                            value: 'Vanilla',
                          ),

                          DropdownMenuItem(
                            child: Text('Chocolate'),
                            value: 'Chocolate',
                          ),

                          DropdownMenuItem(
                            child: Text('Strawberry'),
                            value: 'Strawberry',
                          ),
                        ],

                        value: _currentFlavor,
                        onChanged: (String? str){
                          _currentFlavor = str!;
                          calculatePrice();
                        }
                    ),
                  ],
                ),
              ),
            ),






            //check box rows
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 0.0,
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _peanuts,
                          onChanged: (bool? val){
                            handleCheckBox('Peanuts', val!);
                            calculatePrice();
                          },
                          title: Text('Peanuts'),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _almonds,
                          onChanged: (bool? val){
                            handleCheckBox('Almonds', val!);
                            calculatePrice();
                          },
                          title: Text('Almonds'),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _strawberries,
                          onChanged: (bool? val){
                            handleCheckBox('Strawberries', val!);
                            calculatePrice();
                          },
                          title: Text('Strawberries'),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _gummy,
                          onChanged: (bool? val){
                            handleCheckBox('Gummy Bears', val!);
                            calculatePrice();
                          },
                          title: Text('Gummy Bears'),
                        ),

                      ],
                    ),
                  ),



                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _mm,
                          onChanged: (bool? val){
                            handleCheckBox('M&Ms', val!);
                            calculatePrice();
                          },
                          title: Text('M&Ms'),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _brownie,
                          onChanged: (bool? val){
                            handleCheckBox('Brownies', val!);
                            calculatePrice();
                          },
                          title: Text('Brownies'),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _oreo,
                          onChanged: (bool? val){
                            handleCheckBox('Oreos', val!);
                            calculatePrice();
                          },
                          title: Text('Oreos'),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: _marshmallow,
                          onChanged: (bool? val){
                            handleCheckBox('Marshmallows', val!);
                            calculatePrice();
                          },
                          title: Text('Marshmallows'),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),






            //Slider
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    Text(
                      "Fudge:",
                      style: TextStyle(
                        fontSize: 16.0,

                      ),
                    ),

                    Expanded(
                      child: Slider(
                        value: _sliderValue.toDouble(),
                        min: 0.0,
                        max: 3.0,
                        label: _sliderValue.toString(),
                        onChanged: (double val){
                          setState(() {
                            _sliderValue = val.toInt();
                          });
                          calculatePrice();
                        },
                      ),
                    ),

                    Text(
                      "$_sliderValue oz",
                      style: TextStyle(
                        fontSize: 16.0,

                      ),
                    ),

                  ],
                ),
              ),
            ),





            //Text Buttons
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        theWorks();
                      },
                      child: Text(
                        'The Works',
                        style: TextStyle(
                          fontSize: 16.0,

                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        reset();
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 16.0,

                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        order();
                        reset();
                      },
                      child: Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 16.0,

                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
