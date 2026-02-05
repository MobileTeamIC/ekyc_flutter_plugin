# Hướng dẫn Release Plugin

Tài liệu này hướng dẫn cách sử dụng script `release.sh` để tự động hóa quy trình release phiên bản mới cho plugin.

## Quy trình Release

Script `release.sh` sẽ thực hiện các bước sau:
1. `git add .`: Thêm toàn bộ thay đổi.
2. `git commit`: Tạo commit với thông báo `chore: release [VERSION]`.
3. `git push`: Đẩy code lên nhánh hiện tại.
4. Quản lý Tag: Xóa tag cũ (nếu trùng) và tạo tag mới.
5. `git push origin [VERSION]`: Đẩy tag lên GitHub.

## Cách sử dụng

### 1. Cấp quyền thực thi (chỉ cần thực hiện một lần)

Trước khi chạy lần đầu tiên, bạn cần cấp quyền thực thi cho file script:

```bash
chmod +x release.sh
```

### 2. Chạy script release

Sử dụng lệnh sau để bắt đầu quy trình release:

```bash
./release.sh [VERSION]
```

**Ví dụ:**

```bash
./release.sh v1.1.0
```

## Lưu ý quan trọng

- Đảm bảo bạn đang ở đúng nhánh muốn release (ví dụ: `main` hoặc `master`).
- Đảm bảo đã cập nhật phiên bản trong file `pubspec.yaml` trước khi chạy script này.
- Sau khi script chạy xong, bạn nên lên GitHub để tạo **Release Note** từ tag vừa mới push lên.