import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  final String uploadUrl;
  final Function(String) onUploadSuccess;
  final Function(String) onUploadError;
  final double width;
  final double height;

  const ImageUploader({
    super.key,
    required this.uploadUrl,
    required this.onUploadSuccess,
    required this.onUploadError,
    this.width = 300,
    this.height = 250,
  });

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _selectedImage;
  double _uploadProgress = 0;
  String _uploadStatus = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _uploadStatus = '';
        _uploadProgress = 0;
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _uploadStatus = '';
        _uploadProgress = 0;
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedImage == null) {
      setState(() {
        _uploadStatus = '请先选择图片';
      });
      return;
    }

    final allowedFormats = ['jpg', 'jpeg', 'png'];
    final fileExtension = _selectedImage!.path.split('.').last.toLowerCase();
    if (!allowedFormats.contains(fileExtension)) {
      setState(() {
        _uploadStatus = '仅支持JPG、JPEG、PNG格式';
      });
      return;
    }

    if (_selectedImage!.lengthSync() > 10 * 1024 * 1024) {
      setState(() {
        _uploadStatus = '图片大小超过10MB，请重新选择';
      });
      return;
    }

    try {
      setState(() {
        _uploadStatus = '上传中...';
      });

      final url = Uri.parse(widget.uploadUrl);
      final request = http.MultipartRequest('POST', url);

      final fileStream = http.ByteStream(_selectedImage!.openRead());
      final fileLength = _selectedImage!.lengthSync();

      final multipartFile = http.MultipartFile(
        'file',
        fileStream,
        fileLength,
        filename: _selectedImage!.path.split('/').last,
      );

      request.files.add(multipartFile);

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        widget.onUploadSuccess(responseBody);
        setState(() {
          _uploadStatus = '上传成功';
        });
      } else {
        widget.onUploadError('上传失败，状态码：${response.statusCode}');
        setState(() {
          _uploadStatus = '上传失败';
        });
      }

      response.stream.listen((event) {
        setState(() {
          _uploadProgress = event.length / fileLength;
        });
      });
    } catch (e) {
      widget.onUploadError(e.toString());
      setState(() {
        _uploadStatus = '上传失败: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          children: [
            IconButton(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo_library),
              tooltip: '从相册选择',
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.shade200,
                ),
              ),
            ),
            IconButton(
              onPressed: _takePhoto,
              icon: const Icon(Icons.camera_alt),
              tooltip: '拍照上传',
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.shade200,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_selectedImage != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Image.file(_selectedImage!, fit: BoxFit.cover),
            ),
          ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: _uploadFile,
          icon: const Icon(Icons.cloud_upload),
          label: const Text('上传图片'),
        ),
        const SizedBox(height: 8),
        if (_uploadStatus.isNotEmpty)
          Center(
            child: Text(
              _uploadStatus,
              style: TextStyle(
                fontSize: 14,
                color: _uploadStatus.contains('成功') ? Colors.green : Colors.red,
              ),
            ),
          ),
        if (_uploadProgress > 0 && _uploadProgress < 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                LinearProgressIndicator(value: _uploadProgress),
                const SizedBox(height: 4),
                Text('进度: ${(_uploadProgress * 100).toStringAsFixed(1)}%'),
              ],
            ),
          ),
      ],
    );
  }
}
