import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constants.dart';
import 'package:tiktokclone/controllers/video_controller.dart';
import 'package:tiktokclone/views/screens/comment_screen.dart';
import 'package:tiktokclone/views/widgets/circle_animation.dart';
import 'package:tiktokclone/views/widgets/video_player_item.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profiePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profiePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Container(
        padding: const EdgeInsets.all(11),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.grey, Colors.white],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image(
            image: NetworkImage(profilePhoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(
                  videoUrl: videoController.videoList[index].videourl,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data.username,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.caption,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        data.songName,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 20,
                      margin: EdgeInsets.only(top: size.height / 5),
                      child: Column(
                        children: [
                          buildProfile('String Url'),
                          Column(
                            children: [
                              InkWell(
                                onTap: () => videoController.likeVideo(data.id),
                                child: Icon(
                                  Icons.favorite,
                                  size: 40,
                                  color: data.likes
                                          .contains(authController.user.uid)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                data.likes.length.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (builder) => CommentScreen(
                                            id: data.id,
                                          )));
                                },
                                child: const Icon(
                                  Icons.comment,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                data.commentCount.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.share,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                data.shareCount.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          CircleAnimation(
                            child: buildMusicAlbum(data.profilePhoto),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
