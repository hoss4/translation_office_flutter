// ignore_for_file: prefer_const_constructors
/////////
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/admin_naviagtor.dart';
import 'package:translation_office_flutter/pages/adminpages/request_info.dart';
import 'package:translation_office_flutter/services/admin_api.dart';

class ViewRequest extends StatefulWidget {
  const ViewRequest({super.key});

  @override
  State<ViewRequest> createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminNaviagtor(),
      appBar: AppBar(
        title: Text("Requested Translations"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: AdminApi.getRequestedTranslations(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String id = snapshot.data![index]['_id'];
                    String fromlang = snapshot.data![index]['fromlang'];
                    String tolang = snapshot.data![index]['tolang'];
                    DateTime date =
                        DateTime.parse(snapshot.data![index]['date']);
                    DateTime newtime =
                        DateTime(0, 0, 0, date.hour + 2, date.minute);
                    bool onthephone = snapshot.data![index]['onthephone'];
                    String clientname = snapshot.data![index]['clientname'];
                    bool inperson = snapshot.data![index]['inperson'];
                    DateTime createdat =
                        DateTime.parse(snapshot.data![index]['createdAt']);
                    createdat = createdat.add(const Duration(hours: 3));

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 3),
                        child: ListTile(
                          leading: onthephone
                              ? Column(
                                  children: const [
                                    Icon(
                                      Icons.phone,
                                      size: 20,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'On the phone',
                                      style: TextStyle(fontSize: 9),
                                    )
                                  ],
                                )
                              : Column(
                                  children: const [
                                    Icon(Icons.people_alt_sharp),
                                    SizedBox(height: 8),
                                    Text(
                                      ' In person',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                          title: Padding(
                            padding: const EdgeInsets.only(
                              top: 2.0,
                              bottom: 10.0,
                            ),
                            child: Text(clientname,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          subtitle: Text(
                              ' From $fromlang To $tolang, ${date.day}/${date.month}/${date.year}  ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          isThreeLine: true,
                          contentPadding: EdgeInsets.all(10),
                          trailing: IconButton(
                            icon: Icon(
                              CupertinoIcons.arrow_right,
                              size: 30,
                              color: Colors.blue[500],
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RequestInfo(
                                      translationid: id,
                                      clientname: clientname,
                                      fromlang: fromlang,
                                      tolang: tolang,
                                      date: date,
                                      time: newtime,
                                      onthephone: onthephone,
                                      inperson: inperson,
                                      createdat: createdat)));
                            },
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
