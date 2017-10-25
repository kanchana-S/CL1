Program:

!echo QUERY 1 : 'BECOMP' table dropped, if exists......;
!echo -----------------------------;
drop table if exists BECOMP;

!echo QUERY 2 : 'BECOMP' table is creating....;
!echo -----------------------------;
create table BECOMP (userid int, taskid int, unknown int, ip string, times string, task string) row format delimited fields terminated by '\t'; 

!echo QUERY 3 : Checking 'BECOMP' table schema....;
!echo -----------------------------;
describe BECOMP;

!echo QUERY 4 : Loading data to 'BECOMP' table from HDFS hive directory....;
!echo -----------------------------;
load data local inpath '/home/training/LibraryLogFile.txt' into table BECOMP;    

!echo QUERY 5 : Count the no of rows where userid = 4;
!echo -----------------------------;
select count(*) from BECOMP where userid = 4;

!echo QUERY 6 : Top ten IPs who have made maximum hit to digital library --server;
!echo -----------------------------;
select ip, count(ip) as totalhit from BECOMP group by ip order by totalhit desc limit 10;

!echo QUERY 7 : Select distinct userids who have accessed task 'hadoop';
!echo -----------------------------;
select distinct(userid) from BECOMP where task like '%hadoop%';

!echo QUERY 8 : Check the count of 'Java' ebooks;
!echo -----------------------------;
select count(task) from BECOMP where task like '%java%';

!echo QUERY 9 : List no of users who have accessed digital library from ip --'172.16.2.105';
!echo -----------------------------;
select distinct (userid) from BECOMP where ip like '172.16.2.105';

!echo QUERY 10 : List the count of users who have accessed digital library --on date 'Jul 08';
!echo -----------------------------;
select count(userid) from BECOMP where times like '%Jul 08%';
 
!echo QUERY 11:Top 10 books accessed;
!echo -----------------------------;
select ip,count(*) as cnt from BECOMP group by ip order by cnt desc limit 10;

!echo QUERY 12: view all possible tasks;
!echo -----------------------------;
select taskid,task from BECOMP group by taskid,task;



