import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/admin_naviagtor.dart';
import 'package:translation_office_flutter/pages/adminpages/old_app_info.dart';
import 'package:translation_office_flutter/services/admin_api.dart';

class ViewOldApp extends StatefulWidget {
  const ViewOldApp({super.key});

  @override
  State<ViewOldApp> createState() => _ViewOldAppState();
}

class _ViewOldAppState extends State<ViewOldApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminNaviagtor(),
      appBar: AppBar(
        title: const Text("Previous Appointments"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: AdminApi.getpreviousTranslations(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String fromlang = snapshot.data![index]['fromlang'];
                String tolang = snapshot.data![index]['tolang'];
                DateTime date = DateTime.parse(snapshot.data![index]['date']);
                DateTime newtime =
                    DateTime(0, 0, 0, date.hour + 2, date.minute);
                bool onthephone = snapshot.data![index]['onthephone'];
                String clientname = snapshot.data![index]['clientname'];
                String translatorname = snapshot.data![index]['translatorname'];
                bool inperson = snapshot.data![index]['inperson'];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 3,
                    ),
                    child: ListTile(
                      leading: onthephone
                          ? Column(
                              children: const [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'On the phone',
                                  style: TextStyle(
                                    fontSize: 9,
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: const [
                                Icon(
                                  Icons.people_alt_sharp,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  ' In person',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          top: 2.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          clientname,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      subtitle: Text(
                          ' From $fromlang To $tolang, ${date.day}/${date.month}/${date.year}  ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.all(10),
                      trailing: IconButton(
                        icon: Icon(
                          CupertinoIcons.arrow_right,
                          size: 30,
                          color: Colors.blue[500],
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OldAppInfo(
                                clientname: clientname,
                                fromlang: fromlang,
                                tolang: tolang,
                                date: date,
                                time: newtime,
                                onthephone: onthephone,
                                inperson: inperson,
                                translatorname: translatorname,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
