import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import '../errors/failures.dart';

/// Helper class for image operations
class ImageHelper {
  final ImagePicker _picker = ImagePicker();

  /// Pick image from camera
  Future<Either<Failure, String>> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: AppConstants.imageQuality,
        maxWidth: AppConstants.maxImageWidth.toDouble(),
        maxHeight: AppConstants.maxImageHeight.toDouble(),
      );

      if (image == null) {
        return const Left(ImagePickerFailure('No image selected'));
      }

      return await _saveImage(image);
    } catch (e) {
      return Left(ImagePickerFailure('Failed to pick image from camera: $e'));
    }
  }

  /// Pick image from gallery
  Future<Either<Failure, String>> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: AppConstants.imageQuality,
        maxWidth: AppConstants.maxImageWidth.toDouble(),
        maxHeight: AppConstants.maxImageHeight.toDouble(),
      );

      if (image == null) {
        return const Left(ImagePickerFailure('No image selected'));
      }

      return await _saveImage(image);
    } catch (e) {
      return Left(ImagePickerFailure('Failed to pick image from gallery: $e'));
    }
  }

  /// Save image to app directory and return the path
  Future<Either<Failure, String>> _saveImage(XFile image) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String imagesDir = path.join(appDir.path, 'product_images');

      // Create directory if it doesn't exist
      final Directory imageDirectory = Directory(imagesDir);
      if (!await imageDirectory.exists()) {
        await imageDirectory.create(recursive: true);
      }

      // Generate unique filename
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';
      final String savedPath = path.join(imagesDir, fileName);

      // Copy file to app directory
      final File imageFile = File(image.path);
      await imageFile.copy(savedPath);

      return Right(savedPath);
    } catch (e) {
      return Left(StorageFailure('Failed to save image: $e'));
    }
  }

  /// Delete image file
  Future<Either<Failure, void>> deleteImage(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to delete image: $e'));
    }
  }

  /// Check if image file exists
  Future<bool> imageExists(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      return await imageFile.exists();
    } catch (e) {
      return false;
    }
  }
}
