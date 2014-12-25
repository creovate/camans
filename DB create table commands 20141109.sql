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
	PRIMARY KEY (NRIC_number)
);

/*
**====================================
**Worker & its complements  Table [15]
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

	Primary Key(FIN_number)
);

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

	Primary Key(ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
		 ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB;

/*
**============================
** Face Picture
**============================
*/

Drop table if exists tbl_worker_facepic;
Create table tbl_worker_facepic (
	Entry_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
	ID int auto_increment not null,
	Face_picture varchar(255) null,
	Worker_FIN_number varchar(12) not null,
	
	Primary Key (ID),
	FOREIGN KEY (Worker_FIN_number) 
        REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

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
	Job_remarks varchar (400) null,


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
	Housing_provided varchar(2) null,
	IPA_remarks varchar (200) null,

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
	Work_hist_first varchar(2) null,
	Work_hist_year_arrive varchar(50) null,
	Work_hist_previous varchar (1000) null,
	Work_hist_previous_problems varchar (1000) null,
	Work_hist_remarks varchar (200) null,


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

	PRIMARY KEY (Prob_key),
	FOREIGN KEY (Worker_FIN_number) 
		REFERENCES tbl_worker(FIN_number)
			ON DELETE CASCADE ON UPDATE CASCADE,

	FOREIGN KEY (Job_key)
      REFERENCES tbl_job(Job_key)
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
    username varchar (12) not null, /*to indicate who did the action*/
    Key_log varchar(20) not null, /*to know which key (problem,job or worker) was being edited. If it was on a user, user FIN would be recorded */
    FIN_log varchar (20) not null, /*to indicate the name of the worker or user whose attributes was changed/added */
    Action_type varchar(20) not null, /* Type of action - add, edit, delete, import, export */
	Action_description_log varchar(8000) null, /* descripton of action */

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
	Other varchar(500) null,
	Primary key(ID)
);

