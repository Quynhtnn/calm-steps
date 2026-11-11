# Hướng dẫn tạo screenshot thật

Không có ảnh evidence được tạo sẵn. Chạy app trên điện thoại/emulator rồi chụp bằng công cụ screenshot của thiết bị. Lưu các ảnh PNG vào evidence/ đúng tên chữ hoa/thường và dấu gạch. Không đặt PNG rỗng hoặc đổi đuôi file để giả ảnh.

Thứ tự thuận tiện: login #9 → signup #6/#7 → home/detail/favorites → settings/API → logout/login error #10 → notifications. Có thể dùng account demo Fiona / fiona@example.com / Calm1234. Đây chỉ là dữ liệu bạn tự nhập khi chạy.

## 3. Five Figma screens

Tên file: `figma-evidence1.png`

Làm theo FIGMA_GUIDE.md: trong Figma thật, đặt cạnh nhau 5 frame Login, Registration, Home, Detail, Favorites/Profile. Zoom vừa đủ thấy cả 5 và tên frame. Chụp canvas có giao diện Figma.

## 4. Four Figma screens

Tên file: `figma-evidence2.png`

Trong Figma thật, chụp 4 frame External API, Settings Menu, Settings Screen, Notifications Screen cùng tên frame.

## 6. Signup screen

Tên file: `signup_screen_evidence.png`

Ở login bấm Sign up. Chụp màn hình Registration trước khi submit, thấy Username, Email, Password, Sign up và link Log in. Đóng bàn phím trước khi chụp.

## 7. Signup error

Tên file: `signup_error.png`

Ở Registration để username trống, nhập email bad và password 123. Nhấn Sign up. Chụp thông báo validation thật. Sau đó sửa để đăng ký Fiona / fiona@example.com / Calm1234.

## 9. Login screen

Tên file: `login_screen_evidence.png`

Trước khi đăng ký hoặc sau logout, chụp login có Email, Password, Log in, Sign up và link Sign up.

## 10. Login error

Tên file: `login_error.png`

Sau khi đã tạo account và logout, nhập fiona@example.com với password Wrong1234. Nhấn Log in; chờ Incorrect email or password rồi chụp. Password có >=8 ký tự để đi qua field validation.

## 12. Home screen and logo

Tên file: `home-screen-evidence.png`

Đăng nhập hợp lệ; chụp Home gồm logo spa trong header, Calm Steps, Welcome, Fiona! và cards.

## 14. Navigation on main screen

Tên file: `evidence-detail-navigation.png`

Chụp Home với các chevron_right trên cards và menu icon rõ ràng. Sau đó tap Morning Calm để tự kiểm chứng điều hướng.

## 15. Detail information

Tên file: `evidence-detail-screen.png`

Chụp Detail Morning Calm thấy tiêu đề, hướng dẫn, nút back và heart.

## 17. Saved local data

Tên file: `evidence-persistence.png`

Lưu Morning Calm bằng heart, trở về Favorites/Profile. Đóng app khỏi recent apps, mở lại (không xóa app data), vào Favorites/Profile. Chụp phần Local storage — reloaded from device có favorites chứa Morning Calm. Đây là snapshot thực đọc lại từ SharedPreferences, không phải text cố định.

## 18. UI and local data

Tên file: `evidence-integrateScreen-persistence.png`

Sau cold restart, chụp cùng màn hình Favorites/Profile thấy cả hàng Morning Calm ở UI và snapshot favorites: [Morning Calm] phía dưới. Nếu cần, dùng màn hình lớn/font mặc định để vừa cả hai. Có thể bổ sung Android Studio Device Explorer: data/data/com.example.calm_steps/shared_prefs/FlutterSharedPreferences.xml; snapshot là đường kiểm tra chung cho Android/iOS. Không chụp email/passwordHash.

## 20. Fetched API data

Tên file: `evidence-api-ux.png`

Menu > Mindful world. Có Internet, chờ dữ liệu thời tiết thật tải xong. Chụp nhiệt độ/gió/thời gian cập nhật và dòng Live data. Nếu hiện lỗi thì dùng Retry; không nộp loading/error làm ảnh thành công.

## 22. Menu icon

Tên file: `evidence-menu-icon.png`

Chụp Home thấy icon menu ở góc trên phải.

## 23. Menu items

Tên file: `evidence-menu-items.png`

Tap menu, chụp Settings menu có Favorites/Profile, Mindful world, Theme and preferences, Notifications, Help và Log out.

## 25. Settings screen

Tên file: `evidence-settings-screen.png`

Menu > Theme and preferences. Chụp Settings có Dark mode, Practice duration, Language, Configure notifications. Thử đổi dark và duration, đóng/mở app để kiểm tra lưu.

## 27. Notification setup

Tên file: `evidence-notification-configure.png`

Menu > Notifications. Nhập title Meditation Reminder, chọn ngày và giờ tương lai bằng picker. Bấm Schedule reminder. Android: chấp nhận Notifications và Alarms & reminders, quay lại và bấm Schedule lần nữa. Chỉ chụp khi có trạng thái Scheduled, switch ON, title và selected date/time. Chọn trước 2–3 phút để đủ thời gian.

## 28. Triggered notification

Tên file: `evidence-notification-alert.png`

Sau khi cấp đủ quyền, bấm Test in 15 seconds. Chờ trạng thái Scheduled rồi đưa app về background ngay bằng nút Home (không Force stop). Đợi 15–30 giây, mở system notification shade/Notification Center và chụp notification thật của Calm Steps: Meditation Reminder / Time for your daily meditation! Nếu không xuất hiện, kiểm tra Settings > notifications/channel, Focus/DND, alarm permission và battery restrictions rồi thử lại. Trên Android, tránh test liên tiếp trong idle vì OS có thể giới hạn exact alarm. Ảnh cấu hình hoặc mockup không thay thế ảnh này.

Android emulator: dùng nút camera ở toolbar. Android thật: Power + Volume Down. iOS Simulator: File > Save Screen; thiết bị iOS dùng tổ hợp phím screenshot tương ứng. Copy ảnh gốc vào evidence/ và đặt tên. Không sửa nội dung UI/notification trong ảnh. Kiểm tra evidence/CHECKLIST.md trước khi nộp.

