import 'package:flutter/material.dart';

class ScreenTransacton extends StatelessWidget {
  const ScreenTransacton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
                    itemBuilder: (ctx, index){
                      return Card(
                        child: ListTile(
                          leading: Text('02 july'),
                          title: Text('xxxxx'),
                          subtitle: Text('Travel'),
                        ),
                      );
                    } , 
                    separatorBuilder:(ctx,index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount: 10,
                    );
  }
}
