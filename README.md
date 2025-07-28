
# LecCenter Flutter 乐程团队中心站（Flutter 版） (开发中)

## 📱 项目简介

本项目是 LecCenter 团队中心站的 **Flutter 移动端版本**，支持跨平台运行（Android / iOS），用于团队成员管理、签到、排行榜查看、通告接收等功能。

---

## ✨ 功能模块

- ✅ 登录 / 注册
- ✅ 签到打卡
- ✅ 通告查看
- ✅ 个人资料展示
- ✅ 排行榜查询
- ✅ 负责人管理
- ✅ WebSocket 实时消息推送（通告/提醒）

---

## 🧱 技术栈

| 层级       | 使用技术                                       |
|------------|------------------------------------------------|
| 前端框架   | Flutter 3.x                                     |
| 状态管理   | provider / riverpod                             |
| 路由管理   | go_router / GetX / Navigator 2.0（可自选）     |
| 网络请求   | dio + json_serializable 自动序列化              |
| 数据存储   | shared_preferences（本地缓存）                  |
| WebSocket  | `web_socket_channel` 实现实时推送               |
| 接口通信   | 与 gin + gorm 后端 API 对接              |
| 接口数据   | mysql（后端提供）                             |
| 构建工具   | Flutter build / release                         |

---

## 🚀 快速开始

### 1. 克隆项目

```bash
git clone https://github.com/NexusXian/lec_center_flutter.git
cd lec_center_flutter
````

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 运行项目

```bash
flutter run
```

或者选择具体平台：

```bash
flutter run -d android        # Android 模拟器/真机
flutter run -d ios            # iOS 模拟器/真机（仅 macOS）
```

---

## 🖼 项目结构

```bash
lib/
├── main.dart              # 入口文件
├── models/               # 数据模型（User, Notice, Attendance 等）
├── pages/                # 各页面（Login, Home, SignIn, Admin 等）
├── providers/            # 状态管理类（Provider）
├── services/             # 网络请求 & WebSocket 服务封装
├── widgets/              # 通用组件（头像上传、排行榜等）
├── routes/               # 路由配置
└── utils/                # 工具函数（时间格式化、本地存储等）
```

---

## 📡 后端接口

后端使用 go + gin + gorm + mysql 提供数据服务，接口统一采用 REST 风格。具体字段定义见 `/lib/models/` 下的类定义（如 `User`, `Notice`, `Attendance` 等）。

---

## 📦 编译打包

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

```

---

## 🤝 开发团队

* 联系方式：[xyhcatrl@gmail.com](mailto:xyhcatrl@gmail.com)

---

## 📄 LICENSE

MIT License - 本项目完全开源，欢迎使用与二次开发。


