# Calm Steps

Beginner Flutter meditation/wellness app — Final Project.

## Chạy app

Cài Flutter stable có Dart >=3.11.4 (SDK dùng tạo project: Flutter hiện có trên máy). Cài Android Studio + Android SDK/emulator; hoặc macOS + Xcode + CocoaPods cho iOS. Bật USB debugging nếu dùng Android thật.

Mở terminal trong thư mục calm_steps đã giải nén:

```sh
flutter doctor
flutter pub get
flutter devices
flutter run -d DEVICE_ID
```

Thay DEVICE_ID bằng ID ở flutter devices. Ưu tiên Android emulator API 33 trở lên hoặc Android thật. Không chạy web/desktop: native reminder chỉ được cài cho Android/iOS. Mở iOS bằng ios/Runner.xcworkspace sau khi dependencies được cài; chọn team signing của bạn nếu chạy thiết bị thật.

## Thao tác

1. Sign up: username >=2 ký tự, email hợp lệ, password >=8 ký tự. Một tài khoản local cho mỗi lần cài app.
2. Home: logo spa, lời chào, ba meditation cards; tap chevron để xem detail.
3. Detail: đọc hướng dẫn, bấm heart lưu favorite, Start để chạy timer. Timer dành cho foreground, không phải audio player.
4. Favorites / Profile: favorite list và snapshot đọc lại từ SharedPreferences trên cùng màn hình.
5. Menu góc phải: Favorites/Profile, Mindful world, Theme and preferences, Notifications, Help, Log out.
6. Mindful world tải thời tiết thật từ Open-Meteo; loading/error/retry, không có dữ liệu giả khi lỗi.
7. Settings: dark mode, thời lượng 1/5/10/15 phút; lưu sau khi đóng/mở.
8. Notifications: title, date/time picker, schedule một lần; test sau 15 giây; tắt switch hoặc logout hủy reminder.

Đăng nhập lại bằng email/password đã tạo. Muốn reset demo account: xóa app data (Android Settings > Apps > Calm Steps > Storage > Clear storage), rồi mở lại. Không xóa dữ liệu trước khi chụp persistence.

## Notification thật

Android: chấp nhận Notifications và Alarms & reminders khi được hỏi, quay lại và bấm Schedule/Test lần nữa. Lần xin quyền chưa tính là schedule thành công. Khi hiện Scheduled, bấm Home để đưa app về background. Chờ notification trên system tray. Không Force stop, không reboot trước test; bản beginner này không tự phục hồi alarm sau reboot. Nếu quyền đã bị từ chối, mở system Settings để bật lại. Tắt Do Not Disturb/Focus và kiểm tra notification channel.

iOS: Allow notifications, đưa app về background rồi chờ. Foreground banner không được cấu hình trong bản này. Nếu không thấy banner, xem Notification Center và quyền trong Settings.

Một reminder mới thay thế reminder cũ. Switch hiển thị preference đã lưu, không phải trạng thái permission hệ thống hoặc danh sách pending alarms; sau khi trigger, preference vẫn ON. DateTime được chuyển thành thời điểm tuyệt đối; nếu đổi múi giờ, hãy schedule lại.

## Cấu trúc

- lib/screens/auth.dart: signup + login + validation
- lib/screens/home.dart: home, favorites/profile và snapshot persistence
- lib/screens/detail.dart: detail, favorite, timer
- lib/screens/api_screen.dart + lib/services/api.dart: external API
- lib/screens/settings.dart: menu và settings
- lib/screens/notifications_screen.dart + lib/services/notifications.dart: reminder UI và channel
- android/app/src/main/kotlin/com/example/calm_steps/: Android AlarmManager + receiver
- ios/Runner/AppDelegate.swift: iOS UNUserNotificationCenter
- lib/services/storage.dart: SharedPreferences, session, demo auth
- user_stories.md: 9 stories và acceptance criteria
- SUBMISSION.md: từng mục 1–28
- EVIDENCE_GUIDE.md: chụp evidence thật
- FIGMA_GUIDE.md: tạo 9 wireframes trong Figma
- evidence/: manifest/checklist; tự thêm screenshot thật

## Kiểm tra

```sh
flutter analyze
flutter test
flutter build apk --debug
```

Xem VALIDATION.md để biết lệnh nào đã thực sự được chạy. Debug APK dùng kiểm tra bài học; release template dùng debug signing và chưa chuẩn bị để đưa lên store.

## Giới hạn demo authentication

Một account local, không có backend, reset password hay sync. Password không lưu plaintext; salted SHA-256 trong preferences chỉ phục vụ lab, không phải hệ thống xác thực production. Không dùng password thật. Favorites và preferences ở local; gỡ app/xóa storage có thể mất dữ liệu.

## GitHub và bài nộp

Tự tạo repository Public rồi upload project (bao gồm pubspec.lock, android, ios, lib, test và tài liệu). Không upload build/, .dart_tool/, local.properties hay thông tin signing. Bổ sung ảnh thật trong evidence/, thay URL trong SUBMISSION.md bằng URL repo của bạn. Không có thao tác publish tự động.

Nguồn API: https://open-meteo.com/en/docs . Storage: https://pub.dev/packages/shared_preferences . Android reminders: https://developer.android.com/develop/background-work/services/alarms/schedule . iOS: https://developer.apple.com/documentation/usernotifications .

