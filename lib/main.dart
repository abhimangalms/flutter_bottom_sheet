import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';

void main() {
  List<ListItem> testArray = new List(10);
  for(var inc = 0; inc < 10; inc++){
    testArray[inc] = (inc % 2 == 0 ? HeadingItem("Location $inc") : MessageItem("22.02.2020 | 04.30 $inc", "Theatre name $inc"));
//    testArray[inc] = HeadingItem("Location $inc");
  }
  runApp(SlidingUpPanelExample(
      items : testArray
  ));
}

class SlidingUpPanelExample extends StatefulWidget {
  final List<ListItem> items;

  SlidingUpPanelExample({Key key, @required this.items}) : super(key: key);

  @override
  _SlidingUpPanelExampleState createState() => _SlidingUpPanelExampleState();
}

class _SlidingUpPanelExampleState extends State<SlidingUpPanelExample> {

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen = 570.0;
  double _panelHeightClosed = 70.0;

  String selectedLocation;
  String selectedDate;

  final List<String> _dropdownValuesLocation = [
    "Ernakulam",
    "Angamaly",
    "Chalakkudy",
  ];
  final List<String> _dropdownValuesDates = [
    "01.01.2020",
    "03.01.2020",
    "08.01.2020",
  ];

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Material(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text("View goes here",
                  style: TextStyle(
                      fontSize: 36.0
                  ),),
              ),

              SlidingUpPanel(
                maxHeight: _panelHeightOpen,
                minHeight: _panelHeightClosed,
                parallaxEnabled: true,
                parallaxOffset: .5,
//            body: _body(),
                panel: _panel(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _panel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 12.0,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),

        SizedBox(
          height: 10.0,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Discover movie",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20.0,
              ),
            ),
          ],
        ),

        SizedBox(
          height: 30.0,
        ),

        Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              dateDropDownButton(_dropdownValuesDates),
              SizedBox(width: 4.0),
              locationDropDownButton(_dropdownValuesLocation),
            ],
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

      Expanded(
        child: sectionList(),
      )

      ],
    );
  }

  Widget dateDropDownButton(List<String> dropdownValues) {
    return Column(
      children: <Widget>[
        new Container(
          width: 150,
          height: 35,
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
                color: Colors.black54, style: BorderStyle.solid, width: 0.80),
          ),
          child: new ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 130.0, maxHeight: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Icon(
                  Icons.date_range,
                  color: Colors.black54,
                ),
                SizedBox(width: 5.0),
                new DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text("Date"),
                    isDense: true,
                    value: selectedDate,
                    items: dropdownValues.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String changedDateValue) {
                      selectedDate = changedDateValue;
                      setState(() {
                        selectedDate; //setting the selected value into drop down
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget locationDropDownButton(List<String> dropdownValues) {
    return Column(
      children: <Widget>[
        new Container(
          width: 150,
          height: 35,
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
                color: Colors.black54, style: BorderStyle.solid, width: 0.80),
          ),
          child: new ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 130.0, maxHeight: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Icon(
                  Icons.location_on,
                  color: Colors.black54,
                ),
                SizedBox(width: 5.0),
                new DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text("Location"),
                    isDense: true,
                    value: selectedLocation,
                    items: dropdownValues.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String changedLocationValue) {
                      selectedLocation = changedLocationValue;
                      setState(() {
                        selectedLocation; //setting the selected value into drop down
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sectionList() {
    return ListView.builder(
      shrinkWrap: true,
      // Let the ListView know how many items it needs to build.
      itemCount: widget.items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      // ignore: missing_return
      itemBuilder: (context, index) {
        final item = widget.items[index];

        if (item is HeadingItem) {
          return ListTile(
            title: Text(
              item.heading_test,
              style: Theme.of(context).textTheme.headline,
            ),
          );
        } else if (item is MessageItem) {
          return Card(
            elevation: 8.0,
            margin:
            EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
            color: Colors.white,
            child: new Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.date_range,
                            color: Colors.pinkAccent,
                            size: 18,),
                          new Container(
                              margin: EdgeInsets.only(left: 5.0),
                              constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 300),
                              child: Text(
                                item.sender,
                                style: new TextStyle(
                                    fontSize: 16.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.normal),
                                maxLines: 1,
                              ))
                        ]),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        new Icon(Icons.location_on,
                          color: Colors.pinkAccent,
                          size: 18,),
                        new Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 4.0),
                            constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 300),
                            child: Text(
                              item.body,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF2d2424),
                                  fontWeight: FontWeight.w300),
                              maxLines: 4,
                            )),
                      ],
                    ),
                    SizedBox(height: 8,),
                    new Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10.0),
                        constraints:
                        BoxConstraints(minWidth: 100, maxWidth: 300),
                        child: Text(
                          "Theatre location",
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: const Color(0xFF2d2424),
                              fontWeight: FontWeight.w300),
                          maxLines: 4,
                        )),
                    SizedBox(height: 8,),
                    new Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10.0),
                        constraints:
                        BoxConstraints(minWidth: 100, maxWidth: 300),
                        child: Text(
                          "Theatre address",
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: const Color(0xFF2d2424),
                              fontWeight: FontWeight.w300),
                          maxLines: 4,
                        )),
                  ]),
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 15.0, bottom: 15.0),
              alignment: Alignment.center,
            ),
          );
        }
      },
    );
  }
}

abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading_test;

  HeadingItem(this.heading_test);
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
