//Example to setup Bubble Bottom Bar with PageView
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_meal/Blogic/firebase/firestore.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:share_meal/models/user.dart';
import 'package:share_meal/screens/profile/profile.dart';
import 'package:share_meal/screens/thehome/home.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:share_meal/screens/goals.dart';

class nav extends StatefulWidget {
  nav({Key? key}) : super(key: key);

  @override
  State<nav> createState() => _navState();
}

class _navState extends State<nav> {
  User_m? curuser;
  Future<void> getuser() async {
    curuser = await FireStore.getCurrent();
    if (curuser != null) {}
    setState(() {});
  }

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  Future<void> initializeState() async {
    try {
      await getuser();
    } catch (e) {
      print('Error initializing state: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  PageController controller = PageController(initialPage: 0);
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    if (isLoading || curuser == null) {
      setState(() {
        initializeState();
      });
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          Home(curuser: curuser!),
          Profile(),
          GoalsScreen(),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        backgroundColor: Theme.of(context).backgroundColor,
        option: BubbleBarOptions(
          // barStyle: BubbleBarStyle.vertical,
          barStyle: BubbleBarStyle.horizotnal,
          bubbleFillStyle: BubbleFillStyle.fill,
          // bubbleFillStyle: BubbleFillStyle.outlined,
          opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).selectedRowColor,
            ),

            title: Padding(
              padding: const EdgeInsets.only(left: 60),
              child: const Text('Home'),
            ),
            backgroundColor: green_shade,
            unSelectedColor: Theme.of(context).selectedRowColor,

            // selectedColor: Colors.pink,
            // selectedIcon: const Icon(Icons.read_more),
            badge: const Badge(),
            showBadge: true,
          ),
          BottomBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Icon(
                Icons.person,
                color: Theme.of(context).selectedRowColor,
              ),
            ),
            title: Text('profile'),
            backgroundColor: green_shade,
          ),
          BottomBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Icon(
                Icons.file_copy,
                color: Theme.of(context).selectedRowColor,
              ),
            ),
            title: Text('goals'),
            backgroundColor: green_shade,
          ),
        ],
        // fabLocation: StylishBarFabLocation.end,
        // hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
            controller.jumpToPage(index);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        foregroundColor: white,
        onPressed: () {
          _openBottomSheetForAdd(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

void _openBottomSheetForAdd(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          color: Theme.of(context).backgroundColor,
          //  height: 500.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              listtileitem(
                backcolor: Color.fromARGB(255, 81, 16, 94),
                icon: Icons.card_giftcard,
                onPress: () {
                  Navigator.pushNamed(context, '/chooseCategory');
                },
                tittle: "مجانى",
                subtittle: "تعطى مجانا طعام وغير طعام",
              ),
              listtileitem(
                backcolor: red,
                icon: Icons.local_mall_rounded,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    '/addnew',
                    arguments: {
                      'transaction': "sell",
                    },
                  );
                },
                tittle: "للبيع",
                subtittle: "لبيع اشياء غير طعام",
              ),
              listtileitem(
                backcolor: pink,
                icon: Icons.handshake,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    '/addnew',
                    arguments: {
                      'transaction': "borrow",
                    },
                  );
                },
                tittle: "اقراض",
                subtittle: "قُرض أشيائك للناس",
              ),
              listtileitem(
                backcolor: Color.fromARGB(228, 238, 223, 21),
                icon: Icons.question_mark_rounded,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    '/addnew',
                    arguments: {
                      'transaction': "Wanted",
                    },
                  );
                },
                tittle: "تحتاج",
                subtittle: "اسال عن شئ تحتاجه",
              ),
            ],
          ),
        ),
      );
    },
  );
}

class listtileitem extends StatelessWidget {
  final Color backcolor;
  final void Function()? onPress;
  final IconData icon;
  final String tittle;
  final String subtittle;

  listtileitem({
    super.key,
    required this.backcolor,
    required this.onPress,
    required this.icon,
    required this.tittle,
    required this.subtittle,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: lightgrey,
        elevation: 10,
        child: ListTile(
            leading: CircleAvatar(
                backgroundColor: backcolor,
                child: Icon(
                  icon,
                  color: white,
                )),
            title: Text(tittle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: black)),
            subtitle: Text(
              subtittle,
              style: TextStyle(fontSize: 15.sp),
            ),
            onTap: onPress),
      ),
    );
  }
}
