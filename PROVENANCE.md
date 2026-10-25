# BẢN GHI NGUỒN GỐC & KẾ THỪA DỰ ÁN (PROJECT PROVENANCE & ATTRIBUTION)

## ĐỀ TÀI SỐ 03: WEBSITE QUẢNG BÁ SẢN PHẨM BẰNG WORDPRESS
**Học phần:** Triển khai và Quản trị Hệ thống Phần mềm (TKVQTHTPM)  
**Trường:** Đại học Công nghệ Thông tin & Truyền thông — Đại học Thái Nguyên (ICTU)

---

## 1. THÔNG TIN DỰ ÁN MỚI
* **Sinh viên thực hiện:** Dương Quang Trung
* **Mã sinh viên:** `DTC245180129`
* **GitHub Username:** [`dtc245180129-ops`](https://github.com/dtc245180129-ops)
* **Email trường:** `dtc245180129@ictu.edu.vn`
* **Tài khoản Ubuntu Server dự kiến:** `trungdz123`
* **Thư mục triển khai mục tiêu trên Ubuntu:** `/home/trungdz123/de-03-wordpress`
* **Repository chính thức:** [`https://github.com/dtc245180129-ops/Duong-Quang-Trung-DTC245180129-De-3.git`](https://github.com/dtc245180129-ops/Duong-Quang-Trung-DTC245180129-De-3.git)

---

## 2. GHI NHẬN NGUỒN GỐC DỰ ÁN THAM KHẢO
Dự án này được kế thừa, tinh chỉnh và chuẩn hóa dựa trên đề tài tham khảo đã triển khai xuất sắc trước đó:

* **Tác giả dự án tham khảo:** Nông Quốc Tuấn
* **Mã sinh viên:** `DTC245200059`
* **Lớp:** KTPM K23C
* **Kho mã nguồn tham khảo:** [`https://github.com/dtc245200059-eng/DTC245200059-De-tai-03-TKVQTHTPM-Website-Quang-Ba-San-Pham-.git`](https://github.com/dtc245200059-eng/DTC245200059-De-tai-03-TKVQTHTPM-Website-Quang-Ba-San-Pham-.git)
* **Giấy phép phần mềm:** Kế thừa các điều khoản mã nguồn mở theo giấy phép GPL-2.0 / MIT.

---

## 3. DANH MỤC THÀNH PHẦN KẾ THỪA & ĐIỀU CHỈNH

| Hạng mục kỹ thuật | Trạng thái | Chi tiết kế thừa & Tinh chỉnh |
| :--- | :---: | :--- |
| **Kiến trúc Docker Compose** | Kế thừa 100% | Điều phối 12 dịch vụ: Nginx, WordPress, phpMyAdmin, MySQL, Prometheus, Grafana, Node Exporter, cAdvisor, MySQL Exporter, Loki, Alloy, Docker Socket Proxy. |
| **Phân tách mạng nội bộ** | Kế thừa 100% | 4 mạng bridge: `frontend-net`, `backend-net` (internal), `monitoring-net`, `docker-api-net` (internal). |
| **An toàn máy chủ Nginx** | Kế thừa 100% | Điểm tiếp nhận HTTPS duy nhất, TLS 1.2/1.3, Rate limiting chống brute-force, chặn HTTP 444 với host header không hợp lệ, HTTP Basic Auth cho phpMyAdmin. |
| **Theme WordPress TechSmart** | Chuẩn hóa | Kế thừa cấu trúc Classic Theme responsive (`website-quang-ba`); cập nhật thông tin tác giả, email hỗ trợ đồ án sang `dtc245180129@ictu.edu.vn`. |
| **Giám sát & Logging** | Kế thừa 100% | Nạp sẵn dashboard giám sát hệ thống (Host, Container, MySQL); tích hợp Loki + Alloy + HAProxy API Proxy theo kiến trúc Deny-by-default. |
| **Quản trị Bí mật & `.env`** | Chuẩn hóa | Giữ nguyên `.env.example`, bảo vệ nghiêm ngặt `.env`, `.htpasswd` và chứng chỉ SSL trong `.gitignore`. Không đưa dữ liệu cá nhân hay secret vào Git. |
| **Git Workflow & Remote** | Khởi tạo mới | Tách biệt hoàn toàn khỏi repository cũ; cấu hình Git user cục bộ của Dương Quang Trung; trỏ `origin` duy nhất tới `dtc245180129-ops/Duong-Quang-Trung-DTC245180129-De-3.git`. |
| **Môi trường triển khai** | Tách biệt | Phân biệt rõ ràng cấu hình tĩnh trong repository với môi trường máy chủ Ubuntu đích (`/home/trungdz123/de-03-wordpress`). |

---

*Bản ghi nguồn gốc này được lập nhằm bảo đảm tính minh bạch học thuật, quyền tác giả và tuân thủ các quy định của học phần Triển khai và Quản trị Hệ thống Phần mềm.*
