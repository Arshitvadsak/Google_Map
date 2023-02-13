import 'package:flutter/material.dart';
import 'components/DetailPage.dart';
import 'components/constants.dart';
import 'modals/globals.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
      '/': (context) => const HomePage(),
      'DetailPage': (context) => const DetailPage(),
      'MapPage': (context) =>  Map_Page(),
    },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company CEOS"),
        backgroundColor: Colors.orange[200],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: CompanyDetails.map(
            (e) => Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, arguments: e,"DetailPage");
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        height: 60,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${e['companylogo']}"),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            "${e['companyname']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "${e['ceoname']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "${e['ceophoto']}",
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
