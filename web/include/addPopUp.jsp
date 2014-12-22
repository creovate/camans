<%-- 
    Document   : addPopUp
    Created on : Oct 26, 2014, 2:51:36 PM
    Author     : Nyein Su
--%>

<%@page import="camans.dao.DropdownDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    h4{
        color: #AF4454;
    }

</style>
<script>
    $('.cancel_btn').click(function() {
        $('#pop_up_content').dialog("destroy");
        $('#pop_up_content').empty();
    });

    $(function() {
        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true
        });

    });

    //startdate & enddate 
    $(function() {
        $(".startDate").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            onClose: function(selectedDate) {
                $(".endDate").datepicker("option", "minDate", selectedDate);
            }
        });
        $(".endDate").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            onClose: function(selectedDate) {

                $(".startDate").datepicker("option", "maxDate", selectedDate);
            }
        });
    });

    //for date inputs
    $(document).ready(function() {

        $('.dateInput').focus(function() {

            $('.dateInput').blur();

        });

    });


    //worker form validation 
    $(document).ready(function() {
        $('.worker_pop_up')
                .bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                //nickname
                nickName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The nickname must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The nickname cannot be empty.'
                        }
                    }
                },
                nNickName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The nickname must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The nickname cannot be empty.'
                        }
                    }
                },
                //passport details
                nPassportNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Passport No. must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Passport No. cannot be empty.'
                        }
                    }
                },
                nPassportCountry: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Passport Country must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Passport Country cannot be empty.'
                        }
                    }
                },
                passportNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Passport No. must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Passport No. cannot be empty.'
                        }
                    }
                },
                passportCountry: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Passport Country must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Passport Country cannot be empty.'
                        }
                    }
                },
                //sgPhone & homePhone
                nPhNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Phone No must be less than 20 characters.'
                        },
                        integer: {
                            message: 'The value is not an integer'
                        },
                        notEmpty: {
                            message: 'Phone No. cannot be empty.'
                        }
                    }
                },
                phNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Phone No must be less than 20 characters.'
                        },
                        integer: {
                            message: 'The value is not an integer'
                        },
                        notEmpty: {
                            message: 'Phone No. cannot be empty.'
                        }
                    }
                },
                nPhOwner: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Owner name must be less than 20 characters.'
                        }
                    }
                },
                phOwner: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Owner name must be less than 20 characters.'
                        }
                    }
                },
                //sgAddress & homeCountry Add
                nAddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must be less than 300 characters.'
                        },
                        notEmpty: {
                            message: 'Address cannot be empty.'
                        }
                    }
                },
                address: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must be less than 300 characters.'
                        },
                        notEmpty: {
                            message: 'Address cannot be empty.'
                        }
                    }
                },
                //digitalcontact & remark for all
                nDigitalContactType: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Contact Type must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Contact Type cannot be empty.'
                        }
                    }
                },
                nDigitalMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Contact Type must be less than 50 characters.'
                        }
                    }
                },
                nDigitalDetails: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Contact address must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Contact address cannot be empty.'
                        }
                    }
                },
                nDigitalOwner: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Owner of Contact must be less than 50 characters.'
                        }
                    }
                },
                nRemark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must be less than 200 characters.'
                        }
                    }
                },
                digitalContactType: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Contact Type must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Contact Type cannot be empty.'
                        }
                    }
                },
                digitalMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Contact Type must be less than 50 characters.'
                        }
                    }
                },
                digitalDetails: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Contact address must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Contact address cannot be empty.'
                        }
                    }
                },
                digitalOwner: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Owner of Contact must be less than 50 characters.'
                        }
                    }
                },
                remark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must be less than 200 characters.'
                        }
                    }
                },
                //nok & family & Friends
                nName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The nickname cannot be empty.'
                        }
                    }
                },
                nRelation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Relationship must be less than 50 characters.'
                        }
                    }
                },
                nDocReference: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Identity docs/references must be less than 200 characters.'
                        }
                    }
                },
                nDigitalContact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact Details must be less than 200 characters.'
                        }
                    }
                },
                nProofDoc: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Attesting Documents must be less than 200 characters.'
                        }
                    }
                },
                name: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The name cannot be empty.'
                        }
                    }
                },
                relation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Relationship must be less than 50 characters.'
                        }
                    }
                },
                docReference: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Identity docs/references must be less than 200 characters.'
                        }
                    }
                },
                digitalContact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact Details must be less than 200 characters.'
                        }
                    }
                },
                proofDoc: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Attesting Documents must be less than 200 characters.'
                        }
                    }
                },
                //language
                nMainLanguage: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Language must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Language cannot be empty.'
                        }
                    }
                },
                nLanguageMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Others must be less than 50 characters.'
                        }
                    }
                },
                mainLanguage: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Language must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Language cannot be empty.'
                        }
                    }
                },
                languageMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Others must be less than 50 characters.'
                        }
                    }
                },
                //bankAccount
                nBankAcctName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Name cannot be empty.'
                        }
                    }
                },
                nBankAcctNum: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Account No. must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Account No. cannot be empty.'
                        }
                    }
                },
                nBankName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Bank name cannot be empty.'
                        }
                    }
                },
                nBankBranch: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank branch must be less than 50 characters.'
                        }
                    }
                },
                nBankBranchCode: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank branch code must be less than 50 characters.'
                        }
                    }
                },
                nBankBranchAddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must be less than 300 characters.'
                        }
                    }
                },
                nBankSwift: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank Swift must be less than 50 characters.'
                        }
                    }
                },
                bankAcctName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Name cannot be empty.'
                        }
                    }
                },
                bankAcctNum: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Account No. must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Account No. cannot be empty.'
                        }
                    }
                },
                bankName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Bank name cannot be empty.'
                        }
                    }
                },
                bankBranch: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank branch must be less than 50 characters.'
                        }
                    }
                },
                bankBranchCode: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank branch code must be less than 50 characters.'
                        }
                    }
                },
                bankBranchAddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must be less than 300 characters.'
                        }
                    }
                },
                bankSwift: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank Swift must be less than 50 characters.'
                        }
                    }
                }
            }
        })

    });

    //job form validation 
    $(document).ready(function() {
        $('.job_pop_up')
                .bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                //pass details
                passtype: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Pass Type must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Pass Type cannot be empty.'
                        }
                    }
                },
                passtypeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Pass Type must be less than 50 characters.'
                        }
                    }
                },
                passno: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Pass number must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Pass number cannot be empty.'
                        }
                    }
                },
                issuer: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Agency name must be less than 20 characters.'
                        }
                    }
                },
                remark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must be less than 200 characters.'
                        }
                    }
                },
                npasstype: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Pass Type must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Pass Type cannot be empty.'
                        }
                    }
                },
                npasstypeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Pass Type must be less than 50 characters.'
                        }
                    }
                },
                npassno: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Pass number must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'Pass number cannot be empty.'
                        }
                    }
                },
                nissuer: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Agency name must be less than 20 characters.'
                        }
                    }
                },
                nremark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must be less than 200 characters.'
                        }
                    }
                },
                //emp details
                name: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The name cannot be empty.'
                        }
                    }
                },
                empid: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Employer ID must be less than 50 characters.'
                        }
                    }
                },
                address: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Address must be less than 200 characters.'
                        }
                    }
                },
                contact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact details must be less than 200 characters.'
                        }
                    }
                },
                person: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Key person name must be less than 200 characters.'
                        }
                    }
                },
                nname: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The name cannot be empty.'
                        }
                    }
                },
                nempid: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Employer ID must be less than 50 characters.'
                        }
                    }
                },
                naddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must be less than 300 characters.'
                        }
                    }
                },
                ncontact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact details must be less than 200 characters.'
                        }
                    }
                },
                nperson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Key person name must be less than 200 characters.'
                        }
                    }
                },
                //employment contract
                contdate: {
                    validators: {
                        notEmpty: {
                            message: 'Contract date cannot be empty.'
                        }
                    }
                },
                location: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        }
                    }
                },
                language: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Language must be less than 20 characters.'
                        }
                    }
                },
                opname: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The name cannot be empty.'
                        }
                    }
                },
                relationship: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Relationship must be less than 200 characters.'
                        }
                    }
                },
                occupation: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'occupation must be less than 200 characters.'
                        }
                    }
                },
                salary: {
                    validators: {
                        numeric: {
                            message: 'Salary must be a number'
                        }
                    }
                },
                allowance: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Allowance Details must be less than 500 characters.'
                        }
                    }
                },
                deduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must be less than 500 characters.'
                        }
                    }
                },
                duration: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must be less than 500 characters.'
                        }
                    }
                },
                duress: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must be less than 500 characters.'
                        }
                    }
                },
                ncontdate: {
                    validators: {
                        notEmpty: {
                            message: 'Contract date cannot be empty.'
                        }
                    }
                },
                nlocation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        }
                    }
                },
                nlanguage: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Language must be less than 20 characters.'
                        }
                    }
                },
                nopname: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'The name cannot be empty.'
                        }
                    }
                },
                nrelationship: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Relationship must be less than 200 characters.'
                        }
                    }
                },
                noccupation: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'occupation must be less than 200 characters.'
                        }
                    }
                },
                nsalary: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Salary must be less than 50 characters.'
                        },
                        numeric: {
                            message: 'Salary must be a number'
                        }
                    }
                },
                nallowance: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Allowance Details must be less than 500 characters.'
                        }
                    }
                },
                ndeduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must be less than 500 characters.'
                        }
                    }
                },
                nduration: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must be less than 500 characters.'
                        }
                    }
                },
                nduress: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must be less than 500 characters.'
                        }
                    }
                },
                //agent
                company: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Company name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Company name cannot be empty.'
                        }
                    }
                },
                agperson: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Agent key person name must be less than 50 characters.'
                        }
                    }
                },
                aglocationMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Agent location must be less than 50 characters.'
                        }
                    }
                },
                amtowed: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                amtpaid: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                feeshared: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                feetraining: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Training expense details must be less than 50 characters.'
                        }
                    }
                },
                feeairfare: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Airfare fee must be less than 50 characters.'
                        }
                    }
                },
                feewhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                feewhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                feerepay: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Repayment plan must be less than 200 characters.'
                        }
                    }
                },
                emp: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Employer name must be less than 200 characters.'
                        }
                    }
                },
                agremark: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Employer name must be less than 1000 characters.'
                        }
                    }
                },
                ncompany: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Company name must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'Company name cannot be empty.'
                        }
                    }
                },
                nagperson: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Agent key person name must be less than 50 characters.'
                        }
                    }
                },
                naglocationMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Agent location must be less than 50 characters.'
                        }
                    }
                },
                namtowed: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                namtpaid: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nfeeshared: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nfeetraining: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Training expense details must be less than 50 characters.'
                        }
                    }
                },
                nfeeairfare: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Airfare fee must be less than 50 characters.'
                        }
                    }
                },
                nfeewhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nfeewhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nfeerepay: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Repayment plan must be less than 200 characters.'
                        }
                    }
                },
                nemp: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Employer name must be less than 200 characters.'
                        }
                    }
                },
                nagremark: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Remark must be less than 1000 characters.'
                        }
                    }
                },
                //verbal assurance
                vaWhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                vaWhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                vaContent: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Content must be less than 1000 characters.'
                        }
                    }
                },
                nvaWhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nvaWhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nvaContent: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Content must be less than 1000 characters.'
                        }
                    }
                },
                //workplace
                wpType: {
                    validators: {
                        notEmpty: {
                            message: 'Type cannot be empty.'
                        }
                    }
                },
                wpTypeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Type must be less than 200 characters.'
                        }
                    }
                },
                whose: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                personDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Key person details must be less than 200 characters.'
                        }
                    }
                },
                relation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                direct: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                directMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                start: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                end: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                condition: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Working conditions must be less than 500 characters.'
                        }
                    }
                },
                safety: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Safety issues must be less than 200 characters.'
                        }
                    }
                },
                nwpType: {
                    validators: {
                        notEmpty: {
                            message: 'Type cannot be empty.'
                        }
                    }
                },
                nwpTypeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Type must be less than 200 characters.'
                        }
                    }
                },
                nwhose: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                npersonDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Key person details must be less than 200 characters.'
                        }
                    }
                },
                nrelation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ndirect: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ndirectMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nstart: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nend: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ncondition: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Working conditions must be less than 500 characters.'
                        }
                    }
                },
                nsafety: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Safety issues must be less than 200 characters.'
                        }
                    }
                },
                //work history
                how: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                howMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                arrivalYear: {
                    validators: {
                        //gonna change it to year dropdown
                    }
                },
                prevJob: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                prevProb: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                nhow: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nhowMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                narrivalYear: {
                    validators: {
                        //gonna change it to year dropdown
                    }
                },
                nprevJob: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                nprevProb: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                //accommodation
                isProvided: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                isProvidedMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                typeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                accCharged: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                accPaid: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                meal: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                from: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                to: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nisProvided: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nisProvidedMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                ntype: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ntypeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                naccCharged: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                naccPaid: {
                    validators: {
                        numeric: {
                            message: 'Amount must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nmeal: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nfrom: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nto: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                //ipa
                workpassType: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                workpassTypeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                empName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        }
                    }
                },
                agentName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        }
                    }
                },
                industry: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Industry must be less than 20 characters.'
                        }
                    }
                },
                ipaoccupation: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Occupation must be less than 30 characters.'
                        }
                    }
                },
                periods: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Period of pass must be less than 20 characters.'
                        },
                        numeric: {
                            message: 'Period of pass must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                basicSalary: {
                    validators: {
                        numeric: {
                            message: 'Salary must be a number.'
                        }
                    }
                },
                totalAllowance: {
                    validators: {
                        numeric: {
                            message: 'Total allowance must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                allowanceDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                deducation: {
                    validators: {
                        numeric: {
                            message: 'Deducation must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                deducationDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nworkpassType: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nworkpassTypeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nempName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        }
                    }
                },
                nagentName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must be less than 50 characters.'
                        }
                    }
                },
                nindustry: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Industry must be less than 20 characters.'
                        }
                    }
                },
                nipaoccupation: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Occupation must be less than 30 characters.'
                        }
                    }
                },
                nperiods: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Period of pass must be less than 20 characters.'
                        },
                        numeric: {
                            message: 'Period of pass must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nbasicSalary: {
                    validators: {
                        numeric: {
                            message: 'Salary must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                ntotalAllowance: {
                    validators: {
                        numeric: {
                            message: 'Total allowance must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nallowanceDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                ndeducation: {
                    validators: {
                        numeric: {
                            message: 'Deducation must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                ndeducationDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                }
            }
        });

    });

    //problem form validation 
    $(document).ready(function() {
        $('.problem_pop_up')
                .bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                //injury
                date: {
                    validators: {
                        notEmpty: {
                            message: 'Date of injury cannot be empty.'
                        }
                    }
                },
                remark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must be less than 200 characters.'
                        }
                    }
                },
                ndate: {
                    validators: {
                        notEmpty: {
                            message: 'Date of injury cannot be empty.'
                        }
                    }
                },
                ntime: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'The Approx time must be less than 20 characters.'
                        }
                    }
                },
                nlocation: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Location must be less than 200 characters.'
                        }
                    }
                },
                nbodyPart: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Body part(s) must be less than 500 characters.'
                        }
                    }
                },
                nhow: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Body part(s) must be less than 1000 characters.'
                        }
                    }
                },
                ntreatment: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nremark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must be less than 200 characters.'
                        }
                    }
                },
                //illness
                startTime: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nstartTime: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ndiagnoseTime: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ndiagnosePerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Doctor/hospital must be less than 200 characters.'
                        }
                    }
                },
                nnature: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Nature of illness must be less than 200 characters.'
                        }
                    }
                },
                nworkRelatedYes: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Doctor/hospital must be less than 500 characters.'
                        }
                    }
                },
                //other case
                other: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                loss: {
                    validators: {
                        numeric: {
                            message: 'Salary must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }

                    }
                },
                nother: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nloss: {
                    validators: {
                        numeric: {
                            message: 'Salary must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //trafficking
                person: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                tipi81: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                tipi82: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                nperson: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                ntipi81: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                ntipi82: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                //salary claim
                basis: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                nbasis: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                //wica claim & non wica claim
                refNumber: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Reference number must be less than 30 characters.'
                        }
                    }
                },
                insurer: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Insurance company name must be less than 50 characters.'
                        }
                    }
                },
                policyNumber: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Insurance policy no must be less than 50 characters.'
                        }
                    }
                },
                reason: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nrefNumber: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Reference number must be less than 30 characters.'
                        }
                    }
                },
                ninsurer: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Insurance company name must be less than 50 characters.'
                        }
                    }
                },
                npolicyNumber: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Insurance policy no must be less than 50 characters.'
                        }
                    }
                },
                nreason: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                //police report
                npoliceReportStation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Police station name must be less than 50 characters.'
                        }
                    }
                },
                npoliceReportRefNumber: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Reference Number must be less than 30 characters.'
                        }
                    }
                },
                npoliceReportDetails: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                policeReportStation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Police station name must be less than 50 characters.'
                        }
                    }
                },
                policeReportRefNumber: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Reference Number must be less than 30 characters.'
                        }
                    }
                },
                policeReportDetails: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                //other complaint
                complaintAgency: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                complaintWho: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                compleintWhoMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                compaintModeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                complaintDetails: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                ncomplaintAgency: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ncomplaintWho: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ncompleintWhoMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ncompaintModeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                ncomplaintDetails: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                //case discussion
                discussionTime: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                discussionWhere: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                discussionWhereMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                discussionTWC2P1: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                discussionTWC2P2: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                discussionOtherPerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                discussionTranslator: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                discussionTopic: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                discussionGist: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                discussionAssist: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                discussionCal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                discussionAction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                ndiscussionTime: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                ndiscussionWhere: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ndiscussionWhereMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ndiscussionTWC2P1: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ndiscussionTWC2P2: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                ndiscussionOtherPerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                ndiscussionTranslator: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ndiscussionTopic: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ndiscussionGist: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                ndiscussionAssist: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                ndiscussionCal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                ndiscussionAction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                //hospital
                hospName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                hospNameMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                hospDoctor: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nhospName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nhospNameMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nhospDoctor: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                //mc
                mcStatus: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                mcStatusMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                expCum: {
                    validators: {
                        integer: {
                            message: 'This field must be a number.'
                        }
                    }
                },
                nmcStatus: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nmcStatusMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nexpCum: {
                    validators: {
                        integer: {
                            message: 'This field must be a number.'
                        }
                    }
                },
                //r2r
                r2rTime: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                r2rHosp: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                r2rDept: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                r2r1: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                r2r2: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                r2rPurpose: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                r2rPreApptNotes: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                r2rPostApptNotes: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                r2rFeedback: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                r2rMed: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                r2rOut: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nr2rTime: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                nr2rHosp: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nr2rDept: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nr2r1: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                nr2r2: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                nr2rPurpose: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nr2rPreApptNotes: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nr2rPostApptNotes: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nr2rFeedback: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nr2rMed: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nr2rOut: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number.'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //wica status
                wicaStatus: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                wicaStatusMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                wicaPoints: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                wicaDollars: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nwicaStatus: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nwicaStatusMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nwicaPoints: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nwicaDollars: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //lawyer
                lawyerFirm: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                lawyerFirmMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                lawyerName: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nlawyerFirm: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nlawyerFirmMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nlawyerName: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                //non criminal milestone
                nmilestoneNCReached: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nmilestoneNCReachedMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                milestoneNCReached: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                milestoneNCReachedMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                //criminal milestone
                nmilestoneCRReached: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nmilestoneCRReachedMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nmilestoneCRCharges: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nmilestoneCRSentence: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                milestoneCRReached: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                milestoneCRReachedMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                milestoneCRCharges: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                milestoneCRSentence: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                //ttr
                ttrStatus: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                ttrStatusMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                ttrDepartureDate: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ttrEmployerName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ttrJob: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nttrStatus: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nttrStatusMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                nttrDepartureDate: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nttrEmployerName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                nttrJob: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                //aggravating issues
                aggravissueType: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                aggravissueTypeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                aggravLoss: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                naggravissueType: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                naggravissueTypeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                naggravLoss: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //leadcase worker
                leadCaseWorkerName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nleadCaseWorkerName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                //auxiliary caseworker
                auxiliaryCaseWorkerName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nauxiliaryCaseWorkerName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                //salary related
                basisSal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                overtime: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                allowance: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                deduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                kickbacks: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                otherSal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                modeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                totalLoss: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                oneYearLoss: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nbasisSal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                novertime: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                nallowance: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                ndeduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                nkickbacks: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                notherSal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                nmodeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ntotalLoss: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                noneYearLoss: {
                    validators: {
                        numeric: {
                            message: 'This field must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                }
            }
        });

    });

    //date revalidation
    $('.dateInput').on('change', function() {
        $('.complement_detailed_form')
                .data('bootstrapValidator')             // Get the validator instance
                .revalidateField('date');                // Revalidate it

    });
    $('.dateInput').on('change', function() {
        $('.complement_detailed_form')
                .data('bootstrapValidator')             // Get the validator instance
                .revalidateField('ndate');                // Revalidate it

    });

    //explain if above is Other
    /**function displayOther(div_id) {
     var div = document.getElementById(div_id);
     
     if (document.getElementById(div_id).value == 'Other') {
     var other_div = div_id + "_other_div";
     //document.getElementById(other_div).style.display = 'block';
     $("#" + other_div).show();
     }else{
     var other_div = div_id + "_other_div";
     //document.getElementById(other_div).style.display = 'block';
     $("#" + other_div).hide();
     }
     };**/

    //hide the year dropdwon
    function hideOther(div_id) {
        var div = document.getElementById(div_id);

        if (document.getElementById(div_id).value === "Yes") {
            //alert("hello");
            var other_div = div_id + "_other_div";
            //alert(other_div);
            $("#" + other_div).toggle();
        } else {
            var other_div = div_id + "_other_div";
            $("#" + other_div).toggle();
        }
    }

    //year dropdown
    for (i = new Date().getFullYear(); i > 1900; i--)
    {
        $('#yearpicker').append($('<option />').val(i).html(i));
    }

