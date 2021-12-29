import 'package:flutter/material.dart';
import 'package:textform095/models/food.dart';
import 'package:textform095/models/subject.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.Title}) : super(key: key);

  final Title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  String? foodValue;

  late List<Food> foods;
  late List<Subject> subject;
  List<ListItem> dropdownItems = ListItem.getListItem();
  late List<DropdownMenuItem<ListItem>> dropdownMenuItems;
  late ListItem _selectedItem;

  List selectedSubject = [];

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    subject = Subject.getSubject(); //ไปเอาค่า Subject มาเก็บไว้
    dropdownMenuItems = createDropdropdownMenu(dropdownItems);
    _selectedItem = dropdownMenuItems[0].value!;
  }

  List<DropdownMenuItem<ListItem>> createDropdropdownMenu(
      List<ListItem> dropdownItems) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in dropdownItems) {
      items.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item,
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        user(),
                        SizedBox(height: 16),
                        pass(),
                        Column(
                          children: createFoodRadio(),
                        ),
                        Text('Itim Selected: $foodValue'),
                        const SizedBox(height: 14),
                        Column(
                          children: createSubjectCheckbox(),
                        ),
                        const SizedBox(height: 14),
                        DropdownButton(
                            value: _selectedItem,
                            items: dropdownMenuItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value as ListItem;
                              });
                            }),
                        Text('Item selected: ' +
                            _selectedItem.value!.toString() +
                            ' ' +
                            _selectedItem.name!),
                        submit(),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  ElevatedButton submit() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          print(_usernamecontroller.text);
          print(_passwordcontroller.text);
        }
      },
      child: Text('submit'),
    );
  }

  TextFormField pass() {
    return TextFormField(
      controller: _passwordcontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter password Please';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.password),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0,
          )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0,
          ))),
    );
  }

  TextFormField user() {
    return TextFormField(
      controller: _usernamecontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Username Please';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Username',
          prefixIcon: Icon(Icons.person),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0,
          )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0,
          ))),
    );
  }

  List<Widget> createFoodRadio() {
    List<Widget> listRadioFood = [];

    listRadioFood = foods
        .map(
          (food) => RadioListTile<dynamic>(
              title: Text(food.thName!),
              subtitle: Text(food.eName!),
              secondary: Text(food.price!.toString() + 'บาท'),
              value: food.foodvalue,
              groupValue: foodValue,
              onChanged: (value) {
                setState(() {
                  foodValue = value!;
                });
              }),
        )
        .toList();

    return listRadioFood;
  }

  List<Widget> createSubjectCheckbox() {
    List<Widget> listCheckboxSubject = [];

    for (var subject in subject) {
      listCheckboxSubject.add(
        CheckboxListTile(
          title: Text(subject.subName!),
          subtitle: Text('credit: ${subject.credit}'),
          value: subject.checked,
          onChanged: (value) {
            setState(() {
              subject.checked = value!;
            });

            // ให้เขียน item ออกจาก List
            if (value!) {
              selectedSubject.add(subject.subName!);
            }
            print(selectedSubject);
          },
        ),
      );
    }
    return listCheckboxSubject;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);

  static List<ListItem> getListItem() {
    return [
      ListItem(1, 'Itim 1'),
      ListItem(2, 'Itim 2'),
      ListItem(3, 'Itim 3'),
      ListItem(4, 'Itim 4'),
    ];
  }
}





                        // RadioListTile(
                        //   title: Text('pizzaaaaaa'),
                        //   subtitle: Text('2000 บาท'),
                        //   value: 'pizza',
                        //   groupValue: foodValue,
                        //   onChanged: (value){
                        //     setState(() {
                        //       foodValue = value.toString();
                        //     });
                        //   }
                        //   ),
                        // RadioListTile(
                        //   title: Text('Steak'),
                        //   subtitle: Text('16 บาท'),
                        //   value: 'Steak',
                        //   groupValue: foodValue,
                        //   onChanged: (value){
                        //     setState(() {
                        //      foodValue = value.toString();
                        //     });
                        //   }
                        //   ),