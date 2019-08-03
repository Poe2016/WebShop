--������ռ�
CREATE TABLESPACE SpecialShop
DATAFILE 'G:\Database\SpecialShop.DBF'
SIZE 5M
AUTOEXTEND ON NEXT 1M 
MAXSIZE UNLIMITED
LOGGING;


--�����û�
CREATE USER special IDENTIFIED BY special DEFAULT TABLESPACE SpecialShop;

--����Ȩ��
GRANT CONNECT,RESOURCE TO special;--�����
CREATE TABLE exam
(
	id varchar2(10),
	username varchar2(10),
	password varchar2(10),
	company varchar2(10),
	age int,
	sex int,
	PRIMARY KEY(id)
);

--�����û���
CREATE TABLE users
(	
		userid int,
		mail VARCHAR2(20) PRIMARY KEY NOT NULL,		--�˺ţ����䣩
		password VARCHAR2(20) NOT NULL,		--����
		active INT,			--�Ƿ񼤻�
		address varchar2(40),--�ʼĵ�ַ
		nickname,varchar2(20)--�ǳ�
);
--�ڶ�������Ա�����Զ���������
     create sequence userid_seq
     minvalue 1
     maxvalue 9999999999999999999999999999
     start with 1
     increment by 1
     nocache;
     
--�����������������������е�ֵ��������users�����
     
--�˴�����û��
CREATE OR REPLACE TRIGGER MY_TGR
before INSERT ON users
FOR EACH ROW
DECLARE
 NEXT_ID NUMBER;
BEGIN
 SELECT userid_seq.NEXTVAL INTO NEXT_ID FROM DUAL;
 :new.userid := NEXT_ID;
END;

--ÿ���û�����һ����¼��ʷ�����¼��history+userid���������ؼ��ֱ�searchkey+userid��
create table his_table4
(
	goodno char(8),--�������Ʒ���
	see_date date,--���ʱ��
	amount int,--�������
	primary key(goodno,see_date)
);
create table search_key_t3
(
	keyword varchar2(20),--�����Ĺؼ���
	amount int--�����Ĵ���
);
--����һ���ܵ������¼��
create table his_table(
	mail VARCHAR2(20) REFERENCES users(mail),		--������û�����
	goodno char(8),--�������Ʒ���
	see_date date,--���ʱ��
	amount int,--�������
	primary key(mail,goodno,see_date)
);


 

--���ﳵ��
CREATE TABLE cart
(
	goodNo char(8) REFERENCES good(goodNo) NOT NULL,--��Ʒ���
	mail VARCHAR2(20) REFERENCES users(mail) NOT NULL,--��Ʒ�����û���
	amount INT,--���빺�ﳵ����Ʒ����
	PRIMARY KEY(goodNo,mail)
);

--��Ʒ������ÿ����Ʒ������
CREATE TABLE good
(
	goodNo char(8) PRIMARY KEY NOT NULL,		--��Ʒ��ţ���00000001��ʼ����8λ
	mail varchar2(20) REFERENCES users(mail),	--��Ʒ�ϴ���
	goodname varchar2(20) NOT NULL,		--��Ʒ��
	goodinfo varchar2(50) NOT NULL,		--��Ʒ����
	price INT NOT NULL,		--��Ʒ�۸�
	goodnum INT,		--��Ʒ����
	goodtype varchar2(20)
);
--
--�����û���
CREATE TABLE usersOnline
(
	mail VARCHAR2(20) REFERENCES users(mail),
	PRIMARY KEY(mail)
);
--�洢ArrayList���������ϵͳ��ֻ��һ��ArrayList����
CREATE TABLE listtable
(
	list blob
);
--�洢�û����ﳵʵ����ÿ���û���Ӧһ�����ﳵʵ�����ڵ�¼ʱ����
CREATE TABLE cartofuser
(
	mail VARCHAR2(20) REFERENCES users(mail),
	cart blob,
	PRIMARY KEY(mail)
);
--��ʽ�����
set linesize 200
set pagesize 100
--����ʾ����Ʒ
insert into good values('00000001','123@qq.com','iphone8','iphone���¿�',8888,2);
insert into good values('00000002','111@qq.com','iphone8','iphone���¿�',8888,2);
insert into good values('00000003','111@qq.com','iphone8','iphone���¿�',8888,2);
insert into good values('00000004','111@qq.com','iphone8','iphone���¿�',8888,2);
insert into cart values('00000001','123@qq.com',1);
insert into cart values('00000002','123@qq.com',2);
select goodname from good where goodno in (select goodno from cart where mail='123@qq.com');

--searchkey���ڱ����û��������Ĺؼ���,�����û��������ؼ��ֶ��洢���������
create table search_key_t1(
	searchkey varchar2(20),--�����Ĺؼ���
	mail VARCHAR2(20) REFERENCES users(mail),--��¼�û�
	primary key(searchkey,mail),
	amount int--��������
)
--�û���ע��Ʒ�б�
create table caregood_t7(
	goodno char(8) primary key,--��ע��Ʒ���
	mail VARCHAR2(20) REFERENCES users(mail)--��¼�û�
);
--�û���ע���̱�
create table caresaler_t7(
	saler VARCHAR2(20) REFERENCES users(mail)--��ע���û�
);


--������������Զ���������
     create sequence ord_id_seq
     minvalue 1
     maxvalue 9999999999999999999999999999
     start with 1
     increment by 1
     nocache;

--������
create table order_t(
	ord_id int primary key,--����������ţ��Զ�����
	mail VARCHAR2(20) REFERENCES users(mail),--�����������û�����
	goodno char(8),--������Ӧ��Ʒ���
	ord_date date,--��������ʱ��(δ����ʱָ������ʱ�䣬�����ָ������ʱ��)
	ord_price int,--��������
	ord_num int,--��������
	money int,--�����ܽ��
	ord_address varchar2(40),--��Ʒ�ʼĵ�ַ
	pay int, --�Ƿ񸶿1-�Ѹ���0-δ��
	seller varchar2(20) REFERENCES users(mail),--��������
	receiver varchar2(20),--�ջ�������
	send_state int,--����Ƿ��ѷ���
	receive_state int--����Ƿ����ջ�
	
);
--�������۱���Զ���������
     create sequence eva_id_seq
     minvalue 1
     maxvalue 9999999999999999999999999999
     start with 1
     increment by 1
     nocache;
--�û����۱�
create table evaluation(
	eva_id int primary key,--����id
	ord_id int references order_t(ord_id),--���۵Ķ������
	mail VARCHAR2(20) REFERENCES users(mail),--���۶������û�����
	eva_date date,--����ʱ��
	pkscore char(1) ,--��װ����
	spscore char(1),--�ٶ�����,
	atscore char(1),--̬������
	goscore char(1),--��Ʒ����
	tags varchar2(100),--��ǩ����
	def_text varchar2(20),--�Զ����ǩ
	words varchar2(500),--��������
	anony char(1)--�Ƿ�������0-�� 1-��
);

