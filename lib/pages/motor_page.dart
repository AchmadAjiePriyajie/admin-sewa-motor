import 'package:admin_sewa_motor/Services/motor_service.dart';
import 'package:admin_sewa_motor/components/my_drawer.dart';
import 'package:admin_sewa_motor/pages/form_motor_page.dart';
import 'package:admin_sewa_motor/pages/motor_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MotorPage extends StatefulWidget {
  const MotorPage({super.key});

  @override
  State<MotorPage> createState() => _MotorPageState();
}

class _MotorPageState extends State<MotorPage> {
  MotorService motorService = MotorService();

  Widget _floatingActionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[600],
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () => Navigator.pushNamed(context, '/add_motor_page'),
        icon: Icon(
          Icons.add,
        ),
        color: Colors.white,
      ),
    );
  }

  void warningDelete(String docID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Do you want to delete this?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'cancel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              motorService.deleteNote(docID);

              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'delete',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            color: Colors.white,
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: Text(
          'Motor',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: _floatingActionButton(context),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: motorService.getMotorStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> motorList = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: motorList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = motorList[index];
                        String docID = document.id;

                        // get note from each doc
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        String namaMotor = data['namaMotor'];
                        String merk = data['merk'];
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  namaMotor,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  merk,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MotorDetailPage(
                                          docID: docID,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FormMotorPage(
                                        docID: docID,
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.mode_edit,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => warningDelete(docID),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text(
                      'Belum ada motor',
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
