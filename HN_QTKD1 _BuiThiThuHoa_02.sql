-- Câu 1: Tạo CSDL và tạo bảng
-- Tạo cơ sở dữ liệu và sử dụng
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Tạo bảng 
CREATE TABLE Employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	employee_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	salary DECIMAL(10, 2) CHECK (salary > 0),
	department VARCHAR(50)
);

CREATE TABLE Projects(
	project_id INT PRIMARY KEY AUTO_INCREMENT,
	project_name VARCHAR(100) NOT NULL,
	budget DECIMAL(15, 2),
	start_date DATE
);

CREATE TABLE Assignments(
	assignment_id INT PRIMARY KEY AUTO_INCREMENT,
	employee_id INT, 
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
	project_id INT,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
	hours_worked INT DEFAULT(0),
	assignment_date DATE
);

-- Câu 2:Thêm dữ liệu
INSERT INTO Employees
VALUES
	(1,'Nguyen Van An', 'an.nguyen@company.com', 15000000, 'Ky Thuat'),
	(2,'Tran Thi Binh', 'binh.tran@company.com', 12000000, 'Ke Toan'),
	(3,'Le Van Cuong', 'cuong.le@company.com', 18000000, 'Ky Thuat'),
	(4,'Pham Thi Dung', 'dung.pham@company.com', 10000000, 'Nhan Su'),
	(5,'Hoang Van Em', 'em.hoang@company.com', 20000000, 'Quan Ly'),
	(6,'Do Thi Hoa', 'hoa.do@company.com', 11000000, 'Ke Toan'),
	(7,'Vu Van Giang', 'giang.vu@company.com', 14000000, 'Ky Thuat'),
	(8,'Bui Thi Hang', 'hang.bui@company.com', 9000000, 'Nhan Su'),
	(9,'Ngo Van Hung', 'hung.ngo@company.com', 16000000, 'Marketing'),
	(10,'Trinh Thi Khoi', 'khoi.trinh@company.com', 13000000, 'Marketing');

INSERT INTO Projects
VALUES
	(1,'Xay dung Website', 50000000, '2024-01-01'),
	(2,'Phat trien App Mobile', 80000000, '2024-02-01'),
	(3,'Kiem toan tai chinh', 20000000, '2024-03-01'),
	(4,'Tuyen dung nhan su', 5000000, '2024-04-01'),
	(5,'Chien luoc kinh doanh', 30000000, '2024-05-01'),
	(6,'Bao tri he thong', 15000000, '2024-06-01'),
	(7,'Bao cao thue', 10000000, '2024-07-01'),
	(8,'Dao tao noi bo', 5000000, '2024-08-01'),
	(9,'Quang cao Facebook', 25000000, '2024-09-01'),
	(10,'Nghien cuu thi truong', 15000000, '2024-10-01');
    
INSERT INTO Assignments
VALUES
	(1,1, 1, 120, '2024-01-05'),
	(2,2, 3, 50, '2024-03-05'),
	(3,3, 2, 150, '2024-02-05'),
	(4,4, 4, 20, '2024-04-05'),
	(5,5, 5, 80, '2024-05-05'),
	(6,6, 7, 40, '2024-07-05'),
	(7,7, 6, 60, '2024-06-05'),
	(8,8, 8, 10, '2024-08-05'),
	(9,9, 9, 100, '2024-09-05'),
	(10,10, 10, 90, '2024-10-05');
    
-- Câu 3: Cập nhật dữ liệu
-- Cập nhật mức lương (salary) của nhân viên có tên "Nguyen Van An" thành 17000000.
SET SQL_SAFE_UPDATES = 0;
UPDATE Employees
SET salary = 17000000
WHERE employee_name = 'Nguyen Van An';

-- Cập nhật ngân sách (budget) của dự án "Xay dung Website" gấp đôi giá trị hiện tại.
UPDATE Projects 
SET budget = budget * 2
WHERE project_name = 'Xay dung Website';

