import 'package:flutter/material.dart';
import 'package:myexpensetracker/Model/boxes.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';
import 'package:myexpensetracker/UI%20Elements/listOfIcons.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  int chosenIcon = -1;
  bool iconsExpanded = false;
  List days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  String pickADateTitle = "Pick a date";
  late String chosenDate = "Monday, December - 2019";

  TextEditingController titleController = TextEditingController();
  TextEditingController expenseController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String formatDate(DateTime date) {
    List<String> days = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"];
    List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

    String day = days[date.weekday - 1];
    String month = months[date.month - 1];
    String formattedDate = "$day, ${date.day} - $month - ${date.year}";

    return formattedDate;
  }

  // Register Expense
  void registerExpense(
      String icon, String title, double expense, String note, String date) {
    ExpenseModel currentExpense = ExpenseModel()
      ..icon = icon
      ..title = title
      ..expense = expense
      ..note = note
      ..date = formatDate(DateTime.now());
    final box = Boxes.getExpenses();
    box.add(currentExpense);
    setState(() {});
    Navigator.pushReplacementNamed(context, "homePage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children: [
          // Back Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
          // Add Expense Title
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add Expenses Message
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
                  child: Text(
                    "\t\t Add 💰\nExpenses ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Input Expenses
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Choose an Icon
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      chosenIcon == -1
                          ? Icons.adjust_rounded
                          : ListOfIcons.listOfIcons[chosenIcon],
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    title: Text(
                      "Choose an Icon",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      iconsExpanded
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    onExpansionChanged: (expansionState) {
                      iconsExpanded = expansionState;
                      setState(() {});
                    },
                    tilePadding: EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      Divider(
                        color: Colors.grey[400],
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:Theme.of(context).primaryColor,
                          //border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 76,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: ListOfIcons.listOfIcons.length,
                            itemBuilder: (context, index) {
                              return IconButton(
                                icon: Icon(
                                  ListOfIcons.listOfIcons[index],
                                  color: index == chosenIcon
                                      ? Colors.deepOrangeAccent
                                      : Theme.of(context).secondaryHeaderColor,
                                ),
                                onPressed: () {
                                  chosenIcon = index;
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Enter Title
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "✍",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.grey[900],
                          ),
                          controller: titleController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            labelText: "enter a short title",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Enter Expense Amount
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "💰",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.grey[900],
                          ),
                          keyboardType: TextInputType.number,
                          controller: expenseController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            labelText: "enter how much you spent",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Enter Extra Note
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color:Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "📝",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.grey[900],
                          ),
                          controller: noteController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            labelText: "enter a descriptive note",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.0),
                // Pick a date
                GestureDetector(
                  child: Container(

                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    decoration: BoxDecoration(

                      /*gradient: LinearGradient(
                        colors: [
                          Color(0xffb3ffab),
                          Color(0xff12fff7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),*/
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      pickADateTitle,
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ).then((date) {
                      chosenDate = days[date!.weekday - 1] +
                          ", " +
                          date.day.toString() +
                          " - " +
                          months[date.month] +
                          " - " +
                          date.year.toString();
                      pickADateTitle = chosenDate;
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Color(0xee12fff7),
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 28.0,
        ),
        onPressed: () {
          if(chosenIcon == -1){
            return;
          }
          // Register Expense
          registerExpense(
            chosenIcon == -1 ? "Icons.adjust_rounded" : chosenIcon.toString(),
            titleController.text,
            double.parse(expenseController.text),
            noteController.text,
            "Friday the 13 th", //chosenDate,
          );
        },
      ),
    );
  }

}