/* User Roles */
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (1, 'User Role', 'Administrator', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (2, 'User Role', 'Manager', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (3, 'User Role', 'General Specialist', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (4, 'User Role', 'Restricted Specialist', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (5, 'User Role', 'Associate', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (6, 'User Role', 'None', null);
/* DD00 -- Worker - Digital Type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (7, 'Nationality_type','Bangladesh', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (8, 'Nationality_type','Cambodia', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (9, 'Nationality_type','China', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (10, 'Nationality_type','India', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (11, 'Nationality_type','Indonesia', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (12, 'Nationality_type','Malaysia', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (13, 'Nationality_type','Myanmar', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (14, 'Nationality_type','Philippines', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (15, 'Nationality_type','Sri Lanka', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (16, 'Nationality_type','Thailand', null);                           
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (17, 'Nationality_type','Vietnam', null);                    
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (18, 'Nationality_type','Other', null);
/* DD01 -- Worker - Digital Type*/
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (19, 'DigitalType', 'Email', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (20, 'DigitalType', 'QQ', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (21, 'DigitalType', 'Other', null);
/* DD02 -- Worker - Language*/
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (22, 'MainLang', 'Bengali', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (23, 'MainLang', 'Burmese', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (24, 'MainLang', 'Cambodian', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (25, 'MainLang', 'Chinese Mandarin', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (26, 'MainLang', 'English', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (27, 'MainLang', 'Filipino', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (28, 'MainLang', 'Hindi', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (29, 'MainLang', 'Indonesian', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (30, 'MainLang', 'Punjabi', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (31, 'MainLang', 'Sinhala', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (32, 'MainLang', 'Tamil', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (33, 'MainLang', 'Telugu', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (34, 'MainLang', 'Thai', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (35, 'MainLang', 'Vietnamese', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (36, 'MainLang', 'Other', null);
/* DD03 -- Worker - Spoken English Standard*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (37, 'Spoken_english_standard', 'Almost none, cannot comprehend', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (38, 'Spoken_english_standard', 'Phrases only', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (39, 'Spoken_english_standard','Short Sentences', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (40, 'Spoken_english_standard','Confident but ungrammatical', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (41, 'Spoken_english_standard','Fluent and can read', null);
/* DD04 -- Job - Work  Pass Type*/
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (42, 'Work_pass_type','Work Permit', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (43, 'Work_pass_type','S Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (44, 'Work_pass_type','Employment Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (45, 'Work_pass_type','Training Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (46, 'Work_pass_type','No workpass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (47, 'Work_pass_type','Other', null);
/* DD04 -- Job - Job Sector*/
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (48, 'Job_sector_type', "Cleaning", null);
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (49, 'Job_sector_type',"Construction", null);                       
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (50, 'Job_sector_type',"Domestic", null);                     
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (51, 'Job_sector_type',"Landscaping", null);                   
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (52, 'Job_sector_type',"Manufacturing", null);
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (53, 'Job_sector_type',"Marine", null);                      
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (54, 'Job_sector_type',"Process", null);                  
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (55, 'Job_sector_type',"Services", null);	
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (56, 'Job_sector_type',"Nil", null);
INSERT into tbl_dropdown (ID, dropdownType, Name, Other) Values (57, 'Job_sector_type',"Other", null); 
/* DD06 -- Job - Pass Details*/
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (58, 'Pass_type','Special Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (59, 'Pass_type', 'Work Permit', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (60, 'Pass_type','S Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (61, 'Pass_type','Employment Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (62, 'Pass_type','Training Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (63, 'Pass_type','Social Visit Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (64, 'Pass_type','Longterm SV Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (65, 'Pass_type','Dependent Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (66, 'Pass_type','Other', null);
/* DD07 -- Job - IPA Pass type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (67, 'IPA_pass_type','Work Permit', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (68, 'IPA_pass_type','S Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (69, 'IPA_pass_type','Employment Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (70, 'IPA_pass_type','Training Pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (71, 'IPA_pass_type','Other', null);
/* DD08 -- Job - Intermediary Agent*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (72, 'Agent_location_type','Singapore', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (73, 'Agent_location_type','HomeCountry', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (74, 'Agent_location_type','Travels btwn SG & Home Ctry', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (75, 'Agent_location_type','Other', null);
/* DD09 -- Job - Workplace */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (76, 'Workplace_type', 'Building Site', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (77, 'Workplace_type', 'Factory', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (78, 'Workplace_type', 'F&B or Hotel', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (79, 'Workplace_type', 'Home', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (80, 'Workplace_type', 'Indoor Commercial', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (81, 'Workplace_type', 'Medical Facility', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (82, 'Workplace_type', 'Outdoor or Public areas', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (83, 'Workplace_type', 'Petrochemical', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (84, 'Workplace_type', 'Retail', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (85, 'Workplace_type', 'Sea Vessel', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (86, 'Workplace_type', 'Shipyard', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (87, 'Workplace_type', 'Other', null);
/* DD10 -- Job - Workplace Direct*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (88, 'Workplace_direct_type','Employer', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (89, 'Workplace_direct_type','Agent', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (90, 'Workplace_direct_type','Self', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (91, 'Workplace_direct_type','Other', null);
/* DD11 -- Job - Work History How*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (92, 'Work_history_how_type', 'Got job in home city, came to SG', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (93, 'Work_history_how_type','Transferred/found this job while in SG', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (94, 'Work_history_how_type','Found this job soon after arrival', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (95, 'Work_history_how_type','Other', null);
/* DD12 -- Job - AccomProvided */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (96, 'Accom_provided_type','Provided', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (97, 'Accom_provided_type','Not Provided', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (98, 'Accom_provided_type','Subsidy given', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (99, 'Accom_provided_type','Other', null);
/* DD13 -- Job - Accom Type */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (100, 'Accommodation_type', 'Employer home', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (101, 'Accommodation_type', 'Commercial dorm', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (102, 'Accommodation_type', 'Factory convert to dorm, not at worksite', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (103, 'Accommodation_type', 'Temp structure not at worksite', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (104, 'Accommodation_type', 'Temp structure at worksite', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (105, 'Accommodation_type', 'Solid building at worksite', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (106, 'Accommodation_type', 'HDB/condo flat used as dorm', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (107, 'Accommodation_type', 'Shophouse/terrace house', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (108, 'Accommodation_type', 'Other', null);
/* DD14 -- Problem - Problem Type, also Aggra_issue Problem type */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (109, 'Problem_type', 'Contract Dispute', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (110, 'Problem_type','Criminal Investigation/Charges', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (111, 'Problem_type','Denial of Medical Treatment', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (112, 'Problem_type','Forced Repat/Transportation', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (113, 'Problem_type','Housing', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (114, 'Problem_type','Illegal Deployment', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (115, 'Problem_type','Illegal Working', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (116, 'Problem_type','Illness', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (117, 'Problem_type','Injury, Non-Work', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (118, 'Problem_type','Injury, Work', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (119, 'Problem_type','Insufficient Work Assigned', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (120, 'Problem_type','Kickbacks', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (121, 'Problem_type','Loss/Retention of Personal Docs', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (122, 'Problem_type','Mistreatment', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (123, 'Problem_type','No rest day or Excessive hours', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (124, 'Problem_type','Overstay social visit pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (125, 'Problem_type','Overstay work pass/special pass', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (126, 'Problem_type','Premature Termination', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (127, 'Problem_type','Recruitment fail, Not scam', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (128, 'Problem_type','Recruitment fail, Scam/misrepresent', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (129, 'Problem_type','Resignation/Change of employer', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (130, 'Problem_type','Run away', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (131, 'Problem_type','Safety Violation', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (132, 'Problem_type','Salary/Deductions', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (133, 'Problem_type','Work pass revoked by MOM', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (134, 'Problem_type','Other', null);
/* DD15 -- Problem - Salary & related history */
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (135, 'Salary_payment_type', 'Cash', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (136, 'Salary_payment_type', 'Cheque', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (137, 'Salary_payment_type', 'Bank giro', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (138, 'Salary_payment_type', 'Mixed/variable', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (139, 'Salary_payment_type', 'Other', null);
/* DD16 -- Problem - Complaint_type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (140, 'Complaint_type', 'Worker', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (141, 'Complaint_type', 'TWC2', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (142, 'Complaint_type', 'Third Party', null);
/* DD17 -- Problem - Complaint Mode Type*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (143, 'Complaint_mode_type','Face to Face', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (144, 'Complaint_mode_type','Email', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (145, 'Complaint_mode_type','Agency online form', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (146, 'Complaint_mode_type','Paper letter', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (147, 'Complaint_mode_type','Other', null);
/* DD18 -- Problem - Discussion Location*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (148, 'Discuss_where_type','TWC2 office', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (149, 'Discuss_where_type','TCRP', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (150, 'Discuss_where_type','Email', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (151, 'Discuss_where_type','Fax', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (152, 'Discuss_where_type','Phone conversation', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (153, 'Discuss_where_type','Physical document', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (154, 'Discuss_where_type','Video conference', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (155, 'Discuss_where_type','Agent place', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (156, 'Discuss_where_type','Airport', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (157, 'Discuss_where_type','Company/worksite', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (158, 'Discuss_where_type','During outreach', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (159, 'Discuss_where_type','Employer home', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (160, 'Discuss_where_type','Hospital', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (161, 'Discuss_where_type','ICA', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (162, 'Discuss_where_type','Law Office', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (163, 'Discuss_where_type','MOM', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (164, 'Discuss_where_type','Police station', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (165, 'Discuss_where_type','Prison', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (166, 'Discuss_where_type','Repatriation office', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (167, 'Discuss_where_type','Other', null);
/* DD19 -- Problem - Hospital*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (168, 'Hospital_name','Alexandra', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (169, 'Hospital_name','CGH', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (170, 'Hospital_name','Gleneagles', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (171, 'Hospital_name','KTPH', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (172, 'Hospital_name','Mt Alvernia', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (173, 'Hospital_name','Mt Eliz - Mt Eliz', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (174, 'Hospital_name','Mt Eliz - Novena', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (175, 'Hospital_name','Ng Teng Fong', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (176, 'Hospital_name','NUH', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (177, 'Hospital_name','Raffles', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (178, 'Hospital_name','SGH', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (179, 'Hospital_name','TTSH', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (180, 'Hospital_name','Westpoint', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (181, 'Hospital_name','Other', null);
/* DD20 -- Problem - MC Status*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (182, 'MC_status_type','Medical Leave', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (183, 'MC_status_type','Light Duty', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (184, 'MC_status_type','No MC, No LD', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (185, 'MC_status_type','Do not know', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (186, 'MC_status_type','Other', null);
/* DD21 -- Problem - Wica Status*/
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (187, 'Wicamon_status','Not found', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (188, 'Wicamon_status','No claim field', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (189, 'Wicamon_status','Withdrawn', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (190, 'Wicamon_status','MOM checking validity', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (191, 'Wicamon_status','MOM informed of accident, awaiting info', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (192, 'Wicamon_status','MOM informed of work accdnt, employer to pay MC', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (193, 'Wicamon_status','Employer to pay MC', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (194, 'Wicamon_status','Suspended', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (195, 'Wicamon_status','Decided not to claim', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (196, 'Wicamon_status','Invalid claim', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (197, 'Wicamon_status','Not work-related(final)', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (198, 'Wicamon_status','MOM not received med report', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (199, 'Wicamon_status','Clarification of med report required', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (200, 'Wicamon_status','Pre-hearing conference scheduled', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (201, 'Wicamon_status','Common law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (202, 'Wicamon_status','Awarded, can still object', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (203, 'Wicamon_status','Received objection', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (204, 'Wicamon_status','No permanent incapcity', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (205, 'Wicamon_status','Awarded, final', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (206, 'Wicamon_status','Concluded', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (207, 'Wicamon_status','Other', null);
/* DD22 -- Problem - Lawyer Firm List*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (208, 'Lawyer_firm','APAC Law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (209, 'Lawyer_firm','Averex Law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (210, 'Lawyer_firm','Centro-Legal Law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (211, 'Lawyer_firm','Charan & Co', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (212, 'Lawyer_firm','Cosmas', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (213, 'Lawyer_firm','CrossBorders', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (214, 'Lawyer_firm','Dominion', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (215, 'Lawyer_firm','Foo Kwok', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (216, 'Lawyer_firm','Gavan Law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (217, 'Lawyer_firm','Har Assoc', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (218, 'Lawyer_firm','Hoh Law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (219, 'Lawyer_firm','Jeya & Assoc', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (220, 'Lawyer_firm','Joseph Chen & Co', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (221, 'Lawyer_firm','K Ravi', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (222, 'Lawyer_firm','Khan & Co', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (223, 'Lawyer_firm','Myint Soe & Selvaraj', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (224, 'Lawyer_firm','Prestige Legal', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (225, 'Lawyer_firm','Pritam Singh Gill & Co', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (226, 'Lawyer_firm','Sathi & Co', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (227, 'Lawyer_firm','Satwant & Assoc', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (228, 'Lawyer_firm','Sim & Co', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (229, 'Lawyer_firm','SK Kumar', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (230, 'Lawyer_firm','Yeo Perumal Mohideen Law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (231, 'Lawyer_firm','Other', null);
/* DD23 -- Problem - Non Criminal Case Mile Stone List*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other)  Values (232, 'Miles_nc_reached','Salary & related claims settled & paid', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (233, 'Miles_nc_reached','MC wages to-date paid', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (234, 'Miles_nc_reached','Medical expenses to-date reimbursed', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (235, 'Miles_nc_reached','First WICA assessment done', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (236, 'Miles_nc_reached','Second WICA (re)assessment done', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (237, 'Miles_nc_reached','Final NOA issued', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (238, 'Miles_nc_reached','Final NOA paid', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (239, 'Miles_nc_reached','Referred to Labour Court', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (240, 'Miles_nc_reached','Labour Court decision made', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (241, 'Miles_nc_reached','Labour Court award paid', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (242, 'Miles_nc_reached','Referred to Datapool', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (243, 'Miles_nc_reached','To common law', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (244, 'Miles_nc_reached','Case abandoned', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (245, 'Miles_nc_reached','Other', null);
/* DD24 -- Problem - Criminal Case Mile Stone List*/
INSERT INTO tbl_dropdown (ID, dropdownType, Name, Other) Values (246,'Casemilestone_criminal_type', 'Summons received', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (247,'Casemilestone_criminal_type',  'Arrested', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (248, 'Casemilestone_criminal_type', 'Bailed out', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (249,'Casemilestone_criminal_type',  'Formal warning given', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (250, 'Casemilestone_criminal_type', 'Lawyer found', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (251, 'Casemilestone_criminal_type', 'Formally charged', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (252, 'Casemilestone_criminal_type', 'Charges amended', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (253, 'Casemilestone_criminal_type', 'Charges withdrawn', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (254, 'Casemilestone_criminal_type', 'Trial verdict', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (255, 'Casemilestone_criminal_type', 'Sentence meted', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (256, 'Casemilestone_criminal_type', 'Fine Paid', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (257, 'Casemilestone_criminal_type', 'Start prison service', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (258, 'Casemilestone_criminal_type', 'Release from prison', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (259, 'Casemilestone_criminal_type', 'Other', null);
/* DD25 -- Problem - TTR status*/
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (260, 'Ttr_status_type','Willingly repatriated', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (261,'Ttr_status_type', 'Forcibly repatriated', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (262,'Ttr_status_type', 'Phone cut-off, believed repatriated', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (263, 'Ttr_status_type', 'Friends say he has been repatriated', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (264, 'Ttr_status_type', 'Departed Sg at his own cost', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (265, 'Ttr_status_type', 'TJS allowed by MOM', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (266, 'Ttr_status_type', 'Change of employer allowed by MOM', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (267, 'Ttr_status_type', 'TJS commenced', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (268, 'Ttr_status_type', 'TJS ended', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (269, 'Ttr_status_type', 'New job commenced', null);
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (270, 'Ttr_status_type', 'Other', null);
/* DD26 -- Benefits - Type */
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (271, 'Bene_type','Airline Ticket', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (272,'Bene_type', 'Cash accom', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (273,'Bene_type', 'Cash meal', 'Food');
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (274, 'Bene_type', 'Cash medical', 'Medical & Karunya');
Insert into tbl_dropdown (ID, dropdownType, Name, Other)  Values (275, 'Bene_type', 'Cash other', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (276, 'Bene_type', 'Cash transport', 'Transport');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (277, 'Bene_type', 'EZ FareGo', 'Transport');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (278, 'Bene_type', 'EZ SWAT', 'Transport');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (279, 'Bene_type', 'Hospital invoice', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (280, 'Bene_type', 'Invoice from other vendor', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (281, 'Bene_type', 'Karunya referral', 'Medical & Karunya');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (282, 'Bene_type', 'Meal card', 'Food');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (283, 'Bene_type', 'Meal CR', 'Food');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (284, 'Bene_type', 'Phone card', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (285, 'Bene_type', 'Pro-bono legal representation', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (286, 'Bene_type', 'Refund by worker', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (287, 'Bene_type', 'Remittance to worker or family', 'Other');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (288, 'Bene_type', 'Shelter admission', 'Roof');
Insert into tbl_dropdown (ID, dropdownType, Name, Other) Values (289, 'Bene_type', 'Other', 'Other');


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


