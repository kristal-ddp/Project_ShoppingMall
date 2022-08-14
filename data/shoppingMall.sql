CREATE USER shop IDENTIFIED BY a123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO shop;

DROP TABLE REVIEW PURGE;
DROP TABLE QNA PURGE;
DROP TABLE NOTICE PURGE;
DROP TABLE DELIVERY PURGE;
DROP TABLE ORDERS PURGE;
DROP TABLE PRODUCT PURGE;
DROP TABLE COMMENTS PURGE;
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
    REGISTRATION NUMBER(1),
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
    DESCRIPTION VARCHAR2(1000),
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
   REVIEW NUMBER(1),
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

CREATE TABLE NOTICE (
   BOARDNUM NUMBER,
   USERID VARCHAR2(20),
   SUBJECT VARCHAR2(100),
   CONTENT VARCHAR2(1024),
   POSTDATE DATE,
   HITS NUMBER,
   CONSTRAINT PK_NOTICE_BOARDNUM PRIMARY KEY (BOARDNUM),
   CONSTRAINT FK_NOTICE_USERID FOREIGN KEY (USERID) REFERENCES MEMBER(USERID));
    
CREATE TABLE QNA (
   BOARDNUM NUMBER,
   USERID VARCHAR2(20),
   PRODUCTNUM NUMBER(10),
   SUBJECT VARCHAR2(100),
   CONTENT VARCHAR2(1024),
   POSTDATE DATE,
   HITS NUMBER,
   CONSTRAINT PK_QNA_BOARDNUM PRIMARY KEY (BOARDNUM),
   CONSTRAINT FK_QNA_USERID FOREIGN KEY (USERID) REFERENCES MEMBER(USERID),
   CONSTRAINT FK_QNA_PRODUCTNUM FOREIGN KEY (PRODUCTNUM) REFERENCES PRODUCT(PRODUCTNUM));
    
CREATE TABLE REVIEW (
   BOARDNUM NUMBER,
   USERID VARCHAR2(20),
   ORDERNUM NUMBER(10),
   SUBJECT VARCHAR2(100),
   CONTENT VARCHAR2(1024),
   POSTDATE DATE,
   HITS NUMBER,
   CONSTRAINT PK_REVIEW_BOARDNUM PRIMARY KEY (BOARDNUM),
   CONSTRAINT FK_REVIEW_USERID FOREIGN KEY (USERID) REFERENCES MEMBER(USERID),
   CONSTRAINT FK_REVIEW_ORDERNUM FOREIGN KEY (ORDERNUM) REFERENCES ORDERS(ORDERNUM));

CREATE TABLE COMMENTS (
   BOARDNUM NUMBER,
    COMMUNITY VARCHAR2(20),
    USERID VARCHAR2(20),
   POSTDATE DATE,
   CONTENT VARCHAR2(1024),
   CONSTRAINT FK_COMMENT_USERID FOREIGN KEY (USERID) REFERENCES MEMBER(USERID));

INSERT INTO MEMBER VALUES('KRISTAL','sss','관리자','여자','1993/02/14','06234/서울 강남구 테헤란로 124/4층/(역삼동)','kristal@naver.com','01055861420',1);
INSERT INTO MEMBER VALUES('yun','asd','yun','남자','95/04/01','12334/서울 강남구 테헤란로 124/4층/(역삼동)','yun@naver.com','01020893971',1);
INSERT INTO MEMBER VALUES('hong','asd','hong','남자','90/01/01','06234/서울 강남구 테헤란로 124/4층/(역삼동)','hong@naver.com','01068755530',1);
INSERT INTO MEMBER VALUES('chang','asd','chang','남자','88/07/07','06234/서울 강남구 테헤란로 124/4층/(역삼동)','chang@naver.com','01041643687',1);
INSERT INTO MEMBER VALUES('asd','asd','asdName','남자',SYSDATE,'06234/서울 강남구 테헤란로 124/4층/(역삼동)','asd@asd.asd','01012341234',1);
INSERT INTO MEMBER VALUES('qwe','qwe','qweName','남자',SYSDATE,'11111/서울 역삼/4층/(역삼동)','qwe@qwe.qwe','01012341234',1);
INSERT INTO MEMBER VALUES('soo','sss','수정','여자',SYSDATE,'11111/서울 역삼/4층/(역삼동)','soo@naver.com','01012341234',1);

INSERT INTO PRODUCT VALUES(1,'Half-sleeve linen Jacket',139500,'outer','44d34ec9996559ad8ccc723232d7ea46.jpg,97501c74e01b25dc9609a62b52db502c.jpg,54c688722a8a2c464bc8c03463055344.jpg,c10b47ebdd58e09ba4affbf5ba01051a.jpg,65f284088a5db1291351c3e9ac6cbc7b.jpg','44d34ec9996559ad8ccc723232d7ea46.jpg,97501c74e01b25dc9609a62b52db502c.jpg,54c688722a8a2c464bc8c03463055344.jpg,c10b47ebdd58e09ba4affbf5ba01051a.jpg,65f284088a5db1291351c3e9ac6cbc7b.jpg','BEIGE','SMALL,MEDIUM,LARGE','깔끔한 디자인의 린넨 자켓입니다.'||CHR(10)||CHR(13)||'슬림한 핏과 크롭 기장으로 여성스러운 포인트를 더했으며,'
||CHR(10)||CHR(13)||'어디에나 잘 어울려 여름 시즌 가볍게 걸치기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'FABRIC : LINEN 55% COTTON 45%'
||CHR(10)||CHR(13)||'WASHING : DRY CLEANING ONLY'||CHR(10)||CHR(13)||'(두께 보통 / 신축성 없음 / 비침 없음 / 안감 없음 / 핏 보통)'
);

INSERT INTO PRODUCT VALUES(2,'Half-sleeve linen jacket',139500,'outer','e559674f242de910cd8bc196de30d2e8.jpg,82089ea5569897db10ceb0f12ec7ea1d.jpg,5694d1ef348f3f5e26f36ec5a2a1ee9b.jpg,1494772317f8fc016c582802f3812de9.jpg,e2fa70c29edbbb0e2076117bf3170640.jpg,bb86c8065bbe22d93436c4cbae9e1f97.jpg','e559674f242de910cd8bc196de30d2e8.jpg,82089ea5569897db10ceb0f12ec7ea1d.jpg,5694d1ef348f3f5e26f36ec5a2a1ee9b.jpg,1494772317f8fc016c582802f3812de9.jpg,e2fa70c29edbbb0e2076117bf3170640.jpg,bb86c8065bbe22d93436c4cbae9e1f97.jpg','BLACK','MEDIUM,LARGE','깔끔한 디자인의 린넨 자켓입니다.'||CHR(10)||CHR(13)||'슬림한 핏과 크롭 기장으로 여성스러운 포인트를 더했으며,'
||CHR(10)||CHR(13)||'어디에나 잘 어울려 여름 시즌 가볍게 걸치기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'FABRIC : LINEN 55% COTTON 45%'
||CHR(10)||CHR(13)||'WASHING : DRY CLEANING ONLY'||CHR(10)||CHR(13)||'(두께 보통 / 신축성 없음 / 비침 없음 / 안감 없음 / 핏 보통)');

