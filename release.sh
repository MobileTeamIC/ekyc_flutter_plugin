#!/bin/bash

# Kiểm tra xem người dùng có nhập version không
if [ -z "$1" ]; then
  echo "❌ Lỗi: Vui lòng nhập số phiên bản (Ví dụ: ./release.sh v1.1.0)"
  exit 1
fi

VERSION=$1

echo "🚀 Bắt đầu quy trình release cho phiên bản: $VERSION..."

# 1. Thêm tất cả thay đổi
git add .

# 2. Commit với thông báo release
git commit -m "chore: release $VERSION"

# 3. Push code lên nhánh hiện tại (main/master)
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📤 Đang đẩy code lên nhánh $BRANCH..."
git push origin $BRANCH

# 4. Kiểm tra xem tag đã tồn tại chưa, nếu có thì xóa để tạo mới (đề phòng lỗi)
if git rev-parse "$VERSION" >/dev/null 2>&1; then
  echo "⚠️ Tag $VERSION đã tồn tại. Đang tiến hành xóa và cập nhật lại..."
  git tag -d "$VERSION"
  git push origin --delete "$VERSION"
fi

# 5. Tạo Tag mới
echo "🏷️ Đang tạo tag $VERSION..."
git tag -a "$VERSION" -m "Release version $VERSION"

# 6. Push Tag lên GitHub
echo "📤 Đang đẩy tag lên GitHub..."
git push origin "$VERSION"

echo "✅ Đã release thành công phiên bản $VERSION!"
echo "🔗 Bây giờ bạn có thể vào GitHub để tạo 'Draft a new release' từ tag này."