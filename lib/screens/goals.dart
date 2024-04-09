import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_meal/constants/constans.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<DocumentSnapshot> goals = [];
  int currentIndex = 0;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchGoals();
  }

  Future<void> fetchGoals() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('goals').get();
    setState(() {
      goals = snapshot.docs;
    });
  }

  void onNextPressed() {
    setState(() {
      isAnimating = true;
      currentIndex =
          (currentIndex + 1) % goals.length; //3/10 = 0 and  reminder=3
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: goals.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  left: isAnimating ? -MediaQuery.of(context).size.width : 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(color: green),
                      margin: EdgeInsets.all(80.h),
                      width: 200.w,
                      height: 320.h,
                      child: Card(
                        color: light_green,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(goals[currentIndex]['title']),
                            Text(goals[currentIndex]['description']),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: 400,
                  bottom: 20,
                  right: 20,
                  child: IconButton(
                    color: green,
                    onPressed: onNextPressed,
                    icon: Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