INSERT INTO PRODUCT VALUES(3,'Classy tweed half jacket',178200,'outer','115458b584868a66fd0869bdc760c1bc.jpg,e337cb7d8e7f5533c3dad7230b3dbdb2.jpg,989229b7d43c4d7de1463ba6372cab48.jpg,fdb6b40a55b150a9e5888f38390b1e24.jpg,3bf7a975e77e387546ec973c1076991e.jpg,a32c194cbb9e15908649b79bdcb334e7.jpg','115458b584868a66fd0869bdc760c1bc.jpg,e337cb7d8e7f5533c3dad7230b3dbdb2.jpg,989229b7d43c4d7de1463ba6372cab48.jpg,fdb6b40a55b150a9e5888f38390b1e24.jpg,3bf7a975e77e387546ec973c1076991e.jpg,a32c194cbb9e15908649b79bdcb334e7.jpg','WHITE','SMALL,MEDIUM,LARGE','클래식한 매력의 트위드 자켓입니다.'||CHR(10)||CHR(13)||'여름에도 가볍게 걸치기 좋은 두께감과'||CHR(10)||CHR(13)||
'고급스러운 소재를 자랑하며'||CHR(10)||CHR(13)||'원피스는 물론 팬츠나 스커트와도 잘 어울리는 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'[WOOL 38% LYOCELL 28% POLYESTER 34%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(4,'Classy tweed half jacket',178200,'outer','cd56ca14ccccb500a1e3ef3ac2962163.jpg,52565c7c218b425f6dcf5a51e93c6847.jpg,3f789b114667eb98f24db037824b2a25.jpg,cd104ed6e465d18b7610268ab3d28c51.jpg,c3ca657c2638775301bbcf15858d2f25.jpg,cd2764a6fcaa79c8cbea1fec6a579759.jpg','cd56ca14ccccb500a1e3ef3ac2962163.jpg,52565c7c218b425f6dcf5a51e93c6847.jpg,3f789b114667eb98f24db037824b2a25.jpg,cd104ed6e465d18b7610268ab3d28c51.jpg,c3ca657c2638775301bbcf15858d2f25.jpg,cd2764a6fcaa79c8cbea1fec6a579759.jpg','MINT','MEDIUM,LARGE','클래식한 매력의 트위드 자켓입니다.'||CHR(10)||CHR(13)||'여름에도 가볍게 걸치기 좋은 두께감과'||CHR(10)||CHR(13)||
'고급스러운 소재를 자랑하며'||CHR(10)||CHR(13)||'원피스는 물론 팬츠나 스커트와도 잘 어울리는 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'[WOOL 38% LYOCELL 28% POLYESTER 34%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(5,'Button crop cardigan',121500,'outer','aad4e708954afc9fb4df7daf194e838e.jpg,7267faed51a06bb0ae91d6ac7a2abf0e.jpg,eceb6df08467cd3e236f7801d20d8508.jpg,19fd4c53f4e2143c91e93d8e06e63b0b.jpg,d8c3f1a4ff014ed3b4a9e395a2f3341b.jpg,c180d8c339c866dc9a17760f11fbab03.jpg','aad4e708954afc9fb4df7daf194e838e.jpg,7267faed51a06bb0ae91d6ac7a2abf0e.jpg,eceb6df08467cd3e236f7801d20d8508.jpg,19fd4c53f4e2143c91e93d8e06e63b0b.jpg,d8c3f1a4ff014ed3b4a9e395a2f3341b.jpg,c180d8c339c866dc9a17760f11fbab03.jpg','IVORY','SMALL,MEDIUM,LARGE','깔끔한 디자인의 크롭 가디건입니다.'||CHR(10)||CHR(13)||'한층 더 슬림해 보이는 크롭 기장에 배색 디테일이 포인트가 되어'
||CHR(10)||CHR(13)||'여성스러운 매력을 더했으며,'||CHR(10)||CHR(13)||'가벼운 소재감으로 초여름까지 함께할 수 있는 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 60% POLYESTER 40%]'
||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'
||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'
||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(6,'Tweed half sleeve cardigan',135000,'outer','326f7b54249f96de615c7f5938d64d10.jpg,5eff621b9e9396991b71db60ad49d625.jpg,ee9460b6dcb0cf1738d3bc7561a11235.jpg,226af4887c1476964e8bac12f2ef2cca.jpg,b56e7cd140e1c800b19fce347d50207e.jpg,93ac45e69ed37cf07adf92f4a77e9e92.jpg','326f7b54249f96de615c7f5938d64d10.jpg,5eff621b9e9396991b71db60ad49d625.jpg,ee9460b6dcb0cf1738d3bc7561a11235.jpg,226af4887c1476964e8bac12f2ef2cca.jpg,b56e7cd140e1c800b19fce347d50207e.jpg,93ac45e69ed37cf07adf92f4a77e9e92.jpg','BEIGE','SMALL,MEDIUM,LARGE','여성스러운 분위기가 물씬 느껴지는 가디건입니다.' ||CHR(10)||CHR(13)||'화사한 컬러 배색이 돋보이는 트위드 디자인에'
||CHR(10)||CHR(13)||'가볍고 부드러운 터치감을 자랑해'||CHR(10)||CHR(13)||'여름 시즌까지 함께할 수 있는 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 70% ACRYLIC 30%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'
||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(7,'Line knit cardigan',124200,'outer','1e1cd5f2b51fc229b1ef62cb1eee4e08.jpg,f7260687ecaacb00e872797734be08c8.jpg,82712337cb3419b4a0ce290a4fd7e471.jpg,48f424955c7abd02b371477393081bd4.jpg,5b87b3d646ed53ef5365ca80fd58c664.jpg,a6e3ac45bab01c66bcbbec58ef3c405f.jpg','1e1cd5f2b51fc229b1ef62cb1eee4e08.jpg,f7260687ecaacb00e872797734be08c8.jpg,82712337cb3419b4a0ce290a4fd7e471.jpg,48f424955c7abd02b371477393081bd4.jpg,5b87b3d646ed53ef5365ca80fd58c664.jpg,a6e3ac45bab01c66bcbbec58ef3c405f.jpg','SKYBLUE','MEDIUM,LARGE','여성스러운 무드를 더해줄 가디건입니다.'||CHR(10)||CHR(13)||'배색이 포인트가 된 디자인에 부드럽고 가벼운 소재감으로'
||CHR(10)||CHR(13)||'초여름까지 입을 수 있으며,'||CHR(10)||CHR(13)||'세트로는 물론 단품으로도 활용하기 좋은 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 60% POLYESTER 40%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'
||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(8,'Grace tweed jacket',177300,'outer','add9826f7b40e88350c87db96ec1b105.jpg,fd3e12e1fc18b15867491db24dbe88c8.jpg,99d56bf28362954d33df6cc9d161237c.jpg,164b00b2c634ad5a3d08cbf0ba4bb475.jpg,dea5972e93898b2d822c48fbcf017c99.jpg','add9826f7b40e88350c87db96ec1b105.jpg,fd3e12e1fc18b15867491db24dbe88c8.jpg,99d56bf28362954d33df6cc9d161237c.jpg,164b00b2c634ad5a3d08cbf0ba4bb475.jpg,dea5972e93898b2d822c48fbcf017c99.jpg','IVORY','SMALL,MEDIUM,LARGE','세련된 분위기가 물씬 느껴지는 트위드 자켓입니다.'||CHR(10)||CHR(13)||'고급스럽고 여성스러운 트위드 원단에 예쁘게 떨어지는 핏감으로'
||CHR(10)||CHR(13)||'스커트와 세트로는 물론, 팬츠나 원피스와 함께 매치하기도 좋으며,'||CHR(10)||CHR(13)||
'격식있는 자리에서 입기도 좋아 소장가치가 높은 상품입니다. ' ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[WOOL 40% ACRYLIC 40% POLYESTER 20%]'
||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(9,'Summer knit bolero',76500,'outer','e69a6adad516a4126cdd87ada665e54a.jpg,de3d93313b0c61835819c6dbad4c1314.jpg,1ff931cf2e73e03bf6a9071df476db57.jpg,d6565b343868858f6006030aa7c2ca60.jpg,70f105f3e2682d4474260144a85f9fa0.jpg','e69a6adad516a4126cdd87ada665e54a.jpg,de3d93313b0c61835819c6dbad4c1314.jpg,1ff931cf2e73e03bf6a9071df476db57.jpg,d6565b343868858f6006030aa7c2ca60.jpg,70f105f3e2682d4474260144a85f9fa0.jpg','SKYBLUE','SMALL,MEDIUM,LARGE','여름시즌 가볍게 걸치기 좋은 니트 볼레로입니다.'||CHR(10)||CHR(13)||'심플한 디자인과 시원한 소재감으로'||CHR(10)||CHR(13)||
'원피스는 물론 다양한 코디에 매치하기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[ACRYLIC 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');


INSERT INTO PRODUCT VALUES(10,'Minimal crop knit vest',80100,'top','b24e98674d016cf112285106614bb945.jpg,d4818b73d6d716e73432643ac30302fa.jpg,bd1c232f011034780bfb0003479c3716.jpg,32a19ec6a2fc7a45a6a4a8b3c2731d32.jpg,8840baf286432fe0b7c53ac0f4426724.jpg,26e21364bcfadcb5ef39180d6aa80073.jpg','b24e98674d016cf112285106614bb945.jpg,d4818b73d6d716e73432643ac30302fa.jpg,bd1c232f011034780bfb0003479c3716.jpg,32a19ec6a2fc7a45a6a4a8b3c2731d32.jpg,8840baf286432fe0b7c53ac0f4426724.jpg,26e21364bcfadcb5ef39180d6aa80073.jpg','CREAM','MEDIUM,LARGE','센스있는 포인트가 되어줄 니트 베스트입니다.'||CHR(10)||CHR(13)||'미니멀한 기장감으로 트렌디함은 물론 한층 더 날씬해 보이는 효과를 주며,'
 ||CHR(10)||CHR(13)||'어떤 룩에나 포인트로 매치하기 좋아 소장가치가 높은 상품입니다.' ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'[COTTON 100%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(11,'Lily shirring blouse',98100,'top','4b9108acd56283bd6774cdf3d5ba0dd0.jpg,d630540421f669cd21103ba7ff52078e.jpg,5f740cd970749a4732c10b17a68dde44.jpg,c607eb426b0b09bd4170e63d2a12e35a.jpg,2142fe3f052e576d5918ebd7026bb773.jpg,09c7f2ebc7032f38a8e9c92fd04646b9.jpg','4b9108acd56283bd6774cdf3d5ba0dd0.jpg,d630540421f669cd21103ba7ff52078e.jpg,5f740cd970749a4732c10b17a68dde44.jpg,c607eb426b0b09bd4170e63d2a12e35a.jpg,2142fe3f052e576d5918ebd7026bb773.jpg,09c7f2ebc7032f38a8e9c92fd04646b9.jpg','BLACK','MEDIUM,LARGE',
'러블리한 매력의 블라우스입니다.'||CHR(10)||CHR(13)||'셔링 디테일이 포인트가 된 디자인에'||CHR(10)||CHR(13)||
'크롭 기장감으로 썸머시즌 비치룩으로도 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 100%]' ||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(12,'Balloon square shirring blouse',126000,'top','b5d0289c97de85ccce30d395e4a56a9a.jpg,a6d74a31b2a5ca6579cc1eee31d76544.jpg,468a7c656d0f064aed0965de70b0c99f.jpg,cef5dd455f4bc3af3e85490fcc2c36bd.jpg,892565e11bb91f5161d4b27669294e9d.jpg,4a7dbe9333ab80148fe4cb94352761da.jpg','b5d0289c97de85ccce30d395e4a56a9a.jpg,a6d74a31b2a5ca6579cc1eee31d76544.jpg,468a7c656d0f064aed0965de70b0c99f.jpg,cef5dd455f4bc3af3e85490fcc2c36bd.jpg,892565e11bb91f5161d4b27669294e9d.jpg,4a7dbe9333ab80148fe4cb94352761da.jpg','WHITE','SMALL,MEDIUM,LARGE',
'여성스러운 매력이 물씬 느껴지는 블라우스입니다.'||CHR(10)||CHR(13)||'셔링과 퍼프소매 디테일이 포인트가 된 디자인으로'
||CHR(10)||CHR(13)||'팬츠는 물론 스커트와도 잘 어울리는 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[POLYESTER 100%]'
||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(13,'Balloon square shirring blouse',126000,'top','8a85306581cde6787fc230ab0a356638.jpg,12df543fb212f62f98c2c69fc21b00b7.jpg,10d6992f755f83b30fdf5d487ee4e90a.jpg,60216ec81d395adc77fae895c8d89817.jpg,bdf264b5f0a36d234d9b2560d1e09902.jpg,abecb5a35df5ce317b3830103474607c.jpg','8a85306581cde6787fc230ab0a356638.jpg,12df543fb212f62f98c2c69fc21b00b7.jpg,10d6992f755f83b30fdf5d487ee4e90a.jpg,60216ec81d395adc77fae895c8d89817.jpg,bdf264b5f0a36d234d9b2560d1e09902.jpg,abecb5a35df5ce317b3830103474607c.jpg','MINT','MEDIUM,LARGE',
'여성스러운 매력이 물씬 느껴지는 블라우스입니다.' ||CHR(10)||CHR(13)||'셔링과 퍼프소매 디테일이 포인트가 된 디자인으로'
||CHR(10)||CHR(13)||'팬츠는 물론 스커트와도 잘 어울리는 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[POLYESTER 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(14,'Lily shirring blouse',98100,'top','8b85ff77eda1c00b19d3691adf7d07d0.jpg,00c3ecf687923ee96c0b4c1a7f1f81b3.jpg,5d6081c85cc113d6236d8a1379be203e.jpg,7e93df274048eec50267c83e2ad2b266.jpg,b85acf7c10a07f7badc7381ac20e000c.jpg,355ef69d59a8d78d41c5cefe84df8a4a.jpg','8b85ff77eda1c00b19d3691adf7d07d0.jpg,00c3ecf687923ee96c0b4c1a7f1f81b3.jpg,5d6081c85cc113d6236d8a1379be203e.jpg,7e93df274048eec50267c83e2ad2b266.jpg,b85acf7c10a07f7badc7381ac20e000c.jpg,355ef69d59a8d78d41c5cefe84df8a4a.jpg','WHITE','SMALL,MEDIUM,LARGE',
'러블리한 매력의 블라우스입니다.' ||CHR(10)||CHR(13)||'셔링 디테일이 포인트가 된 디자인에'||CHR(10)||CHR(13)||
'크롭 기장감으로 썸머시즌 비치룩으로도 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(15,'Lily shirring blouse',98100,'top','d6980fb0d5a11d4fd66cb1a6f64c9a75.jpg,a7d69132ab699a2f09523e9fa941fa06.jpg,726699e31344a72155b0c6be9690ea28.jpg,65033b3cce0ab317cbd8a6ffb14981fc.jpg,fe00e7488fcb74c246d487ba9759c8fa.jpg,91c2aea9b7eba168cc8b4c1d7c5b8dc1.jpg','d6980fb0d5a11d4fd66cb1a6f64c9a75.jpg,a7d69132ab699a2f09523e9fa941fa06.jpg,726699e31344a72155b0c6be9690ea28.jpg,65033b3cce0ab317cbd8a6ffb14981fc.jpg,fe00e7488fcb74c246d487ba9759c8fa.jpg,91c2aea9b7eba168cc8b4c1d7c5b8dc1.jpg','YELLOW','MEDIUM,LARGE',
'러블리한 매력의 블라우스입니다.'||CHR(10)||CHR(13)||'셔링 디테일이 포인트가 된 디자인에'||CHR(10)||CHR(13)||
'크롭 기장감으로 썸머시즌 비치룩으로도 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 100%]' ||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY' ||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(16,'Balloon square shirring blouse',126000,'top','4fa50b13238795e8e21b3d29b44ded24.jpg,4b300a12f46a8b27b500a75c261ccde0.jpg,5d1c0440b5a097e725b8de7704dd90dd.jpg,5c103dfce6f43c2e36dbe0236192a832.jpg,7ffb4e215e0def56b3bf4f5bf4d3701e.jpg,1eac50bb0f92d82bdcaff33cd0b68f2a.jpg','4fa50b13238795e8e21b3d29b44ded24.jpg,4b300a12f46a8b27b500a75c261ccde0.jpg,5d1c0440b5a097e725b8de7704dd90dd.jpg,5c103dfce6f43c2e36dbe0236192a832.jpg,7ffb4e215e0def56b3bf4f5bf4d3701e.jpg,1eac50bb0f92d82bdcaff33cd0b68f2a.jpg','BLACK','SMALL,MEDIUM,LARGE',
'여성스러운 매력이 물씬 느껴지는 블라우스입니다.'||CHR(10)||CHR(13)||'셔링과 퍼프소매 디테일이 포인트가 된 디자인으로'||CHR(10)||CHR(13)||
'팬츠는 물론 스커트와도 잘 어울리는 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[POLYESTER 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(17,'Terry tube top',58500,'top','9ba8f944383cfa31e2ee8df9fcb406fe.jpg,53b7f7722f2350f7b503f84b9054ddbb.jpg,9f89dec87c26c5bedd0fed63d168d2f4.jpg,07adf113f5ed6e3956715755e580622c.jpg,39b3dbf0a7a6bec77b83f6a71cccc3b9.jpg,a468af22af76e5d3017254678702fe2e.jpg','9ba8f944383cfa31e2ee8df9fcb406fe.jpg,53b7f7722f2350f7b503f84b9054ddbb.jpg,9f89dec87c26c5bedd0fed63d168d2f4.jpg,07adf113f5ed6e3956715755e580622c.jpg,39b3dbf0a7a6bec77b83f6a71cccc3b9.jpg,a468af22af76e5d3017254678702fe2e.jpg','MINT','SMALL,MEDIUM,LARGE',
'썸머시즌 화사한 포인트가 되어줄 탑 제품입니다.'||CHR(10)||CHR(13)||'부드럽고 시원한 테리소재로 편안한 착용감을 자랑하며'||CHR(10)||CHR(13)||
'캡이 내장되어 있어 볼륨감도 더해주었습니다.'||CHR(10)||CHR(13)||'동일한 원단으로 제작된 팬츠와 함께 착용하시면 더욱 러블리한 무드를 연출할 수 있는 제품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 82% POLYESTER 18%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(18,'Terry tube top',58500,'top','23c5def6d90b1e6e3af622ba3f6674f6.jpg,895303efd16b0aa24956af17d7b2ea85.jpg,1ebe5e48824ff1a8015bfa78040d8025.jpg,74d974ad97f2571950454d120273dae3.jpg,991765e38aa61426c568255fe6a9a875.jpg,75f077890f311be545fafa8a7fe5b554.jpg','23c5def6d90b1e6e3af622ba3f6674f6.jpg,895303efd16b0aa24956af17d7b2ea85.jpg,1ebe5e48824ff1a8015bfa78040d8025.jpg,74d974ad97f2571950454d120273dae3.jpg,991765e38aa61426c568255fe6a9a875.jpg,75f077890f311be545fafa8a7fe5b554.jpg','PURPLE','MEDIUM,LARGE',
'썸머시즌 화사한 포인트가 되어줄 탑 제품입니다.'||CHR(10)||CHR(13)||'부드럽고 시원한 테리소재로 편안한 착용감을 자랑하며'||CHR(10)||CHR(13)||
'캡이 내장되어 있어 볼륨감도 더해주었습니다.'||CHR(10)||CHR(13)||'동일한 원단으로 제작된 팬츠와 함께 착용하시면 더욱 러블리한 무드를 연출할 수 있는 제품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 82% POLYESTER 18%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');




INSERT INTO PRODUCT VALUES(19,'Classic wool slacks',133200,'bottom','60e28027cd1babf9096f1c8a60f3787a.jpg,34a4492a43ceba35053d9496114f6f70.jpg,7d5ec2242375b8f62930f56a045150fe.jpg,71c0dd292b3642363956ef7e13275991.jpg,1f5a7446ba7df7001f2def2726854bba.jpg,3ac655a9876de550d8b59e74ca7147e8.jpg','60e28027cd1babf9096f1c8a60f3787a.jpg,34a4492a43ceba35053d9496114f6f70.jpg,7d5ec2242375b8f62930f56a045150fe.jpg,71c0dd292b3642363956ef7e13275991.jpg,1f5a7446ba7df7001f2def2726854bba.jpg,3ac655a9876de550d8b59e74ca7147e8.jpg','CHARCOAL','SMALL,MEDIUM,LARGE',
'클래식한 디자인의 슬랙스입니다.'||CHR(10)||CHR(13)||'도톰한 울 혼방 소재로 보온성을 자랑하며,' ||CHR(10)||CHR(13)||
'딱 떨어지는 핏으로 한층 더 고급스러운 룩을 완성시켜줄 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'WOOL 18% POLYESTER 56% RAYON 24% SPAN 2%'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(20,'Wide fit denim pants',108000,'bottom','c292c01c8b0bb026f47f75122a15b63a.jpg,cf01e75f6007c95c11769984e27e6a15.jpg,657fef125c98ba6e1ae3f7ef4301a2a2.jpg,cf88cfa515689dd12b103f2634492bee.jpg,914a2bae5b54980b8116374ff7d46ee4.jpg,4c28aebf539720a6916d4a6fa0605b36.jpg','c292c01c8b0bb026f47f75122a15b63a.jpg,cf01e75f6007c95c11769984e27e6a15.jpg,657fef125c98ba6e1ae3f7ef4301a2a2.jpg,cf88cfa515689dd12b103f2634492bee.jpg,914a2bae5b54980b8116374ff7d46ee4.jpg,4c28aebf539720a6916d4a6fa0605b36.jpg','BLUE','SMALL,MEDIUM,LARGE',
'어디에나 매치하기 좋은 디자인의 데님 팬츠입니다.'||CHR(10)||CHR(13)||'여유 있는 핏감으로 사이즈에 구애 없이 즐길 수 있으며,'
 ||CHR(10)||CHR(13)||'편안한 착용감을 자랑해 데일리 아이템으로 제격인 상품입니다. ' ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'COTTON 100%'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(21,'Terry half sweat pants',67500,'bottom','168e4d1f8523a080c05f6578eee30bf4.jpg,d69b76e0e4f51929b2dc9f0beb4362ea.jpg,dceb00477952b03161e9fbf724fc23b1.jpg,6eb02ede4ad817e7a7b4fb8cd5db31f7.jpg,67d23a36b8e52918e29e5453850628d9.jpg,e3dc7acd57352229eb62d03acbc78194.jpg','168e4d1f8523a080c05f6578eee30bf4.jpg,d69b76e0e4f51929b2dc9f0beb4362ea.jpg,dceb00477952b03161e9fbf724fc23b1.jpg,6eb02ede4ad817e7a7b4fb8cd5db31f7.jpg,67d23a36b8e52918e29e5453850628d9.jpg,e3dc7acd57352229eb62d03acbc78194.jpg','MINTCHECK','MEDIUM,LARGE',
'썸머시즌 편하게 착용하기 좋은 테리 팬츠입니다.' ||CHR(10)||CHR(13)||'귀여운 체크패턴이 포인트가 되었으며'||CHR(10)||CHR(13)||
'부드럽고 시원한 테리소재가 편안한 착용감을 자랑하는 제품입니다.' ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 82% POLYESTER 18%]'
||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(22,'linen roll-up pants',80500,'bottom','aa7f82e8eb3a15c8e1318635d156c63e.jpg,ed8a2338713fb4a09038c56385430634.jpg,a9104fd1dbdbe551099a2a552edf3038.jpg,2448395de3e9739533727caa3fc2a0a1.jpg,0a4ff3491681a533e6ff16b71b7398e6.jpg,55a7a51b3067af97320bff9e66803171.jpg','aa7f82e8eb3a15c8e1318635d156c63e.jpg,ed8a2338713fb4a09038c56385430634.jpg,a9104fd1dbdbe551099a2a552edf3038.jpg,2448395de3e9739533727caa3fc2a0a1.jpg,0a4ff3491681a533e6ff16b71b7398e6.jpg,55a7a51b3067af97320bff9e66803171.jpg','BLACK','SMALL,MEDIUM,LARGE',
'데일리 하게 즐기기 좋은 린넨팬츠입니다.' ||CHR(10)||CHR(13)||'시원한 린넨 소재에 여유 있는 핏 감과 적당한 기장감으로 여름 시즌 어디에나 매치하기 좋은 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'FABRIC : LINEN 100%'||CHR(10)||CHR(13)||'WASHING : DRY CLEANING ONLY'||CHR(10)||CHR(13)||'(두께 보통 / 신축성 없음 / 비침 보통 / 안감 없음 / 핏 보통)'
);

INSERT INTO PRODUCT VALUES(23,'linen roll-up pants',80500,'bottom','03a46e12688aaeec636e75a62b33a0e8.jpg,239fe49c54b2d30ba81802a633fa6588.jpg,778711a6fe6d7c9bb8933e31df321837.jpg,999979ddb4369882f8318d9e742aa31c.jpg,43ee15e866879cd5114846d85326f647.jpg,2a3468142d94d71d2dff128c0187cecf.jpg','03a46e12688aaeec636e75a62b33a0e8.jpg,239fe49c54b2d30ba81802a633fa6588.jpg,778711a6fe6d7c9bb8933e31df321837.jpg,999979ddb4369882f8318d9e742aa31c.jpg,43ee15e866879cd5114846d85326f647.jpg,2a3468142d94d71d2dff128c0187cecf.jpg','BEIGE','MEDIUM,LARGE',
'데일리 하게 즐기기 좋은 린넨팬츠입니다.'||CHR(10)||CHR(13)||'시원한 린넨 소재에 여유 있는 핏 감과 적당한 기장감으로 여름 시즌 어디에나 매치하기 좋은 상품입니다.'
 ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'FABRIC : LINEN 100%' ||CHR(10)||CHR(13)||'WASHING : DRY CLEANING ONLY'||CHR(10)||CHR(13)||'(두께 보통 / 신축성 없음 / 비침 보통 / 안감 없음 / 핏 보통)');

INSERT INTO PRODUCT VALUES(24,'Pintuck half pants',103500,'bottom','e6605a0060e138da51f2e34140a95ea0.jpg,210d393b974813459ba297f2b07d161c.jpg,d9068835512dbda96e10a720e5091206.jpg,aa7dfb23c7fa3894cc810c22af9eb9da.jpg,e5bfa47f441c834c90977939c10bb437.jpg,42bfccc90a21d3dfc6a589ed03f16263.jpg','e6605a0060e138da51f2e34140a95ea0.jpg,210d393b974813459ba297f2b07d161c.jpg,d9068835512dbda96e10a720e5091206.jpg,aa7dfb23c7fa3894cc810c22af9eb9da.jpg,e5bfa47f441c834c90977939c10bb437.jpg,42bfccc90a21d3dfc6a589ed03f16263.jpg','PINK','SMALL,MEDIUM,LARGE','데일리하게 즐기기 좋은 팬츠입니다.'||CHR(10)||CHR(13)||'심플한 디자인에 핀턱으로 포인트를 주었으며' ||CHR(10)||CHR(13)||
'가벼운 소재와 적당한 기장감으로'||CHR(10)||CHR(13)||'여름시즌 부담없이 즐기기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'[COTTON 100%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH'
);

INSERT INTO PRODUCT VALUES(25,'Pintuck half pants',103500,'bottom','2aeb67dbb6e2c6585bfc5815d64f32d6.jpg,fd18cd9c9dfe7bfd8138e4b8e62639f8.jpg,b3a4360ef26c9adf4ad23965b57f7e73.jpg,ae981001de9f8afb13b357d2022b5c05.jpg,96518e580d7a369da7254be00ddc3eec.jpg,8e0aa20ce70f796fdbba7d19fde0afa6.jpg','2aeb67dbb6e2c6585bfc5815d64f32d6.jpg,fd18cd9c9dfe7bfd8138e4b8e62639f8.jpg,b3a4360ef26c9adf4ad23965b57f7e73.jpg,ae981001de9f8afb13b357d2022b5c05.jpg,96518e580d7a369da7254be00ddc3eec.jpg,8e0aa20ce70f796fdbba7d19fde0afa6.jpg','WHITE','SMALL,MEDIUM,LARGE',
'데일리하게 즐기기 좋은 팬츠입니다.' ||CHR(10)||CHR(13)||'심플한 디자인에 핀턱으로 포인트를 주었으며'||CHR(10)||CHR(13)||
'가벼운 소재와 적당한 기장감으로'||CHR(10)||CHR(13)||'여름시즌 부담없이 즐기기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'[COTTON 100%]' ||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(26,'Terry half sweat pants',67500,'bottom','f23d2ba0a1a0145f1d87d2b810a32b10.jpg,ea4ab93ab1dae894d1e72ef5253d481e.jpg,79ba358e8a1598ccef8a53156ba0ba55.jpg,7c59ff6e8f83c019d85562636d7b147c.jpg,659d85335503e0610fe6d01bb9fed7f5.jpg,6e6f6d606d610b433da48381afe97918.jpg','f23d2ba0a1a0145f1d87d2b810a32b10.jpg,ea4ab93ab1dae894d1e72ef5253d481e.jpg,79ba358e8a1598ccef8a53156ba0ba55.jpg,7c59ff6e8f83c019d85562636d7b147c.jpg,659d85335503e0610fe6d01bb9fed7f5.jpg,6e6f6d606d610b433da48381afe97918.jpg','MINT','SMALL,MEDIUM,LARGE',
'썸머시즌 편하게 착용하기 좋은 테리 팬츠입니다.'||CHR(10)||CHR(13)||'귀여운 체크패턴이 포인트가 되었으며'||CHR(10)||CHR(13)||
'부드럽고 시원한 테리소재가 편안한 착용감을 자랑하는 제품입니다.' ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 82% POLYESTER 18%]'
 ||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(27,'Terry half sweat pants',67500,'bottom','f1d3b64a56fd25912339dacb2132c349.jpg,5d71cb941fcaf393d2dcdba42f10ae73.jpg,8b1131efc7dd009ce8a21330b685ad80.jpg,1b41eea08f35da675c72eb903698a9ca.jpg,50f158fe9fab14c0a11dc83c3ff08660.jpg,9f1591017c2e897ae6b881416de29c90.jpg','f1d3b64a56fd25912339dacb2132c349.jpg,5d71cb941fcaf393d2dcdba42f10ae73.jpg,8b1131efc7dd009ce8a21330b685ad80.jpg,1b41eea08f35da675c72eb903698a9ca.jpg,50f158fe9fab14c0a11dc83c3ff08660.jpg,9f1591017c2e897ae6b881416de29c90.jpg','PURPLE','MEDIUM,LARGE','썸머시즌 편하게 착용하기 좋은 테리 팬츠입니다.'||CHR(10)||CHR(13)||'귀여운 체크패턴이 포인트가 되었으며'||CHR(10)||CHR(13)||
'부드럽고 시원한 테리소재가 편안한 착용감을 자랑하는 제품입니다.' ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[COTTON 82% POLYESTER 18%]'
 ||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH'
);




INSERT INTO PRODUCT VALUES(28,'Vacation cancan dress',179100,'dress','c59cddb8952562aadaea34082fec8a37.jpg,5aba83232d2e29a7a685bb2e1739f0ef.jpg,de7975d9018d6f2ae745eb0a8ec25555.jpg,255f26e4322d6741aac1b440e47d0353.jpg,4ed38d1ba2a25ff81575902f8a4dc223.jpg,9c4508d850b97f46b69be711260eace0.jpg','c59cddb8952562aadaea34082fec8a37.jpg,5aba83232d2e29a7a685bb2e1739f0ef.jpg,de7975d9018d6f2ae745eb0a8ec25555.jpg,255f26e4322d6741aac1b440e47d0353.jpg,4ed38d1ba2a25ff81575902f8a4dc223.jpg,9c4508d850b97f46b69be711260eace0.jpg','WHITE','SMALL,MEDIUM,LARGE',
'러블리한 매력이 물씬 느껴지는 원피스입니다.'||CHR(10)||CHR(13)||'여유있는 핏감으로 체형커버는 물론 편안한 착용감을 자랑하며' ||CHR(10)||CHR(13)||
'배색 디테일이 사랑스러운 분위기를 더한 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[RAYON 70% LINEN 16% COTTON 14%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(29,'Vacation cancan dress',179100,'dress','6c9ee09410562dd8d44d79df02d6fe6d.jpg,108b5479c718fc1827c90952bf157917.jpg,c1d9a205c88682c0598b6682022706a5.jpg,39f860e7add6627a373c06d8ef39e42c.jpg,f09a4c92171823cf468a357f07aa0eb9.jpg,89c9587fe3c153db36eb7fe5e5259fe2.jpg','6c9ee09410562dd8d44d79df02d6fe6d.jpg,108b5479c718fc1827c90952bf157917.jpg,c1d9a205c88682c0598b6682022706a5.jpg,39f860e7add6627a373c06d8ef39e42c.jpg,f09a4c92171823cf468a357f07aa0eb9.jpg,89c9587fe3c153db36eb7fe5e5259fe2.jpg','MELON','SMALL,MEDIUM,LARGE','러블리한 매력이 물씬 느껴지는 원피스입니다.'||CHR(10)||CHR(13)||'여유있는 핏감으로 체형커버는 물론 편안한 착용감을 자랑하며' ||CHR(10)||CHR(13)||
'배색 디테일이 사랑스러운 분위기를 더한 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[RAYON 70% LINEN 16% COTTON 14%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH'
);

INSERT INTO PRODUCT VALUES(30,'Blooming mini ops',148500,'dress','cb653fd47d32f22b8f2054051fe1a244.jpg,f4744129487ed449c2b9a308b0d0932e.jpg,a62cda121092788a367ccf1c11069912.jpg,90716b122651b756ede822756df867f2.jpg,b8e07829fdaa6c2d4ca9225d896dfa54.jpg,cedd6b636cc61644a395cf0ad6a72081.jpg','cb653fd47d32f22b8f2054051fe1a244.jpg,f4744129487ed449c2b9a308b0d0932e.jpg,a62cda121092788a367ccf1c11069912.jpg,90716b122651b756ede822756df867f2.jpg,b8e07829fdaa6c2d4ca9225d896dfa54.jpg,cedd6b636cc61644a395cf0ad6a72081.jpg','BEIGE','MEDIUM,LARGE',
'러블리한 매력의 원피스입니다.'||CHR(10)||CHR(13)||'스퀘어 네크라인으로 여리여리해 보이는 핏감을 자랑하며,'||CHR(10)||CHR(13)||
'캉캉 디테일로 사랑스러운 매력을 더했습니다.'||CHR(10)||CHR(13)||'부담스럽지 않은 기장감이라 데일리하게 즐길 수 있는 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[RAYON 66% NYLON 34%]' ||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(31,'Daisy puff lace dress',184500,'dress','1f0983f0bfed4db8560bc2ba164aa1a7.jpg,16b49681584f0fda76ecfd7459affcdc.jpg,1740afff0d44649eddae144d60ae505f.jpg,0516d122ae045ed5c0aa5669f5912473.jpg,5ed5ef9e7fde75d87bf4ccd7c4e3b821.jpg,a15d982df8ba7f26d290162f11f3d4a1.jpg','1f0983f0bfed4db8560bc2ba164aa1a7.jpg,16b49681584f0fda76ecfd7459affcdc.jpg,1740afff0d44649eddae144d60ae505f.jpg,0516d122ae045ed5c0aa5669f5912473.jpg,5ed5ef9e7fde75d87bf4ccd7c4e3b821.jpg,a15d982df8ba7f26d290162f11f3d4a1.jpg','BLACK','MEDIUM,LARGE',
'여성스러운 무드가 물씬 느껴지는 원피스입니다.'||CHR(10)||CHR(13)||'러블리한 퍼프소매 디테일에'||CHR(10)||CHR(13)||
'고급스러운 소재가 포인트가 되었으며' ||CHR(10)||CHR(13)||'바디라인을 예쁘게 잡아주는 핏감을 자랑하는 제품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[POLYESTER 100%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(32,'Daisy puff lace dress',184500,'dress','ebdc1822463b1c0d7bdcfd13b69f4d4b.jpg,b2467f510007440457710fdc6eced409.jpg,fe7c51cd4710089412ba6639b2348561.jpg,e6df5b9dd149ec908aa228b7c931a5cd.jpg,c1d87ea7c6c1128c5545950aa440d9b4.jpg,93b480c59017078e652440ad77e3efc4.jpg','ebdc1822463b1c0d7bdcfd13b69f4d4b.jpg,b2467f510007440457710fdc6eced409.jpg,fe7c51cd4710089412ba6639b2348561.jpg,e6df5b9dd149ec908aa228b7c931a5cd.jpg,c1d87ea7c6c1128c5545950aa440d9b4.jpg,93b480c59017078e652440ad77e3efc4.jpg','WHITE','MEDIUM,LARGE',
'여성스러운 무드가 물씬 느껴지는 원피스입니다.'||CHR(10)||CHR(13)||'러블리한 퍼프소매 디테일에'  ||CHR(10)||CHR(13)||
'고급스러운 소재가 포인트가 되었으며' ||CHR(10)||CHR(13)||'바디라인을 예쁘게 잡아주는 핏감을 자랑하는 제품입니다.'
 ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[POLYESTER 100%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY' ||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(33,'Babydoll long dress',175500,'dress','f7cbe6be6b7802a944732c6ac7930e74.jpg,e0e22002eef92fc848f2f485daa2463e.jpg,ffe126996f6b8bcd28d5d18abf94d990.jpg,ea4170bd6192e7fdbcbf5134bee6a8e4.jpg,c5073450f44e3bbfca7330dcefcb7449.jpg,181bc1a3dfef8c4bca720a1d921dfb72.jpg','f7cbe6be6b7802a944732c6ac7930e74.jpg,e0e22002eef92fc848f2f485daa2463e.jpg,ffe126996f6b8bcd28d5d18abf94d990.jpg,ea4170bd6192e7fdbcbf5134bee6a8e4.jpg,c5073450f44e3bbfca7330dcefcb7449.jpg,181bc1a3dfef8c4bca720a1d921dfb72.jpg','CREAM','MEDIUM,LARGE',
'여성스러운 분위기가 물씬 느껴지는 원피스입니다.' ||CHR(10)||CHR(13)||'어깨라인 셔링 디테일이 사랑스러운 포인트가 되었으며'
||CHR(10)||CHR(13)||'바디라인을 예쁘게 잡아주는 핏감으로 한층 더 슬림해 보이는 효과를 주는 제품입니다. ' ||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||
'[RAYON 65% COTTON 35%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY' ||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY'
 ||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(34,'Jasmine strap dress',170100,'dress','ee6412fecf689cb55815e7107e24c554.jpg,500ec0da1d1dfc3f003b6c42b88251a4.jpg,4293c6a05277ed682a4f21fe387aa5b3.jpg,2853853eb1f50f95d55d4c6b5b229833.jpg,e73125bdd261e8bce897a5982496c3cf.jpg,a93a4e7892114b98a929727c3382ce8a.jpg','ee6412fecf689cb55815e7107e24c554.jpg,500ec0da1d1dfc3f003b6c42b88251a4.jpg,4293c6a05277ed682a4f21fe387aa5b3.jpg,2853853eb1f50f95d55d4c6b5b229833.jpg,e73125bdd261e8bce897a5982496c3cf.jpg,a93a4e7892114b98a929727c3382ce8a.jpg','MELON','SMALL,MEDIUM,LARGE','사랑스러운 분위기를 더해줄 원피스입니다.' ||CHR(10)||CHR(13)||'허리라인을 잡아 한층 더 슬림해 보이는 효과를 주며'||CHR(10)||CHR(13)||
'풍성한 원단감으로 고급스러운 매력을 더했습니다.'||CHR(10)||CHR(13)||'여름시즌 데일리하게는 물론 바캉스룩으로도 제격인 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[RAYON 82% NYLON 18%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(35,'Jasmine strap dress',170100,'dress','c83e7762e0962cfd7ae33bb5ab8dcd1f.jpg,a3bc455d9c775a616b9ebf06a8e3bc46.jpg,6f6f6a1ef30a96824f4847014b8f417a.jpg,8120ccc6cd6e901e2de6a8903b5928e3.jpg,1347c02924290c604be73f9eb40997f0.jpg,34a48b2eacd9be8cee46c52da5a86294.jpg','c83e7762e0962cfd7ae33bb5ab8dcd1f.jpg,a3bc455d9c775a616b9ebf06a8e3bc46.jpg,6f6f6a1ef30a96824f4847014b8f417a.jpg,8120ccc6cd6e901e2de6a8903b5928e3.jpg,1347c02924290c604be73f9eb40997f0.jpg,34a48b2eacd9be8cee46c52da5a86294.jpg','BLACK','SMALL,MEDIUM,LARGE','사랑스러운 분위기를 더해줄 원피스입니다.' ||CHR(10)||CHR(13)||'허리라인을 잡아 한층 더 슬림해 보이는 효과를 주며'||CHR(10)||CHR(13)||
'풍성한 원단감으로 고급스러운 매력을 더했습니다.'||CHR(10)||CHR(13)||'여름시즌 데일리하게는 물론 바캉스룩으로도 제격인 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[RAYON 82% NYLON 18%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');

INSERT INTO PRODUCT VALUES(36,'Jasmine strap dress',170100,'dress','cb0a0ecdb0000a06513af8954e284535.jpg,a64b158b91cab44a922efef8b1df91dc.jpg,ab98d7052480cfcc4d9bf01b7180c178.jpg,1f46c3ac80c45e9ea91e82328adc68c2.jpg,77ed0c7df929c17b0d96a167e64fbad3.jpg,07bfa3ccc93f5460b00f665732bee3ef.jpg','cb0a0ecdb0000a06513af8954e284535.jpg,a64b158b91cab44a922efef8b1df91dc.jpg,ab98d7052480cfcc4d9bf01b7180c178.jpg,1f46c3ac80c45e9ea91e82328adc68c2.jpg,77ed0c7df929c17b0d96a167e64fbad3.jpg,07bfa3ccc93f5460b00f665732bee3ef.jpg
','CREAM','SMALL,EDIUM,LARGE',
'사랑스러운 분위기를 더해줄 원피스입니다.' ||CHR(10)||CHR(13)||'허리라인을 잡아 한층 더 슬림해 보이는 효과를 주며'||CHR(10)||CHR(13)||
'풍성한 원단감으로 고급스러운 매력을 더했습니다.'||CHR(10)||CHR(13)||'여름시즌 데일리하게는 물론 바캉스룩으로도 제격인 상품입니다.'
||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[RAYON 82% NYLON 18%]'||CHR(10)||CHR(13)||'·  DRY CLEAN ONLY'||CHR(10)||CHR(13)||
'·  DO NOT TUMBLE DRY'||CHR(10)||CHR(13)||'·  DO NOT BLEACH');




INSERT INTO PRODUCT VALUES(37,'Simple Fox Short Muffler',52000,'acc','6f915f607a17a4b32ab031c5ca2582e9.jpg,8f84ed90a14810478f97c06194e4ed52.jpg,09b75f83180cadac507a320c5b248244.jpg,c321e69af4999b998ce82e4d960e30f2.jpg,d7deed19215f21395769116d1129341f.jpg','6f915f607a17a4b32ab031c5ca2582e9.jpg,8f84ed90a14810478f97c06194e4ed52.jpg,09b75f83180cadac507a320c5b248244.jpg,c321e69af4999b998ce82e4d960e30f2.jpg,d7deed19215f21395769116d1129341f.jpg','BROWN','FREE','');

INSERT INTO PRODUCT VALUES(38,'Simple Fox Short Muffler',52000,'acc','30891f794f281b8b120a356e7c6b902a.jpg,586c1450ddf3a5a8db870c705e5d75c1.jpg,4bafc1fcf20af0838e4fcb36ddfe3921.jpg,8bb6750a26464b5e0bb89ea3d1ec6db6.jpg','30891f794f281b8b120a356e7c6b902a.jpg,586c1450ddf3a5a8db870c705e5d75c1.jpg,4bafc1fcf20af0838e4fcb36ddfe3921.jpg,8bb6750a26464b5e0bb89ea3d1ec6db6.jpg','GREY','FREE','');

INSERT INTO PRODUCT VALUES(39,'modern two-strap bag',178500,'acc','a3aba87bf2570f884baff41dc0b9cb80.jpg,11b59bdcdab5948063a953a47b6459d4.jpg,be30996617fe75a806547beb09cd607c.jpg,5fcb6c02b52da4dbc9a6063d9c80339b.jpg,90ecfb0caaebabcb9013daf65f40ed09.jpg,6fac43c905dde685c0ea812cec865eb8.jpg','a3aba87bf2570f884baff41dc0b9cb80.jpg,11b59bdcdab5948063a953a47b6459d4.jpg,be30996617fe75a806547beb09cd607c.jpg,5fcb6c02b52da4dbc9a6063d9c80339b.jpg,90ecfb0caaebabcb9013daf65f40ed09.jpg,6fac43c905dde685c0ea812cec865eb8.jpg','IVORY','FREE','');

INSERT INTO PRODUCT VALUES(40,'Reversible Wool Hood Muffle',75000,'acc','9dabf6d2db210201d6945ee837522cc6.jpg,a9a82c5c35d8ca75f54f7e066bf30611.jpg,6ddb80b6000e8a716c621233505f32c2.jpg,b3f32b83cba1448cfcb845015e7f5e43.jpg,f353967c95590ff80f110d2d6742f1e0.jpg','9dabf6d2db210201d6945ee837522cc6.jpg,a9a82c5c35d8ca75f54f7e066bf30611.jpg,6ddb80b6000e8a716c621233505f32c2.jpg,b3f32b83cba1448cfcb845015e7f5e43.jpg,f353967c95590ff80f110d2d6742f1e0.jpg','GRAY','FREE','');

INSERT INTO PRODUCT VALUES(41,'Reversible Wool Hood Muffle',75000,'acc','226b3e858575517f6808ef1af0e0da98.jpg,5c35f3ad3d19c89489a6ba0bbc9074f6.jpg,aba2ee9232a9cd9964d3b66b8ed6ad87.jpg,e5a55c625a694f3de9468a75d85b9f3f.jpg,9ed1760f28081c8c2effe51eed6243e1.jpg,3f62fe1ac9884eb259ea0a8f9a75faf5.jpg','226b3e858575517f6808ef1af0e0da98.jpg,5c35f3ad3d19c89489a6ba0bbc9074f6.jpg,aba2ee9232a9cd9964d3b66b8ed6ad87.jpg,e5a55c625a694f3de9468a75d85b9f3f.jpg,9ed1760f28081c8c2effe51eed6243e1.jpg,3f62fe1ac9884eb259ea0a8f9a75faf5.jpg','BEIGE','FREE','');

INSERT INTO PRODUCT VALUES(42,'Whole garment layered knit shawl',88200,'acc','e926dfae8dc4b2e707204bd4c2298ea4.jpg,c81574dc7fb78153af14e5769201c5ad.jpg,7e4ef91d8373e2fa990dc027a9a4406e.jpg,c96e8eccafe0d01b8445be2f58047195.jpg,1fe12944143f751e3f9b29b27bbb9161.jpg,03e1573afd668a06811338a9aa4e66ee.jpg','e926dfae8dc4b2e707204bd4c2298ea4.jpg,c81574dc7fb78153af14e5769201c5ad.jpg,7e4ef91d8373e2fa990dc027a9a4406e.jpg,c96e8eccafe0d01b8445be2f58047195.jpg,1fe12944143f751e3f9b29b27bbb9161.jpg,03e1573afd668a06811338a9aa4e66ee.jpg','PINK','FREE',
'사랑스러운 포인트가 되어줄 니트 숄입니다.' ||CHR(10)||CHR(13)||'어떤룩에나 자연스럽게 매치하기 좋으며,'||CHR(10)||CHR(13)||
'보온성도 높아 간절기에 하나쯤 소장하기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[ACRYLIC 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY' ||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH'
);

INSERT INTO PRODUCT VALUES(43,'Whole garment layered knit shawl',88200,'acc','1f693e8ffd9ff05b431002b72ab60151.jpg,4ad6b891ed69f8affa18dde5420d676d.jpg,e3733f8630d49427bc53b6b7721d9d39.jpg,38fe4bf8c7c9f87dc8e91d8449fdeec4.jpg,a73876b896a31c99ab2f32d23d6d5f36.jpg,9252bc2af87eb5158939b70c893f82bf.jpg','1f693e8ffd9ff05b431002b72ab60151.jpg,4ad6b891ed69f8affa18dde5420d676d.jpg,e3733f8630d49427bc53b6b7721d9d39.jpg,38fe4bf8c7c9f87dc8e91d8449fdeec4.jpg,a73876b896a31c99ab2f32d23d6d5f36.jpg,9252bc2af87eb5158939b70c893f82bf.jpg','SKYBLUE','FREE',
'사랑스러운 포인트가 되어줄 니트 숄입니다.' ||CHR(10)||CHR(13)||'어떤룩에나 자연스럽게 매치하기 좋으며,'||CHR(10)||CHR(13)||
'보온성도 높아 간절기에 하나쯤 소장하기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[ACRYLIC 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY' ||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH'
);

INSERT INTO PRODUCT VALUES(44,'Whole garment layered knit shawl',88200,'acc','505dd9f40436fab1a380140c24e627a4.jpg,e82085b944ad3bba24b742c6c10e11bb.jpg,10b09c045e07e55f83df0185fbd7151b.jpg,0a5b9a30e2e9df3bfe6436079fc1ab23.jpg,8f414b83c5bc4080968aca00c6ac999a.jpg,847258a35d3da5fd61c36294c4a11d8d.jpg','505dd9f40436fab1a380140c24e627a4.jpg,e82085b944ad3bba24b742c6c10e11bb.jpg,10b09c045e07e55f83df0185fbd7151b.jpg,0a5b9a30e2e9df3bfe6436079fc1ab23.jpg,8f414b83c5bc4080968aca00c6ac999a.jpg,847258a35d3da5fd61c36294c4a11d8d.jpg','BLACK','FREE',
'사랑스러운 포인트가 되어줄 니트 숄입니다.' ||CHR(10)||CHR(13)||'어떤룩에나 자연스럽게 매치하기 좋으며,'||CHR(10)||CHR(13)||
'보온성도 높아 간절기에 하나쯤 소장하기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[ACRYLIC 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY' ||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH'
);

INSERT INTO PRODUCT VALUES(45,'Whole garment layered knit shawl',88200,'acc','d00182135028109f8ff40f9141223197.jpg,1e3b0f33841d3ffe17e9ae7a0cce95e2.jpg,1d04039e337fa0dda44f4e51552901b7.jpg,9538a37c7d8cadfc7c1ee14441545674.jpg,b88c4f0f20a88e897ad5050caca3fa85.jpg,32598147fcc645fffdd5ac683a762774.jpg','d00182135028109f8ff40f9141223197.jpg,1e3b0f33841d3ffe17e9ae7a0cce95e2.jpg,1d04039e337fa0dda44f4e51552901b7.jpg,9538a37c7d8cadfc7c1ee14441545674.jpg,b88c4f0f20a88e897ad5050caca3fa85.jpg,32598147fcc645fffdd5ac683a762774.jpg','IVORY','FREE',
'사랑스러운 포인트가 되어줄 니트 숄입니다.' ||CHR(10)||CHR(13)||'어떤룩에나 자연스럽게 매치하기 좋으며,'||CHR(10)||CHR(13)||
'보온성도 높아 간절기에 하나쯤 소장하기 좋은 상품입니다.'||CHR(10)||CHR(13)||' '||CHR(10)||CHR(13)||'[ACRYLIC 100%]'||CHR(10)||CHR(13)||
'·  DRY CLEAN ONLY' ||CHR(10)||CHR(13)||'·  DO NOT TUMBLE DRY' ||CHR(10)||CHR(13)||'·  DO NOT BLEACH'
);
INSERT INTO ORDERS VALUES(1,'yun',1,2,'red','L','2022/08/01','cartList',0);
INSERT INTO ORDERS VALUES(2,'yun',2,3,'red','L','2022/08/02','wishList',0);
INSERT INTO ORDERS VALUES(3,'hong',1,1,'red','L','2022/08/03','cartList',0);
INSERT INTO ORDERS VALUES(4,'hong',2,2,'red','L','2022/08/04','wishList',0);
INSERT INTO ORDERS VALUES(5,'chang',1,3,'red','L','2022/08/05','cartList',0);
INSERT INTO ORDERS VALUES(6,'chang',2,4,'red','L','2022/08/06','wishList',0);


INSERT INTO NOTICE VALUES(1,'KRISTAL','고객 보상 지원 제도 시행 안내','고객 보상 지원 제도 시행 안내','2022/08/01',0);
INSERT INTO NOTICE VALUES(2,'KRISTAL','상의 일부 상품의 권장 소비자 가격이 변경됨을 안내드립니다.','상의 일부 상품의 권장 소비자 가격이 변경됨을 안내드립니다.','2022/08/03',0);
INSERT INTO NOTICE VALUES(3,'KRISTAL','인터넷 익스플로러(IE) 지원 종료 안내','친구 및 쪽지 서비스 종료 안내','2022/09/01',0);
INSERT INTO NOTICE VALUES(4,'KRISTAL','친구 및 쪽지 서비스 종료 안내','친구 및 쪽지 서비스 종료 안내','2022/09/20',0);
INSERT INTO NOTICE VALUES(5,'KRISTAL','대리구매 이용 자제를 당부드립니다.','대리구매 이용 자제를 당부드립니다.','2022/10/11',0);
INSERT INTO NOTICE VALUES(6,'KRISTAL','5년이상 미 사용 적립금 소멸 관련 공지사항입니다.','5년이상 미 사용 적립금 소멸 관련 공지사항입니다.','2022/11/27',0);
INSERT INTO NOTICE VALUES(7,'KRISTAL','[사과문] 후속 조치에 대해 말씀드립니다.','[사과문] 후속 조치에 대해 말씀드립니다.','2022/08/01',0);
INSERT INTO NOTICE VALUES(8,'KRISTAL','장바구니 상품 보관 정책 변경 안내','장바구니 상품 보관 정책 변경 안내','2022/12/25',0);


INSERT INTO QNA VALUES(1,'yun',1,'상품문의','상품문의','2022/08/01',0);
INSERT INTO QNA VALUES(2,'yun',2,'환불문의','환불문의','2022/08/02',0);
INSERT INTO QNA VALUES(3,'yun',3,'결제문의','결제문의','2022/08/03',0);
INSERT INTO QNA VALUES(4,'hong',1,'상품문의','상품문의','2022/08/04',0);
INSERT INTO QNA VALUES(5,'hong',2,'환불문의','환불문의','2022/08/05',0);
INSERT INTO QNA VALUES(6,'hong',3,'결제문의','결제문의','2022/08/06',0);
INSERT INTO QNA VALUES(7,'chang',1,'상품문의','상품문의','2022/08/07',0);
INSERT INTO QNA VALUES(8,'chang',2,'결제문의','결제문의','2022/08/08',0);


INSERT INTO REVIEW VALUES(1,'yun',1,'정말 이뻐요','정말 이뻐요','2022/08/01',0);
INSERT INTO REVIEW VALUES(2,'yun',2,'대박','대박','2022/08/02',0);
INSERT INTO REVIEW VALUES(3,'yun',3,'의상 인증','인증합니다','2022/08/03',0);
INSERT INTO REVIEW VALUES(4,'hong',1,'또 사고싶어요','사이즈 적당히 잘 맞는거 같아요','2022/08/04',0);
INSERT INTO REVIEW VALUES(5,'hong',2,'또 이용할게요','감사합니다','2022/08/05',0);
INSERT INTO REVIEW VALUES(6,'hong',3,'인증샷','정말 이뻐요','2022/08/06',0);
INSERT INTO REVIEW VALUES(7,'chang',1,'정말 멋져요','또사고싶어요','2022/08/07',0);
INSERT INTO REVIEW VALUES(8,'chang',2,'착샷','또살게요','2022/08/08',0);                   

commit;