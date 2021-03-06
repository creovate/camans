<%-- 
    Document   : addPopUp
    Created on : Oct 26, 2014, 2:51:36 PM
    Author     : Nyein Su
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    form{
        padding-top: 2%;
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

        $(".removeBtn").click(function() {
            var field = $(this).data('field');
            
            $("." + field + "dateToRemove").val("");
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
                nNickName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The nickname must not exceed 50 characters.'
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
                            message: 'Passport No. must not exceed 20 characters.'
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
                            message: 'Passport Country must not exceed 20 characters.'
                        },
                        notEmpty: {
                            message: 'Passport Country cannot be empty.'
                        }
                    }
                },
                //sgPhone & homePhone
                nsgPhNum: {
                    validators: {
                        stringLength: {
                            max: 12,
                            message: 'Phone No must not exceed 12 characters.'
                        },
                        regexp: {
                            regexp: /^[\d|\-|(|)|+|\s]+$/,
                            message: 'Phone No can contain space, - , () , + and digits only.'
                        },
                        notEmpty: {
                            message: 'Phone No. cannot be empty.'
                        }
                    }
                },
                nPhNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Phone No must not exceed 20 characters.'
                        },
                        regexp: {
                            regexp: /^[\d|\-|(|)|+|\s]+$/,
                            message: 'Phone No can contain space, - , () , + and digits only.'
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
                            message: 'Owner name must not exceed 20 characters.'
                        }
                    }
                },
                //sgAddress & homeCountry Add
                nAddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must not exceed 300 characters.'
                        },
                        notEmpty: {
                            message: 'Address cannot be empty.'
                        }
                    }
                },
                //digitalcontact & remark for all
                nDigitalContactType: {
                    validators: {
                        notEmpty: {
                            message: 'Contact Type cannot be empty.'
                        }
                    }
                },
                nDigitalMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Contact Type must not exceed 50 characters.'
                        }
                    }
                },
                nDigitalDetails: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Contact address must not exceed 50 characters.'
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
                            message: 'Owner of contact must not exceed 50 characters.'
                        }
                    }
                },
                nRemark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remarks must not exceed 200 characters.'
                        }
                    }
                },
                //nok & family & Friends
                nName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must not exceed 50 characters.'
                        },
                        notEmpty: {
                            message: 'The name cannot be empty.'
                        }
                    }
                },
                nRelation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Relationship must not exceed 50 characters.'
                        }
                    }
                },
                nDocReference: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Identity docs/references must not exceed 200 characters.'
                        }
                    }
                },
                nDigitalContact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact Details must not exceed 200 characters.'
                        }
                    }
                },
                nProofDoc: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Attesting Documents must not exceed 200 characters.'
                        }
                    }
                },
                nNOKPhNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Phone No must not exceed 20 characters.'
                        },
                        regexp: {
                            regexp: /^[\d|\-|(|)|+|\s]+$/,
                            message: 'Phone No can contain space, - , () , + and digits only.'
                        }
                    }
                },
                nNOKAddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must not exceed 300 characters.'
                        }
                    }
                },
                //family member
                nFamilyPhNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Phone No must not exceed 20 characters.'
                        },
                        regexp: {
                            regexp: /^[\d|\-|(|)|+|\s]+$/,
                            message: 'Phone No can contain space, - , () , + and digits only.'
                        }
                    }
                },
                nFamilyAddress: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must not exceed 20 characters.'
                        }
                    }
                },
                //friend
                nFriendPhNum: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Phone No must not exceed 20 characters.'
                        },
                        regexp: {
                            regexp: /^[\d|\-|(|)|+|\s]+$/,
                            message: 'Phone No can contain space, - , () , + and digits only.'
                        }
                    }
                },
                //language
                nMainLanguage: {
                    validators: {
                        notEmpty: {
                            message: 'Language cannot be empty.'
                        }
                    }
                },
                nLanguageMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Others must not exceed 50 characters.'
                        }
                    }
                },
                nEnglishStandard: {
                    validators: {
                        notEmpty: {
                            message: 'Spoken English Standard cannot be empty.'
                        }
                    }
                },
                //bankAccount
                nBankAcctName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Name must not exceed 50 characters.'
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
                            message: 'Account No. must not exceed 50 characters.'
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
                            message: 'Bank name must not exceed 50 characters.'
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
                            message: 'Bank branch must not exceed 50 characters.'
                        }
                    }
                },
                nBankBranchCode: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank branch code must not exceed 50 characters.'
                        }
                    }
                },
                nBankBranchAddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must not exceed 300 characters.'
                        }
                    }
                },
                nBankSwift: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank Swift must not exceed 50 characters.'
                        }
                    }
                },
                bankAcctName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Name must not exceed 50 characters.'
                        },
                        notEmpty: {
                            message: 'Name cannot be empty.'
                        }
                    }
                }
            }
        });

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
                npasstype: {
                    validators: {
                        notEmpty: {
                            message: 'Pass type cannot be empty.'
                        }
                    }
                },
                npasstypeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Pass type must not exceed 50 characters.'
                        }
                    }
                },
                npassno: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Pass number must not exceed 20 characters.'
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
                            message: 'Agency name must not exceed 20 characters.'
                        }
                    }
                },
                nremark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remarks must not exceed 200 characters.'
                        }
                    }
                },
                //emp details
                nname: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must not exceed 50 characters.'
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
                            message: 'Employer ID must not exceed 50 characters.'
                        }
                    }
                },
                naddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must not exceed 300 characters.'
                        }
                    }
                },
                ncontact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact details must not exceed 200 characters.'
                        }
                    }
                },
                nperson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                //employment contract
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
                            message: 'Location must not exceed 50 characters.'
                        }
                    }
                },
                nlanguage: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Language must not exceed 20 characters.'
                        }
                    }
                },
                nopname: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must not exceed 50 characters.'
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
                            message: 'Relationship must not exceed 200 characters.'
                        }
                    }
                },
                noccupation: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'occupation must not exceed 200 characters.'
                        }
                    }
                },
                nsalary: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Salary must not exceed 50 characters.'
                        }
                    }
                },
                nallowance: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Allowance Details must not exceed 500 characters.'
                        }
                    }
                },
                ndeduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must not exceed 500 characters.'
                        }
                    }
                },
                nduration: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Length of contract must not exceed 20 characters.'
                        }
                    }
                },
                nduress: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction Details must not exceed 500 characters.'
                        }
                    }
                },
                //agent
                ncompany: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Company name must not exceed 50 characters.'
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
                            message: 'Agent key person name must not exceed 50 characters.'
                        }
                    }
                },
                naglocationMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Agent location must not exceed 50 characters.'
                        }
                    }
                },
                namtowed: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                namtpaid: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nfeeshared: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nfeetraining: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Training expense details must not exceed 50 characters.'
                        }
                    }
                },
                nfeeairfare: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Airfare fee must not exceed 50 characters.'
                        }
                    }
                },
                nfeewhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nfeewhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nfeerepay: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Repayment plan must not exceed 200 characters.'
                        }
                    }
                },
                nemp: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Employer name must not exceed 200 characters.'
                        }
                    }
                },
                nagremark: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Remarks must not exceed 1000 characters.'
                        }
                    }
                },
                //verbal assurance
                nvaWhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nvaWhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nvaContent: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Content must not exceed 1000 characters.'
                        }
                    }
                },
                //workplace
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
                            message: 'Type must not exceed 200 characters.'
                        }
                    }
                },
                nwhose: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                npersonDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Location of workplace must not exceed 200 characters.'
                        }
                    }
                },
                nrelation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nstart: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nend: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                ncondition: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                nsafety: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                //work history
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                narrivalYear: {
                    validators: {
                        integer: {
                            message: 'This field must be a number.'
                        },
                        stringLength: {
                            max: 4,
                            message: 'This field must be a year value.'
                        }
                    }
                },
                narrivalDate: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nprevJob: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                nprevProb: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                //accommodation
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                ntypeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                naccCharged: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                naccPaid: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nmeal: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nfrom: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nto: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nlocationAccom: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                //ipa
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nempName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must not exceed 50 characters.'
                        }
                    }
                },
                nagentName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must not exceed 50 characters.'
                        }
                    }
                },
                nindustry: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Industry must not exceed 20 characters.'
                        }
                    }
                },
                nipaoccupation: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Occupation must not exceed 30 characters.'
                        }
                    }
                },
                nperiods: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Period of pass must not exceed 20 characters.'
                        },
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nbasicSalary: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                ntotalAllowance: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nallowanceDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                ntotalDeduction: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                ndeducationDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
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
                            message: 'The Approx time must not exceed 20 characters.'
                        }
                    }
                },
                nlocation: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Location must not exceed 200 characters.'
                        }
                    }
                },
                nbodyPart: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Body part(s) must not exceed 500 characters.'
                        }
                    }
                },
                nhow: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty. Please enter a value.'
                        }
                    }
                },
                nhowinjury: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                ntreatment: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nremark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remarks must not exceed 200 characters.'
                        }
                    }
                },
                
                //illness
                nstartTime: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                ndiagnosePerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Doctor/hospital must not exceed 200 characters.'
                        }
                    }
                },
                nnature: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Nature of illness must not exceed 200 characters.'
                        }
                    }
                },
                nworkRelatedYes: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Doctor/hospital must not exceed 500 characters.'
                        }
                    }
                },
                //other case
                nother: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nloss: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //salary claim
                nbasis: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                //wica claim & non wica claim
                nrefNumber: {
                    validators: {
                        notEmpty: {
                            message: 'Reference number cannot be empty.'
                        },
                        stringLength: {
                            max: 30,
                            message: 'Reference number must not exceed 30 characters.'
                        }
                    }
                },
                ninsurer: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Insurance company name must not exceed 50 characters.'
                        }
                    }
                },
                npolicyNumber: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Insurance policy no must not exceed 30 characters.'
                        }
                    }
                },
                
                nreason: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nNWicaremark: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Remarks must not exceed 1000 characters.'
                        }
                    }
                },
                //police report
                npoliceReportStation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Police station name must not exceed 50 characters.'
                        }
                    }
                },
                npoliceReportPerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Accompanying person name must not exceed 200 characters.'
                        }
                    }
                },
                npoliceReportRefNumber: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Reference Number must not exceed 30 characters.'
                        }
                    }
                },
                npoliceReportDetails: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                //other complaint
                ncomplaintAgency: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
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
                ncomplaintWhoMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                ncomplaintModeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                ncomplaintDetails: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                //case discussion
                ndiscussionTime: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must not exceed 20 characters.'
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                ndiscussionTWC2P1: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must not exceed 20 characters.'
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                ndiscussionOtherPerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                ndiscussionTranslator: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                ndiscussionTopic: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
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
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                ndiscussionAssist: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                ndiscussionCal: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                ndiscussionAction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                //hospital
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nhospDoctor: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                ninternalRemarks: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Remarks must not exceed 500 characters.'
                        }
                    }
                },
                //mc
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
                            message: 'This field must not exceed 50 characters.'
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
                nr2rHosp: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must not exceed 20 characters.'
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nr2rTime: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must not exceed 20 characters.'
                        }
                    }
                },
                nr2r1: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must not exceed 20 characters.'
                        }
                    }
                },
                nr2r2: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must not exceed 20 characters.'
                        }
                    }
                },
                nr2rPurpose: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nr2rPreApptNotes: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nr2rPostApptNotes: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nr2rFeedback: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nr2rMed: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nr2rOut: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //wica status
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nwicaPoints: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nwicaDollars: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //lawyer
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nlawyerName: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
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
                            message: 'This field must not exceed 200 characters.'
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nmilestoneCRCharges: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nmilestoneCRSentence: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                //ttr
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nttrDepartureDate: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nttrEmployerName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                nttrJob: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                nttrremark: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Remarks must not exceed 500 characters.'
                        }
                    }
                },
                //aggravating issues
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                naggravLoss: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                //leadcase worker
                nleadCaseWorkerName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                //auxiliary caseworker
                nauxiliaryCaseWorkerName: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                //salary related
                nbasicSal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
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
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                nallowance: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                ndeduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                nkickbacks: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                notherSal: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                nmodeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                ntotalLoss: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                noneYearLoss: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                }
            }
        });

    });

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

    $(document).ready(function() {
        $('.cancel_btn').addClass('pull-right');
        $('.form-control').addClass('input-sm');
    });


