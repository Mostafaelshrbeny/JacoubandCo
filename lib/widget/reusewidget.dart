/*BottomNavigationBar(
                                  backgroundColor: const Color(0xFF112C3B),
                                  onTap: (value) {
                                    // Vibration.vibrate(repeat: 0);
                                    HapticFeedback.heavyImpact();
                                    setState(() {
                                      current = value;
                                    });
                                  },
                                  currentIndex: current,
                                  showUnselectedLabels: false,
                                  showSelectedLabels: false,
                                  selectedItemColor:
                                      const Color.fromRGBO(142, 112, 79, 1),
                                  unselectedItemColor:
                                      const Color.fromRGBO(91, 125, 144, 1),
                                  items: [
                                    BottomNavigationBarItem(
                                      icon: AnimatedCrossFade(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        firstChild: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: FaIcon(
                                            FontAwesomeIcons.briefcase,
                                            size: 20,
                                            color: current == 0
                                                ? const Color.fromRGBO(
                                                    142, 112, 79, 1)
                                                : const Color.fromRGBO(
                                                    91, 125, 144, 1),
                                          ),
                                        ),
                                        secondChild: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: FaIcon(
                                            FontAwesomeIcons.briefcase,
                                            size: 20,
                                            color: current == 0
                                                ? const Color.fromRGBO(
                                                    142, 112, 79, 1)
                                                : const Color.fromRGBO(
                                                    91, 125, 144, 1),
                                          ),
                                        ),
                                        crossFadeState: current == 0
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond,
                                      ),
                                      label: '',
                                    ),
                                    BottomNavigationBarItem(
                                        icon: AnimatedCrossFade(
                                          firstChild: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: FaIcon(
                                              FontAwesomeIcons.solidComments,
                                              size: 20,
                                              color: current == 1
                                                  ? const Color.fromRGBO(
                                                      142, 112, 79, 1)
                                                  : const Color.fromRGBO(
                                                      91, 125, 144, 1),
                                            ),
                                          ),
                                          secondChild: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: FaIcon(
                                              FontAwesomeIcons.solidComments,
                                              size: 19,
                                              color: current == 1
                                                  ? const Color.fromRGBO(
                                                      142, 112, 79, 1)
                                                  : const Color.fromRGBO(
                                                      91, 125, 144, 1),
                                            ),
                                          ),
                                          crossFadeState: current == 1
                                              ? CrossFadeState.showFirst
                                              : CrossFadeState.showSecond,
                                          duration:
                                              const Duration(milliseconds: 400),
                                        ),
                                        label: ''),
                                    BottomNavigationBarItem(
                                        icon: AnimatedCrossFade(
                                          crossFadeState: current == 2
                                              ? CrossFadeState.showFirst
                                              : CrossFadeState.showSecond,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          firstChild: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: FaIcon(
                                              FontAwesomeIcons.solidUser,
                                              size: 20,
                                              color: current == 2
                                                  ? const Color.fromRGBO(
                                                      142, 112, 79, 1)
                                                  : const Color.fromRGBO(
                                                      91, 125, 144, 1),
                                            ),
                                          ),
                                          secondChild: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: FaIcon(
                                              FontAwesomeIcons.solidUser,
                                              size: 20,
                                              color: current == 2
                                                  ? const Color.fromRGBO(
                                                      142, 112, 79, 1)
                                                  : const Color.fromRGBO(
                                                      91, 125, 144, 1),
                                            ),
                                          ),
                                        ),
                                        label: ''),
                                  ])
*/
/*
Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color.fromARGB(255, 0, 0, 0),
                                const Color.fromRGBO(2, 20, 31, 1)
                                    .withOpacity(0.009)
                              ]),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          margin: const EdgeInsets.only(
                              bottom: 30 * 0.8,
                              right: 30 * 0.8,
                              left: 30 * 0.8,
                              top: 0),
                          child: SafeArea(
                            left: false,
                            right: false,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: InkblobNavigationBar(
                                backgroundColor: const Color(0xFF112C3B),
                                containerHeight:
                                    MediaQuery.of(context).size.height / 10,
                                items: [
                                  InkblobBarItem(
                                    filledIcon: AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      firstChild: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: FaIcon(
                                          FontAwesomeIcons.briefcase,
                                          size: 20,
                                          color: current == 0
                                              ? const Color.fromRGBO(
                                                  142, 112, 79, 1)
                                              : const Color.fromRGBO(
                                                  91, 125, 144, 1),
                                        ),
                                      ),
                                      secondChild: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        child: FaIcon(
                                          FontAwesomeIcons.briefcase,
                                          size: 20,
                                          color: current == 0
                                              ? const Color.fromRGBO(
                                                  142, 112, 79, 1)
                                              : const Color.fromRGBO(
                                                  91, 125, 144, 1),
                                        ),
                                      ),
                                      crossFadeState: current == 0
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                    ),
                                    emptyIcon: const Icon(
                                      FontAwesomeIcons.briefcase,
                                      size: 20,
                                    ),
                                    color: current == 0
                                        ? const Color.fromRGBO(142, 112, 79, 1)
                                        : const Color.fromRGBO(91, 125, 144, 1),
                                  ),
                                  // Custom Containers
                                  InkblobBarItem(
                                    filledIcon: AnimatedCrossFade(
                                      firstChild: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: FaIcon(
                                          FontAwesomeIcons.solidComments,
                                          size: 20,
                                          color: current == 1
                                              ? const Color.fromRGBO(
                                                  142, 112, 79, 1)
                                              : const Color.fromRGBO(
                                                  91, 125, 144, 1),
                                        ),
                                      ),
                                      secondChild: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidComments,
                                          size: 19,
                                          color: current == 1
                                              ? const Color.fromRGBO(
                                                  142, 112, 79, 1)
                                              : const Color.fromRGBO(
                                                  91, 125, 144, 1),
                                        ),
                                      ),
                                      crossFadeState: current == 1
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration:
                                          const Duration(milliseconds: 400),
                                    ),
                                    emptyIcon: const FaIcon(
                                      FontAwesomeIcons.solidComments,
                                      size: 20,
                                    ),
                                    color: current == 1
                                        ? const Color.fromRGBO(142, 112, 79, 1)
                                        : const Color.fromRGBO(91, 125, 144, 1),
                                  ),
                                  InkblobBarItem(
                                    filledIcon: AnimatedCrossFade(
                                      crossFadeState: current == 2
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      firstChild: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: FaIcon(
                                          FontAwesomeIcons.solidUser,
                                          size: 20,
                                          color: current == 2
                                              ? const Color.fromRGBO(
                                                  142, 112, 79, 1)
                                              : const Color.fromRGBO(
                                                  91, 125, 144, 1),
                                        ),
                                      ),
                                      secondChild: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidUser,
                                          size: 20,
                                          color: current == 2
                                              ? const Color.fromRGBO(
                                                  142, 112, 79, 1)
                                              : const Color.fromRGBO(
                                                  91, 125, 144, 1),
                                        ),
                                      ),
                                    ),
                                    emptyIcon: const FaIcon(
                                      FontAwesomeIcons.solidUser,
                                      size: 20,
                                    ),
                                    color: current == 2
                                        ? const Color.fromRGBO(142, 112, 79, 1)
                                        : const Color.fromRGBO(91, 125, 144, 1),
                                  ),
                                ],
                                selectedIndex: current,
                                iconSize: 50,
                                animationDuration:
                                    const Duration(milliseconds: 550),
                                previousIndex: pcurrent,
                                onItemSelected: (int value) {
                                  HapticFeedback.heavyImpact();
                                  setState(() {
                                    pcurrent = current;
                                    current = value;
                                  });
                                },
                              ),


                            ),
                          ),
                        ),
                      ),
                    )
*/