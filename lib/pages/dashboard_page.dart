import 'package:cafe21/app_color.dart';
import 'package:cafe21/pages/invoice_list.dart';
import 'package:cafe21/widget/drawer.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  bool isSelectedBottomButtonOne = true;
  bool isSelectedBottomButtonTwo = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: const Text('Sells Dashboard'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  height: width * 0.4,
                  width: width,
                  decoration: const BoxDecoration(color: Color(0xff7c79ea)
                      // color: Colors.white
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Todays Sells Data',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                // color:  Color(0xff6a67dc),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Text('Sells'),
                          ),
                          const Text(
                            '\$10,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const Text(
                        'Total No. invoice 10 6',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: const [
                      BuildBoxContent(
                        title: 'Without Tax',
                        value: '100',
                        color: AppColor.boxOne,
                      ),
                      BuildBoxContent(
                        title: 'Tax Collection',
                        value: '100',
                        color: AppColor.boxTwo,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                const _BuildMostSellerList(),
                const _BuildMostSellerList(),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: const [
                      BuildBoxContent(
                        title: 'Without Tax',
                        value: '100',
                        color: AppColor.box4,
                      ),
                      BuildBoxContent(
                        title: 'Tax Collection',
                        value: '100',
                        color: AppColor.box5,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: const [
                      BuildBoxContent(
                        title: 'Without Tax',
                        value: '100',
                        color: AppColor.box6,
                      ),
                      BuildBoxContent(
                        title: 'Tax Collection',
                        value: '100',
                        color: AppColor.box7,
                      ),
                      // BuildBoxContent(title: 'Tax Collection', value: '100', color: AppColor.boxThree,),
                    ],
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.all(1),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             child: Container(
                //               height: 100,
                //               color: Colors.blue,
                //               child: const Text('Hello World'),
                //             ),
                //           ),
                //           Expanded(
                //               child: Container(
                //             color: Colors.purple,
                //             child: const Text('Hello World'),
                //           ))
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Expanded(
                //               child: Container(
                //             color: Colors.amber,
                //             child: const Text('Hello World'),
                //           )),
                //           Expanded(
                //               child: Container(
                //             color: Colors.green,
                //             child: const Text('Hello World'),
                //           ))
                //         ],
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),

        ),
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.08,
        child: Row(
          children: [
            _BuildBottomButton(isSelected: isSelectedBottomButtonOne, title: 'Dashboard',),
            _BuildBottomButton(isSelected: isSelectedBottomButtonTwo, title: 'Invoice',),
          ],
        ),
      ),
    );
  }
}

class _BuildMostSellerList extends StatelessWidget {
  const _BuildMostSellerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xff40407a)),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            // foregroundColor: Colors.white,
            child: Icon(
              Icons.ac_unit,
              // color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Most server person',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                Text(
                  'Abdul Zabbar',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Text(
            '100s',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class BuildBoxContent extends StatelessWidget {
  const BuildBoxContent(
      {Key? key, required this.title, required this.value, required this.color})
      : super(key: key);

  final String title, value;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //   width: 100,
        //   height: 85,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(color), borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildBottomButton extends StatelessWidget {
  const _BuildBottomButton({
    Key? key, required this.isSelected, required this.title,
  }) : super(key: key);

  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if(title.contains('Invoice')) Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoiceList(),));
        },
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: !isSelected ? Colors.deepPurple : Colors.deepPurple.shade50,
          child: Center(
              child: Text(title, style: TextStyle(color: !isSelected ? Colors.white : Colors.deepPurple.shade900, fontWeight: !isSelected ? FontWeight.normal : FontWeight.w500),)),),
      ),
    );
  }
}
