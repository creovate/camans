DROP DATABASE IF EXISTS TWC2DB;
CREATE DATABASE TWC2DB;
USE TWC2DB;

/*
**==================================
** User Table 1
**==================================
*/

DROP TABLE IF EXISTS tbl_user;
CREATE TABLE tbl_user (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	NRIC_number varchar(10) not null,
	Full_name varchar(50) not null,
	Alias varchar(50) not null,
	Username varchar(20) unique not null,
	Password varchar(500) not null,
	Email_address varchar(50) not null,
	Phone_number varchar(15) not null,
	Gender varchar(10) not null,
	Role varchar(25) not null,
	Photo varchar(255) null,
	Status varchar(50) not null,
	index(Username),
	PRIMARY KEY (NRIC_number)
);

/*
**====================================
**Worker & its complements  Table [14]
**====================================
*/

Drop table if exists tbl_worker;

CREATE TABLE tbl_worker (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	FIN_number VARCHAR(12)  NOT NULL, 
	Name_of_worker VARCHAR(50) NOT NULL, 
	Worker_registration_date Date NOT NULL, 
	Created_by varchar(20) null, 
	Create_for varchar(20) null, 
	Gender VARCHAR(10)   NULL, 
	Nationality varchar(50)  NULL, 
	Nationality_more varchar(50) null, 
	Date_of_birth Date  NULL , 
	Photo varchar(255) null,
	index(FIN_number),
	Primary Key(FIN_number)
)ENGINE=INNODB;

/*
*====================
** Table Nickname
**=====================
**/