-- Câu 4: Cập nhật dữ liệu
-- Xóa các bản ghi phân công trong bảng Assignments nếu số giờ làm việc (hours_worked) nhỏ hơn hoặc bằng 10.
DELETE FROM Assignments
WHERE hours_worked <= 10;

-- Xóa dự án có tên "Dao tao noi bo" khỏi bảng Projects.
DELETE FROM Projects
WHERE project_name = 'Dao tao noi bo';

-- Câu 5: Truy vấn cơ bản
-- Lấy ra danh sách nhân viên thuộc phòng ban (department) là "Ke Toan".
SELECT *
FROM Employees
WHERE department = 'Ke Toan';

-- Lấy ra danh sách các dự án có ngân sách (budget) lớn hơn 20,000,000.
SELECT *
FROM Projects 
WHERE budget > 20000000;

-- Tìm kiếm các nhân viên có email chứa chữ "company.com".
SELECT *
FROM Employees
WHERE email like '%company.com%';

-- Lấy ra danh sách nhân viên sắp xếp theo lương (salary) giảm dần.
SELECT *
FROM Employees
ORDER BY salary DESC;

-- Lấy ra thông tin của 3 dự án mới nhất.
SELECT *
FROM Projects
ORDER BY start_date DESC 
LIMIT 3;

-- Câu 6: Truy vấn nhiều bảng
-- Lấy ra danh sách gồm: Tên nhân viên (employee_name), Phòng ban, Tên dự án (project_name) và Số giờ làm việc.
SELECT e.employee_name, e.department, p.project_name, a.hours_worked
FROM Employees e
JOIN Assignments a ON a.employee_id = e.employee_id
JOIN Projects p ON a.project_id = p.project_id;

-- Lấy ra tên dự án và tên nhân viên của những dự án có ngân sách trên 30,000,000.
SELECT p.project_name, e.employee_name, p.budget
FROM Employees e
JOIN Assignments a ON a.employee_id = e.employee_id
JOIN Projects p ON a.project_id = p.project_id
WHERE p.budget > 30000000;

-- Hiển thị tên nhân viên và số giờ làm việc của những người đã làm việc trên 100 giờ.
SELECT e.employee_name, a.hours_worked
FROM Employees e
JOIN Assignments a ON a.employee_id = e.employee_id
WHERE a.hours_worked > 100;

-- Hiển thị danh sách các dự án thuộc về nhân viên có chức vụ trong phòng "Ky Thuat".
SELECT p.project_id, p.project_name, e.employee_name, e.department
FROM Projects p
JOIN Assignments a ON a.project_id = p.project_id
JOIN Employees e ON e.employee_id = a.employee_id
WHERE e.department = 'Ky Thuat';

-- Câu 7: Truy vấn gom nhóm
-- Thống kê số lượng nhân viên trong từng phòng ban (department).
SELECT department, COUNT(employee_id) AS So_luong_nv
FROM Employees 
GROUP BY department; 

-- Tính tổng mức lương (salary) mà công ty phải trả cho mỗi phòng ban.
SELECT department, SUM(salary) AS Tong_luong
FROM Employees
GROUP BY department;

-- Tìm những phòng ban (department) có số lượng nhân viên lớn hơn hoặc bằng 3
SELECT department, COUNT(employee_id) AS So_luong_nv
FROM Employees
GROUP BY department
HAVING So_luong_nv >= 3;

-- Câu 8: Truy vấn lồng
-- Tìm thông tin những nhân viên (employee_name, salary) có mức lương cao nhất công ty.
SELECT employee_name, salary
FROM Employees 
WHERE employee_name IN (SELECT MAX(salary)
						FROM Employees 
                        );

-- Lấy ra danh sách các dự án chưa có nhân viên nào tham gia.
SELECT p.project_id, p.project_name
FROM Projects p 
WHERE p.project_name NOT IN (SELECT p.project_id
	FROM Projects p
	JOIN Assignments a ON a.project_id = p.project_id
	JOIN Employees e ON e.employee_id = a.employee_id );

    




