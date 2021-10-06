import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/providers/product_provider.dart';
import 'package:vanfly/refer_and_earnn/create_referal_code.dart';
import 'package:vanfly/refer_and_earnn/dynamic_link.dart';
import 'package:vanfly/widgets/task_card.dart';
import 'package:vanfly/widgets/video_card.dart';
import 'package:share/share.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
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