Drop table if exists tbl_worker_nickname;
Create table tbl_worker_nickname (
	
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Nickname varchar(50) NOT null,
	index(Worker_FIN_Number),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

/*
**============================
**Table Passport
**============================
*/

Drop table if exists tbl_worker_passport_details;
CREATE table tbl_worker_passport_details(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Passport_number Varchar(20)  Not NULL,
	Passport_country varchar(30) NOT null,
	Passport_issue_date Date  NULL,
	Passport_expiry_date Date  NULL,
	Worker_FIN_number varchar(12) not null,
	index(Worker_FIN_Number),

	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
		 ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB;

/*
**=====================================
** Home Country Table
**=====================================
*/
Drop table if exists tbl_home_country_phone_number;
Create table tbl_home_country_phone_number(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Home_country_telephone_number varchar (50) NOT null,
	Owner_of_number varchar(20) null,
	Home_phone_obsolete date null,
	Worker_FIN_number varchar(12) not null,
	index(Worker_FIN_Number),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

/*
**==============================
** Table Sg Phone Number
**==============================
*/

Drop table if exists tbl_sg_phone_number;
Create table tbl_sg_phone_number(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Sg_phone_num varchar (15) NOT null,
	Sg_phone_obsolete Date null,
	Worker_FIN_number varchar(12)not null,
	index(Worker_FIN_Number),

	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

/*
*=========================
* Table Sg Address
*=========================
*/
Drop table if exists tbl_sg_address;
create table tbl_sg_address(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment null,
	Singapore_address Varchar(200)  NOT NULL,
	Addr_singapore_obsolete DATE NULL,
	Worker_FIN_number varchar(12) not null,
	index(Worker_FIN_Number),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

/*
**===============================
* Table Home Country Address
**================================
*/
Drop table if exists tbl_home_country_address;
Create table tbl_home_country_address(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Home_country_address Varchar(300)  NOT NULL, 
	Home_country_obsolete_address DATE  NULL,
	Worker_FIN_number varchar(12) not null,
	index(Worker_FIN_Number),
	
	PRIMARY KEY(ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
**==========================
**Table Digital Contact
**==========================
*/

Drop Table If Exists tbl_digital_contact;
CREATE TABLE tbl_digital_contact(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment  NOT NULL,
	Digital_contact_type varchar(20)  NOT NULL,
	Digital_more varchar (50) null,
	Email_or_QQ_address varchar(50)  NOT NULL, 
	Owner_of_electronic_contact varchar(50)  NULL, 
	Digital_remarks varchar(200)  NULL, 
	Obsolete_date DATE  NULL, 
	Worker_FIN_number VARCHAR(12)  Not NULL,   
	index(Worker_FIN_Number),
	
	Primary Key (ID),
		FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
**============
**Table Kin
**============
*/
Drop table if exists tbl_kin;
CREATE TABLE tbl_kin (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment  NOT NULL, 
	Worker_FIN_number VARCHAR(12)  not NULL, 
	Kin_name Varchar(50)  NOT NULL, 
	Kin_relationship Varchar(50)  NULL, 
	Kin_Id_doc varchar(200)  NULL, 
	Kin_phone Varchar(20)  NULL, 
	Kin_digital Varchar(200)  NULL, 
	Kin_address Varchar (200) null, 
	Kin_proof Varchar(200)  NULL, 
	Kin_remarks Varchar(200)  NULL, 
	Kin_obsolete_date Date  NULL,  
	index(Worker_FIN_Number),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
**========================
* Table Family Member
**========================
*/
Drop Table if exists tbl_family_member;
CREATE TABLE tbl_family_member (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment  NOT NULL, 
	Worker_FIN_number VARCHAR(12)  Not NULL, 
	Name_of_family_member Varchar(50) not NULL, 
	Family_member_relationship Varchar(50)  NULL, 
	Family_member_where Varchar(200)  NULL, 
	Family_member_phone_number Varchar(20)  NULL, 
	Family_member_digital Varchar(200)  NULL, 
	Family_member_remarks Varchar(200)  NULL, 
	Family_member_obsolete Date  NULL, 
	index(Worker_FIN_Number),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
** Table Sg Friend
**
*/

Drop Table if exists tbl_sg_friend;
CREATE TABLE tbl_sg_friend (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment  NOT NULL, 
	Worker_FIN_number VARCHAR(12)  Not NULL, 
	friend_sg_name Varchar(50) not NULL, 
	friend_sg_phone Varchar(20)  NULL, 
	friend_sg_rel Varchar(50)  NULL, 
	friend_sg_rem Varchar(200)  NULL, 
	friend_sg_obsolete Date  NULL, 
	index(Worker_FIN_Number),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
** Table Language
*/

Drop table if exists tbl_language;
Create table tbl_language (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_main_language varchar(50) not null,
	Worker_main_language_more varchar(50) not null,
	Spoken_english_standard varchar(50) null,
	Language_remarks varchar(200) null,
	Worker_FIN_number varchar(12) not null,
	index(Worker_FIN_Number),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
* Table Bank Account Details
*/
/* Worker's Bank Account Table **/

Drop table if exists tbl_bank_acc_details;
Create table tbl_bank_acc_details (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Bank_account_name varchar(50) not null,
	Bank_account_number varchar (50) not null,
	Bank_name varchar (50) not null,
	Bank_branch_name varchar (50) null,
	Bank_branch_address varchar (300) null,
	Bank_branch_code varchar (50) null,
	Bank_swift_code varchar(50) null,
	Bank_account_remarks varchar (200) null,
	Bank_obsolete_date date null,
	Worker_FIN_number varchar (12) not null,
	index(Worker_FIN_Number),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
*========================
* tbl_worker_attachment
*========================
*/
Drop table if exists tbl_worker_attachment;
Create table tbl_worker_attachment (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	FIN_number varchar (12) not null, /* FIN number of worker */
	Document_name varchar(255) null,
	File_path varchar(255) null,
	Submit_by varchar(20) not null, /* username of TWC2 user */
	index(FIN_number),
	Primary Key (ID),
	Foreign Key (FIN_number) References tbl_worker(FIN_number)
		ON DELETE CASCADE ON UPDATE CASCADE,
	Foreign Key (Submit_by) References tbl_user (username)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

/*
*=========================
*End of tbl_worker_attachment
*=========================
*/
/*
**==================================
** Job and its complements Table [10]
**==================================
*/

/*Select * from tbl_job;*/
Drop table if exists tbl_job;
Create table tbl_job (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	Worker_FIN_number varchar (12) not null,
	Job_key MEDIUMINT NOT NULL,
	Employer_name varchar (50) not null,
	Workpass_type varchar (50) not null,
	Workpass_more varchar (50) null,
	Job_sector varchar (50) null,
	Job_sector_more varchar (50) null,
	Occupation varchar (50) null,
	Job_start_date varchar(500) null,
	Job_end_date varchar(500) null,
	Job_whether_TJS varchar(10) null,
	Job_remarks varchar (200) null,
	index(Worker_FIN_Number),
	index(Job_Key),

	Primary Key (Job_Key),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
** Table Pass Details
*/

Drop table if exists tbl_pass_details;
Create table tbl_pass_details (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar (12) not null,
	Job_key MEDIUMINT NOT NULL,
	Pass_type varchar (255) not null,
	Pass_type_more varchar (255) null,
	Pass_number varchar (20) not null,
	Pass_application_date date null,
	Pass_issue_date date null,
	Pass_expiry_date date null,
	Pass_issuer varchar (20) null,
	Pass_remarks varchar (200) null,
	Pass_obsolete_date date null,
	index(Worker_FIN_Number),
	index(Job_Key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE

)ENGINE = INNODB;

/*
**====================
** Table IPA Details
**====================
*/
/*Select * from tbl_ipa_details;*/
Drop table if exists tbl_ipa_details;
Create table tbl_ipa_details (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT  not null,
	IPA_pass_type varchar(50) not null,
	IPA_pass_type_more varchar (50) null,
	IPA_application_date date null,
	IPA_employer_name varchar(50) null,
	IPA_agent_name varchar (50) null,
	IPA_industry varchar (50) null,
	IPA_occupation varchar (30) null,
	IPA_period_years varchar(30) null,
	IPA_basic_salary decimal(13,2) null,
	IPA_allowances decimal(13,2) null,
	IPA_allowances_details varchar (200) null,
	IPA_deduction decimal(13,2) null,
	IPA_deduction_details varchar (200) null,
	Housing_provided varchar(3) null,
	IPA_remarks varchar (200) null,
	index(Worker_FIN_Number),
	index(Job_Key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
**============================
* Table Verbal Assurance
**============================
*/

Drop table if exists tbl_verbal_assurances;
Create table tbl_verbal_assurances (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Verbal_name varchar (20) not null,
	Verbal_relationship varchar (200) null,
	Verbal_when varchar(50) null,
	Verbal_where varchar(50) null,
	Verbal_content varchar(1000) null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	index(Worker_FIN_Number),
	index(Job_Key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
**
** Table Employment Contract
*/
Drop table if exists tbl_employment_contract;
Create table tbl_employment_contract (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_Number varchar (12) not null,
	Short_name varchar(50) null,
	Job_key MEDIUMINT not null,
	Contract_date date not null,
	Contract_where varchar (50) null,
	Contract_language varchar (20) null,
	Contract_opposite_name varchar(50) not null,
	Contract_opposite_relationship varchar (200) null,
	Contract_occupation varchar (200) null,
	Contract_basic_salary varchar (50) null,
	Contract_allowances varchar(500) null,
	Contract_deduction_details varchar (500) null,
	Contract_duration varchar(20) null,
	Contract_duress varchar (500) null,
	Contract_remarks varchar (200) null,
	index(Worker_FIN_Number),
	index(Job_Key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
**===========================
** Table Intermediary Agent
**===========================
*/

Drop table if exists tbl_agent;
Create table tbl_agent (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Agent_company varchar (50) not null,
	Agent_person_name varchar (20) null,
	Agent_location varchar (200) null,
	Agent_location_more varchar (200) null,
	Agent_address varchar (300) null,
	Agent_contact varchar (200) null,
	Agent_amt_paid decimal(13,2) null,
	Agent_amt_owed decimal(13,2) null,
	Agent_fee_shared varchar(200) null,
	Agent_fee_training varchar(200) null,
	Agent_fee_airfare varchar(200) null,
	Agent_fee_where varchar(200) null,
	Agent_fee_when varchar(200) null,
	Agent_fee_repay varchar(200) null,
	Agent_employer varchar(200) null,
	Agent_remarks varchar (200) null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	index(Worker_FIN_Number),
	index(Job_Key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
** Table Employer
*/
Drop table if exists tbl_employer;
Create table tbl_employer (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Employer_official_name varchar(50) not null,
	Employer_ID varchar (50) null,
	Employer_address varchar (200) null,
	Employer_contacts varchar (200) null,
	Employer_persons varchar (200) null,
	Employer_remarks varchar (500) null,
	index(Worker_FIN_Number),
	index(Job_Key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
* Workplace Details
*/
Drop table if exists tbl_workplace;
Create table tbl_workplace (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Workplace_type varchar (200) not null,
	Workplace_type_more varchar (200) null,
	Workplace_whose varchar (50) null,
	Workplace_persons varchar (200) null,
	Workplace_employer_relationship varchar (50) null,
	Workplace_direct varchar (200) not null,
	Workplace_direct_more varchar (200) null,
	Workplace_start varchar (50) null,
	Workplace_end varchar (50) null,
	Workplace_condition varchar (500) null,
	Workplace_safety varchar (200) null,
	Workplace_remarks varchar (200) null,
	index(Worker_FIN_Number),
	index(Job_Key),

	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;



/*
** Work History
*/

Drop table if exists tbl_work_history;
Create table tbl_work_history (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar (12) not null,
	Job_key MEDIUMINT not null,
	Work_hist_how varchar (200) not null,
	Work_hist_how_more varchar(200) null,
	Work_hist_date date null,	
	Work_hist_first varchar(3) null,
	Work_hist_year_arrive varchar(50) null,
	Work_hist_previous varchar (1000) null,
	Work_hist_previous_problems varchar (1000) null,
	Work_hist_remarks varchar (200) null,
	index(Worker_FIN_Number),
	index(Job_Key),

	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
** Table Accommodation
*/

Drop table if exists tbl_accomodation;
Create table tbl_accomodation (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment null,
	Accomodation_provided varchar (200) not null,
	Accomodation_provided_more varchar (200) null,
	Accomodation_type varchar (200)  null,
	Accomodation_type_more varchar (200) null,
	Accomodation_location varchar (200) null,
	Accomodation_condition varchar (500) null,
	Accomodation_charged decimal(13,2) null,
	Accomodation_self_paid decimal(13,2) null,
	Accomodation_meals varchar (200) null,
	Accomodation_start varchar (50) null,
	Accomodation_end varchar (50) null,
	Accomodation_remarks varchar (200) null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	index(Worker_FIN_Number),
	index(Job_Key),
	Primary Key (ID),	
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
**======================================
**(End Of Iteration 2) Job & Work Tables
**======================================
*/


/*
**======================================
** Problem and its complements table [23]
**======================================
*/

/*
*===================
* Table Problem
*===================
*/
DROP TABLE IF EXISTS tbl_problem;
CREATE TABLE tbl_problem(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT auto_increment NOT NULL,
	Chief_problem_date Date  not null,
	Chief_problem varchar(50) not null,
	Chief_problem_more varchar(50)  null,
	Chief_problem_remarks varchar(200) null,
    Referred_by varchar(10) null,
    Referred_to varchar(10) null,
    Referred_date Date null,
    Description varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	
	PRIMARY KEY (Prob_key),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (Referred_by)
      REFERENCES tbl_user(Username)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (Referred_to)
      REFERENCES tbl_user(Username)
        ON DELETE CASCADE ON UPDATE CASCADE
		
)ENGINE = INNODB;


/*
* Table Aggravating Issue
*/
Drop table if exists tbl_aggravating_issue;
Create table tbl_aggravating_issue (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Aggra_issue varchar(50) not null,
	Aggra_issue_more varchar(50) null,
	Aggra_loss  varchar (255) null,
	Aggra_remarks varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key (ID),

	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job (Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
*
* Table Lead Case worker
*/
Drop table if exists tbl_lead_case_worker;
Create table tbl_lead_case_worker(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Lead_case_worker varchar(20) null,
	Lead_start date null,
	Lead_end date null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
*
* Table Auxiliary CaseWorker;
*/
Drop table if exists tbl_auxillarycaseworker;
Create table tbl_auxillarycaseworker(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Aux_name varchar(20) null,
	Aux_start date null,
	Aux_end date null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
* Salary Related History
*/
Drop table if exists tbl_salary_history;
Create table tbl_salary_history(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,	
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Sal_hist_basic varchar(500) not null,
	Sal_hist_ot varchar(500) null,
	Sal_hist_allowances varchar(500) null,
	Sal_hist_deductions varchar(500) null,
	Sal_hist_kickbacks varchar(500) null,
	Sal_hist_other varchar(500) null,
	Sal_mode varchar(20) null,
	Sal_mode_more varchar(50) null,
	Sal_loss_total decimal(13,2) null,
	Sal_loss_1_year decimal(13,2) null,
	Sal_his_remarks varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
* Table Injury
*/
Drop table if exists tbl_injury;
Create table tbl_injury (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar (12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Injury_date Date  not null,
	Injury_time varchar(200) null,
	Injury_location varchar (200) null,
	Injury_death varchar(3) null,
	Injury_body_part varchar (500) null,
	Injury_how varchar(1000) null,
	Injury_ambulance varchar (12) null,
	Injury_initial_treatment varchar (200) null, /** Hospital **/
	Injury_initial_treatment_more varchar (200) null, /** Hospital More **/
	Injury_work_related varchar(12) null,
	Injury_remarks varchar (200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;



/*
* Table Illness
*/
Drop table if exists tbl_illness;
Create table tbl_illness (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Illness_start_when varchar(50) not null,
	Illness_diag_when varchar(50) null,
	Illness_diag_who varchar(200) null,
	Illness_nature varchar(200) null,
	Illness_work_related varchar(12) null,
	Illness_why varchar(500) null,
	Illness_rem varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
	
)ENGINE = INNODB;

/*
* Table Other Problem
*/

Drop table if exists tbl_other_problems;
Create table tbl_other_problems (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Prob_key MEDIUMINT not null,
	Oth_problem_desc varchar (1000) not null,
	Oth_problem_loss decimal(13,2) null,
	Oth_problem_rem varchar (200) null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
* Table Trafficking Indicators
*/
Drop table if exists tbl_trafficking_indicators;
Create table tbl_trafficking_indicators(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Tipi_assess_date date not null, /* date of assessment */
	Tipi_assess_name varchar (20) not null, /*name of assessor */
	Tipi_21 varchar (3) null, /*Feel unable to negotiate terms of contract/employment */
	Tipi_22 varchar (3) null, /*Received little or no payment though entitled*/
	Tipi_23 varchar (3) null, /*Deductions not pre-agreed*/
	Tipi_24 varchar (3) null, /*No access to earnings*/
	Tipi_25 varchar (3) null, /*Excessively long hours over long periods*/
	Tipi_26 varchar (3) null, /*No days off*/
	Tipi_27 varchar (3) null, /*Lack protective equipment though work conditions call for them*/
	Tipi_28 varchar (3) null, /*Disciplined through fines*/
	Tipi_41 varchar (3) null, /*Movement restricted or under surveillance */
	Tipi_42 varchar (3) null, /*Communication restricted or under surveillance */
	Tipi_43 varchar (3) null, /*Threat of violence against worker or family */
	Tipi_44 varchar (3) null, /*Threat of trouble with authorities */
	Tipi_45 varchar (3) null, /*Seizure/retention of personal identity documents */
	Tipi_46 varchar (3) null, /*Poor/substandard accommodation, no option to leave */
	Tipi_47 varchar (3) null, /*No access to medical care */
	Tipi_48 varchar (3) null, /*No privacy */
	Tipi_49 varchar (3) null, /*Feel victimised by misrepresentation */
	Tipi_50 varchar (3) null, /*Feel loss of autonomy through debt or heavy sunk cost */
	Tipi_51 varchar (3) null, /*Subject to insults, abuse, violence */
	Tipi_61 varchar (3) null, /*Found in location associated with confinement/exploitation*/
	Tipi_62 varchar (3) null, /*Allow others to speak for them when addressed directly */
	Tipi_63 varchar (3) null, /*Act as if instructed by someone else */
	Tipi_64 varchar (3) null, /*Escorted wherever they go*/
	Tipi_65 varchar (3) null, /*Unable to show personal identity documents*/
	Tipi_66 varchar (3) null, /*Have association with, or clothes of a kind associated with sex work */
	Tipi_67 varchar (3) null, /*Have injuries that appear to be associated with assault or application of control measures */
	Tipi_81 varchar(500) null, /* Describe other indicators of trafficking complained of */
	Tipi_82 varchar(500) null, /* Describe other indicators of trafficking observed */
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	
	Primary Key (ID),
	
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
* Table Salary Claim Lodged
*/
Drop table if exists tbl_salary_claim_lodged;
Create table tbl_salary_claim_lodged (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Sal_claim_date date not null,
	Sal_claim_loss decimal(13,2) null,
	Sal_claim_basis varchar(1000) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
*=========================
* Wica Claim Table
*=========================
*/

Drop table if exists tbl_wica_claim;
Create table tbl_wica_claim(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Wica_claim_date date not null,
	Wica_ref_nbr varchar(30) null,
	Wica_insurer varchar(50) null,
	Wica_policy_nbr varchar(30) null,
	Wica_claim_reason varchar(200) null,
	Wica_claim_rem varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
*===========================
*Non Wica Claim
*===========================
*/
Drop table if exists tbl_non_wica_claim;
Create table tbl_non_wica_claim(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Med_claim_date Date  not null,
	Med_claim_loss decimal(13,2) null,
	Med_claim_insurer varchar(50) null,
	Med_claim_policy_nbr varchar(30) null,
	Med_claim_basis varchar(1000) null,
	Med_claim_rem varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE

)ENGINE = INNODB;

/*
**
*-=======================
* Table Police Report
*========================
*/

Drop table if exists tbl_police_report;
Create table tbl_police_report(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Police_rpt_date Date not null,
	Police_rpt_station varchar (50) null,
	Police_rpt_pers varchar (200) null,
	Police_rpt_ref_nbr varchar(100) null,
	Police_rpt_details varchar(1000) null,
	Police_rpt_rem varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
*=====================
*Other Complaint Lodged
*=====================
*/

Drop table if exists tbl_other_complaint;
Create table tbl_other_complaint(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,	
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Other_plaint_date Date not null,
	Other_plaint_agency varchar (50) not null,
	Other_plaint_who varchar (12) not null,
	Other_plaint_who_more varchar(50) null,
	Other_plaint_mode varchar(50) null,
	Other_plaint_mode_more varchar(200) null,
	Other_plaint_details varchar(1000) null,
	Other_plaint_rem varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;




/*
*=====================
*Table Case Discussion
*======================
*/

Drop table if exists tbl_case_discussion;
Create table tbl_case_discussion(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Discuss_date Date not null,
	Discuss_time varchar (20) null,
	Discuss_where varchar (30) not null,
	Discuss_where_more varchar(50) null,
	Discuss_worker_present varchar(20) null,
	Discuss_TWC2_pers1 varchar(200) null,
	Discuss_TWC2_pers2 varchar(200) null,
	Discuss_oth_pers varchar(200) null,
	Discuss_translator varchar(50) null,
	Discuss_topic varchar(200) null,
	Discuss_gist varchar(1000) null,
	Discuss_assist varchar(1000) null,
	Discuss_calculate varchar(1000) null,
	Discuss_action varchar(500) null,
	Discuss_rem varchar(500) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
*==========================
*Table Hospital
*==========================
*/

Drop table if exists tbl_hospital;
create table tbl_hospital (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Hosp_update date not null,
	Hosp_name varchar(30) not null,
	Hosp_name_more varchar(50) null,
	Hosp_doctor varchar(200) null,
	Hosp_remark varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
*=======================
*Table MC Status
*=======================
*/

Drop table if exists tbl_MC_status;
Create table tbl_MC_status (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	MC_update date not null,
	MC_status varchar(20) not null,
	MC_status_more varchar(50) null,
	MC_exp_date Date null, /*MC expiry date */
	MC_days_cumul int null, /*Cumulative MC so far */
	MC_rem varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
** Table R2R
*/
Drop table if exists tbl_R2R;
Create table tbl_R2R (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	R2R_date date not null,
	R2R_time varchar(20) null,
	R2R_hosp varchar(20) not null,
	R2R_dept varchar(50) null,
	R2R1 varchar(20) null, /*R2R first volunteer*/
	R2R2 varchar(20) null, /*R2R second volunteer*/
	R2R_purpose varchar(50) null,
	R2R_pre_appt_notes varchar(200) null,
	R2R_post_appt_notes varchar(200) null,
	R2R_feedback varchar(200) null,
	R2R_med_cost decimal(13,2) null, /* How much is the medical cost */
	R2R_outlay decimal(13,2) null, /* How much paid by volunteer */
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;


/*
*================================
* Start of Wica Tables (different)
*================================
*/

Drop table if exists tbl_wica;
Create table tbl_wica(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Wicamon_update date not null,
	Wicamon_status varchar(80) not null,
	Wicamon_status_more varchar(200) null,
	Wicamon_points decimal(13,2) null,
	Wicamon_dollars decimal(13,2) null,
	Wicamon_remarks varchar (200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;
/*
*=========================
*End of Wica Table
*=========================
*/



/*================================
* Start of Lawyer Tables (different)
*================================
*/

Drop table if exists tbl_lawyer;
Create table tbl_lawyer (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Lawyer_update Date not null,
	Lawyer_firm varchar(50) not null,
	Lawyer_firm_more varchar(50) null,
	Lawyer_Name varchar(200) null,	
	Lawyer_remarks varchar (200) null,
	Worker_FIN_number varchar(12) not null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;
/*
*=========================
*End of Lawyer Table
*=========================


/*
* Table CaseMileStone (Non-Criminal)
*/

Drop table if exists tbl_casemilestone_noncriminal;
Create table tbl_casemilestone_noncriminal(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Miles_nc_date Date not null,
	Miles_nc_reached varchar(50) not null,
	Miles_nc_reached_more varchar(200) null,
	Miles_nc_rem varchar(200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
* Table CaseMileStone (Criminal)
*/

Drop table if exists tbl_casemilestone_criminal;
Create table tbl_casemilestone_criminal(
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Miles_cr_date Date not null,
	Miles_cr_reached varchar(50) not null,
	Miles_cr_reached_more varchar(200) null,
	Miles_cr_charges varchar(200) null,
	Miles_cr_sentence varchar(200) null,
	Miles_cr_rem varchar (200) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
* Table ttr
*/
Drop table if exists tbl_ttr;
Create table tbl_ttr (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Ttr_update Date not null,
	Ttr_status varchar(50) not null,
	Ttr_status_more varchar(200) null,
	Departure_date varchar(50) null,
	Name_new_employer varchar(50) null,
	New_job varchar(200)null,
	Ttr_rem varchar(200) null,
	Worker_FIN_number varchar(12) not null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;



/*
**==================================
** Benefits 
**==================================
*/
Drop table if exists tbl_benefit;
Create table tbl_benefit (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Worker_FIN_number varchar(12) not null,
	Job_key MEDIUMINT not null,
	Prob_key MEDIUMINT not null,
	Bene_date date not null,
	Bene_giver varchar(20) not null,
	Bene_type varchar(50) null,
	Bene_type_more varchar(100) null,
	Bene_serial varchar(30) null,
	Bene_purpose varchar(50) null,
	Bene_rem varchar(500) null,
	Bene_value decimal(13,2) null,
	index (Worker_FIN_number),
	index (Job_key),
	index (Prob_key),
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
		ON DELETE CASCADE ON UPDATE CASCADE,
		
	FOREIGN KEY (Prob_key)
      REFERENCES tbl_problem(Prob_key)
		ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = INNODB;

/*
*========================
* tbl_audit
*========================
*/

Drop table if exists tbl_audit;
Create table tbl_audit (
    Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
    ID int auto_increment not null,
    username varchar (20) not null, /*to indicate who did the action*/
    Key_log varchar(20) not null, /*to know which key (problem,job or worker) was being edited. If it was on a user, user FIN would be recorded */
    FIN_log varchar (20) not null, /*to indicate the name of the worker or user whose attributes was changed/added */
    Action_type varchar(20) not null, /* Type of action - add, edit, delete, import, export */
	Action_description_log varchar(8000) null, /* descripton of action */
	index (Entry_date),

	Primary Key (ID),
    Foreign Key (Username) References tbl_user(Username)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;


/*
*=========================
*End of tbl_audit
*=========================
*/


/*
*========================
* tbl_dropdown [1]
*========================
*/

Drop table if exists tbl_dropdown;
Create Table tbl_dropdown (
	ID int not null Auto_Increment,
	dropdownType varchar(500) not null,
	Name varchar(500) not null,
	Remark varchar(500) null,
	displayRank int not null,
	index(dropdownType),
	Primary key(ID)
);

/* User Roles */
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (1, 'User Role', 'Administrator', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (2, 'User Role', 'Manager', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (3, 'User Role', 'Specialist', null,4 );
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (5, 'User Role', 'Associate', null, 2);
/* DD00 -- Worker - Digital Type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (7, 'Nationality_type','Bangladesh', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (8, 'Nationality_type','Cambodia', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (9, 'Nationality_type','China', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (10, 'Nationality_type','India', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (11, 'Nationality_type','Indonesia', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (12, 'Nationality_type','Malaysia', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (13, 'Nationality_type','Myanmar', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (14, 'Nationality_type','Philippines', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (15, 'Nationality_type','Sri Lanka', null, 9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (16, 'Nationality_type','Thailand', null, 10);                           
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (17, 'Nationality_type','Vietnam', null, 11);                    
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (18, 'Nationality_type','Other', null, 12);
/* DD01 -- Worker - Digital Type*/
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (19, 'DigitalType', 'Email', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (20, 'DigitalType', 'QQ', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (21, 'DigitalType', 'Other', null, 3);
/* DD02 -- Worker - Language*/
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (22, 'MainLang', 'Bengali', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (23, 'MainLang', 'Burmese', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (24, 'MainLang', 'Cambodian', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (25, 'MainLang', 'Chinese Mandarin', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (26, 'MainLang', 'English', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (27, 'MainLang', 'Filipino', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (28, 'MainLang', 'Hindi', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (29, 'MainLang', 'Indonesian', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (30, 'MainLang', 'Punjabi', null, 9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (31, 'MainLang', 'Sinhala', null, 10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (32, 'MainLang', 'Tamil', null, 11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (33, 'MainLang', 'Telugu', null, 12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (34, 'MainLang', 'Thai', null, 13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (35, 'MainLang', 'Vietnamese', null, 14);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (36, 'MainLang', 'Other', null, 15);
/* DD03 -- Worker - Spoken English Standard*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (37, 'Spoken_english_standard', 'Almost none, cannot comprehend', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (38, 'Spoken_english_standard', 'Phrases only', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (39, 'Spoken_english_standard','Short Sentences', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (40, 'Spoken_english_standard','Confident but ungrammatical', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (41, 'Spoken_english_standard','Fluent and can read', null, 5);
/* DD04 -- Job - Work  Pass Type*/
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (42, 'Work_pass_type','Work Permit', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (43, 'Work_pass_type','S Pass', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (44, 'Work_pass_type','Employment Pass', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (45, 'Work_pass_type','Training Pass', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (46, 'Work_pass_type','No workpass', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (47, 'Work_pass_type','Other', null, 6);
/* DD04 -- Job - Job Sector*/
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (48, 'Job_sector_type', "Cleaning", null, 1);
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (49, 'Job_sector_type',"Construction", null, 2);                       
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (50, 'Job_sector_type',"Domestic", null, 3);                     
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (51, 'Job_sector_type',"Landscaping", null, 4);                   
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (52, 'Job_sector_type',"Manufacturing", null, 5);
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (53, 'Job_sector_type',"Marine", null, 6);                      
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (54, 'Job_sector_type',"Process", null, 7);                  
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (55, 'Job_sector_type',"Services", null, 8);	
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (56, 'Job_sector_type',"Nil", null, 9);
INSERT into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (57, 'Job_sector_type',"Other", null, 10); 
/* DD06 -- Job - Pass Details*/ 
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (58, 'Pass_type','Special Pass', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (59, 'Pass_type', 'Work Permit', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (60, 'Pass_type','S Pass', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (61, 'Pass_type','Employment Pass', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (62, 'Pass_type','Training Pass', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (63, 'Pass_type','Social Visit Pass', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (64, 'Pass_type','Longterm SV Pass', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (65, 'Pass_type','Dependent Pass', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (66, 'Pass_type','Other', null, 9);
/* DD07 -- Job - IPA Pass type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (67, 'IPA_pass_type','Work Permit', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (68, 'IPA_pass_type','S Pass', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (69, 'IPA_pass_type','Employment Pass', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (70, 'IPA_pass_type','Training Pass', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (71, 'IPA_pass_type','Other', null, 5);
/* DD08 -- Job - Intermediary Agent*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (72, 'Agent_location_type','Singapore', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (73, 'Agent_location_type','HomeCountry', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (74, 'Agent_location_type','Travels btwn SG & Home Ctry', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (75, 'Agent_location_type','Other', null, 4);
/* DD09 -- Job - Workplace */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (76, 'Workplace_type', 'Building Site', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (77, 'Workplace_type', 'Factory', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (78, 'Workplace_type', 'F&B or Hotel', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (79, 'Workplace_type', 'Home', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (80, 'Workplace_type', 'Indoor Commercial', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (81, 'Workplace_type', 'Medical Facility', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (82, 'Workplace_type', 'Outdoor or Public areas', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (83, 'Workplace_type', 'Petrochemical', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (84, 'Workplace_type', 'Retail', null, 9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (85, 'Workplace_type', 'Sea Vessel', null, 10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (86, 'Workplace_type', 'Shipyard', null, 11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (87, 'Workplace_type', 'Other', null, 12);
/* DD10 -- Job - Workplace Direct*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (88, 'Workplace_direct_type','Employer', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (89, 'Workplace_direct_type','Agent', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (90, 'Workplace_direct_type','Self', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (91, 'Workplace_direct_type','Other', null, 4);
/* DD11 -- Job - Work History How*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (92, 'Work_history_how_type', 'Got job in home city, came to SG', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (93, 'Work_history_how_type','Transferred/found this job while in SG', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (94, 'Work_history_how_type','Found this job soon after arrival', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (95, 'Work_history_how_type','Other', null, 4);
/* DD12 -- Job - AccomProvided */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (96, 'Accom_provided_type','Provided', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (97, 'Accom_provided_type','Not Provided', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (98, 'Accom_provided_type','Subsidy given', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (99, 'Accom_provided_type','Other', null, 4);
/* DD13 -- Job - Accom Type */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (100, 'Accommodation_type', 'Employer home', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (101, 'Accommodation_type', 'Commercial dorm', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (102, 'Accommodation_type', 'Factory convert to dorm, not at worksite', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (103, 'Accommodation_type', 'Temp structure not at worksite', null,4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (104, 'Accommodation_type', 'Temp structure at worksite', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (105, 'Accommodation_type', 'Solid building at worksite', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (106, 'Accommodation_type', 'HDB/condo flat used as dorm', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (107, 'Accommodation_type', 'Shophouse/terrace house', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (108, 'Accommodation_type', 'Other', null, 9);
/* DD14 -- Problem - Problem Type, also Aggra_issue Problem type */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (109, 'Problem_type', 'Contract Dispute', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (110, 'Problem_type','Criminal Investigation/Charges', null,2 );
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (111, 'Problem_type','Denial of Medical Treatment', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (112, 'Problem_type','Forced Repat/Transportation', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (113, 'Problem_type','Housing', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (114, 'Problem_type','Illegal Deployment', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (115, 'Problem_type','Illegal Working', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (116, 'Problem_type','Illness', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (117, 'Problem_type','Injury, Non-Work', null, 9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (118, 'Problem_type','Injury, Work', null, 10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (119, 'Problem_type','Insufficient Work Assigned', null, 11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (120, 'Problem_type','Kickbacks', null, 12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (121, 'Problem_type','Loss/Retention of Personal Docs', null, 13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (122, 'Problem_type','Mistreatment', null, 14);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (123, 'Problem_type','No rest day or Excessive hours', null, 15);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (124, 'Problem_type','Overstay social visit pass', null, 16);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (125, 'Problem_type','Overstay work pass/special pass', null, 17);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (126, 'Problem_type','Premature Termination', null, 18);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (127, 'Problem_type','Recruitment fail, Not scam', null, 19);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (128, 'Problem_type','Recruitment fail, Scam/misrepresent', null, 20);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (129, 'Problem_type','Resignation/Change of employer', null, 21);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (130, 'Problem_type','Run away', null, 22);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (131, 'Problem_type','Safety Violation', null, 23);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (132, 'Problem_type','Salary/Deductions', null, 24);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (133, 'Problem_type','Work pass revoked by MOM', null, 25);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (134, 'Problem_type','Other', null, 26);
/* DD15 -- Problem - Salary & related history */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (135, 'Salary_payment_type', 'Cash', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (136, 'Salary_payment_type', 'Cheque', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (137, 'Salary_payment_type', 'Bank GIRO', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (138, 'Salary_payment_type', 'Mixed/variable', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (139, 'Salary_payment_type', 'Other', null, 5);
/* DD16 -- Problem - Complaint_type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (140, 'Complaint_type', 'Worker', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (141, 'Complaint_type', 'TWC2', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (142, 'Complaint_type', 'Third Party', null, 3);
/* DD17 -- Problem - Complaint Mode Type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (143, 'Complaint_mode_type','Face to Face', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (144, 'Complaint_mode_type','Email', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (145, 'Complaint_mode_type','Agency online form', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (146, 'Complaint_mode_type','Paper letter', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (147, 'Complaint_mode_type','Other', null, 5);
/* DD18 -- Problem - Discussion Location*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (148, 'Discuss_where_type','TWC2 office', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (149, 'Discuss_where_type','TCRP', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (150, 'Discuss_where_type','Email', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (151, 'Discuss_where_type','Fax', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (152, 'Discuss_where_type','Phone conversation', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (153, 'Discuss_where_type','Physical document', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (154, 'Discuss_where_type','Video conference', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (155, 'Discuss_where_type','Agent place', null,8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (156, 'Discuss_where_type','Airport', null,9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (157, 'Discuss_where_type','Company/worksite', null,10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (158, 'Discuss_where_type','During outreach', null,11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (159, 'Discuss_where_type','Employer home', null,12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (160, 'Discuss_where_type','Hospital', null,13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (161, 'Discuss_where_type','ICA', null,14);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (162, 'Discuss_where_type','Law Office', null,15);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (163, 'Discuss_where_type','MOM', null,16);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (164, 'Discuss_where_type','Police station', null,17);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (165, 'Discuss_where_type','Prison', null,18);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (166, 'Discuss_where_type','Repatriation office', null,19);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (167, 'Discuss_where_type','Other', null,20);
/* DD19 -- Problem - Hospital*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (168, 'Hospital_name','Alexandra', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (169, 'Hospital_name','CGH', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (170, 'Hospital_name','Gleneagles', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (171, 'Hospital_name','KTPH', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (172, 'Hospital_name','Mt Alvernia', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (173, 'Hospital_name','Mt Eliz - Mt Eliz', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (174, 'Hospital_name','Mt Eliz - Novena', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (175, 'Hospital_name','Ng Teng Fong', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (176, 'Hospital_name','NUH', null, 9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (177, 'Hospital_name','Raffles', null, 10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (178, 'Hospital_name','SGH', null, 11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (179, 'Hospital_name','TTSH', null, 12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (180, 'Hospital_name','Westpoint', null, 13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (181, 'Hospital_name','Other', null, 14);
/* DD20 -- Problem - MC Status*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (182, 'MC_status_type','Medical Leave', null, 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (183, 'MC_status_type','Light Duty', null, 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (184, 'MC_status_type','No MC, No LD', null, 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (185, 'MC_status_type','Do not know', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (186, 'MC_status_type','Other', null,5);
/* DD21 -- Problem - Wica Status*/
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (187, 'Wicamon_status','Not found', null,1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (188, 'Wicamon_status','No claim field', null,2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (189, 'Wicamon_status','Withdrawn', null,3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (190, 'Wicamon_status','MOM checking validity', null, 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (191, 'Wicamon_status','MOM informed of accident, awaiting info', null, 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (192, 'Wicamon_status','MOM informed of work accdnt, employer to pay MC', null, 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (193, 'Wicamon_status','Employer to pay MC', null, 7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (194, 'Wicamon_status','Suspended', null, 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (195, 'Wicamon_status','Decided not to claim', null, 9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (196, 'Wicamon_status','Invalid claim', null, 10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (197, 'Wicamon_status','Not work-related(final)', null,11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (198, 'Wicamon_status','MOM not received med report', null,12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (199, 'Wicamon_status','Clarification of med report required', null,13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (200, 'Wicamon_status','Pre-hearing conference scheduled', null,14);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (201, 'Wicamon_status','Common law', null,15);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (202, 'Wicamon_status','Awarded, can still object', null,16);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (203, 'Wicamon_status','Received objection', null,17);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (204, 'Wicamon_status','No permanent incapcity', null,18);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (205, 'Wicamon_status','Awarded, final', null,19);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (206, 'Wicamon_status','Concluded', null,20);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (207, 'Wicamon_status','Other', null,21);
/* DD22 -- Problem - Lawyer Firm List*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (208, 'Lawyer_firm','APAC Law', null,1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (209, 'Lawyer_firm','Averex Law', null,2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (210, 'Lawyer_firm','Centro-Legal Law', null,3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (211, 'Lawyer_firm','Charan & Co', null,4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (212, 'Lawyer_firm','Cosmas', null,5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (213, 'Lawyer_firm','CrossBorders', null,6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (214, 'Lawyer_firm','Dominion', null,7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (215, 'Lawyer_firm','Foo Kwok', null,8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (216, 'Lawyer_firm','Gavan Law', null,9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (217, 'Lawyer_firm','Har Assoc', null,10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (218, 'Lawyer_firm','Hoh Law', null,11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (219, 'Lawyer_firm','Jeya & Assoc', null,12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (220, 'Lawyer_firm','Joseph Chen & Co', null,13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (221, 'Lawyer_firm','K Ravi', null,14);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (222, 'Lawyer_firm','Khan & Co', null,15);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (223, 'Lawyer_firm','Myint Soe & Selvaraj', null,16);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (224, 'Lawyer_firm','Prestige Legal', null,17);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (225, 'Lawyer_firm','Pritam Singh Gill & Co', null,18);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (226, 'Lawyer_firm','Sathi & Co', null,19);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (227, 'Lawyer_firm','Satwant & Assoc', null,20);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (228, 'Lawyer_firm','Sim & Co', null,21);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (229, 'Lawyer_firm','SK Kumar', null,22);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (230, 'Lawyer_firm','Yeo Perumal Mohideen Law', null,23);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (231, 'Lawyer_firm','Other', null,24);
/* DD23 -- Problem - Non Criminal Case Mile Stone List*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (232, 'Miles_nc_reached','Salary & related claims settled & paid', null,1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (233, 'Miles_nc_reached','MC wages to-date paid', null,2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (234, 'Miles_nc_reached','Medical expenses to-date reimbursed', null,3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (235, 'Miles_nc_reached','First WICA assessment done', null,4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (236, 'Miles_nc_reached','Second WICA (re)assessment done', null,5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (237, 'Miles_nc_reached','Final NOA issued', null,6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (238, 'Miles_nc_reached','Final NOA paid', null,7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (239, 'Miles_nc_reached','Referred to Labour Court', null,8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (240, 'Miles_nc_reached','Labour Court decision made', null,9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (241, 'Miles_nc_reached','Labour Court award paid', null,10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (242, 'Miles_nc_reached','Referred to Datapool', null,11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (243, 'Miles_nc_reached','To common law', null,12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (244, 'Miles_nc_reached','Case abandoned', null,13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (245, 'Miles_nc_reached','Other', null,14);
/* DD24 -- Problem - Criminal Case Mile Stone List*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (246,'Casemilestone_criminal_type', 'Summons received', null,1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (247,'Casemilestone_criminal_type',  'Arrested', null,2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (248, 'Casemilestone_criminal_type', 'Bailed out', null,3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (249,'Casemilestone_criminal_type',  'Formal warning given', null,4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (250, 'Casemilestone_criminal_type', 'Lawyer found', null,5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (251, 'Casemilestone_criminal_type', 'Formally charged', null,6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (252, 'Casemilestone_criminal_type', 'Charges amended', null,7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (253, 'Casemilestone_criminal_type', 'Charges withdrawn', null,8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (254, 'Casemilestone_criminal_type', 'Trial verdict', null,10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (255, 'Casemilestone_criminal_type', 'Sentence meted', null,11);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (256, 'Casemilestone_criminal_type', 'Fine Paid', null,12);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (257, 'Casemilestone_criminal_type', 'Start prison service', null,13);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (258, 'Casemilestone_criminal_type', 'Release from prison', null,14);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (259, 'Casemilestone_criminal_type', 'Other', null,15);
/* DD25 -- Problem - TTR status*/
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (260, 'Ttr_status_type','Willingly repatriated', null,1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (261,'Ttr_status_type', 'Forcibly repatriated', null,2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (262,'Ttr_status_type', 'Phone cut-off, believed repatriated', null,3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (263, 'Ttr_status_type', 'Friends say he has been repatriated', null,4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (264, 'Ttr_status_type', 'Departed Sg at his own cost', null,5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (265, 'Ttr_status_type', 'TJS allowed by MOM', null,6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (266, 'Ttr_status_type', 'Change of employer allowed by MOM', null,7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (267, 'Ttr_status_type', 'TJS commenced', null,8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (268, 'Ttr_status_type', 'TJS ended', null,9);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (269, 'Ttr_status_type', 'New job commenced', null,10);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (270, 'Ttr_status_type', 'Other', null,11);
/* DD26 -- Benefits - Type */
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (271, 'Bene_type','Airline Ticket', 'Other', 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (272,'Bene_type', 'Cash accom', 'Roof', 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (273,'Bene_type', 'Cash meal', 'Food', 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (274, 'Bene_type', 'Cash medical', 'Medical & Karunya',1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank)  Values (275, 'Bene_type', 'Cash Remark', 'Other', 2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (276, 'Bene_type', 'Cash transport', 'Transport',1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (277, 'Bene_type', 'EZ FareGo', 'Transport',2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (278, 'Bene_type', 'EZ SWAT', 'Transport',3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (279, 'Bene_type', 'Hospital invoice', 'Other', 3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (280, 'Bene_type', 'Invoice from Remark vendor', 'Other', 4);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (281, 'Bene_type', 'Karunya referral', 'Medical & Karunya',2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (282, 'Bene_type', 'Meal card', 'Food',2);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (283, 'Bene_type', 'Meal CR', 'Food',3);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (284, 'Bene_type', 'Phone card', 'Other', 5);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (285, 'Bene_type', 'Pro-bono legal representation', 'Other', 6);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (286, 'Bene_type', 'Refund by worker', 'Other',7);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (287, 'Bene_type', 'Remittance to worker or family', 'Other', 8);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (288, 'Bene_type', 'Shelter admission', 'Roof', 1);
Insert into tbl_dropdown (ID, dropdownType, Name, Remark, displayRank) Values (289, 'Bene_type', 'Other', 'Other', 9);


/*
*=========================
*Dummy User
*=========================
*/
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 
	Values ("G1234567A", 'FullName', 'Alias', 'specialist', 'specialist', 'email@email.com', '12345', 'Male', "Specialist", "Active");
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 
	Values ("S0000000S", 'FullName', 'Alias', 'superadmin', '1000:713dd55467268ec15408f4f8ec970d4285179a121ca02ecf:2135aeab9a435c855956a4cdfaef2c7db9d89a808e0494e1', 'email@email.com', '12345', 'Male', "Administrator", "Active");

/*	
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 
	Values ("S0000001A", 'Username1', 'Alias', 'username1', 'username1', 'email@email.com', '12345', 'Male', "Specialist", "Active");
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 	
	Values ("S0000002A", 'Username2', 'Alias', 'username2', 'username2', 'email@email.com', '12345', 'Male', "Specialist", "Active");
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 	
	Values ("S0000003A", 'Username3', 'Alias', 'username3', 'username3', 'email@email.com', '12345', 'Male', "Specialist", "Active");
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 	
	Values ("S0000004A", 'Username4', 'Alias', 'username4', 'username4', 'email@email.com', '12345', 'Male', "Specialist", "Active");
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 	
	Values ("S0000005A", 'Username5', 'Alias', 'username5', 'username5', 'email@email.com', '12345', 'Male', "Specialist", "Active");
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 	
	Values ("S0000006A", 'Username6', 'Alias', 'username6', 'username6', 'email@email.com', '12345', 'Male', "Specialist", "Active");
Insert into tbl_user (NRIC_number,Full_name, Alias, Username, Password, Email_address, Phone_number, Gender, Role, Status) 	
	Values ("S0000007A", 'Username7', 'Alias', 'username7', 'username7', 'email@email.com', '12345', 'Male', "Specialist", "Active");
*/


