import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/hive_repository.dart';
import 'package:travoli/feature/dashboard/manage_apartments/screens/add_bills_screen.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/helpers/router/router.dart';

class AddImagesScreen extends StatefulWidget {
  static const routeName = "addImageScreen";
  const AddImagesScreen({super.key});

  @override
  State<AddImagesScreen> createState() => _AddImagesScreenState();
}

class _AddImagesScreenState extends State<AddImagesScreen> {
  final HiveRepository _hiveRepository = HiveRepository();

  List<XFile> selectedImages = []; // List of selected image
  XFile? selectedVideo ;
  VideoPlayerController? _videoController;

  final picker = ImagePicker();

  Future getImages() async {
    //if (selectedImages.length < 4) {
    selectedImages.clear();
    final List<XFile>? images = await ImagePicker().pickMultiImage(limit: 6);
    if (images != null) {
      setState(() {
        selectedImages.addAll(images);
      });
    }
    setState(() {});
  }

  Future getVideos() async {
    //if (selectedImages.length < 4) {
    final XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        selectedVideo = video;
        _initializeVideoController(File(video.path));
      });
      
    }
    setState(() {});
  }

  void _initializeVideoController(File video) {
    _videoController = VideoPlayerController.file(video)
      ..initialize().then((_) {
        setState(() {}); // Update the UI once the video is initialized
        _videoController!.play(); // Optionally auto-play the video
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceY(40.dy),
                CustomText(
                  text: "Apartment",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0B0B0B),
                  fontFamily: kFontFamily,
                ),
                SpaceY(4.dy),
                CustomText(
                  text: "Lets get your house listed with the correct details.",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff100C08),
                  fontFamily: kSecondaryFontFamily,
                ),
                SpaceY(34.dy),
                selectedVideo ==null? GestureDetector(
                  onTap: () {
                   getVideos();
                  },
                  child: Container(
                    height: 145.dy,
                    width: 350.dx,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xffE0DFDF))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.videocam_circle,
                            color: kBlack,
                            size: 34,
                          ),
                          SpaceX(10.dx),
                          CustomText(
                            text: "Please select an Image",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff0B0B0B),
                            fontFamily: kFontFamily,
                          ),
                        ],
                      ),
                    ),
                  ),
                ): AspectRatio(
                    aspectRatio: 16/9,
                    child: VideoPlayer(_videoController!),
              ),
                selectedVideo !=null? Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                          icon: Icon(CupertinoIcons.videocam_circle, 
                          size: 20),
                          onPressed: () { getVideos();},
                        )
                ): Container(),
                SpaceY(28.dy),
                SizedBox(
                  // height: 250.dy,
                  // width: 250.dx,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Display 3 items per row
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 6, // Total slots = 6
                    itemBuilder: (context, index) {
                      // If index is less than the number of picked images, show images
                      if (index < selectedImages.length) {
                        return Container(
                          height: 250.dy,
                          width: 250.dx,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(selectedImages[index].path)),
                              fit: BoxFit.cover,
                            ),
                            color: kWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      } else {
                        // Show an icon for remaining slots
                        return IconButton(
                          icon: Icon(Icons.add_a_photo, size: 40),
                          onPressed: () { getImages();},
                        );
                      }
                    },
                  ),
                ),
              selectedImages.length == 6?  Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                          icon: Icon(Icons.add_a_photo, size: 20),
                          onPressed: () { getImages();},
                        )
                ): Container(),
                SpaceY(16.dy),
                CustomElevatedButton(
                    onPressed: selectedImages.isNotEmpty
                        ? () {
                            //uploadImages(pickedImages);
                            _hiveRepository.add(
                                key: HiveKeys.images,
                                name: HiveKeys.images,
                                item: selectedImages);
                                _hiveRepository.add(
                                key: HiveKeys.video,
                                name: HiveKeys.video,
                                item: selectedImages[0]);
                            moveToNextScreen(
                                context: context,
                                page: AddBillsScreen.routeName);
                          }
                        : null,
                    buttonText: "Next Step"),
                SpaceY(32.dy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 70.dy,
        width: 70.dx,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: const Icon(CupertinoIcons.photo_fill),
      ),
    ));
  }
}
