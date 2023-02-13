import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> CompanyDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details of company"),
        centerTitle: true,
        backgroundColor: Colors.orange[200],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${CompanyDetails['companyname']}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 20),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${CompanyDetails['companylogo']}"),
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
          Text(
            "---------------------------------------------",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text("Company Desc",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
          Text(
            "---------------------------------------------",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("${CompanyDetails['description']}",style: TextStyle(fontSize: 15),),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "company Location",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 60),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange[200]!,),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'MapPage', arguments: CompanyDetails);
                },
                child: Text("Click now"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
