<%-- 
    Document   : jobViewEditPopUp
    Created on : Nov 6, 2014, 5:24:37 PM
    Author     : Nyein Su
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<style>
    h4{
        color: #AF4454;
    }

</style>
<script>
    //----initialize datepicker----//
    $(function() {
        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true
        });

    });

    //----disable manual input in date fields----//
    $(document).ready(function() {
        $('.dateInput').focus(function() {
            $('.dateInput').blur();
        });
    });
    $(document).ready(function() {
        $('.cancel_btn').addClass('pull-right');
        $('.form-control').addClass('input-sm');
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
                            message: 'Remarks must be less than 200 characters.'
                        }
                    }
                },
                npasstype: {
                    validators: {
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
                            message: 'Remarks must be less than 200 characters.'
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
                            message: 'Remarks must be less than 1000 characters.'
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
                totalDeduction: {
                    validators: {
                        numeric: {
                            message: 'Deduction must be a number.'
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
                ntotalDeduction: {
                    validators: {
                        numeric: {
                            message: 'Deduction must be a number.'
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

</script>
<!---------------->
<!--pass details-->
<!---------------->
<%
    /* data collection */
    //worker complement passed data
    String worker_fin = request.getParameter("workerFin");
    String jobKey = request.getParameter("jobkey");         //passed from viewWorker.jsp

    //job complement passed data

    String passId = request.getParameter("passdetails");
    String empId = request.getParameter("empdetails");
    String empcontract = request.getParameter("empcontract");
    String agent = request.getParameter("agent");
    String assurance = request.getParameter("assurance");
    String wplace = request.getParameter("wplace");
    String whistory = request.getParameter("whistory");
    String waccom = request.getParameter("waccom");
    String ipa = request.getParameter("ipa");

    //end of data collection
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    if (passId != null) {
        int id = Integer.parseInt(passId);
        JobPassDetails pass = JobComplementsDAO.retrieveJobPassDetailsById(id);
        ArrayList<String> workpassTypes = DropdownDAO.retrieveAllDropdownListOfWorkpassType();
%>

<form method="POST" id='passdetails_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Pass Details</h4>
    <h4 class='add_comp'>Add A New Pass </h4>
    <h4 class='edit_comp'>Edit Pass  Details</h4>
    <div class='form-group'>


        <%
            String passtype = pass.getPassType();
            String passtypeMore = pass.getPassTypeMore();
            String passnum = pass.getPassNum();
            String issuer = pass.getIssuer();
            String remark = pass.getRemarks();

        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='passtype' class="control-label">Pass Type:</label>
                    <br/>
                    <input class="form-control" type='text' name="passtype" value="<%=passtype%>">
                </div>
                
                <div class="form-group" id="passtype_other_div">
                    <label for="passtypeMore" class="control-label">Explain if above is 'Other':</label><br/>
                    <input class="form-control" type='text' name="npasstypeMore" 
                           value="<%=(passtypeMore==null)?"":passtypeMore%>">
                </div>
                <div class='form-group'>
                    <label for='passno' class="control-label">Pass Number:</label>
                    <br/>
                    <input class="form-control" type='text' name="passno" value="<%=passnum%>">
                </div>
                <div class='form-group'>
                    <label for='apdate' class="control-label">Pass Application Date:</label>
                    <br/>
                    <input class="form-control" type='text' name="apdate" 
                           value="<%=(pass.getPassApplicationDate() == null) ? "" : 
                               sdf.format(pass.getPassApplicationDate())%>">
                </div>
                <div class='form-group'>
                    <label for='isdate' class="control-label">Pass Issue Date: </label>
                    <br/>
                    <input class="form-control" type='text' name="isdate" 
                           value="<%=(pass.getIssueDate() == null) ? "" : 
                               sdf.format(pass.getIssueDate())%>">
                </div>
                <div class='form-group'>
                    <label for='exdate' class="control-label">Pass Expiry Date: </label>
                    <br/>
                    <input class="form-control" type='text' name="exdate" 
                           value="<%=(pass.getExpiryDate() == null) ? "" : 
                               sdf.format(pass.getExpiryDate())%>">
                </div>
                <div class='form-group'>
                    <label for='issuer' class="control-label">Pass Issuing Agency:</label>
                    <br/>
                    <input class="form-control" type='text' name="issuer" value="<%=issuer%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about Pass: </label>

                    <br/>
                    <textarea class="form-control" name="remark" rows="3" maxlength="200"><%=remark%></textarea>
                </div>
                <div class='form-group'>
                    <label for='obsoleteDate' class="control-label">Date Discovered to be Obsolete: </label>
                    <br/>
                    <input class="form-control" type='text' name="obsoleteDate" 
                           value="<%=(pass.getObsoleteDate() == null) ? "" : 
                               sdf.format(pass.getObsoleteDate())%>">
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#passdetails_pop_up", "job")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#passdetails_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='npasstype' class="control-label">Pass Type<span style="color: red">*</span>:</label>
                <br/>
                <select class="form-control" id="passtype" name="npasstype">
                    <option value="">Select Pass Type:</option>
                    <%
                        for (String workpassType : workpassTypes) {
                    %>
                    <option vlue="<%=workpassType%>"><%=workpassType%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class="form-group" id="passtype_other_div">
                <label for="passtypeMore" class="control-label">Explain if above is 'Other':</label><br/>
                <input class="form-control" type='text' name="npasstypeMore">
            </div>    
            <div class='form-group'>
                <label for='npassno' class="control-label">Pass Number<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="npassno" >
            </div>
            <div class='form-group'>
                <label for='napdate' class="control-label">Pass Application Date:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="napdate" >
            </div>
            <div class='form-group'>
                <label for='nisdate' class="control-label">Pass Issue Date: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="nisdate" >
            </div>
            <div class='form-group'>
                <label for='nexdate' class="control-label">Pass Expiry Date: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="nexdate" >
            </div>
            <div class='form-group'>
                <label for='nissuer' class="control-label">Pass Issuing Agency:</label>
                <br/>
                <input class="form-control" type='text' name="nissuer" >
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about Pass: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200" ></textarea>
            </div>
            <div class='form-group'>
                <label for='nobsoleteDate' class="control-label">Date Discovered to be Obsolete: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="nobsoleteDate" >
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="JobPassDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='passtype' class="control-label">Pass Type<span style="color: red">*</span>:</label>
                <br/>
                <select class="form-control" id="passtypeEdit" name="passtype">
                    <%
                        for (String workpassType : workpassTypes) {
                            if (passtype.equals(workpassType)) {

                    %>
                    <option selected><%=workpassType%></option>
                    <%
                    } else {

                    %>
                    <option><%=workpassType%></option>
                    <%

                            }
                        }
                    %>  
                </select>


            </div>
            <div class="form-group" id="passtype_other_div">
                <label for="passtypeMore" class="control-label">Explain if above is 'Other':</label><br/>
                <input class="form-control" type='text' name="passtypeMore" 
                           value="<%=(passtypeMore==null)?"":passtypeMore%>">    
            </div>     
            <div class='form-group'>
                <label for='passno' class="control-label">Pass Number<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="passno" value="<%=passnum%>">
            </div>
            <div class='form-group'>
                <label for='apdate' class="control-label">Pass Application Date:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="apdate" 
                       value="<%=(pass.getPassApplicationDate() == null) ? "" : 
                           sdf.format(pass.getPassApplicationDate())%>">
            </div>
            <div class='form-group'>
                <label for='isdate' class="control-label">Pass Issue Date: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="isdate" 
                       value="<%=(pass.getIssueDate() == null) ? "" : 
                           sdf.format(pass.getIssueDate())%>">
            </div>
            <div class='form-group'>
                <label for='exdate' class="control-label">Pass Expiry Date: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="exdate" 
                       value="<%=(pass.getExpiryDate() == null) ? "" : 
                           sdf.format(pass.getExpiryDate())%>">
            </div>
            <div class='form-group'>
                <label for='issuer' class="control-label">Pass Issuing Agency:</label>
                <br/>
                <input class="form-control" type='text' name="issuer" value="<%=issuer%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about Pass: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" maxlength="200"><%=remark%></textarea>
            </div>
            <div class='form-group'>
                <label for='obsoleteDate' class="control-label">Date Discovered to be Obsolete: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="obsoleteDate" 
                       value="<%=(pass.getObsoleteDate() == null) ? "" : 
                           sdf.format(pass.getObsoleteDate())%>">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="JobPassDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!--employer details--> 
<!-------------------->
<%
    }

    if (empId != null) {
        int id = Integer.parseInt(empId);
        JobEmployer emp = JobComplementsDAO.retrieveJobEmployerById(id);

%>

<form method="POST" id='empdetails_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Employer Details</h4>
    <h4 class='add_comp'>Add A New Employer </h4>
    <h4 class='edit_comp'>Edit Employer  Details</h4>
    <div class='form-group'>


        <%
            String name = emp.getEmployerOfficialName();
            String empid = emp.getEmployerID();
            String address = emp.getEmployerAddress();
            String contact = emp.getEmployerContacts();
            String person = emp.getEmployerPersons();
            String remark = emp.getEmployerRemarks();
        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Official Name of Employer:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='empid' class="control-label">ID of Employer:</label>
                    <br/>
                    <input class="form-control" type='text' name="empid" value="<%=empid%>">
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Employer Address:</label>
                    <br/>
                    <textarea class="form-control" name="address" rows="3" maxlength="200"><%=address%></textarea>
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Employer Phone, Email Contacts:</label>
                    <br/>
                    <textarea class="form-control" name="ncontact" rows="3" maxlength="200">
                        <%=(contact==null)?"":contact%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='person' class="control-label">Key Persons in Employer:</label>
                    <br/>
                    <textarea class="form-control" name="nperson" rows="3" maxlength="200">
                        <%=(person==null)?"":person%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about Employer: </label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3" maxlength="200">
                        <%=(remark==null)?"":remark%>
                    </textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#empdetails_pop_up", "job")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#empdetails_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nname' class="control-label">Official Name of Employer<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nname" required>
            </div>
            <div class='form-group'>
                <label for='nempid' class="control-label">ID of Employer:</label>
                <br/>
                <input class="form-control" type='text' name="nempid">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Employer Address: </label>
                <br/>
                <textarea class="form-control" name="naddress" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='ncontact' class="control-label">Employer Phone, Email Contacts:</label>
                <br/>
                <textarea class="form-control" name="ncontact" rows="3" maxlength="200">
                    <%=(contact==null)?"":contact%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='nperson' class="control-label">Key Persons in Employer:</label>
                <br/>
                <textarea class="form-control" name="nperson" rows="3" maxlength="200">
                    <%=(person==null)?"":person%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about Employer: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="EmployerDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='name' class="control-label">Official Name of Employer<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=name%>" required>
            </div>
            <div class='form-group'>
                <label for='empid' class="control-label">ID of Employer:</label>
                <br/>
                <input class="form-control" type='text' name="empid" value="<%=empid%>">
            </div>
            <div class='form-group'>
                <label for='address' class="control-label">Employer Address: </label>
                <br/>
                <textarea class="form-control" name="address" rows="3" maxlength="200">
                    <%=(address==null)?"":address%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='contact' class="control-label">Employer Phone, Email Contacts:</label>
                <br/>
                <textarea class="form-control" name="contact" rows="3" maxlength="200">
                    <%=(contact==null)?"":contact%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='person' class="control-label">Key Persons in Employer:</label>
                <br/>
                <textarea class="form-control" name="person" rows="3" maxlength="200">
                    <%=(person==null)?"":person%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about Employer: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" maxlength="200">
                    <%=(remark==null)?"":remark%>
                </textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="EmployerDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------------------------>
<!--Employment Contract--->   
<!------------------------>
<%

    }

    if (empcontract != null) {
        int id = Integer.parseInt(empcontract);
        JobEmploymentContract contract = JobComplementsDAO.retrieveEmploymentContractById(id);
%>

<form method="POST" id='contract_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Employment Contract Details</h4>
    <h4 class='add_comp'>Add A New Employment Contract </h4>
    <h4 class='edit_comp'>Edit Employment Contract Details</h4>
    <div class='form-group'>


        <%
            String location = contract.getContractWhere();
            java.util.Date date = contract.getContractDate();
            String language = contract.getContractlanguage();
            String remark = contract.getContractRemarks();
            String opname = contract.getContractOppName();
            String oprelation = contract.getContractOppRelationship();
            String occupation = contract.getContractOccupation();
            String allowance = contract.getContractAllowances();
            String salary = contract.getContractBasicSalary();
            String deduction = contract.getContractDeductDetails();
            String duration = contract.getContractDuration();
            String duress = contract.getContractDuress();
            String shortname = contract.getShortName();
        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Contract Date:</label>
                    <br/>
                    <input class="form-control " type='text' name="name" 
                           value="<%=(date == null) ? "" : sdf.format(date)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where Contract Signed: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=location%>">
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Contract Language:</label>
                    <br/>
                    <input class="form-control" type='text' name="contact" value="<%=language%>">
                </div>
                <div class='form-group'>
                    <label for='person' class="control-label">Name of Opposite Contracting Party:</label>
                    <br/>
                    <input class="form-control" type='text' name="person" value="<%=opname%>">
                </div>
                <div class='form-group'>
                    <label for='empid' class="control-label">Relationship of Opposite Contracting Party to Job:</label>
                    <br/>
                    <textarea class="form-control" name="noprelation" rows="3" maxlength="200">
                        <%=(oprelation==null)?"":oprelation%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Occupation Stated in Contract: </label>
                    <br/>
                    <textarea class="form-control" name="noccupation" rows="3" maxlength="200">
                        <%=(occupation==null)?"":occupation%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Basic Salary: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=salary%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Allowance Details: </label>
                    <br/>
                    <textarea class="form-control"name="remark" rows="3"><%=allowance%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Deductions Details: </label>
                    <br/>
                    <textarea class="form-control"name="remark" rows="3"><%=deduction%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Length of Contract: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=duration%>">
                </div>
                <div class='form-group'>
                    <label for='duresss' class="control-label">Describe if signed under duress or misrepresentation: </label>
                    <br/>
                    <textarea class="form-control"name="duresss" rows="3"><%=duress%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about Contract: </label>
                    <br/>
                    <textarea class="form-control"name="duresss" rows="3"><%=remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#contract_pop_up", "job")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#contract_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='ncontdate' class="control-label">Contract Date<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="ncontdate">
            </div>
            <div class='form-group'>
                <label for='nlocation' class="control-label">Where Contract Signed: </label>
                <br/>
                <input class="form-control" type='text' name="nlocation">
            </div>
            <div class='form-group'>
                <label for='nlanguage' class="control-label">Contract Language:</label>
                <br/>
                <input class="form-control" type='text' name="nlanguage">
            </div>
            <div class='form-group'>
                <label for='nopname' class="control-label">Name of Opposite Contracting Party<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nopname">
            </div>
            <div class='form-group'>
                <label for='empid' class="control-label">Relationship of Opposite Contracting Party to Job:</label>
                <br/>
                <textarea class="form-control" name="noprelation" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Occupation Stated in Contract: </label>
                <br/>
                <textarea class="form-control" name="noccupation" rows="3" maxlength="200"></textarea>
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
                <label for='ndeduction' class="control-label">Deductions Details: </label>
                <br/>
                <textarea class="form-control" name="ndeduction" rows="3" maxlength="500"></textarea>
            </div>
            <div class='form-group'>
                <label for='nduration' class="control-label">Length of Contract: </label>
                <br/>
                <input class="form-control" type='text' name="nduration">
            </div>
            <div class='form-group'>
                <label for='nduress' class="control-label">Describe if signed under duress or misrepresentation: </label>
                <br/>
                <textarea class="form-control" name="nduress" rows="3" maxlength="500"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about Contract: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="ContractDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='contdate' class="control-label">Contract Date<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="contdate" 
                       value="<%=(date == null) ? "" : sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='location' class="control-label">Where Contract Signed:</label>
                <br/>
                <input class="form-control" type='text' name="location" value="<%=location%>">
            </div>
            <div class='form-group'>
                <label for='language' class="control-label">Contract Language:</label>
                <br/>
                <input class="form-control" type='text' name="language" value="<%=language%>">
            </div>
            <div class='form-group'>
                <label for='opname' class="control-label">Name of Opposite Contracting Party<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="opname" value="<%=opname%>">
            </div>
            <div class='form-group'>
                <label for='oprelation' class="control-label">Relationship of Opposite Contracting Party to Job:</label>
                <br/>
                <textarea class="form-control" name="oprelation" rows="3" maxlength="200">
                    <%=(oprelation==null)?"":oprelation%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='occupation' class="control-label">Occupation Stated in Contract: </label>
                <br/>
                <textarea class="form-control" name="occupation" rows="3" maxlength="200">
                    <%=(occupation==null)?"":occupation%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='salary' class="control-label">Basic Salary: </label>
                <br/>
                <input class="form-control" type='text' name="salary" value="<%=salary%>">
            </div>
            <div class='form-group'>
                <label for='allowance' class="control-label">Allowance Details: </label>
                <br/>
                <textarea class="form-control"name="allowance" rows="3"><%=allowance%></textarea>
            </div>
            <div class='form-group'>
                <label for='deduction' class="control-label">Deductions Details: </label>
                <br/>
                <textarea class="form-control"name="deduction" rows="3"><%=deduction%></textarea>
            </div>
            <div class='form-group'>
                <label for='duration' class="control-label">Length of Contract: </label>
                <br/>
                <input class="form-control" type='text' name="duration" value="<%=duration%>">
            </div>
            <div class='form-group'>
                <label for='duress' class="control-label">Describe if signed under duress or misrepresentation: </label>
                <br/>
                <textarea class="form-control"name="duress" rows="3"><%=duress%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about Contract: </label>
                <br/>
                <textarea class="form-control"name="remark" rows="3"><%=remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="ContractDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------------->       
<!--Intermediary Agent-->    
<!---------------------->
<%
    }

    if (agent != null) {
        int id = Integer.parseInt(agent);
        JobIntermediaryAgent wagent = JobComplementsDAO.retrieveJobIntermediaryAgentById(id);
        ArrayList<String> agentLocations = DropdownDAO.retrieveAllDropdownListOfAgentLocationType();
%>

<form method="POST" id='agent_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Intermediary Agent's Details</h4>
    <h4 class='add_comp'>Add A New Intermediary Agent</h4>
    <h4 class='edit_comp'>Edit Intermediary Agent's Details</h4>
    <div class='form-group'>


        <%
            String company = wagent.getAgentCompany();
            String person = wagent.getAgentPersonName();
            String address = wagent.getAgentAddress();
            String location = wagent.getAgentLocation();
            String locationMore = wagent.getAgentlocationMore();
            String contact = wagent.getAgentContact();
            double amtPaid = wagent.getAgentAmtPaid();
            double amtOwed = wagent.getAgentAmtOwed();
            String feeshared = wagent.getAgentFeeShared();
            String feeTraining = wagent.getAgentFeeTraining();
            String feeRepay = wagent.getAgentFeeRepay();
            String feeAirFare = wagent.getAgentFeeAirfare();
            String feeWhere = wagent.getAgentFeeWhere();
            String feeWhen = wagent.getAgentFeeWhen();
            String emp = wagent.getAgentEmployer();
            String remark = wagent.getAgentRemarks();

        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Agent Company Name:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=company%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Agent Key Person Name:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=person%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Location of Agent: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=location%>">
                </div>
                <div class="form-group" id="location_other_div">
                    <label for="locationMore" class="control-label">Explain if above is 'Other':</label><br/>
                    <input class="form-control" type='text' name="naglocationMore" 
                           value="<%=(locationMore==null)?"":locationMore%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Agent Address: </label>
                    <br/>
                    <textarea class="form-control" name="naddress" rows="3" maxlength="300">
                        <%=(address==null)?"":address%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Agent Phone/Email Contact: </label>
                    <br/>
                    <textarea class="form-control" name="ncontact" rows="3" maxlength="200">
                        <%=(contact==null)?"":contact%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='empid' class="control-label">Amount Paid To This Agent(S$):</label>
                    <br/>
                    <input class="form-control" type='text' name="empid" value="<%=amtPaid%>">
                </div>
                <div class='form-group'>
                    <label for='person' class="control-label">Amount Owed To This Agent at the Start of Work(S$):</label>
                    <br/>
                    <input class="form-control" type='text' name="person" value="<%=amtOwed%>">
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Any Suspicion Fee was Shared With Others?:</label>
                    <br/>
                    <textarea class="form-control" name="nfeeshared" rows="3" maxlength="200">
                        <%=(feeshared==null)?"":feeshared%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Did fee includes training expenses? (Explain in Details) </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeTraining%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Did fee include airfare?: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeAirFare%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When agent fee paid: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeWhen%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where agent fee paid: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeWhere%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Repayment Plan if fee owed: </label>
                    <br/>
                    <textarea class="form-control" name="nfeerepay" rows="3" maxlength="200">
                        <%=(feeRepay==null)?"":feeRepay%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Employer that this Agent placed worker to: </label>
                    <br/>
                    <textarea class="form-control" name="nemp" rows="3" maxlength="200">
                        <%=(emp==null)?"":emp%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Agent Remarks: </label>
                    <br/>
                    <textarea class="form-control"name="remark" rows="3"><%=(remark==null)?"":remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#agent_pop_up", "job");'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#agent_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


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
                <select class="form-control" id="agentLocation" name="naglocation">
                    <option value="">Select location:</option>
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
                <label for='nhowMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <input class="form-control" type='text' name="naglocationMore">
            </div>
            <div class='form-group'>
                <label for='naddress' class="control-label">Agent Address: </label>
                <br/>
                <textarea class="form-control" name="naddress" rows="3" maxlength="300"></textarea>
            </div>
            <div class='form-group'>
                <label for='ncontact' class="control-label">Agent Phone/Email Contact: </label>
                <br/>
                <textarea class="form-control" name="ncontact" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='namtpaid' class="control-label">Amount Paid To This Agent(S$):</label>
                <br/>
                <input class="form-control" type='text' name="namtpaid">
            </div>
            <div class='form-group'>
                <label for='namtowed' class="control-label">Amount Owed To This Agent at the Start of Work(S$):</label>
                <br/>
                <input class="form-control" type='text' name="namtowed">
            </div>
            <div class='form-group'>
                <label for='nfeeshared' class="control-label">Any Suspicion Fee was Shared With Others?:</label>
                <br/>
                <textarea class="form-control" name="nfeeshared" rows="3" maxlength="200"></textarea>
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
                <textarea class="form-control" name="nfeerepay" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nemp' class="control-label">Employer that this Agent placed worker to: </label>
                <br/>
                <textarea class="form-control" name="nemp" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Agent Remarks: </label>
                <br/>
                <textarea class="form-control" name="nagremark" rows="3" maxlength="1000"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="Agent"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='company' class="control-label">Agent Company Name<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="company" value="<%=company%>" required>
            </div>
            <div class='form-group'>
                <label for='person' class="control-label">Agent Key Person Name:</label>
                <br/>
                <input class="form-control" type='text' name="agperson" value="<%=person%>">
            </div>
            <div class='form-group'>
                <label for='location' class="control-label">Location of Agent: </label>
                <br/>
                <select class="form-control" id="agentLocationEdit" name="aglocation">
                    <option value="" selected>Select Location:</option>
                    <%
                        for (String agentLocation : agentLocations) {
                            if (location.equals(agentLocation)) {

                    %>
                            <option selected><%=agentLocation%></option>
                    <%
                            } else {

                    %>
                            <option><%=agentLocation%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class="form-group" id="agentLocationEdit_other_div">
                <label for="locationMore" class="control-label">Explain if above is 'Other':</label><br/>
                <input class="form-control" type='text' name="aglocationMore" 
                       value="<%=(locationMore==null)?"":locationMore%>">
            </div>     
            <div class='form-group'>
                <label for='address' class="control-label">Agent Address: </label>
                <br/>
                <textarea class="form-control" name="address" rows="3" maxlength="300">
                    <%=(address==null)?"":address%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='contact' class="control-label">Agent Phone/Email Contact: </label>
                <br/>
                <textarea class="form-control" name="contact" rows="3" maxlength="200">
                    <%=(contact==null)?"":contact%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='amtpaid' class="control-label">Amount Paid To This Agent(S$):</label>
                <br/>
                <input class="form-control" type='text' name="amtpaid" value="<%=amtPaid%>">
            </div>
            <div class='form-group'>
                <label for='amtowed' class="control-label">Amount Owed To This Agent at the Start of Work(S$):</label>
                <br/>
                <input class="form-control" type='text' name="amtowed" value="<%=amtOwed%>">
            </div>
            <div class='form-group'>
                <label for='feeshared' class="control-label">Any Suspicion Fee was Shared With Others?:</label>
                <br/>
                <textarea class="form-control" name="feeshared" rows="3" maxlength="200">
                    <%=(feeshared==null)?"":feeshared%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='feetraining' class="control-label">Did fee includes training expenses? (Explain in Details) </label>
                <br/>
                <input class="form-control" type='text' name="feetraining" value="<%=feeTraining%>">
            </div>
            <div class='form-group'>
                <label for='feeairfare' class="control-label">Did fee include airfare?: </label>
                <br/>
                <input class="form-control" type='text' name="feeairfare" value="<%=feeAirFare%>">
            </div>
            <div class='form-group'>
                <label for='feewhen' class="control-label">When agent fee paid: </label>
                <br/>
                <input class="form-control" type='text' name="feewhen" value="<%=feeWhen%>">
            </div>
            <div class='form-group'>
                <label for='feewhere' class="control-label">Where agent fee paid: </label>
                <br/>
                <input class="form-control" type='text' name="feewhere" value="<%=feeWhere%>">
            </div>
            <div class='form-group'>
                <label for='feerepay' class="control-label">Repayment Plan if fee owed: </label>
                <br/>
                <textarea class="form-control" name="feerepay" rows="3" maxlength="200">
                    <%=(feeRepay==null)?"":feeRepay%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='emp' class="control-label">Employer that this Agent placed worker to: </label>
                <br/>
                <textarea class="form-control" name="emp" rows="3" maxlength="200"><%=(emp==null)?"":emp%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Agent Remarks: </label>
                <br/>
                <textarea class="form-control" name="agremark" rows="3"><%=remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="Agent"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!--verbal assurance--> 
<!-------------------->
<%
    }

    if (assurance != null) {
        int id = Integer.parseInt(assurance);
        JobVerbalAssurance vassurance = JobComplementsDAO.retrieveVerbalAssuranceDetailsById(id);
%>

<form method="POST" id='assurance_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Verbal Assurance Details</h4>
    <h4 class='add_comp'>Add A New Verbal Assurance </h4>
    <h4 class='edit_comp'>Edit Verbal Assurance  Details</h4>
    <div class='form-group'>


        <%
            String name = vassurance.getVerbalName();
            String relationship = vassurance.getVerbalRelationship();
            String when = vassurance.getWhen();
            String where = vassurance.getWhere();
            String content = vassurance.getContent();
        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Name of giver of verbal assurances:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Relationship of giver to worker or agent or employer:</label>
                    <br/>
                    <textarea class="form-control" name="nrelation" rows="3" maxlength="200">
                        <%=(relationship==null)?"":relationship%>"
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When was Verbal Assurance Given?: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=when%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where was Verbal Assurance Given?: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=where%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Content of Verbal Assurance: </label>
                    <br/>
                    <textarea class="form-control"name="remark" rows="3"><%=(content==null)?"":content%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#assurance_pop_up", "job")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#assurance_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nname' class="control-label">Name of giver of verbal assurances<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="nname" required>
            </div>
            <div class='form-group'>
                <label for='nrelationship' class="control-label">Relationship of giver to worker or agent or employer:</label>
                <br/>
                <textarea class="form-control" name="nrelation" rows="3" maxlength="200"></textarea>
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
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="VerbalAssurance"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='name' class="control-label">Name of giver of verbal assurances<span style="color: red">*</span>:</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=name%>" required>
            </div>
            <div class='form-group'>
                <label for='relationship' class="control-label">Relationship of giver to worker or agent or employer:</label>
                <br/>
                <textarea class="form-control" name="relation" rows="3" maxlength="200">
                        <%=(relationship==null)?"":relationship%>"
                </textarea>
            </div>
            <div class='form-group'>
                <label for='vaWhen' class="control-label">When was Verbal Assurance Given?: </label>
                <br/>
                <input class="form-control" type='text' name="vaWhen" value="<%=when%>">
            </div>
            <div class='form-group'>
                <label for='vaWhere' class="control-label">Where was Verbal Assurance Given?: </label>
                <br/>
                <input class="form-control" type='text' name="vaWhere" value="<%=where%>">
            </div>
            <div class='form-group'>
                <label for='vaContent' class="control-label">Content of Verbal Assurance: </label>
                <br/>
                <textarea class="form-control" name="vaContent" rows="3" maxlength="1000"><%=content%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="VerbalAssurance"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------------->
<!--workplace-->  
<!------------->
<%
    }

    if (wplace != null) {
        int id = Integer.parseInt(wplace);
        JobWorkplace workplace = JobComplementsDAO.retrieveJobWorkplaceById(id);
        //to get a list from dropdown dao//
        ArrayList<String> workplaceTypes = DropdownDAO.retrieveAllDropdownListOfWorkplaceType();
        ArrayList<String> workplacedirects = DropdownDAO.retrieveAllDropdownListOfWorkplaceDirectType();
%>

<form method="POST" id='workplace_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Workplace Details</h4>
    <h4 class='add_comp'>Add A New Workplace </h4>
    <h4 class='edit_comp'>Edit Workplace  Details</h4>
    <div class='form-group'>


        <%
            String wpType = workplace.getWorkplaceType();
            String wpTypeMore = workplace.getWorkplaceTypeMore();
            String whose = workplace.getWorkplaceWhose();
            String personDetails = workplace.getWorkpladePersons();
            String relationship = workplace.getWorkplaceEmployerRelationship();
            String direct = workplace.getWorkplaceDirect();
            String directMore = workplace.getWorkplaceDirectMore();
            String start = workplace.getWorkplaceStart();
            String end = workplace.getWorkplaceEnd();
            String condition = workplace.getWorkplaceCondition();
            String safety = workplace.getWorkplaceSafety();
            String remark = workplace.getWorkplaceRemarks();
        %>  

        <div class="view_comp">


            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Type of Workplace:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=wpType%>">
                </div>
                <div class='form-group' id="wrokplaceType_other_div" >
                    <label for='nwpTypeMore' class="control-label">Explain if above is 'Other': </label>
                    <br/>
                    <textarea class="form-control" name="nwpTypeMore" rows="3" maxlength="200">
                        <%=(wpTypeMore==null)?"":wpTypeMore%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Is workplace controlled by employer stated on workpass? If not, who?:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=whose%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Key Person Controlling Workplace & Contact Details: </label>
                    <br/>
                    <textarea class="form-control" name="npersonDetails" maxlength="200">
                        <%=(personDetails==null)?"":personDetails%>"
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Relationship of workplace to employer: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=relationship%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Who directed worker to this workplace?: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=direct%>">
                </div>
                <div class='form-group' id="direct_other_div" >
                    <label for='ndirectMore' class="control-label">Explain if above is 'Other': </label>
                    <br/>
                    <textarea class="form-control" name="ndirectMore" rows="3" maxlength="200">
                        <%=(directMore==null)?"":directMore%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When Start at Workplace?: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=start%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When cease working at Workplace?: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=end%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Work Conditions at the Workplace: </label>
                    <br/>
                    <textarea class="form-control" name="ncondition" rows="3">
                        <%=(condition==null)?"":condition%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Safety Issues At Workplace: </label>
                    <br/>
                    <textarea class="form-control" name="nsafety" rows="3" maxlength="200">
                        <%=(safety==null)?"":safety%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about Workplace: </label>
                    <br/>
                    <textarea class="form-control" name="nremark" rows="3" maxlength="200">
                        <%=(remark==null)?"":remark%>
                    </textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#workplace_pop_up", "job")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#workplace_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>

        <div class='add_comp'>
            <div class='form-group'>
                <!--this thing will become dropdown-->
                <label for='nwpType' class="control-label">Type of Workplace<span style="color: red">*</span>:</label>
                <br/>
                <select class="form-control" id="workplaceType" name="nwpType">
                    <option value="">Select from list:</option>
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
                <label for='nwpTypeMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="nwpTypeMore" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nwhose' class="control-label">Is workplace controlled by employer stated on workpass? If not, who?:</label>
                <br/>
                <input class="form-control" type='text' name="nwhose" >
            </div>
            <div class='form-group'>
                <label for='npersonDetails' class="control-label">Key Person Controlling Workplace & Contact Details: </label>
                <br/>
                <textarea class="form-control" name="npersonDetails" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nrelationship' class="control-label">Relationship of workplace to employer: </label>
                <br/>
                <input class="form-control" type='text' name="nrelation" >
            </div>
            <div class='form-group'>
                <label for='ndirect' class="control-label">Who directed worker to this workplace?<span style="color: red">*</span>: </label>
                <br/>
                <select class="form-control" id="direct" name="ndirect">
                    <option value="">Select from list:</option>
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
                <label for='ndirectMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="ndirectMore" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nstart' class="control-label">When Start at Workplace?: </label>
                <br/>
                <input class="form-control" type='text' name="nstart" >
            </div>
            <div class='form-group'>
                <label for='nend' class="control-label">When cease working at Workplace?: </label>
                <br/>
                <input class="form-control" type='text' name="nend" >
            </div>
            <div class='form-group'>
                <label for='ncondition' class="control-label">Work Conditions at the Workplace: </label>
                <br/>
                <textarea class="form-control" name="ncondition" rows="3" maxlength="500"></textarea>
            </div>
            <div class='form-group'>
                <label for='nsafety' class="control-label">Safety Issues At Workplace: </label>
                <br/>
                <textarea class="form-control" name="nsafety" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about Workplace: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="WorkPlace"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='wpType' class="control-label">Type of Workplace<span style="color: red">*</span>:</label>
                <br/>
                <select class="form-control" id="wpTypeEdit" name="wpType">
                    <%
                        for (String type : workplaceTypes) {
                            if (wpType.equals(type)) {

                    %>
                    <option selected><%=type%></option>
                    <%
                    } else {

                    %>
                    <option><%=type%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="wpTypeEdit_other_div" >
                <label for='wpTypeMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="wpTypeMore" rows="3" maxlength="200">
                    <%=(wpTypeMore==null)?"":wpTypeMore%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='whose' class="control-label">Is workplace controlled by employer stated on workpass? If not, who?:</label>
                <br/>
                <input class="form-control" type='text' name="whose" value="<%=whose%>">
            </div>
            <div class='form-group'>
                <label for='personDetails' class="control-label">Key Person Controlling Workplace & Contact Details: </label>
                <br/>
                <textarea class="form-control" name="personDetails" maxlength="200">
                    <%=(personDetails==null)?"":personDetails%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='relation' class="control-label">Relationship of workplace to employer: </label>
                <br/>
                <input class="form-control" type='text' name="relation" value="<%=relationship%>">
            </div>
            <div class='form-group'>
                <label for='direct' class="control-label">Who directed worker to this workplace?<span style="color: red">*</span>: </label>
                <br/>
                <select class="form-control" id="directEdit" name="direct">
                    <%
                        for (String workplacedirect : workplacedirects) {
                            if (direct.equals(workplacedirect)) {

                    %>
                    <option selected><%=workplacedirect%></option>
                    <%
                    } else {

                    %>
                    <option><%=workplacedirect%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="directEdit_other_div" >
                <label for='directMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="directMore" rows="3" maxlength="200">
                    <%=(directMore==null)?"":directMore%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='start' class="control-label">When Start at Workplace?: </label>
                <br/>
                <input class="form-control" type='text' name="start" value="<%=start%>">
            </div>
            <div class='form-group'>
                <label for='end' class="control-label">When cease working at Workplace?: </label>
                <br/>
                <input class="form-control" type='text' name="end" value="<%=end%>">
            </div>
            <div class='form-group'>
                <label for='condition' class="control-label">Work Conditions at the Workplace: </label>
                <br/>
                <textarea class="form-control" name="condition" rows="3" maxlength="500">
                    <%=(condition==null)?"":condition%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='safety' class="control-label">Safety Issues At Workplace: </label>
                <br/>
                <textarea class="form-control" name="safety" rows="3" maxlength="200">
                    <%=(safety==null)?"":safety%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about Workplace: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" maxlength="200">
                    <%=(remark==null)?"":remark%>
                </textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="WorkPlace"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------->
<!--work history-->
<!---------------->
<%
    }

    if (whistory != null) {
        int id = Integer.parseInt(whistory);
        JobWorkHistory history = JobComplementsDAO.retrieveJobWorkHistoryById(id);
        ArrayList<String> workhist = DropdownDAO.retrieveAllDropdownListOfWorkHistoryHowType();
%>

<form method="POST" id='whistory_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Work History Details</h4>
    <h4 class='add_comp'>Add A New Work History </h4>
    <h4 class='edit_comp'>Edit Work History Details</h4>
    <div class='form-group'>


        <%
            String how = history.getWorkHistHow();
            java.util.Date arrivalDate = history.getWorkHistDate();
            String isFirstJob = history.getWorkHistFirst();
            String arrivalYear = null;
            if (isFirstJob.equals("No")) {
                arrivalYear = history.getWorkHistYearArrive();
            }
            String prevJob = history.getWorkHistPrevious();
            String prevProb = history.getWorkHistPrevProblems();
            String remark = history.getWorkHistRemarks();

        %>  

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">How did worker get into the job defined in Job Profile?</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=how%>">
                </div>
                <div class='form-group' id="howEdit_other_div" >
                    <label for='nhowMore' class="control-label">Explain if above is 'Other': </label>
                    <br/>
                    <textarea class="form-control" name="howMore" maxlength="200">
                        <%=(history.getWorkHistHowMore()==null)?"":history.getWorkHistHowMore()%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Date arrived Singapore for this job:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(arrivalDate == null) ? "" : arrivalDate%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Is this first job in Singapore? </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=isFirstJob%>">
                </div>
                <%
                    if (isFirstJob.equals("No")) {
                %>
                <div class='form-group'>
                    <label for='remark' class="control-label">If not, year in which worker arrived in Singapore for first job</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=arrivalYear%>">
                </div>
                <%}%>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe previous jobs and home breaks </label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=prevJob%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe problems in previous jobs</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=prevProb%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about Work History: </label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#whistory_pop_up", "job");'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#whistory_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nhow' class="control-label">How did worker get into the job defined in Job Profile?<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="workhistHow" name="nhow">
                    <option value="">Select from list:</option>
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
                <label for='nhowMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="nhowMore" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='narrivalDate' class="control-label">Date arrived Singapore for this job:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="narrivalDate" >
            </div>
            <div class='form-group'>
                <label for='nisFirstJob' class="control-label">Is this first job in Singapore? </label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nisFirstJob" >

                    <option selected>No</option>

                    <option>Yes</option>

                </select>

            </div>
            <div class='form-group'>
                <label for='narrivalYear' class="control-label">If not, year in which worker arrived in Singapore for first job</label>
                <br/>
                <input class="form-control dateInput" type='text' name="narrivalYear">
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
                <label for='nremark' class="control-label">Remarks about Work History: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="WorkHistory"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='how' class="control-label">How did worker get into the job defined in Job Profile?<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="howEdit" name="how">
                    <%
                        for (String type : workhist) {
                            if (how.equals(type)) {

                    %>
                    <option selected><%=type%></option>
                    <%
                    } else {

                    %>
                    <option><%=type%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="howEdit_other_div" >
                <label for='nhowMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="howMore" maxlength="200">
                    <%=(history.getWorkHistHowMore()==null)?"":history.getWorkHistHowMore()%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='arrivalDate' class="control-label">Date arrived Singapore for this job:</label>
                <br/>
                <input class="form-control" type='text' name="arrivalDate" value="<%=(arrivalDate == null) ? "" : arrivalDate%>">
            </div>
            <div class='form-group'>
                <label for='isFirstJob' class="control-label">Is this first job in Singapore? </label>
                <br/>
                <select class="form-control" id="digitalContactType" name="isFirstJob" required>
                    <%
                        if (isFirstJob.equals("Yes")) {
                    %>
                    <option selected>Yes</option>

                    <option>No</option>
                    <%                    } else {
                    %>
                    <option selected>No</option>

                    <option>Yes</option>
                    <%                        }
                    %>

                </select>

            </div>
            <div class='form-group'>
                <label for='arrivalYear' class="control-label">If not, year in which worker arrived in Singapore for first job</label>
                <br/>
                <input class="form-control" type='text' name="arrivalYear" value="<%=arrivalYear%>">
            </div>
            <div class='form-group'>
                <label for='prevJob' class="control-label">Describe previous jobs and home breaks </label>
                <br/>
                <textarea class="form-control" name="prevJob" rows="3" maxlength="1000"><%=prevJob%></textarea>

            </div>
            <div class='form-group'>
                <label for='prevProb' class="control-label">Describe problems in previous jobs</label>
                <br/>
                <textarea class="form-control" name="prevProb" rows="3" maxlength="1000"><%=prevProb%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about Work History: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" maxlength="200"><%=remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="WorkHistory"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------->
<!--accomodation-->
<!---------------->
<%
    }

    if (waccom != null) {
        int id = Integer.parseInt(waccom);
        JobAccomodation accom = JobComplementsDAO.retrieveJobAccomodationById(id);
        ArrayList<String> accomTypes = DropdownDAO.retrieveAllDropdownListOfAccomType();
        ArrayList<String> accomProvideds = DropdownDAO.retrieveAllDropdownListOfAccomProvidedType();

%>

<form method="POST" id='accomodation_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View Accommodation Details</h4>
    <h4 class='add_comp'>Add A New Accommodation </h4>
    <h4 class='edit_comp'>Edit Accommodation  Details</h4>
    <div class='form-group'>


        <%
            String isProvided = accom.getAccProvided();
            String isProvidedMore = accom.getAccProvidedMore();
            String type = accom.getAccType();
            String typeMore = accom.getAccTypeMore();
            String location = accom.getAccLocation();
            String condition = accom.getAccCondition();
            double accCharged = accom.getAccCharged();
            double accPaid = accom.getAccSelfPaid();
            String meal = accom.getAccMeals();
            String from = accom.getAccStart();
            String to = accom.getAccEnd();
            String remark = accom.getAccRemarks();
        %>  

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Accommodation provided by employer?</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=isProvided%>">
                </div>
                <div class='form-group' id="accomProvided_other_div" >
                    <label for='location' class="control-label">Explain if above is 'Other': </label>
                    <br/>
                    <textarea class="form-control" name="nisProvidedMore" rows="3" maxlength="200">
                        <%=(isProvidedMore==null)?"":isProvidedMore%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Type of accommodation:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=type%>">
                </div>
                <div class='form-group' id="accomProvided_other_div" >
                    <label for='location' class="control-label">Explain if above is 'Other': </label>
                    <br/>
                    <textarea class="form-control" name="nTypeMore" rows="3" maxlength="200">
                        <%=(typeMore==null)?"":typeMore%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Location of accommodation: </label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=location%></textarea>
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Conditions at living quarters:</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=condition%></textarea>
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Cost charged by employer per month S$</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=accCharged%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Cost paid by self per month S$</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=accPaid%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Meal arrangements</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3">
                        <%=(meal==null)?"":meal%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When Start Staying Here?:</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=from%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When Stop Staying Here?:</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=to%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about Accommodation: </label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3">
                        <%=(remark==null)?"":remark%>
                    </textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#accomodation_pop_up", "job")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#accomodation_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nisProvided' class="control-label">Accommodation provided by employer?<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="accomProvided" name="nisProvided"  >
                    <%
                        for (String accomProvided : accomProvideds) {
                            if(accomProvided.equals("Provided")){
                                %>
                                <option selected><%=accomProvided%></option>
                    <%
                            }else{
                    %>
                    <option><%=accomProvided%></option>
                    <%
                            }
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

                <select class="form-control" id="accomType" name="ntype">
                    <option value="">Select from list:</option>
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
                <label for='nfrom' class="control-label">When Start Staying Here?:</label>
                <br/>
                <input class="form-control" type='text' name="nfrom">
            </div>
            <div class='form-group'>
                <label for='nto' class="control-label">When Stop Staying Here?</label>
                <br/>
                <input class="form-control" type='text' name="nto">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about Accommodation: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="Accommodation"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='isProvided' class="control-label">Accommodation provided by employer?<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="accomProvidedView" name="isProvided">
                    <%
                        for (String provided : accomProvideds) {
                            if (isProvided.equals(provided)) {

                    %>
                    <option selected><%=provided%></option>
                    <%
                    } else {

                    %>
                    <option><%=provided%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="accomProvidedView_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="isProvidedMore" rows="3" maxlength="200">
                    <%=(isProvidedMore==null)?"":isProvidedMore%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='type' class="control-label">Type of Accommodation:</label>
                <br/>
                <select class="form-control" id="accomtypeView" name="type">
                    <%
                        for (String acoomtype : accomTypes) {
                            if (type.equals(acoomtype)) {

                    %>
                    <option selected><%=acoomtype%></option>
                    <%
                    } else {

                    %>
                    <option><%=acoomtype%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class='form-group' id="accomtypeView_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <textarea class="form-control" name="typeMore" rows="3" maxlength="200">
                    <%=(typeMore==null)?"":typeMore%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='location' class="control-label">Location of Accommodation: </label>
                <br/>
                <textarea class="form-control" name="location" rows="3" maxlength="200">
                    <%=(location==null)?"":location%>
                </textarea>
            </div>

            <div class='form-group'>
                <label for='condition' class="control-label">Conditions at living quarters:</label>
                <br/>
                <textarea class="form-control" name="location" rows="3" maxlength="500">
                    <%=(condition==null)?"":condition%>
                </textarea>
            </div>

            <div class='form-group'>
                <label for='accCharged' class="control-label">Cost charged by employer per month S$</label>
                <br/>
                <input class="form-control" type='text' name="accCharged" value="<%=accCharged%>">
            </div>
            <div class='form-group'>
                <label for='accPaid' class="control-label">Cost paid by self per month S$</label>
                <br/>
                <input class="form-control" type='text' name="accPaid" value="<%=accPaid%>">
            </div>
            <div class='form-group'>
                <label for='meal' class="control-label">Meal arrangements</label>
                <br/>
                <textarea class="form-control" name="meal" rows="3" maxlength="200">
                    <%=(meal==null)?"":meal%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='from' class="control-label">When Start Staying Here?:</label>
                <br/>
                <input class="form-control" type='text' name="from" value="<%=from%>">
            </div>
            <div class='form-group'>
                <label for='to' class="control-label">When Stop Staying Here?</label>
                <br/>
                <input class="form-control" type='text' name="to" value="<%=to%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about Accommodation: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" maxlength="200">
                    <%=(remark==null)?"":remark%>
                </textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="Accommodation"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------->
<!--ipa-->
<!------->
<%
    }

    if (ipa != null) {
        int id = Integer.parseInt(ipa);
        JobIPADetails jipa = JobComplementsDAO.retrieveJobIPADetailsById(id);
        ArrayList<String> ipatypes = DropdownDAO.retrieveAllDropdownListOfIPAPassType();
%>

<form method="POST" id='ipa_pop_up' class="form complement_detailed_form job_pop_up"  >
    <h4 class='view_comp'>View IPA Pass Details</h4>
    <h4 class='add_comp'>Add A New IPA Pass </h4>
    <h4 class='edit_comp'>Edit IPA Pass Details</h4>
    <div class='form-group'>


        <%
            String type = jipa.getIpaPassType();
            String typeMore = jipa.getIpaPassTypeMore();
            String empName = jipa.getIpaEmployerName();
            String agentName = jipa.getIpaAgentName();
            String industry = jipa.getIndustry();
            String occupation = jipa.getOccuupation();
            String periods = jipa.getPeriodYears();
            double basicSalary = jipa.getBasicSalary();
            double totalAllowance = jipa.getIpaAllowances();
            double deduction = jipa.getIpaDeduction();
            String allowanceDetails = jipa.getIpaAllowancesDetails();
            String deductionDetails = jipa.getIpaDeductionDetails();
            String isHousingProvided = jipa.getHousingProvided();
            String remark = jipa.getIpaRemarks();

        %>  

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Workpass specified in IPA</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=type%>">
                </div>
                <div class='form-group' id='ipapassType_other_div' >
                    <label for='nworkpassTypeMore' class="control-label">Explain if above is other</label>
                    <br/>
                    <input class="form-control" type='text' name="nworkpassTypeMore" 
                           value="<%=(typeMore==null)?"":typeMore%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">IPA application Date:</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(jipa.getIpaApplicationDate()==null)?"":sdf.format(jipa.getIpaApplicationDate())%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Employer Name: </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=empName%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Agent Name:</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=agentName%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Industry</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=industry%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Occupation</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=occupation%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Period of Pass(Years)</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=periods%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Basic Monthly Salary (S$):</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=basicSalary%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Total Allowance(S$):</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=totalAllowance%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Allowance Details:</label>
                    <br/>
                    <textarea class="form-control" name="nallowanceDetails" rows="3" maxlength="200">
                        <%=(allowanceDetails==null)?"":allowanceDetails%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Total Deduction(S$):</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=deduction%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Deduction Details:</label>
                    <br/>
                    <textarea class="form-control" name="ndeductionDetails" rows="3" maxlength="200">
                        <%=(deductionDetails==null)?"":deductionDetails%>
                    </textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Housing Provided?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=isHousingProvided%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about IPA: </label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark==null)?"":remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#ipa_pop_up", "job")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#ipa_pop_up", "job")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
            <div class='form-group'>
                <label for='nworkpassType' class="control-label">Workpass specified in IPA<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="ipapassType" name="nworkpassType">
                    <option value="">Select Workpass:</option>
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
                <label for='nworkpassTypeMore' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="nworkpassTypeMore">
            </div>
            <div class='form-group'>
                <label for='nappDate' class="control-label">IPA Application Date:</label>
                <br/>
                <input class="form-control  dateInput" type='text' name="nappDate">
            </div>
            <div class='form-group'>
                <label for='nempName' class="control-label">IPA Employer Name: </label>
                <br/>
                <input class="form-control" type='text' name="nempName">
            </div>

            <div class='form-group'>
                <label for='nagentName' class="control-label">IPA Agent Name:</label>
                <br/>
                <input class="form-control" type='text' name="nagentName">
            </div>

            <div class='form-group'>
                <label for='nindustry' class="control-label">IPA Industry:</label>
                <br/>
                <input class="form-control" type='text' name="nindustry">
            </div>
            <div class='form-group'>
                <label for='nipaoccupation' class="control-label">IPA Occupation:</label>
                <br/>
                <input class="form-control" type='text' name="nipaoccupation">
            </div>
            <div class='form-group'>
                <label for='nperiods' class="control-label">IPA Period of Pass(Years)</label>
                <br/>
                <input class="form-control" type='text' name="nperiods">
            </div>
            <div class='form-group'>
                <label for='nbasicSalary' class="control-label">IPA Basic Monthly Salary (S$):</label>
                <br/>
                <input class="form-control" type='text' name="nbasicSalary">
            </div>
            <div class='form-group'>
                <label for='ntotalAllowance' class="control-label">IPA Total Allowance(S$):</label>
                <br/>
                <input class="form-control" type='text' name="ntotalAllowance">
            </div>
            <div class='form-group'>
                <label for='nallowanceDetails' class="control-label">IPA Allowance Details:</label>
                <br/>
                <textarea class="form-control" name="nallowanceDetails" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='ndeduction' class="control-label">IPA Total Deduction(S$):</label>
                <br/>
                <input class="form-control" type='text' name="ntotalDeduction">
            </div>
            <div class='form-group'>
                <label for='ndeductionDetails' class="control-label">IPA Deduction Details:</label>
                <br/>
                <textarea class="form-control" name="ndeductionDetails" rows="3" maxlength="200"></textarea>
            </div>
            <div class='form-group'>
                <label for='nisHousingProvided' class="control-label">Housing Provided?</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="nisHousingProvided">
                    <option >No</option>
                    <option selected>Yes</option>
                </select>

            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks about IPA: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3" maxlength="200"></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="IPA"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='workpassType' class="control-label">Workpass specified in IPA<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="ipapassTypeView" name="workpassType">
                    <%
                        for (String provided : ipatypes) {
                            if (type.equals(provided)) {

                    %>
                    <option selected><%=provided%></option>
                    <%
                    } else {

                    %>
                    <option><%=provided%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>

            <div class='form-group' id='ipapassTypeView_other_div' >
                <label for='workpassTypeMore' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="workpassTypeMore" 
                       value="<%=(typeMore==null)?"":typeMore%>">
            </div>

            <div class='form-group'>
                <label for='appDate' class="control-label">IPA application date:</label>
                <br/>
                <input class="form-control  dateInput" type='text' name="appDate" 
                       value="<%=sdf.format(jipa.getIpaApplicationDate())%>">
            </div>
            <div class='form-group'>
                <label for='empName' class="control-label">IPA Employer Name: </label>
                <br/>
                <input class="form-control" type='text' name="empName" value="<%=empName%>">
            </div>

            <div class='form-group'>
                <label for='agentName' class="control-label">IPA Agent Name:</label>
                <br/>
                <input class="form-control" type='text' name="agentName" value="<%=agentName%>">
            </div>

            <div class='form-group'>
                <label for='industry' class="control-label">IPA Industry:</label>
                <br/>
                <input class="form-control" type='text' name="industry" value="<%=industry%>">
            </div>
            <div class='form-group'>
                <label for='ipaoccupation' class="control-label">IPA Occupation:</label>
                <br/>
                <input class="form-control" type='text' name="ipaoccupation" value="<%=occupation%>">
            </div>
            <div class='form-group'>
                <label for='periods' class="control-label">IPA Period of Pass(Years)</label>
                <br/>
                <input class="form-control" type='text' name="periods" value="<%=periods%>">
            </div>
            <div class='form-group'>
                <label for='basicSalary' class="control-label">IPA Basic Monthly Salary (S$):</label>
                <br/>
                <input class="form-control" type='text' name="basicSalary" value="<%=basicSalary%>">
            </div>
            <div class='form-group'>
                <label for='totalAllowance' class="control-label">IPA Total Allowance(S$):</label>
                <br/>
                <input class="form-control" type='text' name="totalAllowance" value="<%=totalAllowance%>">
            </div>
            <div class='form-group'>
                <label for='allowanceDetails' class="control-label">IPA Allowance Details:</label>
                <br/>
                <textarea class="form-control" name="nallowanceDetails" rows="3" maxlength="200">
                    <%=(allowanceDetails==null)?"":allowanceDetails%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='deduction' class="control-label">IPA Total Deduction(S$):</label>
                <br/>
                <input class="form-control" type='text' name="totalDeduction" value="<%=deduction%>">
            </div>
            <div class='form-group'>
                <label for='deductionDetails' class="control-label">IPA Deduction Details:</label>
                <br/>
                <textarea class="form-control" name="ndeductionDetails" rows="3" maxlength="200">
                    <%=(deductionDetails==null)?"":deductionDetails%>
                </textarea>
            </div>
            <div class='form-group'>
                <label for='isHousingProvided' class="control-label">Housing Provided?</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="isHousingProvided" required>
                    <%
                        if (isHousingProvided.equals("Yes")) {
                    %>
                    <option selected>Yes</option>

                    <option>No</option>
                    <%                    } else {
                    %>
                    <option selected>No</option>

                    <option>Yes</option>
                    <%                        }
                    %>

                </select>

            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about IPA: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark==null)?"":remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="IPA"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    
    </div>
</form>

<%
    }

%>

<script>

    $(document).ready(function() {
        $("#pop_upcontent").dialog({
            create: function(event, ui) {
                var widget = $(this).dialog("widget");
                $(".ui-dialog-titlebar-close span", widget)
                        .removeClass("ui-icon-closethick")
                        .addClass("ui-icon-close");
            }
        });
    })


    $(document).ready(function(event) {

        //alert('alert1');
        $('.view_comp').show();
        //alert('alert2');
        $('.edit_comp').hide();
        //alert('alert3');
        $('.add_comp').hide();


        $('.complement_detailed_form').attr("action", "");


    });
    $('.cancel_btn').click(function() {
        $('#pop_up_content').dialog("destroy");
        $('#pop_up_content').empty();
    });


    function editComplement(div_id, category) {
        //alert("first check");

        $(div_id).prop("action", "editJobComplement.do");




        $(div_id + " .edit_comp").show();
        //alert("edit");
        $(div_id + " .view_comp").hide();
        $(div_id + " .add_comp").hide();
        //alert("final check");
        $(div_id + " .add_comp input").prop('disabled', true);

    }

    function add(div_id, category) {

        $(div_id).prop("action", "addJobComplement.do");

        $(div_id + " .add_comp").show();
        $(div_id + " .edit_comp").hide();
        $(div_id + " .view_comp").hide();
        $(div_id + " .view_comp input").prop('disabled', true);
    }


</script>
