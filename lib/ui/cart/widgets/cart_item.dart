import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String? itemimage;
  final String? storeimage;
  final String? itemname;
  final int? price;
  final state;

  int count;
  CartItem(
      {this.storeimage,
      this.itemimage,
      this.price,
      this.itemname,
      this.state,
      this.count = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 2, right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 7,
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3)
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 160,
            //margin: EdgeInsets.only(top: 50),
            height: 80,
            child: Image(
              image: AssetImage(itemimage.toString()),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(itemname.toString(),
                          style: TextStyle(
                              fontFamily: "poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              child: GestureDetector(
                                onTap: () {
                                  state.setState(() {
                                    state.count--;
                                    if (state.count < 1) {
                                      state.count = 1;
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Color(0xffA6A6A6),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(child: Text('${count}')),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              child: GestureDetector(
                                onTap: () {
                                  state.setState(() {
                                    state.count++;
                                  });

                                  print(count);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.add,
                                      size: 18, color: Color(0xffA6A6A6)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Container(
                            //margin: EdgeInsets.only(right: 20),
                            width: 80,
                            child: Image.asset(storeimage.toString()),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                price.toString(),
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
    );
  }
}
