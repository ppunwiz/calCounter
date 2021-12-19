import 'package:cal_counter/model/food/food.dart';
import 'package:cal_counter/model/record/record.dart';
import 'package:cal_counter/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class RecordViewPage extends StatefulWidget {
  const RecordViewPage({Key key}) : super(key: key);

  @override
  RecordViewPageState createState() => RecordViewPageState();
}

class RecordViewPageState extends State<RecordViewPage>{
  void _handleNewDate(date) {
    if (mounted){
      setState(() {
        _selectedDay = date;
        _selectedEvents = _events[_selectedDay] ?? [];
      });
    }
    print(_selectedEvents);
  }

  List<CleanCalendarEvent> _selectedEvents;
  DateTime _selectedDay;

  final Map<DateTime, List<CleanCalendarEvent>> _events = {};
  Box<Record> box = Hive.box('records');

  void record(){
    for(Record rec in box.values.toList()){
      print(rec.timestamp);
      DateTime date = new DateTime(rec.timestamp.year,rec.timestamp.month,rec.timestamp.day);
      String text = date.toString() + "\n";
      text+="Food List: [";
      for(Food f in rec.foods){
        text+=f.name+", ";
      }
      text+="] kCals: "+rec.kCals.toString();

      if(_events.containsKey(date)){
        _events[date].add(CleanCalendarEvent(text, startTime: date, endTime: date));
        print('date event '+date.toString());
        print('time event '+date.hour.toString()+":"+date.minute.toString());
        print('add event '+_events[date].toString());
      }
      _events.putIfAbsent(date, () => [CleanCalendarEvent(text, startTime: date, endTime: date)]);
    }
  }

  @override
  void initState() {
    super.initState();
    record();
    print('event '+_events.length.toString());
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BackButton( onPressed: () { Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()
              ));
              }
              ),
              Spacer(),
              Text("Records"),
              Spacer(),
            ]
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 0.0,

      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(child:
              Container(
                child: Calendar(
                  startOnMonday: true,
                  weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                  events: _events,
                  onRangeSelected: (range) =>
                      print("Range is ${range.from}, ${range.to}"),
                  onDateSelected: (date) => _handleNewDate(date),
                  isExpandable: true,
                  eventDoneColor: Colors.green,
                  selectedColor: Colors.pink,
                  todayColor: Colors.yellow,
                  eventColor: Colors.grey,
                  isExpanded: true,
                  dayOfWeekStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 11),
                ),
              ),
            ),
            _buildEventList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(0.0),
        itemBuilder: (BuildContext context, int index) {
          final CleanCalendarEvent event = _selectedEvents[index];
          final String start =
          DateFormat('HH:mm').format(event.startTime).toString();
          final String end =
          DateFormat('HH:mm').format(event.endTime).toString();
          return ListTile(
            contentPadding:
            EdgeInsets.only(left: 2.0, right: 8.0, top: 2.0, bottom: 2.0),
            leading: Container(
              width: 10.0,
              color: event.color,
            ),
            title: Text(event.summary),
            subtitle:
            event.description.isNotEmpty ? Text(event.description) : null,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(start), Text(end)],
            ),
            onTap: () {
              if(mounted) {
                var show = popUp(event.summary);
                showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => show);
              }
            },
          );
        },
        itemCount: _selectedEvents.length,
      ),
    );
  }

  Widget popUp(String text){
    print("tap");
    String date = DateFormat.yMMMMd('en_US').add_jm().format(_selectedDay);
    String title = date;
    print(title);
    return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          FlatButton(textColor: Color(0xFF6200EE),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),)]
    );

  }

}
