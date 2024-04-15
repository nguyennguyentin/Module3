use QuanLySinhVien_ThucHanh;

select *
from student
where StudentName like "H%";

select ClassID , ClassName , month(StartDate) as "month" 
from class
where month(StartDate) = 12;

select *
from subject
where Credit >=3 and Credit <=5;

update student
set ClassId = 2
where StudentName like 'Hung';

select student.StudentName , subject.SubName , mark.Mark
from student
inner join mark on student.StudentId = mark.StudentId
inner join subject on mark.SubId = subject.SubId
order by mark.Mark desc , student.StudentName; 

