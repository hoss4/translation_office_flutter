import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/components/translator_navigator.dart';
import 'package:translation_office_flutter/pages/translatorpages/view_cominginfo.dart';
import 'package:translation_office_flutter/services/translator_api.dart';

class UpcomingApp extends StatefulWidget {
  const UpcomingApp({super.key});

  @override
  State<UpcomingApp> createState() => _UpcomingAppState();
}

class _UpcomingAppState extends State<UpcomingApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const TranslatorNaviagtor(),
      appBar: AppBar(
        title: const Text("Upcoming Appointements"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: TranslatorApi.getupcomingTranslations(),
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
                        DateTime.parse(snapshot.data![index]['created']);
                    createdat = createdat.add(const Duration(hours: 2));

                    DateTime acceptedat =
                        DateTime.parse(snapshot.data![index]['createdAt']);
                    acceptedat = acceptedat.add(const Duration(hours: 2));

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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          subtitle: Text(
                              ' From $fromlang To $tolang, ${date.day}/${date.month}/${date.year}',
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
                                  builder: (context) => UpAppInfo(
                                    clientname: clientname,
                                    date: date,
                                    fromlang: fromlang,
                                    tolang: tolang,
                                    time: newtime,
                                    inperson: inperson,
                                    onthephone: onthephone,
                                    translationid: id,
                                    createdat: createdat,
                                    acceptedat: acceptedat,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
