insert supplier values 
(0,'TEST0','TESTF0','TESTL0','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(1,'TEST1','TESTF1','TESTL1','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(2,'TEST2','TESTF2','TESTL2','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(3,'TEST3','TESTF3','TESTL3','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(4,'TEST4','TESTF4','TESTL4','123123123','123123@123.com','TESTAddress','TESTCity','TESTState');

insert Medicine values
(0,'TEST0',0,'12','120','TESTINFO'),
(1,'TEST1',0,'12','120','TESTINFO'),
(2,'TEST2',1,'12','120','TESTINFO'),
(3,'TEST3',2,'12','120','TESTINFO'),
(4,'TEST4',2,'12','120','TESTINFO'),
(5,'TEST5',3,'12','120','TESTINFO'),
(6,'TEST6',4,'12','120','TESTINFO'),
(7,'TEST7',5,'12','120','TESTINFO'),
(8,'TEST8',6,'12','120','TESTINFO');

insert Department values
(0,'TEST0'),
(1,'TEST1'),
(2,'TEST2'),
(3,'TEST3'),
(4,'TEST4');

insert Insurance values
(0,'TEST0',100,'2016/05/01','TESTINFO'),
(1,'TEST1',200,'2016/05/02','TESTINFO'),
(2,'TEST2',300,'2016/05/03','TESTINFO'),
(3,'TEST3',400,'2016/05/03','TESTINFO'),
(4,'TEST4',500,'2016/05/04','TESTINFO'),
(5,'TEST5',600,'2016/05/05','TESTINFO');

insert Bed values
(0,'1',2,1),
(1,'1',1,0),
(2,'2',1,0),
(3,'2',3,1),
(4,'3',4,1);

insert Doctor values
(0,'TESTF0','TESTL0','Doc',30,'M',0,'123123123','TEST0@test',null),
(1,'TESTF1','TESTL1','Doc',31,'F',0,'123123123','TEST0@test',0),
(2,'TESTF2','TESTL2','Doc',31,'M',1,'123123123','TEST0@test',null),
(3,'TESTF3','TESTL3','Doc',34,'F',1,'123123123','TEST0@test',2),
(4,'TESTF4','TESTL4','Doc',34,'M',1,'123123123','TEST0@test',2),
(5,'TESTF5','TESTL5','Doc',36,'M',2,'123123123','TEST0@test',null),
(6,'TESTF6','TESTL6','Doc',37,'F',2,'123123123','TEST0@test',5),
(7,'TESTF7','TESTL7','Doc',41,'F',1,'123123123','TEST0@test',null),
(8,'TESTF8','TESTL8','Doc',29,'M',3,'123123123','TEST0@test',null),
(9,'TESTF9','TESTL8','Doc',31,'M',4,'123123123','TEST0@test',null);

insert Nurse values
(0,'TESTF0','TESTL0','MISS',30,'M',0,'123123123','TEST0@test',null),
(1,'TESTF1','TESTL1','MISS',31,'F',0,'123123123','TEST0@test',0),
(2,'TESTF2','TESTL2','MISS',31,'M',1,'123123123','TEST0@test',null),
(3,'TESTF3','TESTL3','MISS',34,'F',1,'123123123','TEST0@test',2),
(4,'TESTF4','TESTL4','MISS',34,'M',1,'123123123','TEST0@test',2),
(5,'TESTF5','TESTL5','MISS',36,'M',2,'123123123','TEST0@test',null),
(6,'TESTF6','TESTL6','MISS',37,'F',2,'123123123','TEST0@test',5),
(7,'TESTF7','TESTL7','MISS',41,'F',1,'123123123','TEST0@test',null),
(8,'TESTF8','TESTL8','MISS',29,'M',3,'123123123','TEST0@test',null),
(9,'TESTF9','TESTL8','MISS',31,'M',4,'123123123','TEST0@test',null);

insert Patient values
(0,'TESTF0','TESTL0','M',20,'I','123123123','TEST@test',0,0,0),
(1,'TESTF1','TESTL1','F',89,'II','123123123','TEST@test',1,1,1),
(2,'TESTF2','TESTL2','F',34,'III','123123123','TEST@test',1,2,2),
(3,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3),
(4,'TESTF4','TESTL4','M',26,'IV','123123123','TEST@test',3,4,4);

insert Bill values
(0,0,0,0,null),
(1,1,344,234,null),
(2,2,345,100,null),
(3,3,345,22,null),
(4,4,7657,0,'2016/04/11');

insert Bill_Detail values
(0,1,1,'Medicine',100,'2015/12/12'),
(1,1,null,'Room',100,'2016/01/13'),
(1,1,null,'Doc',100,'2016/02/10'),
(2,2,null,'Doc',100,'2015/12/12'),
(3,2,1,'Medicine',100,'2016/01/12'),
(4,3,1,'Medicine',100,'2016/03/20'),
(5,3,1,'Medicine',100,'2015/12/12'),
(6,3,1,'Medicine',100,'2016/02/12'),
(7,4,1,'Medicine',100,'2016/03/12'),
(8,1,1,'Medicine',100,'2016/04/12');