</script>

<%
    String workerFin = request.getParameter("workerFin");   //passed from viewWorker.jsp
    String complement = request.getParameter("complement"); //passed from viewWorker.jsp
    String jobKey = request.getParameter("jobkey");         //passed from viewWorker.jsp
    String probKey = request.getParameter("probkey");    //passed from viewWorker.jsp
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    DecimalFormat df = new DecimalFormat("#,###,###.00");
    java.util.Date today = new java.util.Date();
%>

<!-------------------------->
<!--- Worker Complements --->
<!-------------------------->

<!--------------->
<!-- 1 Nickname-->
<!--------------->
<%
    if (complement.equals("nickname")) {
%>
<form method="POST" action="addWorkerComplement.do" id='nickname_pop_up' class="form complement_detailed_form worker_pop_up"  >

    <div class='add_comp'>
        <div class='form-group '>
            <label for='nickName' class="control-label"><span style="color: red">*</span> Nickname</label>
            <br/>
            <input class="form-control" type='text' name="nNickName" required>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
        <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="WorkerNickname"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form> 

<!----------------------->
<!-- 2 Passport Details-->
<!----------------------->
<%
} else if (complement.equals("passport")) {
%>
<form method="POST" id='passport_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nPassportNum' class="control-label"><span style="color: red">*</span> Passport number</label>
                <br/>
                <input class="form-control" type='text' name="nPassportNum" required>
            </div>
            <div class='form-group'>
                <label for='nPassportCountry' class="control-label"><span style="color: red">*</span> Passport country</label>
                <br/>
                <input class="form-control" type='text' name="nPassportCountry" required>
            </div>
            <div class='form-group'>
                <label for='nPassportIssueDate' class="control-label">Passport issue date</label>
                <br/>
                <input class="form-control col-md-9 startDate startdateToRemove" type='text' name="nPassportIssueDate" style="width: 90%;"/>
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="start" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                <br/><br/>
            </div>
            <div class='form-group'>
                <label for='nPassportExpiryDate' class="control-label">Passport expiry date</label>
                <br/>
                <input class="form-control endDate enddateToRemove col-md-9" type='text' name="nPassportExpiryDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="end" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerPassportDetails"/>

        </div>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!---------------------->
<!-- 3 Singapore Phone-->
<!---------------------->
<%
} else if (complement.equals("sgphone")) {
%>
<form method="POST" id='sgphonenum_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nPhNum' class="control-label"><span style="color: red">*</span> SG phone number</label>
                <br/>
                <input class="form-control" type='text' name="nsgPhNum" required>
            </div>

            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerSgPhNum"/>
        </div>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!------------------------->
<!-- 4 Home Country Phone-->
<!------------------------->
<%
} else if (complement.equals("homephone")) {
%>
<form method="POST" id='homephonenum_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nPhNum' class="control-label"><span style="color: red">*</span> Home country telephone number</label>
                <br/>
                <input class="form-control" type='text' name="nPhNum" required>
            </div>
            <div class='form-group'>
                <label for='nPhOwner' class="control-label">Owner of this number</label>
                <br/>
                <input class="form-control" type='text' name="nPhOwner" >
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerHomeCountryPhNum"/>
        </div>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------------------>
<!-- 5 Singapore address-->
<!------------------------>
<%
} else if (complement.equals("sgadd")) {
%>
<form method="POST" id='sgAdd_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nAddress' class="control-label"><span style="color: red">*</span> Worker address in Singapore</label>
                <br/>
                <textarea class="form-control" name="nAddress" rows="3"  required></textarea>
            </div>

            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerSgAddress"/>

        </div>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!--------------------------->
<!-- 6 Home Country address-->
<!--------------------------->
<%
} else if (complement.equals("homeadd")) {
%>
<form method="POST" id='homeAdd_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='add_comp'>
        <div class='form-group '>
            <div class='form-group'>
                <label for='nAddress' class="control-label"><span style="color: red">*</span> Worker address in home country</label>
                <br/>
                <textarea class="form-control" name="nAddress" rows="3"   required></textarea>
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerHomeCountryAddress"/>
        </div>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!----------------------->
<!-- 7 Digital contacts-->
<!----------------------->
<%
} else if (complement.equals("digcontact")) {
    ArrayList<String> digitalContactList = DropdownDAO.retrieveAllDropdownListOfDigitalContactType();
%>
<form method="POST" id='digi_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nDigitalContactType' class="control-label"><span style="color: red">*</span> Type of digital contact</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nDigitalContactType">
                    <option value="" selected>Select contact type...</option>
                    <%
                        for (String contactType : digitalContactList) {

                    %>
                    <option value="<%=contactType%>"><%=contactType%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class="form-group" id="digitalContactType_other_div">
                <label for="nDigitalMore" class="control-label">Explain if above is 'Other'</label><br/>
                <input class="form-control" type='text' name="nDigitalMore">
            </div>
            <div class='form-group'>
                <label for='nDigitalDetails' class="control-label"><span style="color: red">*</span> Email/QQ address or other details</label>
                <br/>
                <input class="form-control" type='text' name="nDigitalDetails">
            </div>
            <div class='form-group'>
                <label for='nDigitalOwner' class="control-label">Owner of electronic contact</label>
                <br/>
                <input class="form-control" type='text' name="nDigitalOwner">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark about digital contact</label>
                <br/>
                <textarea class="form-control" name="nRemark" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerDigitalContact"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!---------->
<!-- 8 nok-->
<!---------->           
<%
} else if (complement.equals("nok")) {
%>
<form method="POST" id='nok_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nName' class="control-label"><span style="color: red">*</span> Name of next of kin</label>
                <br/>
                <input class="form-control" type='text' name="nName" required>
            </div>
            <div class='form-group'>
                <label for='nRelation' class="control-label">Relationship of next of kin to worker</label>
                <br/>
                <input class="form-control" type='text' name="nRelation">
            </div>
            <div class='form-group'>
                <label for='nDocReference' class="control-label">Identity docs/references of next of kin</label>
                <br/>
                <textarea class="form-control" name="nDocReference" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nPhNum' class="control-label">Phone number of next of kin</label>
                <br/>
                <input class="form-control" type="text" name="nNOKPhNum">
            </div>
            <div class='form-group'>
                <label for='nDigitalContact' class="control-label">Other contact details of next of kin</label>
                <br/>
                <textarea class="form-control" name="nDigitalContact" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nAddress' class="control-label">Address of next of kin</label>
                <br/>
                <textarea class="form-control" name="nNOKAddress" rows="3"  ></textarea>
            </div>
            <div class='form-group'>
                <label for='nProofDoc' class="control-label">What docs attesting next of kin?</label>
                <br/>
                <textarea class="form-control" name="nProofDoc" rows="3"  ></textarea>
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark about next of kin:  </label>
                <br/>
                <textarea class="form-control" name="nRemark" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerNextOfKin"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!-------------------->
<!-- 9 family Member-->
<!-------------------->          
<%
} else if (complement.equals("familymember")) {
%>
<form method="POST" id='fm_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nName' class="control-label"><span style="color: red">*</span> Name of family member</label>
                <br/>
                <input class="form-control" type='text' name="nName" required>
            </div>
            <div class='form-group'>
                <label for='nRelation' class="control-label">Relationship of family member to worker</label>
                <br/>
                <input class="form-control" type='text' name="nRelation">
            </div>
            <div class='form-group'>
                <label for='nAddress' class="control-label">Is the family member in Singapore?</label>
                <br/>
                <input class="form-control" type='text' name="nFamilyAddress">
            </div>
            <div class='form-group'>
                <label for='nPhNum' class="control-label">Phone number of family member</label>
                <br/>
                <input class="form-control" type="text" name="nFamilyPhNum">
            </div>
            <div class='form-group'>
                <label for='nDigitalContact' class="control-label">Other contact details of family member</label>
                <br/>
                <textarea class="form-control" name="nDigitalContact" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark about family member</label>

                <br/>
                <textarea class="form-control" name="nRemark" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerFamilyMember"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!-------------->
<!-- 10 sg fri-->
<!-------------->          
<%
} else if (complement.equals("sgfri")) {
%>
<form method="POST" id='sgFri_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up"  >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nName' class="control-label"><span style="color: red">*</span> Name of friend in Singapore</label>
                <br/>
                <input class="form-control" type='text' name="nName" required>
            </div>
            <div class='form-group'>
                <label for='nPhNum' class="control-label">Phone number of friend</label>
                <br/>
                <input class="form-control" type="text" name="nFriendPhNum">
            </div>
            <div class='form-group'>
                <label for='nRelation' class="control-label">Relationship to worker</label>
                <br/>
                <input class="form-control" type='text' name="nRelation">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark about friend</label>
                <br/>
                <textarea class="form-control" name="nRemark" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerFriend"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!---------------->
<!-- 11 language-->
<!---------------->
<%
} else if (complement.equals("language")) {
    ArrayList<String> languageList = DropdownDAO.retrieveAllDropdownListOfLanguage();
    ArrayList<String> spokenEnglishList = DropdownDAO.retrieveAllDropdownListOfSpokenEnglish();
%>
<form method="POST" id='language_pop_up' action="addWorkerComplement.do" class="form complement_detailed_form worker_pop_up"  >

    <div class='form-group'>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nMainLanguage' class="control-label"><span style="color: red">*</span> Worker's main language</label>
                <br/>
                <select class="form-control" id="mainLang" name="nMainLanguage">
                    <option value="" selected>Select language...</option>
                    <%
                        for (String languageType : languageList) {
                    %>
                    <option value="<%=languageType%>"><%=languageType%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class="form-group" id="mainLang_other_div" >
                <label for="nLanguageMore" class="control-label">Explain if above is 'Other'</label>
                <br/>
                <input class="form-control" type='text' name="nLanguageMore">
            </div>
            <div class='form-group'>
                <label for='nEnglishStandard' class="control-label"><span style="color: red">*</span> Spoken English standard</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nEnglishStandard">
                    <option value="" selected>Select English standard...</option>
                    <%
                        for (String engStd : spokenEnglishList) {
                    %> 
                    <option value="<%=engStd%>"><%=engStd%></option>
                    <%


                        }
                    %>  
                </select>
            </div>
            <div class='form-group'>
                <label for='fremark' class="control-label">Remark about language</label>
                <br/>
                <textarea class="form-control" name="nRemark" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerLanguage"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>

</div>
</form>

<!---------------->
<!-- 12 bank acc-->
<!---------------->
<%
} else if (complement.equals("bankacc")) {
%>

<form method="POST" id='bk_pop_up' class="form complement_detailed_form worker_pop_up" action="addWorkerComplement.do" >

    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nBankAcctName' class="control-label"><span style="color: red">*</span> Bank account name</label>
                <br/>
                <input class="form-control" type='text' name="nBankAcctName" required>
            </div>
            <div class='form-group'>
                <label for='nBankAcctNum' class="control-label"><span style="color: red">*</span> Bank account number</label>
                <br/>
                <input class="form-control" type='text' name="nBankAcctNum" required>
            </div>
            <div class='form-group'>
                <label for='nBankName' class="control-label"><span style="color: red">*</span> Bank name</label>
                <br/>
                <input class="form-control" type='text' name="nBankName" required>
            </div>
            <div class='form-group'>
                <label for='nBankBranch' class="control-label">Bank branch name</label>
                <br/>
                <input class="form-control" type="text" name="nBankBranch">
            </div>
            <div class='form-group'>
                <label for='nBankBranchCode' class="control-label">Bank branch code</label>
                <br/>
                <input class="form-control" type='text' name="nBankBranchCode" >
            </div>
            <div class='form-group'>
                <label for='nBankBranchAddress' class="control-label">Bank branch address</label>
                <br/>
                <textarea class="form-control" name="nBankBranchAddress" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nBankSwift' class="control-label">Bank swift code</label>
                <br/>
                <input class="form-control" type='text' name="nBankSwift">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remark about bank account</label>
                <br/>
                <textarea class="form-control" name="nRemark" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nObseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="nObseleteDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerBankAcct"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>   

<!---------------------->
<!---Job Complements --->   
<!---------------------->

<!---------------->
<!--pass details-->
<!---------------->
<%
} else if (complement.equals("passdetails")) {
    ArrayList<String> workpassTypes = DropdownDAO.retrieveAllDropdownListByType("Pass_type");
%>

<form method="POST" id='passdetails_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='npasstype' class="control-label"><span style="color: red">*</span> Pass type</label>
                <br/>
                <select class="form-control" id="passtype" name="npasstype">
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String workpassType : workpassTypes) {
                    %>
                    <option value="<%=workpassType%>"><%=workpassType%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class="form-group" id="passtype_other_div">
                <label for="passtypeMore" class="control-label">Explain if above is 'Other'</label><br/>
                <input class="form-control" type='text' name="npasstypeMore">
            </div>

            <div class='form-group'>
                <label for='npassno' class="control-label"><span style="color: red">*</span> Pass number</label>
                <br/>
                <input class="form-control" type='text' name="npassno" >
            </div>
            <div class='form-group'>
                <label for='napdate' class="control-label">Pass application date</label>
                <br/>
                <input class="form-control dateInput apdateToRemove col-md-9" type='text' name="napdate" style="width:90%" >
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="ap" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                <br/><br/>
            </div>
            <div class='form-group'>
                <label for='nisdate' class="control-label">Pass issued date</label>
                <br/>
                <input class="form-control startDate isdateToRemove col-md-9" type='text' name="nisdate" style="width:90%" >
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="is" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                <br/><br/>
            </div>
            <div class='form-group'>
                <label for='nexdate' class="control-label">Pass expiry date</label>
                <br/>
                <input class="form-control endDate exdateToRemove col-md-9" type='text' name="nexdate" style="width:90%" >
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="ex" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                <br/><br/>
            </div>
            <div class='form-group'>
                <label for='nissuer' class="control-label">Pass issuing agency</label>
                <br/>
                <input class="form-control" type='text' name="nissuer" >
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about pass</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"  ></textarea>
            </div>
            <div class='form-group'>
                <label for='nobsoleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput" type='text' name="nobsoleteDate" >
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="JobPassDetails"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!--employer details--> 
<!-------------------->
<%
} else if (complement.equals("empdetails")) {
%>

<form method="POST" id='empdetails_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nname' class="control-label"><span style="color: red">*</span> Official name of employer</label>
                <br/>
                <input class="form-control" type='text' name="nname" required>
            </div>
            <div class='form-group'>
                <label for='nempid' class="control-label">ID of employer</label>
                <br/>
                <input class="form-control" type='text' name="nempid">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Employer address</label>
                <br/>
                <textarea class="form-control" name="naddress" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='ncontact' class="control-label">Employer Phone, Email contacts</label>
                <br/>
                <textarea class="form-control" name="ncontact" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nperson' class="control-label">Key persons in employer</label>
                <br/>
                <textarea class="form-control" name="nperson" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about employer</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="EmployerDetails"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!------------------------>
<!--Employment Contract--->   
<!------------------------>
<%
} else if (complement.equals("empcontract")) {
%>

<form method="POST" id='contract_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='ncontdate' class="control-label"><span style="color: red">*</span> Contract date</label>
                <br/>
                <input class="form-control dateInput" type='text' name="ncontdate" value="<%= sdf.format(today)%>">
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Where contract signed</label>
                <br/>
                <input class="form-control" type='text' name="nlocation">
            </div>
            <div class='form-group'>
                <label for='nlanguage' class="control-label">Contract language</label>
                <br/>
                <input class="form-control" type='text' name="nlanguage">
            </div>
            <div class='form-group'>
                <label for='nopname' class="control-label"><span style="color: red">*</span> Name of opposite contracting party</label>
                <br/>
                <input class="form-control" type='text' name="nopname">
            </div>
            <div class='form-group'>
                <label for='noprelation' class="control-label">Relationship of opposite contracting party to job</label>
                <br/>
                <textarea class="form-control" name="noprelation" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='noccupation' class="control-label">Occupation stated in contract</label>
                <br/>
                <textarea class="form-control" name="noccupation" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nsalary' class="control-label">Basic salary</label>
                <br/>
                <input class="form-control" type='text' name="nsalary">
            </div>
            <div class='form-group'>
                <label for='nallowance' class="control-label">Allowance details</label>
                <br/>
                <textarea class="form-control" name="nallowance" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='ndeduction' class="control-label">Deductions details</label>
                <br/>
                <textarea class="form-control" name="ndeduction" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nduration' class="control-label">Length of contract</label>
                <br/>
                <input class="form-control" type='text' name="nduration">
            </div>
            <div class='form-group'>
                <label for='nduress' class="control-label">Describe if signed under duress or misrepresentation</label>
                <br/>
                <textarea class="form-control" name="nduress" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about contract</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="ContractDetails"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------------->       
<!--Intermediary agent-->    
<!---------------------->           
<%

} else if (complement.equals("agent")) {
    ArrayList<String> agentLocations = DropdownDAO.retrieveAllDropdownListOfAgentLocationType();

%>

<form method="POST" id='agent_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='ncompany' class="control-label"><span style="color: red">*</span> Agent company name</label>
                <br/>
                <input class="form-control" type='text' name="ncompany" required>
            </div>
            <div class='form-group'>
                <label for='nperson' class="control-label">Agent key person name</label>
                <br/>
                <input class="form-control" type='text' name="nagperson">
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Location of agent</label>
                <br/>
                <select class="form-control" id="agentLocation" name="naglocation">
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String agentLocation : agentLocations) {
                    %>
                    <option value="<%=agentLocation%>"><%=agentLocation%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="agentLocation_other_div" >
                <label for='nhowMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <input class="form-control" type='text' name="naglocationMore">
                
            </div>
            <div class='form-group'>
                <label for='naddress' class="control-label">Agent address</label>
                <br/>
                <textarea class="form-control" name="naddress" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='ncontact' class="control-label">Agent phone/email contact</label>
                <br/>
                <textarea class="form-control" name="ncontact" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='namtpaid' class="control-label">Amount paid to this agent(S$)</label>
                <br/>
                <input class="form-control" type='text' name="namtpaid">
            </div>
            <div class='form-group'>
                <label for='namtowed' class="control-label">Amount Owed to this agent at the start of work(S$)</label>
                <br/>
                <input class="form-control" type='text' name="namtowed">
            </div>
            <div class='form-group'>
                <label for='nfeeshared' class="control-label">Any suspicion fee was shared with others?</label>
                <br/>
                <textarea class="form-control" name="nfeeshared" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nfeetraining' class="control-label" >Did fee include training expenses? (Explain in detail) </label>
                <br/>
                <input class="form-control" type='text' name="nfeetraining">
            </div>
            <div class='form-group'>
                <label for='nfeeairfare' class="control-label">Did fee include airfare?</label>
                <br/>
                <input class="form-control" type='text' name="nfeeairfare">
            </div>
            <div class='form-group'>
                <label for='nfeewhen' class="control-label">When agent fee paid</label>
                <br/>
                <input class="form-control" type='text' name="nfeewhen">
            </div>
            <div class='form-group'>
                <label for='nfeewhere' class="control-label">Where agent fee paid</label>
                <br/>
                <input class="form-control" type='text' name="nfeewhere">
            </div>
            <div class='form-group'>
                <label for='nfeerepay' class="control-label">Repayment Plan if fee owed</label>
                <br/>
                <textarea class="form-control" name="nfeerepay" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nemp' class="control-label">Employer that this agent placed worker to</label>
                <br/>
                <textarea class="form-control" name="nemp" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Agent remarks</label>
                <br/>
                <textarea class="form-control" name="nagremark" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="Agent"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!--verbal assurance--> 
<!-------------------->
<%
} else if (complement.equals("assurance")) {
%>

<form method="POST" id='assurance_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >


    <div class='form-group'>



        <div class='add_comp'>
            <div class='form-group'>
                <label for='nname' class="control-label"><span style="color: red">*</span> Name of giver of verbal assurance</label>
                <br/>
                <input class="form-control" type='text' name="nname" required>
            </div>
            <div class='form-group'>
                <label for='nrelationship' class="control-label">Relationship of giver to worker or agent or employer</label>
                <br/>
                <textarea class="form-control" name="nrelation" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nvaWhen' class="control-label">When was verbal assurance given?</label>
                <br/>
                <input class="form-control" type='text' name="nvaWhen">
            </div>
            <div class='form-group'>
                <label for='nvaWhere' class="control-label">Where was verbal assurance given?</label>
                <br/>
                <input class="form-control" type='text' name="nvaWhere">
            </div>
            <div class='form-group'>
                <label for='nvaContent' class="control-label">Content of verbal assurance</label>
                <br/>
                <textarea class="form-control" name="nvaContent" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="VerbalAssurance"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!------------->
<!--workplace-->  
<!------------->
<%
} else if (complement.equals("wplace")) {
    ArrayList<String> workplaceTypes = DropdownDAO.retrieveAllDropdownListOfWorkplaceType();
    ArrayList<String> workplacedirects = DropdownDAO.retrieveAllDropdownListOfWorkplaceDirectType();

%>

<form method="POST" id='workplace_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >


    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nwpType' class="control-label"><span style="color: red">*</span> Type of workplace</label>
                <br/>
                <select class="form-control" id="workplaceType" name="nwpType" >
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String type : workplaceTypes) {
                    %>
                    <option value="<%=type%>"><%=type%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="wrokplaceType_other_div" >
                <label for='nwpTypeMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="nwpTypeMore" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nwhose' class="control-label">Is workplace controlled by employer stated on workpass? If not, who?</label>
                <br/>
                <input class="form-control" type='text' name="nwhose" >
            </div>
            <div class='form-group'>
                <label for='npersonDetails' class="control-label">Location of Workplace</label>
                <br/>
                <textarea class="form-control" name="npersonDetails"></textarea>
            </div>
            <div class='form-group'>
                <label for='nrelationship' class="control-label">Relationship of workplace to employer</label>
                <br/>
                <input class="form-control" type='text' name="nrelation" >
            </div>
            <div class='form-group'>
                <label for='ndirect' class="control-label"><span style="color: red">*</span> Who directed worker to this workplace?</label>
                <br/>
                <select class="form-control" id="direct" name="ndirect" >
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String workplacedirect : workplacedirects) {
                    %>
                    <option value="<%=workplacedirect%>"><%=workplacedirect%></option>
                    <%

                        }
                    %>  
                </select>

            </div>
            <div class='form-group' id="direct_other_div" >
                <label for='ndirectMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="ndirectMore" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nstart' class="control-label">When start at workplace?</label>
                <br/>
                <input class="form-control" type='text' name="nstart" >
            </div>
            <div class='form-group'>
                <label for='nend' class="control-label">When cease working at workplace?</label>
                <br/>
                <input class="form-control" type='text' name="nend" >
            </div>
            <div class='form-group'>
                <label for='ncondition' class="control-label">Work conditions at the workplace</label>
                <br/>
                <textarea class="form-control" name="ncondition" rows="3""></textarea>
            </div>
            <div class='form-group'>
                <label for='nsafety' class="control-label">Safety issues at workplace</label>
                <br/>
                <textarea class="form-control" name="nsafety" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about workplace</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkPlace"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------->
<!--work history-->
<!---------------->
<%
} else if (complement.equals("whistory")) {
    ArrayList<String> workhist = DropdownDAO.retrieveAllDropdownListOfWorkHistoryHowType();
%>

<form method="POST" id='workhistory_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up" >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nhow' class="control-label"><span style="color: red">*</span> How did worker get into job defined in job profile?</label>
                <br/>
                <select class="form-control" id="workhistHow" name="nhow" >
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String type : workhist) {
                    %>
                    <option value="<%=type%>"><%=type%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="workhistHow_other_div" >
                <label for='nhowMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="nhowMore" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='narrivalDate' class="control-label">When worker arrived Singapore for this job?</label>
                <br/>
                <input class="form-control" type='text' name="narrivalDate" >
            </div>
            <div class='form-group'>
                <label for='nisFirstJob' class="control-label">Is this first job in Singapore? </label>
                <br/>
                <select class="form-control" id="nisFirstJob" name="nisFirstJob" onchange="hideOther(this.id);">

                    <option selected>No</option>

                    <option>Yes</option>

                </select>

            </div>
            <div class='form-group' id="nisFirstJob_other_div">
                <label for='narrivalYear' class="control-label">If not, year in which worker arrived in Singapore for first job</label>
                <br/>
                <input class="form-control" name="narrivalYear" id="" type="text"/>
            </div>
            <div class='form-group'>
                <label for='nprevJob' class="control-label">Describe previous jobs and home breaks </label>
                <br/>
                <textarea class="form-control" name="nprevJob" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nprevProb' class="control-label">Describe problems in previous jobs</label>
                <br/>
                <textarea class="form-control" name="nprevProb" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about work history</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkHistory"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------->
<!--accomodation-->
<!---------------->
<%
} else if (complement.equals("waccom")) {
    ArrayList<String> accomTypes = DropdownDAO.retrieveAllDropdownListOfAccomType();
    ArrayList<String> accomProvideds = DropdownDAO.retrieveAllDropdownListOfAccomProvidedType();

%>

<form method="POST" id='accomodation_pop_up' action="addJobComplement.do" class="form complement_detailed_form job_pop_up"  >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nisProvided' class="control-label"><span style="color: red">*</span> Accommodation provided by employer?</label>
                <br/>
                <select class="form-control" id="accomProvided" name="nisProvided"  >
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String accomProvided : accomProvideds) {
                    %>        
                    <option value="<%=accomProvided%>"><%=accomProvided%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class='form-group' id="accomProvided_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="nisProvidedMore" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='ntype' class="control-label">Type of accommodation</label>
                <br/>

                <select class="form-control" id="accomType" name="ntype"  >
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String accomtype : accomTypes) {
                    %>
                    <option value="<%=accomtype%>"><%=accomtype%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="accomtype_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="ntypeMore" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Location of accommodation</label>
                <br/>
                <textarea class="form-control" name="nlocationAccom" rows="3" ></textarea>
            </div>

            <div class='form-group'>
                <label for='ncondition' class="control-label">Conditions at living quarters</label>
                <br/>
                <textarea class="form-control" name="ncondition" rows="3" ></textarea>
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
                <textarea class="form-control" name="nmeal" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nfrom' class="control-label">When start staying here?</label>
                <br/>
                <input class="form-control" type='text' name="nfrom">
            </div>
            <div class='form-group'>
                <label for='nto' class="control-label">When stop staying here?</label>
                <br/>
                <input class="form-control" type='text' name="nto">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about accommodation</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="Accommodation"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------->
<!--ipa-->
<!------->
<%
} else if (complement.equals("ipa")) {
    ArrayList<String> ipatypes = DropdownDAO.retrieveAllDropdownListOfIPAPassType();
%>

<form method="POST" id='ipa_pop_up' action="addJobComplement.do" 
      class="form complement_detailed_form job_pop_up"  >

    <div class='form-group'>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nworkpassType' class="control-label"><span style="color: red">*</span> Workpass specified in IPA</label>
                <br/>
                <select class="form-control" id="ipapassType" name="nworkpassType">
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String ipatype : ipatypes) {
                    %>
                    <option value="<%=ipatype%>"><%=ipatype%></option>
                    <%

                        }
                    %>  
                </select>

            </div>

            <div class='form-group' id='ipapassType_other_div' >
                <label for='nworkpassTypeMore' class="control-label">Explain if above is 'other'</label>
                <br/>
                <textarea class="form-control" name="nworkpassTypeMore" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nappDate' class="control-label">IPA application date</label>
                <br/>
                <input class="form-control dateInput apdateToRemove col-md-9" type='text' name="nappDate" style="width:90%" >
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="ap" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
<br/><br/>
            </div>
            <div class='form-group'>
                <label for='nempName' class="control-label">IPA employer name</label>
                <br/>
                <input class="form-control" type='text' name="nempName">
            </div>

            <div class='form-group'>
                <label for='nagentName' class="control-label">IPA agent name</label>
                <br/>
                <input class="form-control" type='text' name="nagentName">
            </div>

            <div class='form-group'>
                <label for='nindustry' class="control-label">IPA industry</label>
                <br/>
                <input class="form-control" type='text' name="nindustry">
            </div>
            <div class='form-group'>
                <label for='nipaoccupation' class="control-label">IPA occupation</label>
                <br/>
                <input class="form-control" type='text' name="nipaoccupation">
            </div>
            <div class='form-group'>
                <label for='nperiods' class="control-label">IPA period of pass(Years)</label>
                <br/>
                <input class="form-control" type='text' name="nperiods">
            </div>
            <div class='form-group'>
                <label for='nbasicSalary' class="control-label">IPA basic monthly salary (S$)</label>
                <br/>
                <input class="form-control" type='text' name="nbasicSalary">
            </div>
            <div class='form-group'>
                <label for='ntotalAllowance' class="control-label">IPA total allowance(S$)</label>
                <br/>
                <input class="form-control" type='text' name="ntotalAllowance">
            </div>
            <div class='form-group'>
                <label for='nallowanceDetails' class="control-label">IPA allowance details</label>
                <br/>
                <textarea class="form-control" name="nallowanceDetails" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='ndeduction' class="control-label">IPA total deduction(S$)</label>
                <br/>
                <input class="form-control" type='text' name="ntotalDeduction">
            </div>
            <div class='form-group'>
                <label for='ndeductionDetails' class="control-label">IPA deduction details</label>
                <br/>
                <textarea class="form-control" name="ndeductionDetails" rows="3" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nisHousingProvided' class="control-label">Housing provided?</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nisHousingProvided">
                    <option selected>No</option>
                    <option>Yes</option>
                </select>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about IPA</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" ></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="IPA"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------------------------->
<!---Problem Complements--->  
<!------------------------->

<!------------------------>
<!--police report lodged-->
<!------------------------>
<%
} else if (complement.equals("policareport")) {
    ArrayList<String> complaintWho = DropdownDAO.retrieveAllDropdownListOfComplaint();
    ArrayList<String> complaintMode = DropdownDAO.retrieveAllDropdownListOfComplaintMode();
%>

<form method="POST" id='policareport_pop_up' action="addProblemComplement.do" class="form complement_detailed_form problem_pop_up"  >
    <div class='add_comp'>
        <div class='form-group '>
            <label for='date' class="control-label"><span style="color: red">*</span> Date police report made</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%= sdf.format(today)%>">
        </div>
        <div class='form-group '>
            <label for='date' class="control-label">Police Station where report lodged</label>
            <br/>
            <input class="form-control" type='text' name="npoliceReportStation" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Accompanying TWC2 person</label>
            <br/>
            <input class="form-control" type='text' name="npoliceReportPerson">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Police report ref number</label>
            <br/>
            <input class="form-control" type='text' name="npoliceReportRefNumber" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Details of police report</label>
            <br/>
            <textarea class="form-control" name="npoliceReportDetails" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remarks about police report</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="policareport"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!-------------------------->
<!--other complaint lodged-->
<!-------------------------->
<%
} else if (complement.equals("othercomplaint")) {
    ArrayList<String> complaintWho = DropdownDAO.retrieveAllDropdownListOfComplaint();
    ArrayList<String> complaintMode = DropdownDAO.retrieveAllDropdownListOfComplaintMode();
%>

<form method="POST" id='othercomplaint_pop_up' action="addProblemComplement.do"  
      class="form complement_detailed_form problem_pop_up"  >
    <div class='add_comp'>
        <div class='form-group '>
            <label for='date' class="control-label"><span style="color: red">*</span> Date other complaint lodged</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>" >
        </div>
        <div class='form-group '>
            <label for='date' class="control-label"><span style="color: red">*</span> Agency/authority to whom complaint addressed</label>
            <br/>
            <input class="form-control" type='text' name="ncomplaintAgency" >
        </div>
        <div class='form-group'>
            <label for='complaintWho' class="control-label"><span style="color: red">*</span> This complaint is lodged by</label>
            <br/>
            <select class="form-control" id="complaintWho" name="ncomplaintWho">
                <%
                    for (String complaintType : complaintWho) {
                        if (complaintType.equals("Worker")) {
                %>
                <option selected><%=complaintType%></option>
                <%
                } else {
                %>
                <option><%=complaintType%></option>
                <%}
                    }%>  
            </select>
        </div>

        <div class='form-group' id="complaintWho_other_div" >
            <label for='location' class="control-label">If TWC2 or third party, name of person lodging complaint</label>
            <br/>
            <input class="form-control" type='text' name="ncomplaintWhoMore">
        </div>
        <div class='form-group'>
            <label for='complaintMode' class="control-label">Mode of lodging complaint</label>
            <br/>
            <select class="form-control" id="complaintMode" name="ncomplaintMode" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String complaintM : complaintMode) {
                %>
                <option value="<%=complaintM%>"><%=complaintM%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="complaintMode_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="ncomplaintModeMore" rows="3"></textarea>
        </div>
        <div class='form-group '>
            <label for='date' class="control-label">Details of complaint lodged</label>
            <br/>
            <textarea class="form-control" name="ncomplaintDetails" rows="3"></textarea>
        </div>
        <div class='form-group '>
            <label for='date' class="control-label">Remarks about this complaint</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="othercomplaint"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>

<%
} else if (complement.equals("ttr")) {
    ArrayList<String> ttrList = DropdownDAO.retrieveAllDropdownListOfTTRStatus();
%>
<form method="POST" id='ttr_pop_up' action="addProblemComplement.do"  class="form complement_detailed_form problem_pop_up"  >

    <!--Problem add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='ttrUpdate' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='nttrStatus' class="control-label"><span style="color: red">*</span> Transfer, TJS or repatriation status</label>
            <br/>
            <select class="form-control" id="ttrStatus" name="nttrStatus" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String tempStatus : ttrList) {
                %>
                <option value="<%=tempStatus%>"><%=tempStatus%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="ttrStatus_other_div" >
            <label for='nttrStatusMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="nttrStatusMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='ttrDepartureDate' class="control-label">Date of departure from Singapore</label>
            <br/>
            <input class="form-control" type='text' name="nttrDepartureDate">
        </div>
        <div class='form-group'>
            <label for='ttrEmployerName' class="control-label">Name of TJS or new employer</label>
            <br/>
            <input class="form-control" type='text' name="nttrEmployerName">
        </div>
        <div class='form-group'>
            <label for='ttrJob' class="control-label">Description of TJS or new job </label>
            <br/>
            <textarea class="form-control" name="nttrJob" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='nremark' class="control-label">Remarks about transfer, TJS or repatriation</label>
            <br/>
            <textarea class="form-control" name="nttrremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="ttr"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form> 

<!---------------------->
<!--criminal milestone-->
<!---------------------->
<%} else if (complement.equals("cmilestone")) {
    ArrayList<String> crList = DropdownDAO.retrieveAllDropdownListOfMilestoneCriminal();
%>

<form method="POST" action="addProblemComplement.do"  id='milestonecr_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='nmilestoneCRDate' class="control-label"><span style="color: red">*</span> Date milestone reached</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='nmilestoneCRReached' class="control-label"><span style="color: red">*</span> Milestone reached</label>
            <br/>
            <select class="form-control" id="ncReached" name="nmilestoneCRReached">
                <option value="" selected>Select from list...</option>
                <%
                    for (String reached : crList) {
                %>
                <option value="<%=reached%>"><%=reached%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="ncReached_other_div" >
            <label for='nmilestoneCRReachedMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="nmilestoneCRReachedMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRCharges' class="control-label">Details of charges</label>
            <br/>
            <textarea class="form-control" name="nmilestoneCRCharges" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRSentence' class="control-label">Details of sentence</label>
            <br/>
            <textarea class="form-control" name="nmilestoneCRSentence" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='remark' class="control-label">Remarks re milestone reached</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="cmilestone"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>

<!-------------------------->
<!--non criminal milestone-->
<!-------------------------->
<%} else if (complement.equals("ncmilestone")) {
    ArrayList<String> ncList = DropdownDAO.retrieveAllDropdownListOfMilestoneNonCriminal();
%>

<form method="POST" action="addProblemComplement.do"  id='milestonenc_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='milestoneNCDate' class="control-label"><span style="color: red">*</span> Date milestone reached</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='nmilestoneNCReached' class="control-label"><span style="color: red">*</span> Milestone reached</label>
            <br/>
            <select class="form-control" id="ncReached" name="nmilestoneNCReached" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String reached : ncList) {
                %>
                <option value="<%=reached%>"><%=reached%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="ncReached_other_div" >
            <label for='nmilestoneNCReachedMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="nmilestoneNCReachedMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneNCRem' class="control-label">Remarks about milestone reached</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="ncmilestone"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form>

<!------------------->
<!--r2r appointment-->
<!------------------->
<%} else if (complement.equals("r2r")) {
%>

<form method="POST" action="addProblemComplement.do"  id='r2r_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='r2rDate' class="control-label"><span style="color: red">*</span> Date of appointment</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='r2rTime' class="control-label">Time of appointment</label>
            <br/>
            <input class="form-control" type='text' name="nr2rTime">
        </div>
        <div class='form-group'>
            <label for='r2rHosp' class="control-label"><span style="color: red">*</span>Hospital for appointment</label>
            <br/>
            <input class="form-control" type='text' name="nr2rHosp">
        </div>
        <div class='form-group'>
            <label for='r2rDept' class="control-label">Department/doctor for appointment</label>
            <br/>
            <input class="form-control" type='text' name="nr2rDept">
        </div>
        <div class='form-group'>
            <label for='r2r1' class="control-label">R2R first volunteer</label>
            <br/>
            <input class="form-control" type='text' name="nr2r1">
        </div>
        <div class='form-group'>
            <label for='r2r2' class="control-label">R2R second volunteer</label>
            <br/>
            <input class="form-control" type='text' name="nr2r2">
        </div>
        <div class='form-group'>
            <label for='r2rPurpose' class="control-label">Purpose of appointment</label>
            <br/>
            <input class="form-control" type='text' name="nr2rPurpose">
        </div>
        <div class='form-group'>
            <label for='r2rPreApptNotes' class="control-label">Pre-appointment notes</label>
            <br/>
            <textarea class="form-control" name="nr2rPreApptNotes" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rPostApptNotes' class="control-label">Post-appointment notes</label>
            <br/>
            <textarea class="form-control" name="nr2rPostApptNotes" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rFeedback' class="control-label">Feedback</label>
            <br/>
            <textarea class="form-control" name="nr2rFeedback" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rMed' class="control-label">Medical cost of this appt(S$)</label>
            <br/>
            <input class="form-control" type='text' name="nr2rMed">
        </div>
        <div class='form-group'>
            <label for='r2rOut' class="control-label">How much paid by volunteer</label>
            <br/>
            <input class="form-control" type='text' name="nr2rOut">
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="r2r"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form>

<!------------->
<!--mc stauts-->
<!------------->
<%} else if (complement.equals("mc")) {
    ArrayList<String> statusList = DropdownDAO.retrieveAllDropdownListOfMCStatus();
%>

<form method="POST" action="addProblemComplement.do"  id='mc_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <!--add-->
    <div class='add_comp'>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Current MC or light Duty status</label>
            <br/>
            <select class="form-control" id="nmcStatus" name="nmcStatus">
                <option value="" selected>Select from list...</option>
                <%
                    for (String statusObj : statusList) {
                %>
                <option value="<%=statusObj%>"><%=statusObj%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group'>
            <label for='location' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="nmcStatusMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Latest known MC expiry date</label>
            <br/>
            <input class="form-control dateInput" type='text' name="nexpDate">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Cumulative MC days so far</label>
            <input class="form-control" type='text' name="nexpCum">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remarks about MC status</label>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="mc"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</div>



</form>

<!------------>
<!--hospital-->
<!------------>
<%} else if (complement.equals("hospital")) {
    ArrayList<String> names = DropdownDAO.retrieveAllDropdownListOfHosipital();
%>

<form method="POST"  action="addProblemComplement.do"  id='hospital_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <!--add-->
    <div class='add_comp'>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Current hospital</label>
            <br/>
            <select class="form-control" id="nhospName" name="nhospName" >
                <option value="" selected>Select from list...</option>
                <%            for (String name : names) {
                %>
                <option value="<%=name%>"><%=name%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="nhospName_other_div" >
            <label for='nhospNameMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="nhospNameMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='nhospDoctor' class="control-label">Department/doctor within hospital if known</label>
            <br/>
            <input class="form-control" type='text' name="nhospDoctor">
        </div>
        <div class='form-group'>
            <label for='nremark' class="control-label">Remarks about hospital</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="hospital"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------------------->
<!--non wica claim lodged-->
<!------------------------->
<%} else if (complement.equals("nonwicaclaim")) {
%>

<form method="POST"  action="addProblemComplement.do"  id='nonwicaclaim_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label"><span style="color: red">*</span> Date MOM notified</label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
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
                <label for='remark' class="control-label">Remarks about medical claim</label>
                <br/>
                <textarea class="form-control" name="nNWicaremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="nonwicaclaim"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--------------->
<!--Wica status-->
<!--------------->
<%} else if (complement.equals("wica")) {
    ArrayList<String> wicaList = DropdownDAO.retrieveAllDropdownListOfWica();
%>

<form method="POST"  action="addProblemComplement.do"  id='wica_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <div class='add_comp'>

        <div class='form-group'>
            <label for='nwicaUpdate' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='nwicaStatus' class="control-label"><span style="color: red">*</span> WICA status </label>
            <br/>
            <select class="form-control" id="nwicaStatus" name="nwicaStatus" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String tempStatus : wicaList) {
                %>
                <option value="<%=tempStatus%>"><%=tempStatus%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="wicaStatus_other_div" >
            <label for='nwicaStatusMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="nwicaStatusMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='nwicaPoints' class="control-label">WICA points</label>
            <br/>
            <input class="form-control" type='text' name="nwicaPoints">
        </div>
        <div class='form-group'>
            <label for='nwicaDollars' class="control-label">WICA S$ compensation</label>
            <br/>
            <input class="form-control" type='text' name="nwicaDollars">
        </div>
        <div class='form-group'>
            <label for='nwicaRemarks' class="control-label">Remarks about WICA status </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="wica"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--------------------->
<!--wica claim lodged-->
<!--------------------->
<%} else if (complement.equals("wicaclaim")) {
%>

<form method="POST" action="addProblemComplement.do"  id='wicaclaim_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label">Date claim lodged at MOM</label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndateWica">
            </div>
            <div class='form-group'>
                <label for='nrefNumber' class="control-label"><span style="color: red">*</span> WICA reference number</label>
                <br/>
                <input class="form-control" type='text' name="nrefNumber">
            </div>
            <div class='form-group'>
                <label for='ninsurer' class="control-label">WICA insurance company</label>
                <br/>
                <input class="form-control" type='text' name="ninsurer">
            </div>
            <div class='form-group'>
                <label for='npolicyNumber' class="control-label">WICA insurance policy number</label>
                <br/>
                <input class="form-control" type='text' name="npolicyNumber">
            </div>
            <div class='form-group'>
                <label for='nreason' class="control-label">State whether initially lodged by lawyer, worker or TWC2</label>
                <br/>
                <textarea class="form-control" name="nreason" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about WICA claim</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="wicaclaim"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!------------------->
<!--illness history-->
<!------------------->
<%} else if (complement.equals("illnesscase")) {
%>

<form method="POST" action="addProblemComplement.do"  id='illnesscase_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nstartTime' class="control-label"><span style="color: red">*</span> When illness began</label>
                <br/>
                <input class="form-control" type='text' name="nstartTime">
            </div>
            <div class='form-group'>
                <label for='ndiagnoseTime' class="control-label">When illness diagnosed</label>
                <br/>
                <input class="form-control" type='text' name="ndiagnoseTime">
            </div>
            <div class='form-group'>
                <label for='ndiagnosePerson' class="control-label">Who (doctor/hospital name) diagnosed</label>
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
            <div class='form-group' id='workRelatedYes_div'>
                <label for='nworkRelatedYes' class='control-label'>If worker thinks work-related, why?</label>
                <br/>
                <textarea class="form-control" name="nworkRelatedYes" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about illness history</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="illnesscase"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!------------------>
<!--injury history-->
<!------------------>
<%} else if (complement.equals("injurycase")) {
%>

<form method="POST" action="addProblemComplement.do"  id='injurycase_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label"><span style="color: red">*</span> Date of injury</label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>">
            </div>
            <div class='form-group'>
                <label for='ntime' class="control-label">Approx time of injury</label>
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
                <label for='nhowinjury' class="control-label">How injury happened</label>
                <br/>
                <textarea class="form-control" name="nhowinjury" rows="3"></textarea>
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
                <label for='ntreatement' class="control-label">Where (clinic/Hospital) initially treated</label>
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
                <label for='nremark' class="control-label">Remarks about injury history</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="injurycase"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!------------------->
<!--case discussion-->
<!------------------->
<%} else if (complement.equals("casediscussion")) {
    ArrayList<String> locations = DropdownDAO.retrieveAllDropdownListOfDiscussWhere();
%>

<form method="POST" action="addProblemComplement.do"  id='casediscussion_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <div class='add_comp'>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date of discussion, assistance or information-receipt</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate"  value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Approx time of event</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTime" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Mode/Location of discussion, assistance or information-receipt</label>
            <br/>
            <select class="form-control" id="discussionWhere" name="ndiscussionWhere" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String location : locations) {
                %>
                <option value="<%=location%>"><%=location%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="discussionWhere_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="ndiscussionWhereMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Was worker participating</label>
            <br/>
            <select class="form-control" id="isworkerpresent" name="ndiscussionWorkerPresent">
                <option selected>Yes</option>
                <option>No</option>
            </select>
        </div>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> TWC2 person consulted, assisting or informed</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTWC2P1" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Names of other TWC2 persons present</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTWC2P2" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Names of other persons present</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionOtherPerson" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Name of translator(s) present</label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTranslator" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Topic of discussion/information received  </label>
            <br/>
            <input class="form-control" type='text' name="ndiscussionTopic" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Gist of discussion or new information received</label>
            <br/>
            <textarea class="form-control" name="ndiscussionGist" rows="4"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Immediate assistance or referral provided</label>
            <br/>
            <textarea class="form-control" name="ndiscussionAssist" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Updated calculation of claim value</label>
            <br/>
            <textarea class="form-control" name="ndiscussionCal" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Action to follow</label>
            <br/>
            <textarea class="form-control" name="ndiscussionAction" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Internal remarks about discussion</label>
            <br/>
            <textarea class="form-control" name="ninternalRemarks" rows="3"></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="casediscussion"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!----------------------->
<!--salary claim lodged--> 
<!-----------------------> 
<%
} else if (complement.equals("salarycalim")) {
%>

<form method="POST" action="addProblemComplement.do"  id='salarycalim_pop_up' 
      class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='ndate' class="control-label"><span style="color: red">*</span> Date claim lodged at MOM</label>
                <br/>
                <input class="form-control dateInput" type='text' name="ndate" value='<%=sdf.format(today)%>'>
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
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!---------------------------->
<!--Salary & Related history-->
<!---------------------------->
<%} else if (complement.equals("salaryhistory")) {
    ArrayList<String> modeOfPayment = DropdownDAO.retrieveAllDropdownListOfSalaryMode();
%>

<form method="POST" action="addProblemComplement.do"  id='salaryhistory_pop_up' 
      class="form complement_detailed_form problem_pop_up"  >
    <div class='form-group'>
        <div class='add_comp'>
            <div class='form-group'>
                <label for='nbasic' class="control-label"><span style="color: red">*</span> Describe complaint about basic salary incorrect or not paid</label>
                <br/>
                <textarea class="form-control" name="nbasicSal" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='novertime' class="control-label">Describe complaint about overtime incorrect or not paid</label>
                <br/>
                <textarea class="form-control" name="novertime" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nallowance' class="control-label">Describe complaint about allowance incorrect or not paid</label>
                <br/>
                <textarea class="form-control" name="nallowance" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='ndeduction' class="control-label">Describe complaint about deductions</label>
                <br/>
                <textarea class="form-control" name="ndeduction" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nkickbacks' class="control-label">Describe complaint about kickbacks</label>
                <br/>
                <textarea class="form-control" name="nkickbacks" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nother' class="control-label">Other related details</label>
                <br/>
                <textarea class="form-control" name="notherSal" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nmode' class="control-label">Mode of salary payment</label>
                <br/>
                <select class="form-control" id="mode" name="nmode" >
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String pmode : modeOfPayment) {
                    %>
                    <option value="<%=pmode%>"><%=pmode%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id='mode_other_div' >
                <label for='nmodeMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="nmodeMore" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='ntotalLoss' class="control-label">Estimated total value of claim (S$)</label>
                <br/>
                <input class="form-control" type='text' name="ntotalLoss">
            </div>
            <div class='form-group'>
                <label for='noneYearLoss' class="control-label">Estimated 12 months' value of claim(S$)</label>
                <br/>
                <input class="form-control" type='text' name="noneYearLoss">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about salary & related history</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="salaryhistory"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------------------->
<!--law Firm status-->
<!------------------->
<%} else if (complement.equals("lawyer")) {
    ArrayList<String> lawFirmNameList = DropdownDAO.retrieveAllDropdownListOfLawFirms();
%>

<form method="POST" action="addProblemComplement.do"  id='lawyer_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='lawyerUpdate' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate"  value="<%=sdf.format(today)%>">
        </div>
        <div class='form-group'>
            <label for='lawyerFirm' class="control-label"><span style="color: red">*</span> Current law firm</label>
            <br/>
            <select class="form-control" id="nlawyerFirm" name="nlawyerFirm" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String lawFirmName : lawFirmNameList) {
                %>
                <option value="<%=lawFirmName%>"><%=lawFirmName%></option>
                <%
                    }
                %>
            </select>
        </div>
        <div class='form-group' id="nlawyerFirm_other_div" >
            <label for='lawyerHave' class="control-label">Explain if above is 'other'</label>
            <br/>
            <textarea class="form-control" name="nlawyerFirmMore" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='lawyerHave' class="control-label">Name of lawyer or assistant</label>
            <br/>
            <input class="form-control" type='text' name="nlawyerName">
        </div>
        <div class='form-group'>
            <label for='lawyerRemark' class="control-label">Remarks re lawyer law firm status</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="lawyer"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------------------->
<!--Auxiliary Case Worker-->   
<!------------------------->
<%} else if (complement.equals("auxcaseworker")) {
    ArrayList<String> auxiliaryCaseworkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>

<form method="POST" action="addProblemComplement.do"  id='auxcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nauxiliaryCaseWorkerName' class="control-label"><span style="color: red">*</span> Auxiliary caseworker</label>
                <br/>
                <select class="form-control" id="leadCaseWorker" name="nauxiliaryCaseWorkerName">
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String auxiliaryCaseWorkerName : auxiliaryCaseworkerNameList) {
                    %>
                    <option value="<%=auxiliaryCaseWorkerName%>"><%=auxiliaryCaseWorkerName%></option>
                    <%

                        }
                    %>  
                </select>

            </div>
            <div class='form-group'>
                <label for='nstartDate' class="control-label">Start date</label>
                <br/>
                <input class="form-control col-md-9 startDate startdateToRemove" type='text' name="nstartDate" value="<%=sdf.format(today)%>" style="width: 90%;"/>
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="start" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <div class='form-group'>
                <label for='nendDate' class="control-label">End date</label>
                <br/>
                <input class="form-control endDate enddateToRemove col-md-9" type='text' name="nendDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="end" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <br/>
            <br/>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="auxcaseworker"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!-------------------->
<!--Lead Case Worker--> 
<!-------------------->
<%} else if (complement.equals("leadcaseworker")) {
    ArrayList<String> leadCaseWorkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>

<form method="POST" action="addProblemComplement.do"  id='leadcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='nleadCaseWorkerName' class="control-label"><span style="color: red">*</span> Lead caseworker</label>
                <br/>
                <select class="form-control" id="leadCaseWorker" name="nleadCaseWorkerName">
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String leadCaseWorkerName : leadCaseWorkerNameList) {
                    %>
                    <option value="<%=leadCaseWorkerName%>"><%=leadCaseWorkerName%></option>
                    <%

                        }
                    %>  
                </select>

            </div>
            <div class='form-group'>
                <label for='nstartDate' class="control-label startDate">Start date</label>
                <br/>
                <input class="form-control" type='text' name="nstartDate" value="<%=sdf.format(today)%>"/>


            </div>
            <div class='form-group'>
                <label for='nendDate' class="control-label">End date</label>
                <br/>
                <input class="form-control endDate enddateToRemove col-md-9" type='text' name="nendDate" style="width:90%">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="end" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>

            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="leadcaseworker"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn ">Save</button>
                <button type='button' class='btn modal_btn  cancel_btn'>Cancel</button>
            </div>
        </div>

    </div>
</form>

<!--------------------->
<!--aggravating Issue-->
<!--------------------->
<%} else if (complement.equals("aggravissue")) {
    ArrayList<String> problemTypes = DropdownDAO.retrieveAllDropdownListOfProblems();
%>

<form method="POST" action="addProblemComplement.do"  id='aggravIssue_pop_up' 
      class="form complement_detailed_form problem_pop_up"  >
    <div class='form-group'>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='naggravissueType' class="control-label"><span style="color: red">*</span> Aggravating issue</label>
                <br/>
                <select class="form-control" id="aggravissueType" name="naggravissueType" >
                    <option value="" selected>Select from list...</option>
                    <%
                        for (String aggravissueType : problemTypes) {
                    %>
                    <option value="<%=aggravissueType%>"><%=aggravissueType%></option>
                    <%

                        }
                    %>  
                </select>

            </div>

            <div class='form-group' id='aggravissueType_other_div' >
                <label for='naggravissueTypeMore' class="control-label">Explain if above is other</label>
                <br/>
                <textarea class="form-control" name="naggravissueTypeMore" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='naggravLoss' class="control-label">Monetary loss/value of this aggravating issue S$</label>
                <br/>
                <input class="form-control" type='text' name="naggravLoss">
            </div>
            <div class='form-group'>
                <label for='nRemark' class="control-label">Remarks about aggravating issue </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="aggravissue"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------------------------------> 
<!--Details & history of other Problems-->   
<!---------------------------------------> 
<%    } else if (complement.equals("othercase")) {
%>
<form method="POST" action="addProblemComplement.do"  id='othercase_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>

        <div class='form-group'>
            <label for='nother' class="control-label"><span style="color: red">*</span> Details of problem if it's not salary/injury/illness</label>
            <br/>
            <textarea class="form-control" name="nother" rows="3"></textarea>
        </div>

        <div class='form-group'>
            <label for='nloss' class="control-label">Estimated value of claim S$</label>
            <br/>
            <input class="form-control" type='text' name="nloss">
        </div>
        <div class='form-group'>
            <label for='nremark' class="control-label">Remarks about history of other problems</label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="othercase"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>
<%    }
%>

