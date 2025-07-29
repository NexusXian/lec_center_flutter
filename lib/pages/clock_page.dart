import 'package:flutter/material.dart';
import '../widget/image_uploader.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  final TextEditingController _remarkController = TextEditingController();
  String? _uploadResult;

  // 模拟上传地址，实际需替换为真实后端接口
  final String _uploadUrl = 'https://example.com/upload';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('图片签到')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '* 签到图片',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                ImageUploader(
                  uploadUrl: _uploadUrl,
                  onUploadSuccess: (response) {
                    setState(() {
                      _uploadResult = '上传成功: $response';
                    });
                  },
                  onUploadError: (error) {
                    setState(() {
                      _uploadResult = '上传失败: $error';
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  '支持 JPG、JPEG、PNG 格式，单张图片不超过 10MB',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const Divider(height: 32),
                const Text(
                  '签到备注',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _remarkController,
                  maxLength: 200,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: '请输入签到备注（可选）',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: _submitClock,
                        child: const Text('提交签到'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _resetForm,
                      child: const Text('重置'),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: _viewClockRecords,
                      child: const Text('查看签到记录'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_uploadResult != null)
                  Text(
                    _uploadResult!,
                    style: TextStyle(
                      fontSize: 14,
                      color: _uploadResult!.contains('成功')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitClock() {
    if (_uploadResult == null || _uploadResult!.contains('失败')) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先成功上传图片')));
      return;
    }
    print('签到备注：${_remarkController.text}');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('签到提交成功，可完善后端交互逻辑')));
  }

  void _resetForm() {
    _remarkController.clear();
    setState(() {
      _uploadResult = null;
    });
  }

  void _viewClockRecords() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ClockRecordsPage()),
    );
  }
}

class ClockRecordsPage extends StatelessWidget {
  const ClockRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('签到记录')),
      body: const Center(
        child: Text('这里展示签到记录，可根据实际需求从后端获取并展示', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
