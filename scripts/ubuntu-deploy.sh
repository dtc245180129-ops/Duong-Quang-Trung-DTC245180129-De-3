#!/usr/bin/env bash
# ==============================================================================
# SCRIPT TRIỂN KHAI VÀ KHỞI TẠO HỆ THỐNG TRÊN UBUNTU SERVER
# Đề tài số 03: Website Quảng bá Sản phẩm bằng WordPress
# Môn học: Triển khai và Quản trị Hệ thống Phần mềm
# Sinh viên: Dương Quang Trung | MSV: DTC245180129
# Thư mục đích mong muốn: /home/trungdz123/de-03-wordpress
# ==============================================================================

set -euo pipefail

echo "======================================================================"
echo " TRIỂN KHAI HỆ THỐNG ĐỀ TÀI SỐ 03 CHO DƯƠNG QUANG TRUNG (DTC245180129)"
echo " Đường dẫn triển khai: $(pwd)"
echo "======================================================================"

# 1. Kiểm tra môi trường Docker và Docker Compose
if ! command -v docker >/dev/null 2>&1; then
    echo "[LỖI] Docker chưa được cài đặt. Vui lòng cài đặt Docker Engine trước." >&2
    exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
    echo "[LỖI] Docker Compose (v2) chưa sẵn sàng." >&2
    exit 1
fi
echo "[OK] Docker Engine và Docker Compose đã sẵn sàng."

# 2. Khởi tạo tệp biến môi trường .env nếu chưa có
if [[ ! -f .env ]]; then
    echo "[BƯỚC 1] Khởi tạo tệp .env từ .env.example..."
    cp .env.example .env
    echo "[CẢNH BÁO] Đã tạo tệp .env mặc định. Vui lòng cập nhật mật khẩu mạnh trong .env trước khi chạy production!"
else
    echo "[BƯỚC 1] Tệp .env đã tồn tại, tiếp tục..."
fi

# 3. Khởi tạo chứng chỉ SSL/TLS tự ký
echo "[BƯỚC 2] Kiểm tra và sinh cặp khóa SSL/TLS tự ký..."
chmod +x scripts/generate-ssl.sh
./scripts/generate-ssl.sh

# 4. Khởi tạo tệp xác thực HTTP Basic Auth cho phpMyAdmin nếu chưa có
if [[ ! -f nginx/.htpasswd ]]; then
    echo "[BƯỚC 3] Khởi tạo tệp xác thực HTTP Basic Auth cho phpMyAdmin..."
    PMA_USER="admin_pma"
    if command -v htpasswd >/dev/null 2>&1; then
        echo "Nhập mật khẩu cho tài khoản Basic Auth '${PMA_USER}':"
        htpasswd -c nginx/.htpasswd "${PMA_USER}"
    else
        echo "[INFO] Chưa có gói apache2-utils, sinh tệp qua container httpd:alpine..."
        docker run --rm -it -v "${PWD}/nginx:/etc/nginx" httpd:alpine htpasswd -c /etc/nginx/.htpasswd "${PMA_USER}"
    fi
    chmod 600 nginx/.htpasswd
    echo "[OK] Tệp nginx/.htpasswd đã được khởi tạo thành công với quyền 600."
else
    echo "[BƯỚC 3] Tệp nginx/.htpasswd đã tồn tại, tiếp tục..."
fi

# 5. Kiểm tra tính hợp lệ của cấu hình Docker Compose
echo "[BƯỚC 4] Kiểm tra cú pháp và cấu hình Docker Compose..."
docker compose config -q
echo "[OK] Cấu hình Docker Compose hợp lệ 100%!"

# 6. Khởi động toàn bộ 12 dịch vụ
echo "======================================================================"
read -p "Bạn có muốn khởi động toàn bộ hệ thống ngay bây giờ? (y/N): " -r CONFIRM
if [[ "${CONFIRM}" =~ ^[Yy]$ ]]; then
    echo "[BƯỚC 5] Đang khởi động 12 container trong chế độ nền (-d)..."
    docker compose up -d
    echo ""
    echo "[THÀNH CÔNG] Toàn bộ hệ thống đã được khởi động!"
    echo "Kiểm tra trạng thái container: docker compose ps"
    echo "Xem nhật ký Nginx: docker compose logs -f nginx"
else
    echo "[INFO] Hoàn tất chuẩn bị. Để khởi động thủ công, hãy chạy: docker compose up -d"
fi
echo "======================================================================"
