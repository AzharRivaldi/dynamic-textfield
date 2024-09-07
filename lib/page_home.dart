import 'dart:convert';

import 'package:dynamic_textfield/model_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List countList = ['Pilih:', '1', '2', '3', '4', '5'];
  List<TextEditingController> listController = [TextEditingController()];
  final TextEditingController textUserName = TextEditingController();
  String dropValue = 'Pilih:';
  var dropListUser;
  var userSelectedName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Dynamic TextField',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 1
                  ),
                ),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  hint: const Text('Pilih:',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black
                      )
                  ),
                  value: dropValue,
                  onChanged: (value) {
                    setState(() {
                      dropValue = value.toString();
                      int iLength = listController.length;
                      int iValue = int.parse(dropValue);

                      if (iLength > 1 && iLength > iValue) {
                        listController.removeRange(0 + iValue, iLength);
                      }
                      for (var i = iLength; i < iValue; i++) {
                        listController.add(TextEditingController());
                      }
                    });
                  },
                  items: countList.map((value) {
                    return DropdownMenuItem(
                      value: value.toString(),
                      child: Text(value.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black
                          )
                      ),
                    );
                  }).toList(),
                  icon: const Icon(
                      Icons.arrow_drop_down
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  isExpanded: true,
                ),
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              primary: false,
              itemCount: listController.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                color: Colors.black
                            ),
                            controller: listController[index],
                            autofocus: false,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText: 'Cari Nama',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            int noIndex = index;
                            if (dropValue == 'Pilih:') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                        width: 10
                                    ),
                                    Text('Ups, jumlah dropdown harus dipilih!',
                                        style: TextStyle(
                                            color: Colors.white
                                        )
                                    ),
                                  ],
                                ),
                                backgroundColor: Color(0xffffb129),
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                            else {
                              showModalBottomSheet(
                                  useRootNavigator: true,
                                  isScrollControlled: true,
                                  enableDrag: false,
                                  isDismissible: false,
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.black.withAlpha(1),
                                  elevation: 0,
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context).size.height * 0.9
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)
                                            )
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20
                                                    ),
                                                    child: Text(
                                                      "Pilih Nama",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 20
                                                    ),
                                                    child: IconButton(
                                                      iconSize: 30,
                                                      icon: const Icon(
                                                          Icons.clear
                                                      ),
                                                      onPressed: () => Navigator.pop(context),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: FutureBuilder<List<ModelListUser>>(
                                                  future: getListUser(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.done) {
                                                      if (snapshot.data!.isEmpty) {
                                                        return SizedBox(
                                                            height: size.height / 1.3,
                                                            child: const Center(
                                                                child: Text(
                                                                  "Ups, tidak ada data!",
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                            )
                                                        );
                                                      }
                                                      else {
                                                        return ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemCount: snapshot.data!.length,
                                                            itemBuilder: (context, index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    dropListUser = '${snapshot.data![index].first_name} ${snapshot.data![index].last_name}';
                                                                    userSelectedName = '${snapshot.data![index].first_name} ${snapshot.data![index].last_name}';

                                                                    Navigator.of(context).pop(false);
                                                                    listController[noIndex].text = userSelectedName.toString();
                                                                  });
                                                                },
                                                                child: Card(
                                                                  margin: const EdgeInsets.all(10),
                                                                  clipBehavior: Clip.antiAlias,
                                                                  elevation: 5,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  color: Colors.white,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: const EdgeInsets.only(
                                                                              right: 14
                                                                          ),
                                                                          width: 70,
                                                                          height: 70,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: NetworkImage(
                                                                                snapshot.data![index].avatar!,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Flexible(
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                '${snapshot.data![index].first_name} ${snapshot.data![index].last_name}',
                                                                                style: const TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 18
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 10),
                                                                              Container(
                                                                                padding:
                                                                                const EdgeInsets.all(4),
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    color: Colors.green
                                                                                ),
                                                                                child: Text(
                                                                                  snapshot.data![index].email!,
                                                                                  style: const TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 10
                                                                                  ),
                                                                                  maxLines: 2,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      }
                                                    }
                                                    else if (snapshot.connectionState == ConnectionState.none) {
                                                      return SizedBox(
                                                          height: size.height / 1.3,
                                                          child: Center(
                                                              child: Text("${snapshot.error}")
                                                          )
                                                      );
                                                    }
                                                    else {
                                                      return SizedBox(
                                                        height: size.height / 1.3,
                                                        child: const Center(
                                                          child: CircularProgressIndicator(
                                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green)
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          });
                        },
                        child: const Icon(
                          Icons.search_outlined,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            listController[index].clear();
                          });
                        },
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ModelListUser>> getListUser() async {
    var baseURL = Uri.parse("https://reqres.in/api/users?page=1");
    var apiResult = await http.get(baseURL);
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

    List<ModelListUser> users = [];
    for (int i = 0; i < listUser.length; i++) {
      users.add(ModelListUser.fromJson(listUser[i]));
    }
    return users;
  }
}
