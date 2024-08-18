import 'package:flutter/material.dart';
import 'package:project_fourth/controllers/list_student_controller.dart';
import 'package:project_fourth/screens/widgets/delete_popup.dart';
import 'package:provider/provider.dart';
import 'package:project_fourth/db/models/data_model.dart';
import 'package:project_fourth/screens/widgets/update_student2.widget.dart';
import 'package:project_fourth/screens/widgets/view_student_widget.dart';

class ListStudentWidget extends StatelessWidget {
   const ListStudentWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListStudentController(),
      child: Consumer<ListStudentController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                      controller.isGridView ? Icons.list : Icons.grid_view),
                  onPressed: controller.toggleView,
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearSearch,
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: controller.refreshList,
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        hintText: 'Enter student name',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: controller.searchQueryChanged,
                    ),
                  ),
                  Expanded(
                    child: controller.filteredStudentList.isEmpty
                        ? _buildEmptyListWidget(context)
                        : controller.isGridView
                            ? _buildGridView(controller.filteredStudentList)
                            : _buildListView(controller.filteredStudentList),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyListWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'List is Empty',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Add Student'),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<StudentModel> filteredList) {
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (ctx, index) {
        final data = filteredList[index];
        return buildListTile(ctx, data);
      },
    );
  }

  Widget _buildGridView(List<StudentModel> filteredList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: filteredList.length,
      itemBuilder: (ctx, index) {
        final data = filteredList[index];
        return buildGridTile(ctx, data);
      },
    );
  }

  Widget buildListTile(BuildContext context, StudentModel data) {
    return ListTile(
      leading: Image.asset('lib/assets/student1.png'),
      title: Text(data.name),
      subtitle: Row(
        children: [
          const SizedBox(width: 10),
          TextButton(
            onPressed: () async {
              if (data.id != null) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserDataPage2(
                      idvalue: data.id!,
                      refreshCallback: () {
                        Provider.of<ListStudentController>(context,
                                listen: false)
                            .refreshList();
                      },
                    ),
                  ),
                );

                if (result == true) {
                  // ignore: use_build_context_synchronously
                  Provider.of<ListStudentController>(context, listen: false)
                      .refreshList();
                }
              } else {
                // ignore: avoid_print
                print('The Id value of the data is null');
              }
            },
            child: const Text('Edit'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              if (data.id != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewStudentWidget(student: data),
                  ),
                );
              } else {
                // ignore: avoid_print
                print('The Id value of the data is null');
              }
            },
            child: const Text('View'),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          if (data.id != null) {
            showDialog(
              context: context,
              builder: (context) => AlertPopup(
                itemId: data.id!,
                onDeleted: () {
                  Provider.of<ListStudentController>(context, listen: false)
                      .refreshList();
                },
              ),
            );
          } else {
            // ignore: avoid_print
            print('Student ID is null, unable to delete');
          }
        },
      ),
    );
  }

  Widget buildGridTile(BuildContext context, StudentModel data) {
    return GridTile(
      child: Card(
        child: InkWell(
          onTap: () {
            if (data.id != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ViewStudentWidget(student: data),
                ),
              );
            } else {
              // ignore: avoid_print
              print('The Id value of the data is null');
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'lib/assets/student1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}