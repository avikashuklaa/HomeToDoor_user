import 'package:flutter/material.dart';

import '../models/address.dart';
import '../splashScreen/splash_screen.dart';


class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;

  ShipmentAddressDesign({this.model});



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'Shipping Details:',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  Text(model!.name!, style: TextStyle(fontSize: 17),),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Phone",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  Text(model!.phoneNumber!, style: TextStyle(fontSize: 17)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              model!.fullAddress!,
             style: TextStyle(
               fontSize: 17
             ),
            ),
          ),
        ),
        SizedBox(height: 28,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffd8e2dc),
                        Color(0xffd8e2dc),
                      ],
                      begin:  FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width - 90,
                height: 50,
                child: const Center(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
