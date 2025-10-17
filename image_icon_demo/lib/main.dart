import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Dùng cho Cupertino Icons

void main() {
  // Lệnh run app sẽ chạy widget MyApp
  runApp(const MyApp());
}

// Widget gốc của ứng dụng
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Images & Icons Demo',
      home: ImageAndIconScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Màn hình chính chứa các ví dụ
class ImageAndIconScreen extends StatelessWidget {
  const ImageAndIconScreen({super.key});

  static const String networkImageUrl = 'https://picsum.photos/id/1018/3000/1500';
  //static const String networkImageUrl = 'https://example.com/nonexistent.png'; // Thử nghiệm lỗi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images & Icons trong Flutter Demo'),
        backgroundColor: Colors.blueAccent
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- NetworkImage vs AssetImage ---
            const Text(
              '1. NetworkImage vs AssetImage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildNetworkImageWithLoading(), // Ảnh mạng kèm Loading/Error
            const SizedBox(height: 10),
            _buildAssetImage(), // Ảnh từ Asset
            const SizedBox(height: 20),

            // --- Image Properties ---
            const Text(
              '2. Image Properties (fit, alignment)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildImagePropertiesDemo(),
            const SizedBox(height: 20),

            // --- Material Icons vs Cupertino Icons ---
            const Text(
              '3. Material Icons vs Cupertino Icons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildIconDemo(),
          ],
        ),
      ),
    );
  }

  // Phương thức hiển thị NetworkImage với Loading/Error Handling
  Widget _buildNetworkImageWithLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ảnh từ Mạng (NetworkImage - có Loading/Error):', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Image.network(
            networkImageUrl,
            fit: BoxFit.contain, // Thử nghiệm thuộc tính fit
            alignment: Alignment.center, // Thử nghiệm thuộc tính alignment
            
            // Xử lý trạng thái tải (loadingstate)
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              // Tính toán phần trăm tải
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                ),   
              );
            },
            
            // Xử lý lỗi (errorBuilder)
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 50),
                    Text('Lỗi tải ảnh mạng!', textAlign: TextAlign.center),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Phương thức hiển thị AssetImage
  Widget _buildAssetImage() {
    // Lưu ý: Cần thêm ảnh vào thư mục 'assets/images/' và cấu hình trong pubspec.yaml
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ảnh từ Asset (AssetImage):', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Image.asset(
                'assets/images/Google-flutter-logo.png', 
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            const Text(' (Cần Cấu hình Assets trong pubspec.yaml!)', style: TextStyle(fontSize: 12, color: Colors.orange)),
          ],
        ),
      ],
    );
  }

  // Phương thức hiển thị các thuộc tính của Image
 Widget _buildImagePropertiesDemo() {
  return Container(
    width: double.infinity,
    height: 450, // Tăng chiều cao để chứa cả hai ảnh
    decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
    child: Column(
      children: [
        // 1. Ảnh từ Asset
        Image.asset(
          'assets/images/Google-flutter-logo.png', 
          height: 200, // Đặt chiều cao cố định cho ảnh Asset
          fit: BoxFit.cover, 
          alignment: Alignment.center, 
        ),
        
        const Divider(),
        
        // 2. Ảnh từ Network
        Image.network(
          networkImageUrl,
          height: 200, // Đặt chiều cao cố định cho ảnh Network
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ],
    ),
  );
}

  // Phương thức hiển thị Icons
  Widget _buildIconDemo() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Icon Material
          Column(
            children: [
              Text('Material Icon', style: TextStyle(fontWeight: FontWeight.w600)),
              Icon(
                Icons.ac_unit, // Ví dụ Material Icon
                color: Color.fromARGB(255, 89, 76, 175),
                size: 60.0,
              ),
            ],
          ),
          
          // Icon Cupertino
          Column(
            children: [
              Text('Cupertino Icon', style: TextStyle(fontWeight: FontWeight.w600)),
              Icon(
                CupertinoIcons.heart_fill, // Ví dụ Cupertino Icon
                color: Colors.red,
                size: 60.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
