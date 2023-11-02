import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:plov/src/core/router/router.dart';
import 'package:skadi/skadi.dart';

class UserListPage extends StatefulWidget {
  final String? accountNumber;
  final String? type;
  const UserListPage({super.key, this.accountNumber, this.type});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

List<String> accounts = List.generate(20, (index) => Faker().person.name());

class _UserListPageState extends State<UserListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  String currentUser = "";

  FutureManager<int> manager = FutureManager();
  late TabController tabController;

  Future<int> updateData() async {
    await SkadiUtils.wait(1500);
    return Faker().randomGenerator.integer(99);
  }

  void init() {
    if (widget.accountNumber != null) {
      manager.execute(updateData);
    }
    if (widget.type != null) {
      if (widget.type == "history") {
        tabController = TabController(
          length: 2,
          vsync: this,
          initialIndex: 1,
        );
      } else {
        tabController = TabController(length: 2, vsync: this);
      }
    } else {
      tabController = TabController(length: 2, vsync: this);
    }
  }

  @override
  void dispose() {
    manager.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    init();
    debugLog("Recreate");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugLog("Rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.accountNumber != null ? widget.accountNumber! : "Users"),
        // automaticallyImplyLeading: false,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.accountNumber == null || context.screenSize.width > 760) _buildUserList(),
          if (widget.accountNumber != null) _buildUserDetails(),
        ],
      ),
    );
  }

  Widget _buildUserDetails() {
    final faker = Faker();
    return Expanded(
      child: manager.when(
        ready: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.blue[300],
                controller: tabController,
                onTap: (value) {
                  // String type = value == 0 ? "profile" : "history";
                  // goRouter.go("/account/${widget.accountNumber}?type=$type");
                },
                tabs: const [
                  Tab(text: "Profile"),
                  Tab(text: "History"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: CircleAvatar(
                              radius: 50,
                              child: Icon(Icons.person, size: 50),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Personal Information", style: kTs18.bold),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("First name"),
                            subtitle: Text(faker.person.firstName()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("last name"),
                            subtitle: Text(faker.person.firstName()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: const Text("Email"),
                            subtitle: Text(faker.internet.email()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.call),
                            title: const Text("Phone number"),
                            subtitle: Text(faker.phoneNumber.us()),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        final faker = Faker();
                        return ListTile(
                          title: Text(faker.food.dish()),
                          subtitle: Text("\$${faker.randomGenerator.integer(1000)}"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserList() {
    return SizedBox(
      width: context.isDesktop ? 350 : context.screenSize.width,
      child: ListView.builder(
        itemCount: accounts.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          final accountNumber = "00$index 100 200";
          final accountNumberTrim = accountNumber.replaceAll(" ", "");
          final selected = widget.accountNumber == accountNumberTrim;
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey[200]!,
                width: 0.2,
              ),
              borderRadius: SkadiDecoration.radius(),
            ),
            child: ListTile(
              onTap: () {
                goRouter.go("/account/$accountNumberTrim");
                tabController.animateTo(0);
                manager.execute(updateData);
              },
              selected: selected,
              title: Text(accounts[index]),
              subtitle: const Text("\$ 2303.4"),
              trailing: Text(accountNumber),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
