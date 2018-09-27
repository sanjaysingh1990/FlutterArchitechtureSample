import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/dialog/Dialogs.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(SwipeToDelete());
}

// MyApp is a StatefulWidget. This allows us to update the state of the
// Widget whenever an item is removed.
class SwipeToDelete extends StatefulWidget {
  SwipeToDelete({Key key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<SwipeToDelete> {
  MyItem deletedItem;

  final items = List<MyItem>();
  var uuid = new Uuid();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //add 10 items to list

    for (int i = 0; i < 10; i++) {
      items.add(new MyItem(
          title: "Sanjay Singh Bisht $i",
          color: "#123ab$i",
          uniqueId: uuid.v1()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return new Slidable(
              delegate: new SlidableDrawerDelegate(),
              actionExtentRatio: 0.25,
              child: new Container(
                color: Colors.white,
                child: new ListTile(
                  leading: new CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: new Text('${item.title}'),
                    foregroundColor: Colors.white,
                  ),
                  title: new Text('${item.title}'),
                  subtitle: new Text('SlidableDrawerDelegate'),
                ),
              ),
              secondaryActions: <Widget>[
                new IconSlideAction(
                    caption: 'Edit',
                    color: Colors.black45,
                    icon: Icons.edit,
                    onTap: () => _editItem(context, index)),
                new IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => _confirmationDialog(context, index),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _editItem(BuildContext context, int index) {
    print("edititem$index");
  }

  void _confirmationDialog(BuildContext context, int index) {
    print("delete$index");
    deletedItem = items[index];
    new Dialogs().warningDialog(
        context, "Are you sure want to delete this", deleteConfirmation);
  }

  VoidCallback deleteConfirmation() {
    print("called");
    if (items.contains(deletedItem)) {
      setState(() {
        items.remove(deletedItem);
      });
    }
  }
}

class MyItem {
  MyItem({@required this.title, @required this.color, @required this.uniqueId});

  MyItem.from(MyItem other)
      : title = other.title,
        color = other.color,
        uniqueId = other.uniqueId;
  final String title;
  final String color;
  String uniqueId;

  set uniqueID(String id) => uniqueId = id;
}
