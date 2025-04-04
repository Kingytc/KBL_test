Password Reset Query:
--------------------
LAPS UAT Pwd Query:
		update users set usr_password='xdZxme+WO85BruegcpsMgJYU4r0=',user_first_flag='N',usr_pwdreset_date=sysdate where usr_id=''
--Laps@0987


If Basic Info API error found in UAT for particular Customer ID:
-----------------------------------------------------------------
update perapplicant set perapp_renew='y' 
where perapp_cbsid='209117187'  and perapp_id not in (select max(perapp_id) from
perapplicant a where a.perapp_cbsid='209117187')

(Repalce Cust ID two times)


If JSP error on login issue UAT SAC
-----------------------------------

select * from available_users where au_usr_id='K9102';

delete from available_users where au_usr_id='K9102';




Search for particualar API in log:
-------------------------------------
################@@@@@@@@@@@@@ CBS ID UCIC Request @@@@@@@@@@@@@################
################@@@@@@@@@@@@@ CBS Customer Creation request @@@@@@@@@@@@@################
######### MSMECustomerCreation SERVICE........
######### MSME FACILITYPROPOSAL SERVICE........
######### Customer Creation SERVICE........
######### MSME FINANCIALCMA SERVICE........
######### CustLarPro Details Check.........
################@@@@@@@@@@@@@ ROI MSME UPDATE REQUEST @@@@@@@@@@@@@################
################@@@@@@@@@@@@@ BRE call Request @@@@@@@@@@@@@################ 


Gateway Service los_api_logger table 
-------------------------------------
172.20.115.75:9448/laps/rest/LosServicesODAD/ODADProposalCreation
172.20.115.75:9448/laps/rest/LosServicesODAD/OdadCustomerCreation
172.20.115.75:9448/laps/rest/LosServicesODAD/odadaccOpeningTriggerService
172.20.115.75:9448/laps/rest/LosServicesODAD/goldreappraiserdet
172.20.115.75:9448/laps/rest/LosServicesODAD/getgoldratedet
172.20.115.75:9448/laps/rest/LosServicesODAD/ODADLarNoGeneration/
172.20.115.75:9448/laps/rest/LosServicesODAD/getjewelappraiserlistdet


Co-lending Queries to fetch Product:
-------------------------------------

 [Query Code : getproductcode_general_scheme^pJ^20000.0^1^080]

		select PRD_CODE from PRODUCTS where PRD_WHTDIGIPRD='Y' and PRD_TYPE='pJ' and
		20000.0 between prd_rng_from and prd_rng_to and PRD_REPAYTYPE like '%1%' and PRD_STOP='n' and prd_renew='n' and PRD_BANKSCHEME='080' 
		order by PRD_INTRO_DATE desc



If CAT id is sent
[Query Code : getproductcode_general_scheme_catid^pJ^10000^1^064^78]

		select PRD_CODE from PRODUCTS where PRD_WHTDIGIPRD='Y' and PRD_TYPE='pJ' and
		10000 between prd_rng_from and prd_rng_to and PRD_REPAYTYPE like '%1%' and PRD_STOP='n' and prd_renew='n' and PRD_BANKSCHEME='064' and PRD_CATID='78'
		order by PRD_INTRO_DATE desc
	
MSME :

[Query Code : sel_corpdigiprd_tenor^71^60^NEW TRANSPORT VEHICLES^E@^063]

		select  COM_FACID from FACILITY_CORP  where  COM_WHTDIGIPRD='Y' and COM_SUBFAC='71' 
		and (60 between COM_MINREPAYPERIOD and COM_MAXREPAYPERIOD) and COM_FACDESC like '%NEW TRANSPORT VEHICLES%' and FAC_REPAYTYPE='E@' and com_bankscheme='063'

XPress Home Loan:

		[Query Code : sel_digiproduct_code_HL^pH^C^3500000^2^57]

		select PRD_CODE from PRODUCTS
		where PRD_WHTDIGIPRD='Y' and PRD_TYPE='pH' and PRD_PURPOSE='C' and 3500000
		between prd_rng_from and prd_rng_to and PRD_REPAYTYPE like '%2@%' and PRD_CATID='57' and 
		prd_stop='n' and prd_renew='n' order by PRD_INTRO_DATE desc
	


XPress Car Loan:
[Query Code : sel_digiproduct_code_pa^pA^N^1287864^2]

                select  PRD_CODE from PRODUCTS where PRD_WHTDIGIPRD='Y' and PRD_TYPE='pA' and PRD_PURPOSE='N'  and 1287864 between prd_rng_from and prd_rng_to and PRD_REPAYTYPE like '%2@%' and prd_stop='n' and prd_renew='n' and NOT regexp_like(prd_desc,'NON INDIVIDUAL')
                order by  PRD_INTRO_DATE desc
      



