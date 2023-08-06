import 'package:flutter/material.dart';

class CustomPostContainer extends StatelessWidget {
  final String name;
  final String content;
  final String time;
  final String username;
  final void Function()? onTap;

  const CustomPostContainer(
      {super.key,
      required this.name,
      required this.content,
      required this.time,
      required this.username,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 8.0, top: 8.0, bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 24.0,
              child: Icon(Icons.person_outlined),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 6.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '$name\t\t',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                child: Text(
                                  '@$username',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('• $time'),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(25.0),
                              onTap: () {
                                List<String> options = ['Edit', 'Delete'];
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: 640.0,
                                      height: 110.0,
                                      child: ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: options.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 26.0),
                                              child: Text(
                                                options[index],
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.more_vert_rounded,
                                  size: 18.0,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      content,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
