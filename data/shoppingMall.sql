CREATE USER shop IDENTIFIED BY a123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO shop;

DROP TABLE BOARDS PURGE;
DROP TABLE DELIVERY PURGE;
DROP TABLE ORDERS PURGE;
DROP TABLE PRODUCT PURGE;
DROP TABLE MEMBER PURGE;

CREATE TABLE MEMBER (
	USERID VARCHAR2(20),
	USERPWD VARCHAR2(20),
	USERNAME VARCHAR2(20),
	USERGENDER VARCHAR2(20),
	USERBIRTH DATE,
	USERADDR VARCHAR2(1000),
	USEREMAIL VARCHAR2(50),
	USERTEL CHAR(11),
	CONSTRAINT PK_MEMBER_USERID PRIMARY KEY (USERID));

CREATE TABLE PRODUCT (
	PRODUCTNUM NUMBER(10),
	PRODUCTNAME VARCHAR2(50),
	PRODUCTPRICE NUMBER,
	PRODUCTCATEGORY VARCHAR2(20),
	SAVEFILENAME VARCHAR2(2000),
	ORIGINALFILENAME VARCHAR2(2000),
	PRODUCTCOLOR VARCHAR2(100),
	PRODUCTSIZE VARCHAR2(100),
	CONSTRAINT PK_PRODUCT_PRODUCTNUM PRIMARY KEY (PRODUCTNUM));

CREATE TABLE ORDERS (
	ORDERNUM NUMBER,
	USERID VARCHAR2(20),
	PRODUCTNUM NUMBER(10),
	ORDERQUANTITY NUMBER(5),
    ORDERCOLOR VARCHAR2(20),
    ORDERSIZE VARCHAR2(20),
    UPDATEDDATE DATE,
	PROGRESS VARCHAR2(20),
	CONSTRAINT PK_ORDERS_ORDERNUM PRIMARY KEY (ORDERNUM),
	CONSTRAINT FK_ORDERS_USERID FOREIGN KEY (USERID) REFERENCES MEMBER(USERID),
	CONSTRAINT FK_ORDERS_PRODUCTNUM FOREIGN KEY (PRODUCTNUM) REFERENCES PRODUCT(PRODUCTNUM));

CREATE TABLE DELIVERY (
    DELIVERYNUM NUMBER,
    USERID VARCHAR2(20),
    ORDERNUM VARCHAR2(100),
    DELIVERYNAME VARCHAR2(20),
    DELIVERYTEL CHAR(11),
    DELIVERYADDR VARCHAR2(1000),
    DELIVERYEMAIL VARCHAR2(50),
    TOTALPRICE NUMBER,
    DELIVERYDATE DATE,
    ARRIVEDATE DATE,
    PROGRESS VARCHAR2(20),
	CONSTRAINT PK_DELIVERY_DELIVERYNUM PRIMARY KEY (DELIVERYNUM),
	CONSTRAINT FK_DELIVERY_USERID FOREIGN KEY (USERID) REFERENCES MEMBER(USERID));

CREATE TABLE BOARDS (
	BOARDNUM NUMBER,
    
	USERID VARCHAR2(20),
	PRODUCTNUM NUMBER(10),
	SUBJECT VARCHAR2(100),
	CONTENT VARCHAR2(1024),
	POSTDATE DATE,
	COMMUNITY VARCHAR2(20),
	HITCOUNT NUMBER,
	CONSTRAINT PK_BOARD_BOARDNUM PRIMARY KEY (BOARDNUM),
	CONSTRAINT FK_BOARD_USERID FOREIGN KEY (USERID) REFERENCES MEMBER(USERID),
	CONSTRAINT FK_BOARD_PRODUCTNUM FOREIGN KEY (PRODUCTNUM) REFERENCES PRODUCT(PRODUCTNUM));
	
INSERT INTO MEMBER VALUES('kristal','asd','kristal','F','1993/02/14','서울시 강남구 청담동 129 PH129','kristal@naver.com','01055861420');
INSERT INTO MEMBER VALUES('yun','asd','yun','M','95/04/01','서울 강남구 테헤란로 124,4층,(역삼동)','yun@naver.com','01020893971');
INSERT INTO MEMBER VALUES('hong','asd','hong','M','90/01/01','서울시 강남구 청담동 134-38','hong@naver.com','01068755530');
INSERT INTO MEMBER VALUES('chang','asd','chang','M','88/07/07','서울시 강남구 개포동 1282','chang@naver.com','01041643687');
INSERT INTO MEMBER VALUES('asd','asd','asdName','M',SYSDATE,'06234,서울 강남구 테헤란로 124,4층,(역삼동)','asd@asd.asd','01012341234');
INSERT INTO MEMBER VALUES('qwe','qwe','qweName','M',SYSDATE,'11111,서울 역삼,4층,(역삼동)','qwe@qwe.qwe','01012341234');

INSERT INTO PRODUCT VALUES(1,'asd',10000,'top','57988870f76b16530cf26541774dc56b.jpg,8f5e9783383425af4f201e0fedb8ae9e.jpg',
                            '57988870f76b16530cf26541774dc56b.jpg,8f5e9783383425af4f201e0fedb8ae9e.jpg','red','L');
INSERT INTO PRODUCT VALUES(2,'qwe',20000,'top','80a486b82e7f26dfd48632d43f9ea8e7.jpg,d4acbb7373d136090149204d6305d2bf.jpg',
                            '80a486b82e7f26dfd48632d43f9ea8e7.jpg,d4acbb7373d136090149204d6305d2bf.jpg','red','M');