Financials Fetch Query:
 [Query Code : sel_financial_finid^550110004]
		select FIN_COMAPPID,FIN_CMANO,FIN_FINANCEID,f.FIN_VALUESAREIN from PERAPPLICANT p,COM_FINANCE f      
		where  perapp_cbsid='550110004' and PERAPP_ID=FIN_COMAPPID AND FIN_FINANCEID IN
		(select DEMO_FINSTANDARD from com_demographics a, applications b where a.Demo_Appno=b.app_no and app_status='pa' and app_renew_flag!='P')
		UNION 
		select FIN_COMAPPID,FIN_CMANO,FIN_FINANCEID,f.FIN_VALUESAREIN from PERAPPLICANT p,COM_FINANCE f      
		where perapp_cbsid='185105108' and PERAPP_ID=FIN_COMAPPID AND FIN_FINANCEID IN
		(select FIN_FINID  from fin_rating WHERE fin_status='PA')
		ORDER BY FIN_FINANCEID DESC


Visiting LAPS customer profile to allow modify below query is checking where del flag is not added:
LParser  - QUERY IN SQL PARSER... [Query Code : sel_retail_op^4309925]

			select APP_STATUS from per_demographics,APPLICATIONS where DEMO_APPID = '4309925' and DEMO_APPNO=APP_NO 
        

2024-03-26 16:21:11,248 [172.21.52.19 - 5 [WebContainer : 10]] INFO  com.sai.laps.helper.SQLParser  - QUERY IN SQL PARSER... [Query Code : sel_msme_op^4309925]

			select APP_STATUS from com_demographics,APPLICATIONS where DEMO_COMAPPNEWID = '4309925' and DEMO_APPNO=APP_NO 


select APP_NO, to_char(APP_CREATEDATE, 'DD-MON-YYYY HH24:MI:ss'), to_char(APP_processdate, 'DD-MON-YYYY HH24:MI:ss')  from applications where app_no='09280006608';

Latest financials check query:
------------------------------
		select perapp_id,perapp_cbsid  from perapplicant where perapp_oldid='402122'
        and (perapp_renew='n' or	perapp_renew is null)


	select  * from
		com_finance where fin_comappid ='4536937' and fin_renew!='Y';
        

Svanidhi proposals where key fact statement data not available:
-------------------------------------------------------------
select count(*) from applications where app_prdcode in ('1294','1295','1296');

select count(*) from applications a where not exists (select * from KEYFACT_FEES_DETAILS b where a.app_no=b.kf_appno)
and   app_prdcode in ('1294','1295','1296');

select count(*) from applications a where  exists (select * from KEYFACT_FEES_DETAILS b where a.app_no=b.kf_appno)
and   app_prdcode in ('1294','1295','1296');

Svanidhi Proposal Apprisal - sanction details not avaialable:
----------------------------------------


select * from applications a where not exists (select * from appraisalsanction b where a.app_no=b.APPSANC_APPNO)
and a.app_prdcode in ('1294','1295','1296') and app_status='pa' and app_renew_flag='F' order by app_processdate desc;

select app_no from applications a where not exists (select * from appraisalsanction b where a.app_no=b.APPSANC_APPNO)
and a.app_prdcode in ('1294','1295','1296') and app_status='pa' and app_renew_flag='F' order by app_processdate desc

  
Appriser List:
--------------
[Query Code : getjewelappraiserslist^547]

	select valuer_cbsid, valuers_name,to_char(VALUER_EXPIRYDATE,'dd/mm/yyyy') as VALUER_EXPIRYDATE,O.ORG_SCODE as ORG_SCODE from valuer_orgdetails v,VALUERSMASTER R,ORGANISATIONS O 
where valuer_seqno=VALUERS_SEQNO and valappflag='J'  and valuer_cbsid is not null and O.ORG_CODE=v.VALUER_ORGCODE and O.ORG_SCODE ='547' and VALUER_MAKERFLAG is null


Jewel reappraisal query:
------------------------
  ######### GOLD REAPPRAISER.........


     Select APP_LOANSUBTYPE_DIGI from APPLICATIONS where APP_NO='08430000471'
    
 [Query Code : chkproposalisgoldloan_new^08430000471]

	Select APP_ORGCODE from PRODUCTS p,APPLICATIONS a where a.APP_PRDCODE=p.PRD_CODE and  p.PRD_TYPE='pG' and a.APP_STATUS='pa' and  a.APP_DELFLAG='N' 
     and a.APP_NO='08430000471'
	
. [Query Code : sel_appraiserdet^08430000471]

	select ja_name, to_char(ja_appraiseon,'dd/mm/yyyy') as ja_appraiseon,ja_comments,ja_appraisercbsid from jewel_appraiserdetails where ja_appno='08430000471'
	
 [Query Code : chkcbsidforreappraiser^R03055219^001007001148000]

select VALUERS_NAME from  valuer_orgdetails v,VALUERSMASTER R where v.VALUER_SEQNO=R.VALUERS_SEQNO and R.valappflag='J' and v.VALUER_EXPIRYDATE>=sysdate
and R.valuer_cbsid ='R03055219' and v.VALUER_ORGCODE='001007001148000'  and VALUER_MAKERFLAG is null

        