</script>

<%
    String workerFin = request.getParameter("workerFin");   //passed from viewWorker.jsp
    String complement = request.getParameter("complement"); //passed from viewWorker.jsp
    String jobKey = request.getParameter("jobkey");         //passed from viewWorker.jsp
    String probKey = request.getParameter("problemKey");    //passed from viewWorker.jsp
%>


<!--- Worker Complements --->
<%
    if (complement.equals("nickname")) {
%>
<form method="POST" action="addWorkerComplement.do" id='nickname_pop_up' class="form complement_detailed_form worker_pop_up"  >
    <h4>Add A New Nickname </h4><br/>

    <div class='add_comp'>
        <div class='form-group '>
            <label for='nickName' class="control-label">Nickname<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control" type='text' name="nNickName" required>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="complementName" value="WorkerNickname"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>      
<%
} else if (complement.equals("passport")) {
%>
<form method="POST" id='passport_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Passport Details</h4>

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nPassportNum' class="control-label">Passport No<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nPassportNum" required>
            </div>
            <div class='form-group'>
                <label for='nPassportCountry' class="control-label">Passport Country<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nPassportCountry" required>
            </div>
            <div class='form-group'>
                <label for='nPassportIssueDate' class="control-label">Passport Issued Date: </label>
                <br/>
                <input class="form-control input-append date startDate" type='text' name="nPassportIssueDate" >
            </div>
            <div class='form-group'>
                <label for='nPassportExpiryDate' class="control-label">Passport Expiry Date: </label>
                <br/>
                <input class="form-control endDate" type='text' name="nPassportExpiryDate" >
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerPassportDetails"/>

        </div>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<%
} else if (complement.equals("sgphone")) {
%>
<form method="POST" id='sgphonenum_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Singapore Phone Number </h4>

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nPhNum' class="control-label">Phone No<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nPhNum" required>
            </div>

            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsolete Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate" >
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerSgPhNum"/>
        </div>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>
<%
} else if (complement.equals("homephone")) {
%>
<form method="POST" id='homephonenum_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Home Country Phone Number</h4>

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nPhNum' class="control-label">Phone No<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nPhNum" required>
            </div>
            <div class='form-group'>
                <label for='nPhOwner' class="control-label">Phone Owner: </label>
                <br/>
                <input class="form-control" type='text' name="nPhOwner" >
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsolete Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate" >
            </div>

            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerHomeCountryPhNum"/>
        </div>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>
<%
} else if (complement.equals("sgadd")) {
%>
<form method="POST" id='sgAdd_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Singapore Address </h4>

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nAddress' class="control-label">Address<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nAddress" required>
            </div>

            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsolete Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate" >
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerSgAddress"/>

        </div>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>
<%
} else if (complement.equals("homeadd")) {
%>
<form method="POST" id='homeAdd_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Home Country Address </h4>

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nAddress' class="control-label">Address<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nAddress" required>
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsolete Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate" >
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerHomeCountryAddress"/>
        </div>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>
<%
} else if (complement.equals("digcontact")) {
    HashMap<Integer, String> digitalContactList = DropdownDAO.retrieveAllDropdownListOfDigitalContactType();
%>
<form method="POST" id='digi_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Digital Contact Details </h4>

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nDigitalContactType' class="control-label">Digital Type<span style="color: red">*</span>: </label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nDigitalContactType" required onchange="displayOther(this.id);">
                    <%
                        for (String contactType : digitalContactList.values()) {

                    %>
                    <option><%=contactType%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class="form-group" id="digitalContactType_other_div">
                <label for="nDigitalMore" class="col-md-3 control-label">Explain if above is 'Other'</label>
                <div class=" col-md-6">
                    <input type="text" id="digitalContactType_other_In" class="form-control" name="nDigitalMore"/></div>
            </div>
            <div class='form-group'>
                <label for='nDigitalDetails' class="control-label">Address<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nDigitalDetails">
            </div>
            <div class='form-group'>
                <label for='nDigitalOwner' class="control-label">Owner: </label>
                <br/>
                <input class="form-control" type='text' name="nDigitalOwner">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark: </label>
                <br/>
                <input class="form-control" type='text' name="nRemark">
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsoleted Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerDigitalContact"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%
} else if (complement.equals("nok")) {
%>
<form method="POST" id='nok_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Next Of Kin Details </h4>

    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nName' class="control-label">Name<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nName" required>
            </div>
            <div class='form-group'>
                <label for='nRelation' class="control-label">Relationship: </label>
                <br/>
                <input class="form-control" type='text' name="nRelation">
            </div>
            <div class='form-group'>
                <label for='nDocReference' class="control-label">Identity Docs/References: </label>
                <br/>
                <input class="form-control" type='text' name="nDocReference">
            </div>
            <div class='form-group'>
                <label for='nPhNum' class="control-label">Contact Number: </label>
                <br/>
                <input class="form-control" type='text' name="nPhNum">
            </div>
            <div class='form-group'>
                <label for='nDigitalContact' class="control-label">Other Contact Details: </label>
                <br/>
                <input class="form-control" type='text' name="nDigitalContact">
            </div>
            <div class='form-group'>
                <label for='nAddress' class="control-label">Address: </label>
                <br/>
                <input class="form-control" type='text' name="nAddress">
            </div>
            <div class='form-group'>
                <label for='nProofDoc' class="control-label">Attesting Docs: </label>
                <br/>
                <input class="form-control" type='text' name="nProofDoc">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark: </label>
                <br/>
                <input class="form-control" type='text' name="nRemark">
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsoleted Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerNextOfKin"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%
} else if (complement.equals("familymember")) {
%>
<form method="POST" id='fm_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Family Member </h4>

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nName' class="control-label">Name<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nName"required>
            </div>
            <div class='form-group'>
                <label for='nRelation' class="control-label">Relationship: </label>
                <br/>
                <input class="form-control" type='text' name="nRelation">
            </div>
            <div class='form-group'>
                <label for='nAddress' class="control-label">Address: </label>
                <br/>
                <input class="form-control" type='text' name="nAddress">
            </div>
            <div class='form-group'>
                <label for='nPhNum' class="control-label">Contact Number: </label>
                <br/>
                <input class="form-control" type='text' name="nPhNum">
            </div>
            <div class='form-group'>
                <label for='nDigitalContact' class="control-label">Other Contact Details: </label>
                <br/>
                <input class="form-control" type='text' name="nDigitalContact">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark: </label>
                <br/>
                <input class="form-control" type='text' name="nRemark">
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsoleted Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerFamilyMember"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%
} else if (complement.equals("sgfri")) {
%>
<form method="POST" id='sgFri_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up"  >
    <h4 class='add_comp'>Add A New Friend </h4>

    <div class='form-group'>



        <div class='add_comp'>
            <div class='form-group'>
                <label for='nName' class="control-label">Name<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nName" required>
            </div>
            <div class='form-group'>
                <label for='nRelation' class="control-label">Relationship: </label>
                <br/>
                <input class="form-control" type='text' name="nRelation">
            </div>

            <div class='form-group'>
                <label for='nPhNum' class="control-label">Contact Number: </label>
                <br/>
                <input class="form-control" type='text' name="nPhNum">
            </div>

            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark: </label>
                <br/>
                <input class="form-control" type='text' name="nRemark">
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsoleted Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerFriend"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%
} else if (complement.equals("language")) {
    HashMap<Integer, String> languageList = DropdownDAO.retrieveAllDropdownListOfLanguage();
    HashMap<Integer, String> spokenEnglishList = DropdownDAO.retrieveAllDropdownListOfSpokenEnglish();
%>
<form method="POST" id='language_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up"  >
    <h4 class='add_comp'>Add A New Language </h4>

    <div class='form-group'>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nMainLanguage' class="control-label">Main Language<span style="color: red">*</span>: </label>
                <br/>
                <select class="form-control" id="mainLang" name="nMainLanguage" onchange="displayOther(this.id);">
                    <%
                        for (String languageType : languageList.values()) {
                    %>
                    <option><%=languageType%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class="form-group" id="mainLang_other_div" >
                <label for="nLanguageMore" class="col-md-3 control-label">Explain if above is 'Other'</label>
                <div class=" col-md-6">
                    <input type="text" id="digitalContactType_other_In" class="form-control" name="nLanguageMore"/></div>
            </div>
            <div class='form-group'>
                <label for='nEnglishStandard' class="control-label">English Standard<span style="color: red">*</span>: </label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nEnglishStandard">
                    <%
                        for (String engStd : spokenEnglishList.values()) {
                    %> 
                    <option><%=engStd%></option>
                    <%


                        }
                    %>  
                </select>
            </div>
            <div class='form-group'>
                <label for='fremark' class="control-label">Remark: </label>
                <br/>
                <input class="form-control" type='text' name="nremark" 
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerLanguage"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>

</div>
</form>

<%
} else if (complement.equals("bankacc")) {
%>

<form method="POST" id='bk_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <h4 class='add_comp'>Add A New Bank Account Details </h4>

    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nBankAcctName' class="control-label">Account Name<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nBankAcctName" required>
            </div>
            <div class='form-group'>
                <label for='nBankAcctNum' class="control-label">Account Number<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nBankAcctNum" required>
            </div>
            <div class='form-group'>
                <label for='nBankName' class="control-label">Bank Name<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="nBankName" required>
            </div>
            <div class='form-group'>
                <label for='nBankBranch' class="control-label">Bank Branch Name: </label>
                <br/>
                <input class="form-control" type='text' name="nBankBranch">
            </div>
            <div class='form-group'>
                <label for='nBankBranchCode' class="control-label">Bank Branch Code: </label>
                <br/>
                <input class="form-control" type='text' name="nBankBranchCode" >
            </div>
            <div class='form-group'>
                <label for='nBankBranchAddress' class="control-label">Bank Branch Address: </label>
                <br/>
                <input class="form-control" type='text' name="nBankBranchAddress">
            </div>
            <div class='form-group'>
                <label for='nBankSwift' class="control-label">Bank Swift: </label>
                <br/>
                <input class="form-control" type='text' name="nBankSwift">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark: </label>
                <br/>
                <input class="form-control" type='text' name="nRemark" >
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Obsoleted Date: </label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nObseleteDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="complementName" value="WorkerBankAcct"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>   
<!------------- Job Complements ---------------------------------------->            
<%
} else if (complement.equals("passdetails")) {
    HashMap<Integer, String> workpassTypes = DropdownDAO.retrieveAllDropdownListOfWorkpassType();
%>
<form method="POST" id='passdetails_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >
    <h4>Add A New Employment Pass Details </h4><br/>
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='npasstype' class="control-label">Pass Type<span style="color: red">*</span>:</label>
                <br/>
                <select class="form-control" id="passtype" name="npasstype" onchange="displayOther(this.id);">
                    <%
                        for (String workpassType : workpassTypes.values()) {
                    %>
                    <option><%=workpassType%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="passtype_other_div" >
                <label for='passtypeMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <input class="form-control" type='text' name="npasstypeMore">
            </div>
            <div class='form-group'>
                <label for='npassno' class="control-label">Pass No<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="npassno" >
            </div>
            <div class='form-group'>
                <label for='nissuer' class="control-label">Issuing Agency:</label>
                <br/>
                <input class="form-control" type='text' name="nissuer" >
            </div>
            <div class='form-group'>
                <label for='napdate' class="control-label">Application Date:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="napdate" >
            </div>
            <div class='form-group'>
                <label for='nisdate' class="control-label">Issued Date: </label>
                <br/>
                <input class="form-control startDate" type='text' name="nisdate" >
            </div>
            <div class='form-group'>
                <label for='nexdate' class="control-label">Expiry Date: </label>
                <br/>
                <input class="form-control endDate" type='text' name="nexdate" >
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nobsoleteDate' class="control-label">Date Discovered to be Obsolete: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="nobsoleteDate" >
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="JobPassDetails"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>
<%
} else if (complement.equals("empdetails")) {
%>
<form method="POST" id='empdetails_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >
    <h4>Add A New Employer </h4><br/>
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nname' class="control-label">Employer's Name<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nname" required>
            </div>
            <div class='form-group'>
                <label for='nperson' class="control-label">In-charge Person:</label>
                <br/>
                <input class="form-control" type='text' name="nperson">
            </div>
            <div class='form-group'>
                <label for='nempid' class="control-label">Employer's ID:</label>
                <br/>
                <input class="form-control" type='text' name="nempid">
            </div>
            <div class='form-group'>
                <label for='ncontact' class="control-label">Contact No:</label>
                <br/>
                <input class="form-control" type='text' name="ncontact">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Address: </label>
                <br/>
                <textarea class="form-control" name="naddress" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="EmployerDetails"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%
} else if (complement.equals("empcontract")) {
%>
<form method="POST" id='contract_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >
    <h4>Add A New Employment Contract Details </h4><br/>
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='ncontdate' class="control-label">Contract Date<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="ncontdate">
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Contract Location: </label>
                <br/>
                <input class="form-control" type='text' name="nlocation">
            </div>
            <div class='form-group'>
                <label for='nlanguage' class="control-label">Contract Language:</label>
                <br/>
                <input class="form-control" type='text' name="nlanguage">
            </div>
            <div class='form-group'>
                <label for='nopname' class="control-label">Opposite Party's Name<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nopname">
            </div>
            <div class='form-group'>
                <label for='noprelation' class="control-label">Relationship with Opposite Party:</label>
                <br/>
                <input class="form-control" type='text' name="noprelation">
            </div>
            <div class='form-group'>
                <label for='noccupation' class="control-label">Occupation: </label>
                <br/>
                <input class="form-control" type='text' name="noccupation">
            </div>
            <div class='form-group'>
                <label for='nsalary' class="control-label">Basic Salary: </label>
                <br/>
                <input class="form-control" type='text' name="nsalary">
            </div>
            <div class='form-group'>
                <label for='nallowance' class="control-label">Allowance Details: </label>
                <br/>
                <textarea class="form-control" name="nallowance" rows="3" maxlength="500"></textarea>
            </div>
            <div class='form-group'>
                <label for='ndeduction' class="control-label">Deduction: </label>
                <br/>
                <textarea class="form-control" name="ndeduction" rows="3" maxlength="500"></textarea>
            </div>
            <div class='form-group'>
                <label for='nduration' class="control-label">Contract Duration: </label>
                <br/>
                <input class="form-control" type='text' name="nduration">
            </div>
            <div class='form-group'>
                <label for='nduress' class="control-label">Describe if signed under duress or misrepresentation: </label>
                <br/>
                <textarea class="form-control" name="nduress" rows="3" maxlength="500"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="ContractDetails"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>
<%

} else if (complement.equals("agent")) {
    HashMap<Integer, String> agentLocations = DropdownDAO.retrieveAllDropdownListOfAgentLocationType();

%>
<form method="POST" id='agent_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >

    <h4>Add A New Intermediary Agent</h4><br/>
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='ncompany' class="control-label">Agent Company Name<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="ncompany" required>
            </div>
            <div class='form-group'>
                <label for='nperson' class="control-label">Agent Key Person Name:</label>
                <br/>
                <input class="form-control" type='text' name="nagperson">
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Location of Agent: </label>
                <br/>
                <select class="form-control" id="agentLocation" name="naglocation" onchange="displayOther(this.id);">
                    <%
                        for (String agentLocation : agentLocations.values()) {
                    %>
                    <option><%=agentLocation%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="agentLocation_other_div" >
                <label for='nhowMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <input class="form-control" type='text' name="naglocationMore">
            </div>
            <div class='form-group'>
                <label for='naddress' class="control-label">Agent Address: </label>
                <br/>
                <input class="form-control" type='text' name="naddress">
            </div>
            <div class='form-group'>
                <label for='ncontact' class="control-label">Agent Phone/Email Contact: </label>
                <br/>
                <input class="form-control" type='text' name="ncontact">
            </div>
            <div class='form-group'>
                <label for='namtowed' class="control-label">Amount Owed To This Agent:</label>
                <br/>
                <input class="form-control" type='text' name="namtowed">
            </div>
            <div class='form-group'>
                <label for='namtpaid' class="control-label">Amount Paid To This Agent:</label>
                <br/>
                <input class="form-control" type='text' name="namtpaid">
            </div>
            <div class='form-group'>
                <label for='nfeeshared' class="control-label">Any Suspicion Fee Shared With Others:</label>
                <br/>
                <input class="form-control" type='text' name="nfeeshared">
            </div>
            <div class='form-group'>
                <label for='nfeetraining' class="control-label" >Did fee includes training expenses? (Explain in Details) </label>
                <br/>
                <input class="form-control" type='text' name="nfeetraining">
            </div>
            <div class='form-group'>
                <label for='nfeeairfare' class="control-label">Did fee include airfare?: </label>
                <br/>
                <input class="form-control" type='text' name="nfeeairfare">
            </div>
            <div class='form-group'>
                <label for='nfeewhen' class="control-label">When agent fee paid: </label>
                <br/>
                <input class="form-control" type='text' name="nfeewhen">
            </div>
            <div class='form-group'>
                <label for='nfeewhere' class="control-label">Where agent fee paid: </label>
                <br/>
                <input class="form-control" type='text' name="nfeewhere">
            </div>
            <div class='form-group'>
                <label for='nfeerepay' class="control-label">Repayment Plan if fee owed: </label>
                <br/>
                <input class="form-control" type='text' name="nfeerepay">
            </div>
            <div class='form-group'>
                <label for='nemp' class="control-label">Employer that this Agent placed worker to: </label>
                <br/>
                <input class="form-control" type='text' name="nemp">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nagremark" rows="3" maxlength="1000"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="Agent"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<%
} else if (complement.equals("assurance")) {
%>
<form method="POST" id='assurance_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >

    <h4>Add A New Verbal Assurance </h4><br/>

    <div class='form-group'>



        <div class='add_comp'>
            <div class='form-group'>
                <label for='nname' class="control-label">Name of giver of verbal assurances<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nname" required>
            </div>
            <div class='form-group'>
                <label for='nrelationship' class="control-label">Relationship of giver to worker or agent or employer:</label>
                <br/>
                <input class="form-control" type='text' name="nrelation">
            </div>
            <div class='form-group'>
                <label for='nvaWhen' class="control-label">When was Verbal Assurance Given?: </label>
                <br/>
                <input class="form-control" type='text' name="nvaWhen">
            </div>
            <div class='form-group'>
                <label for='nvaWhere' class="control-label">Where was Verbal Assurance Given?: </label>
                <br/>
                <input class="form-control" type='text' name="nvaWhere">
            </div>
            <div class='form-group'>
                <label for='nvaContent' class="control-label">Content of Verbal Assurance: </label>
                <br/>
                <textarea class="form-control" name="nvaContent" rows="3" maxlength="1000"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="VerbalAssurance"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<%
} else if (complement.equals("wplace")) {
    HashMap<Integer, String> workplaceTypes = DropdownDAO.retrieveAllDropdownListOfWorkplaceType();
    HashMap<Integer, String> workplacedirects = DropdownDAO.retrieveAllDropdownListOfWorkplaceDirectType();

%>

<form method="POST" id='workplace_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >

    <h4>Add A New Workplace </h4><br/>

    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <!--this thing will become dropdown-->
                <label for='nwpType' class="control-label">Workplace Type<span style="color: red">*</span>:</label>
                <br/>
                <select class="form-control" id="workplaceType" name="nwpType" onchange="displayOther(this.id);">
                    <%
                        for (String type : workplaceTypes.values()) {
                    %>
                    <option><%=type%></option>
                    <%

                        }
                    %>  
                </select>
                <div class='form-group' id="wrokplaceType_other_div" >
                    <label for='nwpTypeMore' class="control-label">Explain if above is 'Other': </label>
                    <br/>
                    <input class="form-control" type='text' name="nwpTypeMore">
                </div>
            </div>
            <!--where is other???-->
            <div class='form-group'>
                <label for='nwhose' class="control-label">Is workplace controlled by employer stated on workpass? If not, who?:</label>
                <br/>
                <input class="form-control" type='text' name="nwhose" >
            </div>
            <div class='form-group'>
                <label for='npersonDetails' class="control-label">Key Person & Contact Details: </label>
                <br/>
                <input class="form-control" type='text' name="npersonDetails" >
            </div>
            <div class='form-group'>
                <label for='nrelationship' class="control-label">Relationship of workplace to employer: </label>
                <br/>
                <input class="form-control" type='text' name="nrelation" >
            </div>
            <div class='form-group'>
                <label for='ndirect' class="control-label">Who directed worker to this workplace?<span style="color: red">*</span>: </label>
                <br/>
                <select class="form-control" id="direct" name="ndirect" onchange="displayOther(this.id);">
                    <%
                        for (String workplacedirect : workplacedirects.values()) {
                    %>
                    <option><%=workplacedirect%></option>
                    <%

                        }
                    %>  
                </select>

            </div>
            <div class='form-group' id="direct_other_div" >
                <label for='ndirectMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="ndirectMore" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nstart' class="control-label">Start Date At this Workplace: </label>
                <br/>
                <input class="form-control" type='text' name="nstart" >
            </div>
            <div class='form-group'>
                <label for='nend' class="control-label">End Date At this Workplace: </label>
                <br/>
                <input class="form-control" type='text' name="nend" >
            </div>
            <div class='form-group'>
                <label for='ncondition' class="control-label">Working Conditions at the Workplace: </label>
                <br/>
                <textarea class="form-control" name="ncondition" rows="3" maxlength="500"></textarea>
            </div>
            <div class='form-group'>
                <label for='nsafety' class="control-label">Safety Issues At this Workplace: </label>
                <br/>
                <textarea class="form-control" name="nsafety" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="WorkPlace"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>
<%
} else if (complement.equals("whistory")) {
    HashMap<Integer, String> workhist = DropdownDAO.retrieveAllDropdownListOfWorkHistoryHowType();
%>
<form method="POST" id='workhistory_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up" >

    <h4>Add A New Work History </h4><br/>
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nhow' class="control-label">How did worker get into job defined in Job Profile?<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="workhistHow" name="nhow" onchange="displayOther(this.id);">
                    <%
                        for (String type : workhist.values()) {
                    %>
                    <option><%=type%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="workhistHow_other_div" >
                <label for='nhowMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="nhowMore" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='narrivalDate' class="control-label">Date arrived Singapore for this job:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="narrivalDate" >
            </div>
            <div class='form-group'>
                <label for='nisFirstJob' class="control-label">Is this first job in Singapore? </label>
                <br/>
                <select class="form-control" id="nisFirstJob" name="nisFirstJob" onchange="hideOther(this.id);">

                    <option selected>No</option>

                    <option>Yes</option>

                </select>

            </div>
            <!--like other option-->
            <div class='form-group' id="nisFirstJob_other_div">
                <label for='narrivalYear' class="control-label">If not, year in which worker arrived in Singapore for first job</label>
                <br/>
                <select class="form-control" name="narrivalYear" id="yearpicker"></select>
            </div>

            <div class='form-group'>
                <label for='nprevJob' class="control-label">Describe previous jobs and home breaks </label>
                <br/>
                <textarea class="form-control" name="nprevJob" rows="3" maxlength="1000"></textarea>
            </div>
            <div class='form-group'>
                <label for='nprevProb' class="control-label">Describe problems in previous jobs</label>
                <br/>
                <textarea class="form-control" name="nprevProb" rows="3" maxlength="1000"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="WorkHistory"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<%
} else if (complement.equals("waccom")) {
    HashMap<Integer, String> accomTypes = DropdownDAO.retrieveAllDropdownListOfAccomType();
    HashMap<Integer, String> accomProvideds = DropdownDAO.retrieveAllDropdownListOfAccomProvidedType();

%>

<form method="POST" id='accomodation_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >

    <h4>Add A New Accommodation </h4><br/>
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nisProvided' class="control-label">Accommodation provided by employer?<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="accomProvided" name="nisProvided"  onchange="displayOther(this.id);">
                    <%
                        for (String accomProvided : accomProvideds.values()) {
                    %>
                    <option><%=accomProvided%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class='form-group' id="accomProvided_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="nisProvidedMore" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='ntype' class="control-label">Type of Accommodation:</label>
                <br/>

                <select class="form-control" id="accomType" name="ntype"  onchange="displayOther(this.id);">
                    <%
                        for (String accomtype : accomTypes.values()) {
                    %>
                    <option><%=accomtype%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="accomtype_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="ntypeMore" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Location of Accommodation: </label>
                <br/>
                <textarea class="form-control" name="nlocation" rows="3" maxlength="200"></textarea>
            </div>

            <div class='form-group'>
                <label for='ncondition' class="control-label">Conditions at living quarters:</label>
                <br/>
                <textarea class="form-control" name="ncondition" rows="3" maxlength="500"></textarea>
            </div>

            <div class='form-group'>
                <label for='naccCharged' class="control-label">Cost charged by employer per month S$</label>
                <br/>
                <input class="form-control" type='text' name="naccCharged">
            </div>
            <div class='form-group'>
                <label for='naccPaid' class="control-label">Cost paid by self per month S$</label>
                <br/>

                <input class="form-control" type='text' name="naccPaid">
            </div>
            <div class='form-group'>
                <label for='nmeal' class="control-label">Meal arrangements</label>
                <br/>
                <textarea class="form-control" name="nmeal" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nfrom' class="control-label">Staying at this accommodation from</label>
                <br/>
                <input class="form-control" type='text' name="nfrom">
            </div>
            <div class='form-group'>
                <label for='nto' class="control-label">Staying at this accommodation to</label>
                <br/>
                <input class="form-control" type='text' name="nto">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="Accommodation"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>
<%
} else if (complement.equals("ipa")) {
    HashMap<Integer, String> ipatypes = DropdownDAO.retrieveAllDropdownListOfIPAPassType();
%>

<form method="POST" id='ipa_pop_up' action="addJobComplement.do" 
      class="form complement_detailed_form job_pop_up"  >

    <h4>Add A New IPA Details </h4><br/>
    <div class='form-group'>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nworkpassType' class="control-label">Workpass specified in IPA<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="ipapassType" name="nworkpassType" onchange="displayOther(this.id);">
                    <%
                        for (String ipatype : ipatypes.values()) {
                    %>
                    <option><%=ipatype%></option>
                    <%

                        }
                    %>  
                </select>

            </div>

            <div class='form-group' id='ipapassType_other_div' >
                <label for='nworkpassTypeMore' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="nworkpassTypeMore">
            </div>
            <div class='form-group'>
                <label for='nappDate' class="control-label">IPA application date:</label>
                <br/>
                <input class="form-control dateInput input-append date dateInput" type='text' name="nappDate">
            </div>
            <div class='form-group'>
                <label for='nempName' class="control-label">Employer Name: </label>
                <br/>
                <input class="form-control" type='text' name="nempName">
            </div>

            <div class='form-group'>
                <label for='nagentName' class="control-label">Agent Name:</label>
                <br/>
                <input class="form-control" type='text' name="nagentName">
            </div>

            <div class='form-group'>
                <label for='nindustry' class="control-label">Industry</label>
                <br/>
                <input class="form-control" type='text' name="nindustry">
            </div>
            <div class='form-group'>
                <label for='nipaoccupation' class="control-label">Occupation</label>
                <br/>
                <input class="form-control" type='text' name="nipaoccupation">
            </div>
            <div class='form-group'>
                <label for='nperiods' class="control-label">IPA Period of Pass(Year)</label>
                <br/>
                <input class="form-control" type='text' name="nperiods">
            </div>
            <div class='form-group'>
                <label for='nbasicSalary' class="control-label">Basic Monthly Salary (S$):</label>
                <br/>
                <input class="form-control" type='text' name="nbasicSalary">
            </div>
            <div class='form-group'>
                <label for='ntotalAllowance' class="control-label">Total Allowance(S$):</label>
                <br/>
                <input class="form-control" type='text' name="ntotalAllowance">
            </div>
            <div class='form-group'>
                <label for='nallowanceDetails' class="control-label">Allowance Details:</label>
                <br/>
                <input class="form-control" type='text' name="nallowanceDetails">
            </div>
            <div class='form-group'>
                <label for='ndeduction' class="control-label">Total Deduction(S$):</label>
                <br/>
                <input class="form-control" type='text' name="ndeduction">
            </div>
            <div class='form-group'>
                <label for='ndeductionDetails' class="control-label">Deduction Details:</label>
                <br/>
                <input class="form-control" type='text' name="ndeductionDetails">
            </div>
            <div class='form-group'>
                <label for='nisHousingProvided' class="control-label">Housing Provided?</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nisHousingProvided">

                    <option selected>No</option>

                    <option>Yes</option>

                </select>

            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <input class="form-control" type='text' name="nremark">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="complementName" value="IPA"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>
<!------------- Problem Complements ---------------------------------------->  
<%
} else if (complement.equals("policareport")) {
    HashMap<Integer, String> complaintWho = DropdownDAO.retrieveAllDropdownListOfComplaint();
    HashMap<Integer, String> complaintMode = DropdownDAO.retrieveAllDropdownListOfComplaintMode();
%>
<form method="POST" id='policareport_pop_up' action="addProblemComplement.do" class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Police Report Record </h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group '>
            <label for='date' class="control-label">Date police report made<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" >
        </div>
        <div class='form-group '>
            <label for='date' class="control-label">Police station where report lodged: </label>
            <br/>
            <input class="form-control" type='text' name="npoliceReportStation" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Accompanyign TWC2 person: </label>
            <br/>
            <input class="form-control" type='text' name="nperson" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Details of police report: </label>
            <br/>
            <input class="form-control" type='text' name="npoliceReportRefNumber" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Details of police report: </label>
            <br/>
            <textarea class="form-control" name="npoliceReportDetails" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remark: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="policareport"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>
<%
} else if (complement.equals("othercomplaint")) {
    HashMap<Integer, String> complaintWho = DropdownDAO.retrieveAllDropdownListOfComplaint();
    HashMap<Integer, String> complaintMode = DropdownDAO.retrieveAllDropdownListOfComplaintMode();
%>
<form method="POST" id='othercomplaint_pop_up' action="addProblemComplement.do"  
      class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Other Complaint Record</h4>
    <!--add-->
    <div class='add_comp'>
        <div class='form-group '>
            <label for='date' class="control-label">Date other complaint lodged<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput input-append date dateInput" type='text' name="ndate" >
        </div>
        <div class='form-group '>
            <label for='date' class="control-label">Agency/authority to whom complaint addressed<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control" type='text' name="ncomplaintAgency" >
        </div>
        <div class='form-group'>
            <label for='complaintWho' class="control-label">This complaint is lodged by<span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="complaintWho" name="ncomplaintWho">
                <%
                    for (String complaintType : complaintWho.values()) {
                %>
                <option><%=complaintType%></option>
                <%}%>  
            </select>
        </div>

        <div class='form-group' id="complaintWho_other_div" >
            <label for='location' class="control-label">If TWC2 or third party, name of person lodging complaint: </label>
            <br/>
            <input class="form-control" type='text' name="ncomplaintWhoMore">
        </div>
        <div class='form-group'>
            <label for='complaintMode' class="control-label">Mode of lodging complaint:</label>
            <br/>
            <select class="form-control" id="complaintMode" name="ncomplaintMode" onchange="displayOther(this.id);">
                <%
                    for (String complaintM : complaintMode.values()) {
                %>
                <option><%=complaintM%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="complaintMode_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="ncomplaintModeMore">
        </div>
        <div class='form-group '>
            <label for='date' class="control-label">Details of complaint lodged: </label>
            <br/>
            <textarea class="form-control" name="ncomplaintDetails" rows="3"></textarea>
        </div>
        <div class='form-group '>
            <label for='date' class="control-label">Remark: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="othercomplaint"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>
<%
} else if (complement.equals("ttr")) {
    HashMap<Integer, String> ttrList = DropdownDAO.retrieveAllDropdownListOfTTRStatus();
%>
<form method="POST" id='ttr_pop_up' action="addProblemComplement.do"  class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add A New Transfer, TJS & Repatriation Record </h4>
    <!--Problem add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='ttrUpdate' class="control-label">Date of Update: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate">
        </div>
        <div class='form-group'>
            <label for='nttrStatus' class="control-label">Transfer, TJS or Repatriation Status<span style="color: red">*</span>:</label>
            <br/>
            <select class="form-control" id="ttrStatus" name="nttrStatus" onchange="displayOther(this.id);">
                <%
                    for (String tempStatus : ttrList.values()) {
                %>
                <option><%=tempStatus%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="ttrStatus_other_div" >
            <label for='nttrStatusMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="nttrStatusMore">
        </div>
        <div class='form-group'>
            <label for='ttrDepartureDate' class="control-label">Date of Departure from Singapore: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="nttrDepartureDate">
        </div>
        <div class='form-group'>
            <label for='ttrEmployerName' class="control-label">Name of TJS or New Employer: </label>
            <br/>
            <input class="form-control" type='text' name="nttrEmployerName">
        </div>
        <div class='form-group'>
            <label for='ttrJob' class="control-label">Description of TJS or New Job : </label>
            <br/>
            <textarea class="form-control" name="nttrJob" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='nremark' class="control-label">Remark re Transfer, TJS or Repatriation: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="ttr"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form> 
<%} else if (complement.equals("cmilestone")) {
    HashMap<Integer, String> crList = DropdownDAO.retrieveAllDropdownListOfMilestoneCriminal();
%>
<form method="POST" action="addProblemComplement.do"  id='milestonecr_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Case Milestone Reached(Criminal) </h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='nmilestoneCRDate' class="control-label">Date Milestone Reached: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate">
        </div>
        <div class='form-group'>
            <label for='nmilestoneCRReached' class="control-label">Miestone Reached: <span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="ncReached" name="nmilestoneCRReached">
                <%
                    for (String reached : crList.values()) {
                %>
                <option><%=reached%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="ncReached_other_div" >
            <label for='nmilestoneCRReachedMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="nmilestoneCRReachedMore">
        </div>
        <div class='form-group'>
            <label for='milestoneCRCharges' class="control-label">Details of Charges: </label>
            <br/>
            <textarea class="form-control" name="nmilestoneCRCharges" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRSentence' class="control-label">Details of Sentence: </label>
            <br/>
            <textarea class="form-control" name="nmilestoneCRSentence" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='remark' class="control-label">Remark re Milestone Reached: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="cmilestone"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>
<%} else if (complement.equals("ncmilestone")) {
    HashMap<Integer, String> ncList = DropdownDAO.retrieveAllDropdownListOfMilestoneNonCriminal();
%>
<form method="POST" action="addProblemComplement.do"  id='milestonenc_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Case Milestone Reached(non-criminal) </h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='milestoneNCDate' class="control-label">Date Milestone Reached: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput input-append date dateInput" type='text' name="ndate">
        </div>
        <div class='form-group'>
            <label for='nmilestoneNCReached' class="control-label">Milestone Reached: <span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="ncReached" name="nmilestoneNCReached" onchange="displayOther(this.id);">
                <%
                    for (String reached : ncList.values()) {
                %>
                <option><%=reached%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="ncReached_other_div" >
            <label for='nmilestoneNCReachedMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="nmilestoneNCReachedMore">
        </div>
        <div class='form-group'>
            <label for='milestoneNCRem' class="control-label">Remark re Milestone Reached: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="ncmilestone"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form>
<%} else if (complement.equals("trafficking")) {
%>
<form method="POST" action="addProblemComplement.do"  id='trafficking_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add Trafficking Indicators </h4>
    <div class='form-group'>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label">Date of assessment<span style="color: red">*</span></label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate">
            </div>
            <div class='form-group'>
                <label for='nperson' class="control-label">Person Making this assessment</label>
                <br/>
                <input class="form-control" type='text' name="nperson">
            </div>
            <div class='form-group'>
                <lable for='ntipi21' class='control-label'>Feel unable to negotiate terms of contract/employment</lable>
                <br/>
                <select class="form-control" id="ntipi21" name="ntipi21">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi22' class='control-label'>Received little or no payment though entitled</lable>
                <br/>
                <select class="form-control" id="ntipi22" name="ntipi22">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi23' class='control-label'>Deductions not pre-agreed</lable>
                <br/>
                <select class="form-control" id="ntipi23" name="ntipi23">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi24' class='control-label'>No access to earnings</lable>
                <br/>
                <select class="form-control" id="ntipi24" name="ntipi24">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi25' class='control-label'>Excessively long hours over long periods</lable>
                <br/>
                <select class="form-control" id="ntipi25" name="ntipi25">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi26' class='control-label'>No days off</lable>
                <br/>
                <select class="form-control" id="ntipi26" name="ntipi26">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi27' class='control-label'>Lack protective equipment though work conditions call for them</lable>
                <br/>
                <select class="form-control" id="ntipi27" name="ntipi27">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi28' class='control-label'>Disciplined through fines</lable>
                <br/>
                <select class="form-control" id="ntipi28" name="ntipi28">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi41' class='control-label'>Movement restricted or under surveillance</lable>
                <br/>
                <select class="form-control" id="ntipi41" name="ntipi41">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi42' class='control-label'>Communication restricted or under surveillance</lable>
                <br/>
                <select class="form-control" id="ntipi42" name="ntipi42">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi43' class='control-label'>Threat of violence against worker or family</lable>
                <br/>
                <select class="form-control" id="ntipi43" name="ntipi43">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi44' class='control-label'>Threat of trouble with authorities</lable>
                <br/>
                <select class="form-control" id="ntipi44" name="ntipi44">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi45' class='control-label'>Seizure/retention of personal identity documents</lable>
                <br/>
                <select class="form-control" id="ntipi45" name="ntipi45">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi46' class='control-label'>Poor/substandard accommodation, no option to leave</lable>
                <br/>
                <select class="form-control" id="ntipi46" name="ntipi46">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi47' class='control-label'>No access to medical care</lable>
                <br/>
                <select class="form-control" id="ntipi47" name="ntipi47">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi48' class='control-label'>No privacy</lable>
                <br/>
                <select class="form-control" id="ntipi48" name="ntipi48">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi49' class='control-label'>Feel victimised by misrepresentation</lable>
                <br/>
                <select class="form-control" id="ntipi49" name="ntipi49">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi50' class='control-label'>Feel loss of autonomy through debt or heavy sunk cost</lable>
                <br/>
                <select class="form-control" id="ntipi50" name="ntipi50">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi51' class='control-label'>Subject to insults, abuse, violence</lable>
                <br/>
                <select class="form-control" id="ntipi51" name="ntipi51">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi61' class='control-label'>Found in location associated with confinement/exploitation</lable>
                <br/>
                <select class="form-control" id="ntipi61" name="ntipi61">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi62' class='control-label'>Allow others to speak for them when addressed directly</lable>
                <br/>
                <select class="form-control" id="ntipi62" name="ntipi62">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi63' class='control-label'>Act as if instructed by someone else</lable>
                <br/>
                <select class="form-control" id="ntipi63" name="ntipi63">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi64' class='control-label'>Escorted wherever they go</lable>
                <br/>
                <select class="form-control" id="ntipi64" name="ntipi64">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi65' class='control-label'>Unable to show personal identity documents</lable>
                <br/>
                <select class="form-control" id="ntipi65" name="ntipi65">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi66' class='control-label'>Have association with, or clothes of a kind associated with sex work</lable>
                <br/>
                <select class="form-control" id="ntipi66" name="ntipi66">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi67' class='control-label'>Have injuries that appear to be associated with assault or application of control measures</lable>
                <br/>
                <select class="form-control" id="ntipi67" name="ntipi67">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                </select>
            </div>

            <div class='form-group'>
                <label for='ntipi81' class='control-label'>Describe other indicators of trafficking complained of</label>
                <br/>
                <textarea class="form-control" name="ntipi81" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='ntipi82' class='control-label'>Describe other indicators of trafficking observed</label>
                <br/>
                <textarea class="form-control" name="ntipi82" rows="3"></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="trafficking"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<%} else if (complement.equals("r2r")) {
%>
<form method="POST" action="addProblemComplement.do"  id='r2r_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New R2R Record </h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='r2rDate' class="control-label">Date of Appointment: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" >
        </div>
        <div class='form-group'>
            <label for='r2rTime' class="control-label">Time of Appointment: </label>
            <br/>
            <input class="form-control" type='text' name="nr2rTime">
        </div>
        <div class='form-group'>
            <label for='r2rHosp' class="control-label">Hospital for appointment: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control" type='text' name="nr2rHosp">
        </div>
        <div class='form-group'>
            <label for='r2rDept' class="control-label">Department/doctor for appointment: </label>
            <br/>
            <input class="form-control" type='text' name="nr2rDept">
        </div>
        <div class='form-group'>
            <label for='r2r1' class="control-label">R2R First Volunteer: </label>
            <br/>
            <input class="form-control" type='text' name="nr2r1">
        </div>
        <div class='form-group'>
            <label for='r2r2' class="control-label">R2R Second Volunteer: </label>
            <br/>
            <input class="form-control" type='text' name="nr2r2">
        </div>
        <div class='form-group'>
            <label for='r2rPurpose' class="control-label">Purpose of appointment: </label>
            <br/>
            <input class="form-control" type='text' name="nr2rPurpose">
        </div>
        <div class='form-group'>
            <label for='r2rPreApptNotes' class="control-label">Pre-appointment Notes: </label>
            <br/>
            <textarea class="form-control" name="nr2rPreApptNotes" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rPostApptNotes' class="control-label">Post-appointment Notes: </label>
            <br/>
            <textarea class="form-control" name="nr2rPostApptNotes" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rFeedback' class="control-label">Feedback: </label>
            <br/>
            <textarea class="form-control" name="r2rFeedback" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rMed' class="control-label">Medical Cost of this appt: </label>
            <br/>
            <input class="form-control" type='text' name="nr2rMed">
        </div>
        <div class='form-group'>
            <label for='r2rOut' class="control-label">How much paid by volunteer: </label>
            <br/>
            <input class="form-control" type='text' name="nr2rOut">
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="r2r"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form>
<%} else if (complement.equals("mc")) {
    HashMap<Integer, String> statusList = DropdownDAO.retrieveAllDropdownListOfMCStatus();
%>
<form method="POST" action="addProblemComplement.do"  id='mc_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New MC/Light Duty Record </h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Enter New Date: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput input-append date dateInput" type='text' name="ndate" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Enter Status<span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="nmcStatus" name="nmcStatus">
                <%
                    for (String statusObj : statusList.values()) {
                %>
                <option><%=statusObj%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group'>
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="nmcStatusMore">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">MC Expiry Date: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="nexpDate">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Cumulative MC Days: </label>
            <input class="form-control" type='text' name="nexpCum">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remark: </label>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="mc"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</div>



</form>
<%} else if (complement.equals("hospital")) {
    HashMap<Integer, String> names = DropdownDAO.retrieveAllDropdownListOfHosipital();
%>

<form method="POST"  action="addProblemComplement.do"  id='hospital_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Hospital Record</h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Date of update<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput input-append date dateInput" type='text' name="ndate" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Hospital Name<span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="nhospName" name="nhospName" onchange="displayOther(this.id);">
                <%
                    for (String name : names.values()) {
                %>
                <option><%=name%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="nhospName_other_div" >
            <label for='nhospNameMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="nhospNameMore">
        </div>
        <div class='form-group'>
            <label for='nhospDoctor' class="control-label">Department/doctor within hospital if known: </label>
            <br/>
            <input class="form-control" type='text' name="nhospDoctor">
        </div>
        <div class='form-group'>
            <label for='nremark' class="control-label">Remark: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="hospital"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</div>


</form>

<%} else if (complement.equals("nonwicaclaim")) {
%>
<form method="POST"  action="addProblemComplement.do"  id='nonwicaclaim_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add Non-Wica Claim Details</h4>
    <div class='form-group'>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label">Date MOM notified<span style="color: red">*</span></label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate">
            </div>

            <div class='form-group'>
                <label for='nloss' class="control-label">Initial value of claim S$</label>
                <br/>
                <input class="form-control" type='text' name="nloss">
            </div>
            <div class='form-group'>
                <label for='ninsurer' class="control-label">Insurance company</label>
                <br/>
                <input class="form-control" type='text' name="ninsurer">
            </div>
            <div class='form-group'>
                <label for='npolicyNumber' class="control-label">Insurance policy number</label>
                <br/>
                <input class="form-control" type='text' name="npolicyNumber">
            </div>
            <div class='form-group'>
                <label for='nbasis' class="control-label">Describe basis for amount claimed</label>
                <br/>
                <textarea class="form-control" name="nbasis" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="nonwicaclaim"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("wica")) {
    HashMap<Integer, String> wicaList = DropdownDAO.retrieveAllDropdownListOfWica();
%>

<form method="POST"  action="addProblemComplement.do"  id='wica_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New WICA Monthly Status</h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='nwicaUpdate' class="control-label">Date of Update<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate">
        </div>
        <div class='form-group'>
            <label for='nwicaStatus' class="control-label">Wika Status <span style="color: red">*</span>:</label>
            <br/>
            <select class="form-control" id="nwicaStatus" name="nwicaStatus" onchange="displayOther(this.id);">
                <%
                    for (String tempStatus : wicaList.values()) {
                %>
                <option><%=tempStatus%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="wicaStatus_other_div" >
            <label for='nwicaStatusMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <textarea class="form-control" name="nwicaStatusMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='nwicaPoints' class="control-label">Wika Points: </label>
            <br/>
            <input class="form-control" type='text' name="nwicaPoints">
        </div>
        <div class='form-group'>
            <label for='nwicaDollars' class="control-label">Wika S$ Compensation: </label>
            <br/>
            <input class="form-control" type='text' name="nwicaDollars">
        </div>
        <div class='form-group'>
            <label for='nwicaRemarks' class="control-label">Remarks re Wika Status : </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="wica"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form>
<%} else if (complement.equals("wicaclaim")) {
%>
<form method="POST" action="addProblemComplement.do"  id='wicaclaim_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add Wica Claim Details</h4>
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label">Date claim lodged at MOM<span style="color: red">*</span></label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate">
            </div>

            <div class='form-group'>
                <label for='nrefNumber' class="control-label">Reference number</label>
                <br/>
                <input class="form-control" type='text' name="nrefNumber">
            </div>
            <div class='form-group'>
                <label for='ninsurer' class="control-label">Insurance company</label>
                <br/>
                <input class="form-control" type='text' name="ninsurer">
            </div>
            <div class='form-group'>
                <label for='npolicyNumber' class="control-label">Insurance policy number</label>
                <br/>
                <input class="form-control" type='text' name="npolicyNumber">
            </div>
            <div class='form-group'>
                <label for='nreason' class="control-label">State whether this claim is for compensation, MC wages, expense reimbursement, etc</label>
                <br/>
                <textarea class="form-control" name="nreason" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="wicaclaim"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("illnesscase")) {
%>
<form method="POST" action="addProblemComplement.do"  id='illnesscase_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add A Illness History Accommodation </h4>
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nstartTime' class="control-label">Illness Start Time<span style="color: red">*</span></label>
                <br/>
                <input class="form-control" type='text' name="nstartTime">
            </div>

            <div class='form-group'>
                <label for='ndiagnoseTime' class="control-label">Illness diagnosed time</label>
                <br/>
                <input class="form-control" type='text' name="ndiagnoseTime">
            </div>
            <div class='form-group'>
                <label for='ndiagnosePerson' class="control-label">Illness Diagnosed Person</label>
                <br/>
                <input class="form-control" type='text' name="ndiagnosePerson">
            </div>
            <div class='form-group'>
                <label for='nnature' class="control-label">Nature of illness</label>
                <br/>
                <input class="form-control" type='text' name="nnature">
            </div>

            <div class='form-group'>
                <lable for='nworkRelated' class='control-label'>Does worker consider illness work-related?</lable>
                <br/>
                <select class="form-control" id="workRelated" name="nworkRelated">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Don't know</option>
                </select>
            </div>
            <div class='form-group' id='workRelatedYes_div' style="display: none">
                <label for='nworkRelatedYes' class='control-label'>If worker thinks work-related, why?</label>
                <br/>
                <textarea class="form-control" name="nworkRelatedYes" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="illnesscase"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("injurycase")) {
%>
<form method="POST" action="addProblemComplement.do"  id='injurycase_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add A Injury History Accommodation </h4>
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label">Date of injury<span style="color: red">*</span></label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate" >
            </div>
            <div class='form-group'>
                <label for='ntime' class="control-label">Approximate time of injury </label>
                <br/>
                <input class="form-control" type='text' name="ntime">
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Location of incident</label>
                <br/>
                <input class="form-control" type='text' name="nlocation">
            </div>
            <div class='form-group'>
                <label for='ndeath' class="control-label">Did death ensue?</label>
                <br/>
                <select class="form-control" id="injuryDeath" name="ndeath">
                    <option selected>No</option>
                    <option>Yes</option>
                </select>
            </div>

            <div class='form-group'>
                <label for='nbodyPart' class="control-label">Body part(s) injured</label>
                <br/>
                <textarea class="form-control" name="nbodyPart" rows="3"></textarea>
            </div>

            <div class='form-group'>
                <label for='nhow' class="control-label">How injury happened</label>
                <br/>
                <textarea class="form-control" name="nhow" rows="3"></textarea>
            </div>

            <div class='form-group'>
                <label for='nambulance' class="control-label">Was worker conveyed to hospital in ambulance?</label>
                <br/>
                <select class="form-control" id="injuryAmbulance" name="nambulance">
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Don't know</option>
                </select>
            </div>
            <div class='form-group'>
                <label for='ntreatement' class="control-label">Where initially treated</label>
                <br/>
                <input class="form-control" type='text' name="ntreatement">
            </div>

            <div class='form-group'>
                <label for='nworkRelated' class="control-label">Does worker consider incident work-related?</label>
                <br/>
                <select class="form-control" id="injuryWorkRelated" name="nworkRelated">
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Don't know</option>
                </select>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="injurycase"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("casediscussion")) {
    HashMap<Integer, String> locations = DropdownDAO.retrieveAllDropdownListOfDiscussWhere();
%>
<form method="POST" action="addProblemComplement.do"  id='casediscussion_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add A New Case Discussion</h4>

    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Discussion Date<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Approx Time of discussion<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTime" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Location/Mode of discussion<span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="discussionWhere" name="ndiscussionWhere" onchange="displayOther(this.id);">
                <%
                    for (String location : locations.values()) {
                %>
                <option><%=location%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="discussionWhere_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionWhereMore">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Was worker participating: <span style="color: red">*</span>: </label>
            <br/>
            <select class="form-control" id="isworkerpresent" name="ndiscussionWorkerPresent">
                <option selected>Yes</option>
                <option>No</option>
            </select>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">TWC2 Person 1<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTWC2P1" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">TWC2 Person 2:</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTWC2P2" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Other Person Presented:</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionOtherPerson" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Translator:</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTranslator" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Topic<span style="color: red">*</span>:  </label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTopic" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Gist:</label>
            <br/>
            <textarea class="form-control" name="ndiscussionGist" rows="4"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Assistance/referral provided:</label>
            <br/>
            <textarea class="form-control" name="ndiscussionAssist" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Updated Calculation of claim value: </label>
            <br/>
            <textarea class="form-control" name="ndiscussionCal" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Action to follow: </label>
            <br/>
            <textarea class="form-control" name="ndiscussionAction" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remark: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="casediscussion"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>
<%
} else if (complement.equals("salarycalim")) {
%>
<form method="POST" action="addProblemComplement.do"  id='salarycalim_pop_up' 
      class="form complement_detailed_form problem_pop_up"  >

    <h4 class='add_comp'>Add Salary Claim Details</h4>
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label">Date claim lodged at MOM<span style="color: red">*</span></label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate">
            </div>

            <div class='form-group'>
                <label for='nloss' class="control-label">Initial value of claim S$</label>
                <br/>
                <input class="form-control" type='text' name="nloss">
            </div>
            <div class='form-group'>
                <label for='nbasis' class="control-label">Describe basis for amount claimed</label>
                <br/>
                <textarea class="form-control" name="nbasis" rows="3"></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="salarycalim"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("salaryhistory")) {
    HashMap<Integer, String> modeOfPayment = DropdownDAO.retrieveAllDropdownListOfSalaryMode();
%>
<form method="POST" action="addProblemComplement.do"  id='salaryhistory_pop_up' 
      class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Salary & Related History </h4>
    <div class='form-group'>



        <div class='add_comp'>
            <div class='form-group'>
                <label for='nbasic' class="control-label">Describe complaint about basic salary incorrect or not paid<span style="color: red">*</span>:</label>
                <br/>
                <textarea class="form-control" name="nbasicSal" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='novertime' class="control-label">Describe complaint about overtime incorrect or not paid: </label>
                <br/>
                <textarea class="form-control" name="novertime" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nallowance' class="control-label">Describe complaint about allowance incorrect or not paid:</label>
                <br/>
                <textarea class="form-control" name="nallowance" rows="3"></textarea>
            </div>

            <div class='form-group'>
                <label for='ndeduction' class="control-label">Describe complaint about deductions:</label>
                <br/>
                <textarea class="form-control" name="ndeduction" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nkickbacks' class="control-label">Describe complaint about kickbacks:</label>
                <br/>
                <textarea class="form-control" name="nkickbacks" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nother' class="control-label">Other Related Details:</label>
                <br/>
                <textarea class="form-control" name="notherSal" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nmode' class="control-label">Mode of Salary Payment</label>
                <br/>
                <select class="form-control" id="mode" name="nmode" onchange="displayOther(this.id);">
                    <%
                        for (String pmode : modeOfPayment.values()) {
                    %>
                    <option><%=pmode%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class='form-group' id='mode_other_div' >
                <label for='nmodeMore' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="nmodeMore">
            </div>
            <div class='form-group'>
                <label for='ntotalLoss' class="control-label">Estimated Total Value of Claim (S$):</label>
                <br/>
                <input class="form-control" type='text' name="ntotalLoss">
            </div>
            <div class='form-group'>
                <label for='noneYearLoss' class="control-label">Estimated 12 Months' Value of Claim(S$):</label>
                <br/>
                <input class="form-control" type='text' name="noneYearLoss">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="salaryhistory"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("lawyer")) {
    HashMap<Integer, String> lawFirmNameList = DropdownDAO.retrieveAllDropdownListOfLawFirms();
%>
<form method="POST" action="addProblemComplement.do"  id='lawyer_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Law Firm Detail </h4>
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='lawyerUpdate' class="control-label">Date of update<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput input-append date dateInput" type='text' name="ndate" >
        </div>
        <div class='form-group'>
            <label for='lawyerFirm' class="control-label">Current Law Firm<span style="color: red">*</span>: </label>
            <br/>
            <select class="form-control" id="nlawyerFirm" name="nlawyerFirm" onchange="displayOther(this.id);">
                <%
                    for (String lawFirmName : lawFirmNameList.values()) {
                %>
                <option><%=lawFirmName%></option>
                <%
                    }
                %>
            </select>
        </div>
        <div class='form-group' id="nlawyerFirm_other_div" >
            <label for='lawyerHave' class="control-label">Explain if above is 'other': </label>
            <br/>
            <input class="form-control" type='text' name="nlawyerFirmMore">
        </div>
        <div class='form-group'>
            <label for='lawyerHave' class="control-label">Name of lawyer or assistant: </label>
            <br/>
            <input class="form-control" type='text' name="nlawyerName">
        </div>
        <div class='form-group'>
            <label for='lawyerRemark' class="control-label">Remarks re lawyer law firm status: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="lawyer"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form>
<%} else if (complement.equals("auxcaseworker")) {
    HashMap<Integer, String> auxiliaryCaseworkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>
<form method="POST" action="addProblemComplement.do"  id='auxcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Auxiliary Caseworker </h4>
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nauxiliaryCaseWorkerName' class="control-label">Auxiliary Caseworker<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="leadCaseWorker" name="nauxiliaryCaseWorkerName">
                    <%
                        for (String auxiliaryCaseWorkerName : auxiliaryCaseworkerNameList.values()) {
                    %>
                    <option><%=auxiliaryCaseWorkerName%></option>
                    <%

                        }
                    %>  
                </select>

            </div>
            <!--
        <div class='form-group' id='auxiliaryCaseWorkerOther' >
            <label for='nauxiliaryCaseWorkerOther' class="control-label">Explain if above is other</label>
            <br/>
            <input class="form-control" type='text' name="nauxiliaryCaseWorkerOther">
        </div>
            -->
            <div class='form-group'>
                <label for='nstartDate' class="control-label">Auxiliary Start Date:</label>
                <br/>
                <input class="form-control startDate" type='text' name="nstartDate">
            </div>
            <div class='form-group'>
                <label for='nendDate' class="control-label">Auxiliary End Date: </label>
                <br/>
                <input class="form-control endDate" type='text' name="nendDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="auxcaseworker"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("leadcaseworker")) {
    HashMap<Integer, String> leadCaseWorkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>
<form method="POST" action="addProblemComplement.do"  id='leadcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Lead Caseworker </h4>
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nleadCaseWorkerName' class="control-label">Lead Caseworker<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="leadCaseWorker" name="nleadCaseWorkerName">
                    <%
                        for (String leadCaseWorkerName : leadCaseWorkerNameList.values()) {
                    %>
                    <option><%=leadCaseWorkerName%></option>
                    <%

                        }
                    %>  
                </select>

            </div>

            <!--div class='form-group' id='leadCaseWorkerOther' >
                <label for='nleadCaseWorkerOther' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="nleadCaseWorkerOther">
            </div-->
            <div class='form-group'>
                <label for='nstartDate' class="control-label">Lead Start Date:</label>
                <br/>
                <input class="form-control startDate" type='text' name="nstartDate">
            </div>
            <div class='form-group'>
                <label for='nendDate' class="control-label">Lead End Date: </label>
                <br/>
                <input class="form-control endDate" type='text' name="nendDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="leadcaseworker"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn ">Save</button>
                <button type='button' class='btn modal_btn  cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>
<%} else if (complement.equals("aggravissue")) {
    HashMap<Integer, String> problemTypes = DropdownDAO.retrieveAllDropdownListOfProblems();
%>
<form method="POST" action="addProblemComplement.do"  id='aggravIssue_pop_up' 
      class="form complement_detailed_form problem_pop_up"  >
    <h4 class='add_comp'>Add A New Aggravating Issue </h4>
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='naggravissueType' class="control-label">Aggravating issue<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="aggravissueType" name="naggravissueType" onchange="displayOther(this.id);">
                    <%
                        for (String aggravissueType : problemTypes.values()) {
                    %>
                    <option><%=aggravissueType%></option>
                    <%

                        }
                    %>  
                </select>

            </div>

            <div class='form-group' id='aggravissueType_other_div' >
                <label for='naggravissueTypeMore' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="naggravissueTypeMore">
            </div>
            <div class='form-group'>
                <label for='naggravLoss' class="control-label">Monetary loss/value S$</label>
                <br/>
                <input class="form-control" type='text' name="naggravLoss">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="aggravissue"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>
<%    } else if (complement.equals("othercase")) {
%>
<form method="POST" action="addProblemComplement.do"  id='othercase_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4>Add Details & history of other problems </h4>
    <div class='form-group'>

        <div class='form-group'>
            <label for='nother' class="control-label">Details of problem if it's not salary/injury/illness<span style="color: red">*</span></label>
            <br/>
            <textarea class="form-control" name="nother" rows="3"></textarea>
        </div>

        <div class='form-group'>
            <label for='nloss' class="control-label">Estimated value of claim S$</label>
            <br/>
            <input class="form-control" type='text' name="nloss">
        </div>
        <div class='form-group'>
            <label for='nremark' class="control-label">Remark</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="othercase"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>
<%    }
%>

