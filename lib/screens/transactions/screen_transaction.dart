import 'package:flutter/material.dart';

class ScreenTransacton extends StatelessWidget {
  const ScreenTransacton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding:const EdgeInsets.all(10) ,
                    itemBuilder: (ctx, index){
                      return const Card(
                        child: ListTile(
                          leading: CircleAvatar(
                                        radius:50, 
                                        child:Text('02\njuly',textAlign: TextAlign.center,)
                                       ),
                          title: Text('RS xxxxx'),
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
