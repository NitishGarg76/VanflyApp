import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:vanfly/providers/product_provider.dart';
import 'package:vanfly/providers/user_provider.dart';
import 'package:vanfly/refer_and_earnn/create_referal_code.dart';
import 'package:vanfly/refer_and_earnn/dynamic_link.dart';
import 'package:vanfly/screens/BottomTab_Bar/task/contest.dart';
import 'package:vanfly/widgets/Task_Bar_button.dart';
import 'package:vanfly/widgets/task_card.dart';
import 'package:vanfly/widgets/video_card.dart';

class Task extends StatefulWidget {
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TaskBarButton(
                  labelColor:
                      selectedTab == 0 ? Colors.white : Colors.pinkAccent,
                  onTapColor:
                      selectedTab == 0 ? Colors.pinkAccent : Colors.white,
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                  label: 'Task',
                ),
                SizedBox(
                  width: 20,
                ),
                TaskBarButton(
                  labelColor:
                      selectedTab == 1 ? Colors.white : Colors.pinkAccent,
                  onTapColor:
                      selectedTab == 1 ? Colors.pinkAccent : Colors.white,
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                    });
                  },
                  label: 'Contest',
                )
              ],
            ),
          )),
      body: (selectedTab == 0) ? TasksScreen() : Contest(),
    );
  }
}

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // int countDown = 0;
  // getTimerValue() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   int timeCount = pref.getInt('timerValue');
  //   return timeCount;
  // }
  //
  // setTimerValue() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setInt('timerValue', countDown);
  // }
  //
  // void setCountDown() {
  //   if (countDown != 0) {
  //     setState(() {
  //       countDown = 15;
  //       setCountDown();
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   checkTimerValue();
  // }
  //
  // checkTimerValue() async {
  //   int timer = await getTimerValue() ?? 0;
  //   setState(() {
  //     countDown = timer;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    final auth = FirebaseFirestore.instance;

    final productProvider = Provider.of<ProductProvider>(context);
    return ListView(
      children: [
        VideoCard(
          taskList: productProvider.whatsAppTasks,
        ),
        VideoCard(
          taskList: productProvider.instagramTasks,
        ),
        TaskCard(
          child: Text(
            'Daily Reward',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          info: 'You will be shown an add',
          buttonText: 'Get Reward',
          onPressed: () async {
            int updateCoins = int.parse(user.userModel.vCoins) + 1;
            await auth
                .collection('users')
                .doc(user.userModel?.id)
                .update({'vCoins': updateCoins.toString()});
            print('added');
          },
          //?? 'wait $countDown mins',
          // onPressed: () {
          //   setCountDown();
          //}
        ),
        TaskCard(
          child: Column(
            children: [
              Text(
                'Invite a friend',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                '$referCode',
                style: TextStyle(fontSize: 20, color: Colors.red),
              )
            ],
          ),
          info: 'Get rewarded with 10 coins for every friend you invite ',
          buttonText: 'Send',
          onPressed: () async {
            print(dynamicUrl);
            await Share.share('${dynamicUrl.toString()}');
          },
        ),
      ],
    );
  }
}