INSERT INTO PRODUCT VALUES(3,'zxc',30000,'top','97a083e98b97bf231eb081b614e312a9.jpg,f4abcc5266199d51e189638fa41405a2.jpg',
                            '97a083e98b97bf231eb081b614e312a9.jpg,f4abcc5266199d51e189638fa41405a2.jpg','red','L');
INSERT INTO ORDERS VALUES(1,'yun',1,2,'red','L','2022/08/01','cartList');
INSERT INTO ORDERS VALUES(2,'yun',2,3,'red','L','2022/08/02','wishList');
INSERT INTO ORDERS VALUES(3,'hong',1,1,'red','L','2022/08/03','cartList');
INSERT INTO ORDERS VALUES(4,'hong',2,2,'red','L','2022/08/04','wishList');
INSERT INTO ORDERS VALUES(5,'chang',1,3,'red','L','2022/08/05','cartList');
INSERT INTO ORDERS VALUES(6,'chang',2,4,'red','L','2022/08/06','wishList');


INSERT INTO BOARDS VALUES(1,'kristal',1,'고객 보상 지원 제도 시행 안내','고객 보상 지원 제도 시행 안내','2022/08/01','NOTICE',0);

INSERT INTO BOARDS VALUES(2,'kristal',2,'상의 일부 상품의 권장 소비자 가격이 변경됨을 안내드립니다.','상의 일부 상품의 권장 소비자 가격이 변경됨을 안내드립니다.','2022/08/03','NOTICE',0);

INSERT INTO BOARDS VALUES(3,'kristal',3,'인터넷 익스플로러(IE) 지원 종료 안내','친구 및 쪽지 서비스 종료 안내','2022/09/01','NOTICE',0);

INSERT INTO BOARDS VALUES(4,'kristal',1,'친구 및 쪽지 서비스 종료 안내','친구 및 쪽지 서비스 종료 안내','2022/09/20','NOTICE',0);

INSERT INTO BOARDS VALUES(5,'kristal',2,'대리구매 이용 자제를 당부드립니다.','대리구매 이용 자제를 당부드립니다.','2022/10/11','NOTICE',0);

INSERT INTO BOARDS VALUES(6,'kristal',3,'5년이상 미 사용 적립금 소멸 관련 공지사항입니다.','5년이상 미 사용 적립금 소멸 관련 공지사항입니다.','2022/11/27','NOTICE',0);

INSERT INTO BOARDS VALUES(7,'kristal',1,'[사과문] 후속 조치에 대해 말씀드립니다.','[사과문] 후속 조치에 대해 말씀드립니다.','2022/08/01','NOTICE',0);

INSERT INTO BOARDS VALUES(8,'kristal',2,'장바구니 상품 보관 정책 변경 안내','장바구니 상품 보관 정책 변경 안내','2022/12/25','NOTICE',0);


INSERT INTO BOARDS VALUES(9,'yun',1,'상품문의','상품문의','2022/08/01','QnA',0);
INSERT INTO BOARDS VALUES(10,'yun',2,'환불문의','환불문의','2022/08/02','QnA',0);
INSERT INTO BOARDS VALUES(11,'yun',3,'결제문의','결제문의','2022/08/03','QnA',0);
INSERT INTO BOARDS VALUES(12,'hong',1,'상품문의','상품문의','2022/08/04','QnA',0);
INSERT INTO BOARDS VALUES(13,'hong',2,'환불문의','환불문의','2022/08/05','QnA',0);
INSERT INTO BOARDS VALUES(14,'hong',3,'결제문의','결제문의','2022/08/06','QnA',0);
INSERT INTO BOARDS VALUES(15,'chang',1,'상품문의','상품문의','2022/08/07','QnA',0);
INSERT INTO BOARDS VALUES(16,'chang',2,'결제문의','결제문의','2022/08/08','QnA',0);


INSERT INTO BOARDS VALUES(17,'yun',1,'정말 이뻐요','정말 이뻐요','2022/08/01','REVIEW',0);
INSERT INTO BOARDS VALUES(18,'yun',2,'대박','대박','2022/08/02','REVIEW',0);
INSERT INTO BOARDS VALUES(19,'yun',3,'의상 인증','인증합니다','2022/08/03','REVIEW',0);
INSERT INTO BOARDS VALUES(20,'hong',1,'또 사고싶어요','사이즈 적당히 잘 맞는거 같아요','2022/08/04','REVIEW',0);
INSERT INTO BOARDS VALUES(21,'hong',2,'또 이용할게요','감사합니다','2022/08/05','REVIEW',0);
INSERT INTO BOARDS VALUES(22,'hong',3,'인증샷','정말 이뻐요','2022/08/06','REVIEW',0);
INSERT INTO BOARDS VALUES(23,'chang',1,'정말 멋져요','또사고싶어요','2022/08/07','REVIEW',0);
INSERT INTO BOARDS VALUES(24,'chang',2,'착샷','또살게요','2022/08/08','REVIEW',0);                            

INSERT INTO ORDERS VALUES(1,'asd',1,5,'red','L',SYSDATE,'cartList');
INSERT INTO ORDERS VALUES(2,'asd',1,5,'red','L',SYSDATE,'cartList');
INSERT INTO ORDERS VALUES(3,'asd',3,5,'red','L',SYSDATE,'cartList');
INSERT INTO ORDERS VALUES(4,'asd',2,3,'red','L',SYSDATE,'cartList');
INSERT INTO ORDERS VALUES(5,'asd',3,7,'red','L',SYSDATE,'cartList');

commit;






