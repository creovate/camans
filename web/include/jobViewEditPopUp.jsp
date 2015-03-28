<%-- 
    Document   : jobViewEditPopUp
    Created on : Nov 6, 2014, 5:24:37 PM
    Author     : Nyein Su
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<style>
    button{
        width : 6vw;
    }

</style>
<script>


    $(document).ready(function() {
        //----initialize datepicker----//
        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true
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
        //----disable manual input in date fields----//
        $('.dateInput').focus(function() {
            $('.dateInput').blur();
        });

        $('.form-control').addClass('input-sm');
        $('.btn_group').addClass('pull-right');

        $(".removeBtn").click(function() {
            var field = $(this).data('field');
            $("." + field + "dateToRemove").val("");
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
                passtype: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Pass type must not exceed 20 characters.'
                        },
                        notEmpty: {
                            message: 'Pass type cannot be empty.'
                        }
                    }
                },
                passtypeMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Pass type must not exceed 50 characters.'
                        }
                    }
                },
                passno: {
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
                issuer: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Agency name must not exceed 20 characters.'
                        }
                    }
                },
                remark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remarks must not exceed 200 characters.'
                        }
                    }
                },
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
                name: {
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
                empid: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Employer ID must not exceed 50 characters.'
                        }
                    }
                },
                address: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Address must not exceed 200 characters.'
                        }
                    }
                },
                contact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact details must not exceed 200 characters.'
                        }
                    }
                },
                person: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Key persons name must not exceed 200 characters.'
                        }
                    }
                },
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
                            message: 'Key persons name must not exceed 200 characters.'
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
                            message: 'Location must not exceed 50 characters.'
                        }
                    }
                },
                language: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Language must not exceed 20 characters.'
                        }
                    }
                },
                opname: {
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
                relationship: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Relationship must not exceed 200 characters.'
                        }
                    }
                },
                occupation: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'occupation must not exceed 200 characters.'
                        }
                    }
                },
                salary: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Salary must not exceed 50 characters.'
                        }
                    }
                },
                allowance: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Allowance details must not exceed 500 characters.'
                        }
                    }
                },
                deduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction details must not exceed 500 characters.'
                        }
                    }
                },
                duration: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Length of contract must not exceed 20 characters.'
                        }
                    }
                },
                duress: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction details must not exceed 500 characters.'
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
                            message: 'The name must not exceed 50 characters.'
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
                            message: 'Allowance details must not exceed 500 characters.'
                        }
                    }
                },
                ndeduction: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction details must not exceed 500 characters.'
                        }
                    }
                },
                nduration: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Length of duration must not exceed 500 characters.'
                        }
                    }
                },
                nduress: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Deduction details must not exceed 500 characters.'
                        }
                    }
                },
                //agent
                company: {
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
                agperson: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Agent key person name must not exceed 50 characters.'
                        }
                    }
                },
                aglocationMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Agent location must not exceed 50 characters.'
                        }
                    }
                },
                amtowed: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                amtpaid: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                feeshared: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                feetraining: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Training expense details must not exceed 50 characters.'
                        }
                    }
                },
                feeairfare: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Airfare fee must not exceed 50 characters.'
                        }
                    }
                },
                feewhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                feewhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                feerepay: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Repayment plan must not exceed 200 characters.'
                        }
                    }
                },
                emp: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                agremark: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
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
                vaWhen: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                vaWhere: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                vaContent: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Content must not exceed 1000 characters.'
                        }
                    }
                },
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
                            message: 'Type must not exceed 200 characters.'
                        }
                    }
                },
                whose: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                personDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Location of workplace must not exceed 200 characters.'
                        }
                    }
                },
                relation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
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
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                start: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                end: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                condition: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must not exceed 500 characters.'
                        }
                    }
                },
                safety: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Safety issues must not exceed 200 characters.'
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
                            message: 'Working conditions must not exceed 500 characters.'
                        }
                    }
                },
                nsafety: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Safety issues must not exceed 200 characters.'
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                arrivalYear: {
                    validators: {
                        //gonna change it to year dropdown
                    }
                },
                arrivalDate: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                prevJob: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
                        }
                    }
                },
                prevProb: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must not exceed 1000 characters.'
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
                            message: 'This field must not exceed 200 characters.'
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                typeMore: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                accCharged: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                accPaid: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                meal: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                from: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
                        }
                    }
                },
                to: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must not exceed 50 characters.'
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
                locationAccom: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
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
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                empName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must not exceed 50 characters.'
                        }
                    }
                },
                agentName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'The name must not exceed 50 characters.'
                        }
                    }
                },
                industry: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'Industry must not exceed 20 characters.'
                        }
                    }
                },
                ipaoccupation: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'Occupation must not exceed 30 characters.'
                        }
                    }
                },
                periods: {
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
                basicSalary: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                totalAllowance: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                allowanceDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
                        }
                    }
                },
                totalDeduction: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                deducationDetails: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must not exceed 200 characters.'
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

    //to track the selected problem
    String probKey = request.getParameter("probkey");

    //end of data collection

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    DecimalFormat df = new DecimalFormat("#,###,###.00");

    if (passId != null) {
        int id = Integer.parseInt(passId);
        JobPassDetails pass = JobComplementsDAO.retrieveJobPassDetailsById(id);
        ArrayList<String> workpassTypes = DropdownDAO.retrieveAllDropdownListByType("Pass_type");
%>

<form method="POST" id='passdetails_pop_up' class="form complement_detailed_form job_pop_up"  >

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
                    <label for='passtype' class="control-label">Pass type</label>
                    <br/>
                    <input class="form-control" type='text' name="passtype" value="<%=passtype%>">
                </div>

                <div class="form-group" id="passtype_other_div">
                    <label for="passtypeMore" class="control-label">Explain if above is 'Other'</label><br/>
                    <input class="form-control" type='text' name="npasstypeMore" 
                           value="<%=(passtypeMore == null) ? "" : passtypeMore%>">
                </div>
                <div class='form-group'>
                    <label for='passno' class="control-label">Pass number</label>
                    <br/>
                    <input class="form-control" type='text' name="passno" value="<%=passnum%>">
                </div>
                <div class='form-group'>
                    <label for='apdate' class="control-label">Pass application date</label>
                    <br/>
                    <input class="form-control" type='text' name="apdate" 
                           value="<%=(pass.getPassApplicationDate() == null) ? ""
                                   : sdf.format(pass.getPassApplicationDate())%>">
                </div>
                <div class='form-group'>
                    <label for='isdate' class="control-label">Pass issue date</label>
                    <br/>
                    <input class="form-control" type='text' name="isdate" 
                           value="<%=(pass.getIssueDate() == null) ? ""
                                   : sdf.format(pass.getIssueDate())%>">
                </div>
                <div class='form-group'>
                    <label for='exdate' class="control-label">Pass expiry date</label>
                    <br/>
                    <input class="form-control" type='text' name="exdate" 
                           value="<%=(pass.getExpiryDate() == null) ? ""
                                   : sdf.format(pass.getExpiryDate())%>">
                </div>
                <div class='form-group'>
                    <label for='issuer' class="control-label">Pass issuing agency</label>
                    <br/>
                    <input class="form-control" type='text' name="issuer" value="<%=(issuer == null) ? "" : issuer%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about pass</label>

                    <br/>
                    <textarea class="form-control" name="remark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
                </div>
                <div class='form-group'>
                    <label for='obsoleteDate' class="control-label">Date discovered to be obsolete</label>
                    <br/>
                    <input class="form-control" type='text' name="obsoleteDate" 
                           value="<%=(pass.getObsoleteDate() == null) ? ""
                                   : sdf.format(pass.getObsoleteDate())%>">
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#passdetails_pop_up", "job", "Edit Pass details");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn" onclick='add("#passdetails_pop_up", "job", "Add A New Pass details");'>Add</button> -->                 
                <button type='button' class="btn cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='passtype' class="control-label"><span style="color: red">*</span> Pass type</label>
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
                <label for="passtypeMore" class="control-label">Explain if above is 'Other'</label><br/>
                <input class="form-control" type='text' name="passtypeMore" 
                       value="<%=(passtypeMore == null) ? "" : passtypeMore%>">    
            </div>     
            <div class='form-group'>
                <label for='passno' class="control-label"><span style="color: red">*</span> Pass number</label>
                <br/>
                <input class="form-control" type='text' name="passno" value="<%=passnum%>">
                
            </div>
            <div class='form-group'>
                <label for='apdate' class="control-label">Pass application date</label>
                <br/>
                       <input class="form-control dateInput apdateToRemove col-md-9" type='text' name="apdate" style="width:90%" value="<%=(pass.getPassApplicationDate() == null) ? ""
                        : sdf.format(pass.getPassApplicationDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="ap" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                <br/><br/>
            </div>
            <div class='form-group'>
                <label for='isdate' class="control-label">Pass issued date</label>
                <br/>
                       <input class="form-control startDate isdateToRemove col-md-9" type='text' name="isdate" style="width:90%" value="<%=(pass.getIssueDate() == null) ? ""
                        : sdf.format(pass.getIssueDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="is" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                <br/><br/>
            </div>
            <div class='form-group'>
                <label for='exdate' class="control-label">Pass expiry date</label>
                <br/>
                       <input class="form-control endDate exdateToRemove col-md-9" type='text' name="exdate" style="width:90%"  value="<%=(pass.getExpiryDate() == null) ? ""
                        : sdf.format(pass.getExpiryDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="ex" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                <br/><br/>
            </div>
            <div class='form-group'>
                <label for='issuer' class="control-label">Pass issuing agency</label>
                <br/>
                <input class="form-control" type='text' name="issuer" value="<%=(issuer == null) ? "" : issuer%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about pass</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <div class='form-group'>
                <label for='obsoleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput" type='text' name="obsoleteDate" 
                       value="<%=(pass.getObsoleteDate() == null) ? ""
                               : sdf.format(pass.getObsoleteDate())%>">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="JobPassDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!--2. employer details--> 
<!-------------------->
<%
    }

    if (empId != null) {
        int id = Integer.parseInt(empId);
        JobEmployer emp = JobComplementsDAO.retrieveJobEmployerById(id);

%>

<form method="POST" id='empdetails_pop_up' class="form complement_detailed_form job_pop_up"  >

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
                    <label for='name' class="control-label">Official name of employer</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='empid' class="control-label">ID of employer</label>
                    <br/>
                    <input class="form-control" type='text' name="empid" value="<%=empid%>">
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Employer address</label>
                    <br/>
                    <textarea class="form-control" name="address" rows="3" ><%=address%></textarea>
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Employer phone, email contacts</label>
                    <br/>
                    <textarea class="form-control" name="ncontact" rows="3" ><%=(contact == null) ? "" : contact%></textarea>
                </div>
                <div class='form-group'>
                    <label for='person' class="control-label">Key persons in employer</label>
                    <br/>
                    <textarea class="form-control" name="nperson" rows="3" ><%=(person == null) ? "" : person%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about employer</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#empdetails_pop_up", "job", "Edit employer details");'>Edit</button>
                <!-- <button type='button' class="btn btn-blue modal_btn" onclick='add("#empdetails_pop_up", "job", "Add A New employer");'>Add</button> -->                 
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='name' class="control-label"><span style="color: red">*</span> Official name of employer</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=name%>" required>
            </div>
            <div class='form-group'>
                <label for='empid' class="control-label">ID of employer</label>
                <br/>
                <input class="form-control" type='text' name="empid" value="<%=empid%>">
            </div>
            <div class='form-group'>
                <label for='address' class="control-label">Employer address</label>
                <br/>
                <textarea class="form-control" name="address" rows="3" ><%=(address == null) ? "" : address%></textarea>
            </div>
            <div class='form-group'>
                <label for='contact' class="control-label">Employer phone, email contacts</label>
                <br/>
                <textarea class="form-control" name="contact" rows="3" ><%=(contact == null) ? "" : contact%></textarea>
            </div>
            <div class='form-group'>
                <label for='person' class="control-label">Key persons in employer</label>
                <br/>
                <textarea class="form-control" name="person" rows="3" ><%=(person == null) ? "" : person%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about employer</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="EmployerDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------------------------>
<!--Employment contract--->   
<!------------------------>
<%

    }

    if (empcontract != null) {
        int id = Integer.parseInt(empcontract);
        JobEmploymentContract contract = JobComplementsDAO.retrieveEmploymentContractById(id);
%>

<form method="POST" id='contract_pop_up' class="form complement_detailed_form job_pop_up"  >

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
                    <label for='name' class="control-label">Contract date</label>
                    <br/>
                    <input class="form-control " type='text' name="name" 
                           value="<%=(date == null) ? "" : sdf.format(date)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where contract signed</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=location%>">
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Contract language</label>
                    <br/>
                    <input class="form-control" type='text' name="contact" value="<%=language%>">
                </div>
                <div class='form-group'>
                    <label for='person' class="control-label">Name of opposite contracting party</label>
                    <br/>
                    <input class="form-control" type='text' name="person" value="<%=opname%>">
                </div>
                <div class='form-group'>
                    <label for='empid' class="control-label">Relationship of opposite contracting party to job</label>
                    <br/>
                    <textarea class="form-control" name="noprelation" rows="3" ><%=(oprelation == null) ? "" : oprelation%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Occupation stated in contract</label>
                    <br/>
                    <textarea class="form-control" name="noccupation" rows="3" ><%=(occupation == null) ? "" : occupation%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Basic salary</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=salary%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Allowance details</label>
                    <br/>
                    <textarea class="form-control"name="remark" rows="3"><%=allowance%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Deductions details</label>
                    <br/>
                    <textarea class="form-control"name="remark" rows="3"><%=deduction%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Length of contract</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=duration%>">
                </div>
                <div class='form-group'>
                    <label for='duresss' class="control-label">Describe if signed under duress or misrepresentation</label>
                    <br/>
                    <textarea class="form-control"name="duresss" rows="3"><%=duress%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about contract</label>
                    <br/>
                    <textarea class="form-control"name="duresss" rows="3"><%=remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#contract_pop_up", "job", "Edit Employment contract details");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn " onclick='add("#contract_pop_up", "job", "Add A New Employment contract");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='contdate' class="control-label"><span style="color: red">*</span> Contract date</label>
                <br/>
                <input class="form-control dateInput" type='text' name="contdate" 
                       value="<%=(date == null) ? "" : sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='location' class="control-label">Where contract signed</label>
                <br/>
                <input class="form-control" type='text' name="location" value="<%=location%>">
            </div>
            <div class='form-group'>
                <label for='language' class="control-label">Contract language</label>
                <br/>
                <input class="form-control" type='text' name="language" value="<%=language%>">
            </div>
            <div class='form-group'>
                <label for='opname' class="control-label"><span style="color: red">*</span> Name of opposite contracting party</label>
                <br/>
                <input class="form-control" type='text' name="opname" value="<%=opname%>">
            </div>
            <div class='form-group'>
                <label for='oprelation' class="control-label">Relationship of opposite contracting party to job</label>
                <br/>
                <textarea class="form-control" name="oprelation" rows="3" ><%=(oprelation == null) ? "" : oprelation%></textarea>
            </div>
            <div class='form-group'>
                <label for='occupation' class="control-label">Occupation stated in contract</label>
                <br/>
                <textarea class="form-control" name="occupation" rows="3" ><%=(occupation == null) ? "" : occupation%></textarea>
            </div>
            <div class='form-group'>
                <label for='salary' class="control-label">Basic salary</label>
                <br/>
                <input class="form-control" type='text' name="salary" value="<%=salary%>">
            </div>
            <div class='form-group'>
                <label for='allowance' class="control-label">Allowance details</label>
                <br/>
                <textarea class="form-control"name="allowance" rows="3"><%=allowance%></textarea>
            </div>
            <div class='form-group'>
                <label for='deduction' class="control-label">Deductions details</label>
                <br/>
                <textarea class="form-control"name="deduction" rows="3"><%=deduction%></textarea>
            </div>
            <div class='form-group'>
                <label for='duration' class="control-label">Length of contract</label>
                <br/>
                <input class="form-control" type='text' name="duration" value="<%=duration%>">
            </div>
            <div class='form-group'>
                <label for='duress' class="control-label">Describe if signed under duress or misrepresentation</label>
                <br/>
                <textarea class="form-control"name="duress" rows="3"><%=duress%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about contract</label>
                <br/>
                <textarea class="form-control"name="remark" rows="3"><%=remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="ContractDetails"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------------->       
<!--3. Intermediary agent-->    
<!---------------------->
<%
    }

    if (agent != null) {
        int id = Integer.parseInt(agent);
        JobIntermediaryAgent wagent = JobComplementsDAO.retrieveJobIntermediaryAgentById(id);
        ArrayList<String> agentLocations = DropdownDAO.retrieveAllDropdownListOfAgentLocationType();
%>

<form method="POST" id='agent_pop_up' class="form complement_detailed_form job_pop_up"  >

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
                    <label for='name' class="control-label">Agent company name</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=company%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Agent key person name</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(person == null) ? "" : person%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Location of agent</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(location == null) ? "" : location%>">
                </div>
                <div class="form-group" id="location_other_div">
                    <label for="locationMore" class="control-label">Explain if above is 'Other'</label><br/>
                    <input class="form-control" type='text' name="naglocationMore" 
                           value="<%=(locationMore == null) ? "" : locationMore%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Agent address</label>
                    <br/>
                    <textarea class="form-control" name="naddress" rows="3" ><%=(address == null) ? "" : address%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Agent phone/email contact</label>
                    <br/>
                    <textarea class="form-control" name="ncontact" rows="3" ><%=(contact == null) ? "" : contact%></textarea>
                </div>
                <div class='form-group'>
                    <label for='empid' class="control-label">Amount paid to this agent(S$)</label>
                    <br/>
                    <input class="form-control" type='text' name="empid" value="<%=(amtPaid == 0.0) ? "" : df.format(amtPaid)%>">
                </div>
                <div class='form-group'>
                    <label for='person' class="control-label">Amount Owed to This agent at the start of work(S$)</label>
                    <br/>
                    <input class="form-control" type='text' name="person" value="<%=(amtOwed == 0.0) ? "" : df.format(amtOwed)%>">
                </div>
                <div class='form-group'>
                    <label for='contact' class="control-label">Any suspicion fee was shared with others?</label>
                    <br/>
                    <textarea class="form-control" name="nfeeshared" rows="3" ><%=(feeshared == null) ? "" : feeshared%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Did fee include training expenses? (Explain in detail) </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeTraining%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Did fee include airfare?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeAirFare%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When agent fee paid</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeWhen%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where agent fee paid</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=feeWhere%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Repayment plan if fee owed</label>
                    <br/>
                    <textarea class="form-control" name="nfeerepay" rows="3" ><%=(feeRepay == null) ? "" : feeRepay%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Employer that this agent placed worker to</label>
                    <br/>
                    <textarea class="form-control" name="nemp" rows="3" ><%=(emp == null) ? "" : emp%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Agent remarks</label>
                    <br/>
                    <textarea class="form-control"name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#agent_pop_up", "job", "Edit Intermediary agent");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn " onclick='add("#agent_pop_up", "job", "Add A New Intermediary agent");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='company' class="control-label"><span style="color: red">*</span> Agent company name</label>
                <br/>
                <input class="form-control" type='text' name="company" value="<%=company%>" required>
            </div>
            <div class='form-group'>
                <label for='person' class="control-label">Agent key person name</label>
                <br/>
                <input class="form-control" type='text' name="agperson" value="<%=person%>">
            </div>
            <div class='form-group'>
                <label for='location' class="control-label">Location of agent</label>
                <br/>
                <select class="form-control" id="agentLocationEdit" name="aglocation">
                    <option value="" selected>Select from list...</option>
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
                <label for="locationMore" class="control-label">Explain if above is 'Other'</label><br/>
                <input class="form-control" type='text' name="aglocationMore" 
                       value="<%=(locationMore == null) ? "" : locationMore%>">
            </div>     
            <div class='form-group'>
                <label for='address' class="control-label">Agent address</label>
                <br/>
                <textarea class="form-control" name="address" rows="3" ><%=(address == null) ? "" : address%></textarea>
            </div>
            <div class='form-group'>
                <label for='contact' class="control-label">Agent phone/email contact</label>
                <br/>
                <textarea class="form-control" name="contact" rows="3" ><%=(contact == null) ? "" : contact%></textarea>
            </div>
            <div class='form-group'>
                <label for='amtpaid' class="control-label">Amount paid to this agent(S$)</label>
                <br/>
                <input class="form-control" type='text' name="amtpaid" value="<%=(amtPaid == 0.0) ? "" : df.format(amtPaid)%>">
            </div>
            <div class='form-group'>
                <label for='amtowed' class="control-label">Amount owed to this agent at the start of work(S$)</label>
                <br/>
                <input class="form-control" type='text' name="amtowed" value="<%=(amtOwed == 0.0) ? "" : df.format(amtOwed)%>">
            </div>
            <div class='form-group'>
                <label for='feeshared' class="control-label">Any suspicion fee was shared With others?</label>
                <br/>
                <textarea class="form-control" name="feeshared" rows="3" ><%=(feeshared == null) ? "" : feeshared%></textarea>
            </div>
            <div class='form-group'>
                <label for='feetraining' class="control-label">Did fee include training expenses? (Explain in detail) </label>
                <br/>
                <input class="form-control" type='text' name="feetraining" value="<%=feeTraining%>">
            </div>
            <div class='form-group'>
                <label for='feeairfare' class="control-label">Did fee include airfare?</label>
                <br/>
                <input class="form-control" type='text' name="feeairfare" value="<%=feeAirFare%>">
            </div>
            <div class='form-group'>
                <label for='feewhen' class="control-label">When agent fee paid</label>
                <br/>
                <input class="form-control" type='text' name="feewhen" value="<%=feeWhen%>">
            </div>
            <div class='form-group'>
                <label for='feewhere' class="control-label">Where agent fee paid</label>
                <br/>
                <input class="form-control" type='text' name="feewhere" value="<%=feeWhere%>">
            </div>
            <div class='form-group'>
                <label for='feerepay' class="control-label">Repayment plan if fee owed</label>
                <br/>
                <textarea class="form-control" name="feerepay" rows="3" ><%=(feeRepay == null) ? "" : feeRepay%></textarea>
            </div>
            <div class='form-group'>
                <label for='emp' class="control-label">Employer that this agent placed worker to</label>
                <br/>
                <textarea class="form-control" name="emp" rows="3" ><%=(emp == null) ? "" : emp%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Agent Remarks</label>
                <br/>
                <textarea class="form-control" name="agremark" rows="3"><%=remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="Agent"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!--4. verbal assurance--> 
<!-------------------->
<%
    }

    if (assurance != null) {
        int id = Integer.parseInt(assurance);
        JobVerbalAssurance vassurance = JobComplementsDAO.retrieveVerbalAssuranceDetailsById(id);
%>

<form method="POST" id='assurance_pop_up' class="form complement_detailed_form job_pop_up"  >

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
                    <label for='name' class="control-label">Name of giver of verbal assurances</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Relationship of giver to worker or agent or employer</label>
                    <br/>
                    <textarea class="form-control" name="nrelation" rows="3"><%=(relationship == null) ? "" : relationship%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When was verbal assurance given?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=when%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where was verbal assurance given?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=where%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Content of verbal assurance</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(content == null) ? "" : content%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#assurance_pop_up", "job", "Edit verbal assurance details");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn" onclick='add("#assurance_pop_up", "job", "Add A New verbal assurance");'>Add</button> -->                 
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='name' class="control-label"><span style="color: red">*</span> Name of giver of verbal assurances</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=name%>" required>
            </div>
            <div class='form-group'>
                <label for='relationship' class="control-label">Relationship of giver to worker or agent or employer</label>
                <br/>
                <textarea class="form-control" name="relation" rows="3" ><%=(relationship == null) ? "" : relationship%></textarea>
            </div>
            <div class='form-group'>
                <label for='vaWhen' class="control-label">When was verbal assurance given?</label>
                <br/>
                <input class="form-control" type='text' name="vaWhen" value="<%=when%>">
            </div>
            <div class='form-group'>
                <label for='vaWhere' class="control-label">Where was verbal assurance given?</label>
                <br/>
                <input class="form-control" type='text' name="vaWhere" value="<%=where%>">
            </div>
            <div class='form-group'>
                <label for='vaContent' class="control-label">Content of verbal assurance</label>
                <br/>
                <textarea class="form-control" name="vaContent" rows="3" ><%=content%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="VerbalAssurance"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
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
                    <label for='name' class="control-label">Type of workplace</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=wpType%>">
                </div>
                <div class='form-group' id="wrokplaceType_other_div" >
                    <label for='nwpTypeMore' class="control-label">Explain if above is 'Other'</label>
                    <br/>
                    <textarea class="form-control" name="nwpTypeMore" rows="3" ><%=(wpTypeMore == null) ? "" : wpTypeMore%></textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Is workplace controlled by employer stated on workpass? If not, who?</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=whose%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Location of Workplace</label>
                    <br/>
                    <textarea class="form-control" name="npersonDetails" ><%=(personDetails == null) ? "" : personDetails%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Relationship of workplace to employer</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=relationship%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Who directed worker to this workplace?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=direct%>">
                </div>
                <div class='form-group' id="direct_other_div" >
                    <label for='ndirectMore' class="control-label">Explain if above is 'Other'</label>
                    <br/>
                    <textarea class="form-control" name="ndirectMore" rows="3" ><%=(directMore == null) ? "" : directMore%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When start at workplace?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=start%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When cease working at workplace?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=end%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Work conditions at the workplace</label>
                    <br/>
                    <textarea class="form-control" name="condition" rows="3"><%=(condition == null) ? "" : condition%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Safety issues at workplace</label>
                    <br/>
                    <textarea class="form-control" name="nsafety" rows="3" ><%=(safety == null) ? "" : safety%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about workplace</label>
                    <br/>
                    <textarea class="form-control" name="nremark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#workplace_pop_up", "job", "Edit workplace details");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn " onclick='add("#workplace_pop_up", "job", "Add A New workplace");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='wpType' class="control-label"><span style="color: red">*</span> Type of workplace</label>
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
                <label for='wpTypeMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="wpTypeMore" rows="3" ><%=(wpTypeMore == null) ? "" : wpTypeMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='whose' class="control-label">Is workplace controlled by employer stated on workpass? If not, who?</label>
                <br/>
                <input class="form-control" type='text' name="whose" value="<%=whose%>">
            </div>
            <div class='form-group'>
                <label for='personDetails' class="control-label">Location of Workplace</label>
                <br/>
                <textarea class="form-control" name="personDetails" ><%=(personDetails == null) ? "" : personDetails%></textarea>
            </div>
            <div class='form-group'>
                <label for='relation' class="control-label">Relationship of workplace to employer</label>
                <br/>
                <input class="form-control" type='text' name="relation" value="<%=relationship%>">
            </div>
            <div class='form-group'>
                <label for='direct' class="control-label"><span style="color: red">*</span> Who directed worker to this workplace?</label>
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
                <label for='directMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="directMore" rows="3" ><%=(directMore == null) ? "" : directMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='start' class="control-label">When start at workplace?</label>
                <br/>
                <input class="form-control" type='text' name="start" value="<%=start%>">
            </div>
            <div class='form-group'>
                <label for='end' class="control-label">When cease working at workplace?</label>
                <br/>
                <input class="form-control" type='text' name="end" value="<%=end%>">
            </div>
            <div class='form-group'>
                <label for='condition' class="control-label">Work conditions at the workplace</label>
                <br/>
                <textarea class="form-control" name="condition" rows="3" ><%=(condition == null) ? "" : condition%></textarea>
            </div>
            <div class='form-group'>
                <label for='safety' class="control-label">Safety issues at workplace</label>
                <br/>
                <textarea class="form-control" name="safety" rows="3" ><%=(safety == null) ? "" : safety%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about workplace</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="WorkPlace"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
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

    <div class='form-group'>


        <%
            String how = history.getWorkHistHow();
            String arrivalDate = history.getWorkHistDate();
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
                    <label for='name' class="control-label">How did worker get into the job defined in job Profile?</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=how%>">
                </div>
                <div class='form-group' id="howEdit_other_div" >
                    <label for='nhowMore' class="control-label">Explain if above is 'Other'</label>
                    <br/>
                    <textarea class="form-control" name="howMore" ><%=(history.getWorkHistHowMore() == null) ? "" : history.getWorkHistHowMore()%></textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">When worker arrived Singapore for this job?</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(arrivalDate==null)?"":arrivalDate%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Is this first job in Singapsore? </label>
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
                    <label for='remark' class="control-label">Remarks about work history</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#whistory_pop_up", "job", "Edit Work History details");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn " onclick='add("#whistory_pop_up", "job", "Add A New Work History");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='how' class="control-label"><span style="color: red">*</span> How did worker get into the job defined in job Profile?</label>
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
                <label for='nhowMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="howMore" ><%=(history.getWorkHistHowMore() == null) ? "" : history.getWorkHistHowMore()%></textarea>
            </div>
            <div class='form-group'>
                <label for='arrivalDate' class="control-label">When worker arrived Singapore for this job?</label>
                <br/>
                <input class="form-control" type='text' name="arrivalDate" value="<%=(arrivalDate==null)?"":arrivalDate%>">
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
                <textarea class="form-control" name="prevJob" rows="3" ><%=prevJob%></textarea>

            </div>
            <div class='form-group'>
                <label for='prevProb' class="control-label">Describe problems in previous jobs</label>
                <br/>
                <textarea class="form-control" name="prevProb" rows="3" ><%=prevProb%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about work history</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="WorkHistory"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
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
                    <label for='location' class="control-label">Explain if above is 'Other'</label>
                    <br/>
                    <textarea class="form-control" name="nisProvidedMore" rows="3" ><%=(isProvidedMore == null) ? "" : isProvidedMore%></textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Type of accommodation</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=type%>">
                </div>
                <div class='form-group' id="accomProvided_other_div" >
                    <label for='location' class="control-label">Explain if above is 'Other'</label>
                    <br/>
                    <textarea class="form-control" name="nTypeMore" rows="3" ><%=(typeMore == null) ? "" : typeMore%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Location of accommodation</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=location%></textarea>
                </div>

                <div class='form-group'>
                    <label for='ncondition' class="control-label">Conditions at living quarters</label>
                    <br/>
                    <textarea class="form-control" name="ncondition" rows="3" ><%=condition%></textarea>
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Cost charged by employer per month S$</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(accCharged == 0.0) ? "" : df.format(accCharged)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Cost paid by self per month S$</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(accPaid == 0.0) ? "" : df.format(accPaid)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Meal arrangements</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(meal == null) ? "" : meal%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When start staying here?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=from%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">When stop staying here?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=to%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about accommodation</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#accomodation_pop_up", "job", "Edit Accommodation details");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn " onclick='add("#accomodation_pop_up", "job", "Add A New Accommodation");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='isProvided' class="control-label"><span style="color: red">*</span> Accommodation provided by employer?</label>
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
                <label for='location' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="isProvidedMore" rows="3" ><%=(isProvidedMore == null) ? "" : isProvidedMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='type' class="control-label">Type of accommodation</label>
                <br/>
                <select class="form-control" id="accomtypeView" name="type">
                    <option value="" selected>Select from list...</option>
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
                <label for='location' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="typeMore" rows="3" ><%=(typeMore == null) ? "" : typeMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='location' class="control-label">Location of accommodation</label>
                <br/>
                <textarea class="form-control" name="locationAccom" rows="3" ><%=(location == null) ? "" : location%></textarea>
            </div>

            <div class='form-group'>
                <label for='condition' class="control-label">Conditions at living quarters</label>
                <br/>
                <textarea class="form-control" name="condition" rows="3" ><%=(condition == null) ? "" : condition%></textarea>
            </div>
            <div class='form-group'>
                <label for='accCharged' class="control-label">Cost charged by employer per month S$</label>
                <br/>
                <input class="form-control" type='text' name="accCharged" value="<%=(accCharged == 0.0) ? "" : df.format(accCharged)%>">
            </div>
            <div class='form-group'>
                <label for='accPaid' class="control-label">Cost paid by self per month S$</label>
                <br/>
                <input class="form-control" type='text' name="accPaid" value="<%=(accPaid == 0.0) ? "" : df.format(accPaid)%>">
            </div>
            <div class='form-group'>
                <label for='meal' class="control-label">Meal arrangements</label>
                <br/>
                <textarea class="form-control" name="meal" rows="3" ><%=(meal == null) ? "" : meal%></textarea>
            </div>
            <div class='form-group'>
                <label for='from' class="control-label">When start staying here?</label>
                <br/>
                <input class="form-control" type='text' name="from" value="<%=from%>">
            </div>
            <div class='form-group'>
                <label for='to' class="control-label">When stop staying here?</label>
                <br/>
                <input class="form-control" type='text' name="to" value="<%=to%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about accommodation</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="Accommodation"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
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

    <div class='form-group'>


        <%
            String type = jipa.getIpaPassType();
            String typeMore = jipa.getIpaPassTypeMore();
            String empName = jipa.getIpaEmployerName();
            String agentName = jipa.getIpaAgentName();
            String industry = jipa.getIndustry();
            String occupation = jipa.getOccuupation();
            double periods = jipa.getPeriodYears();
            double basicSalary = jipa.getBasicSalary();
            double totalAllowance = jipa.getIpaAllowances();
            double deduction = jipa.getIpaDeduction();
            String allowanceDetails = jipa.getIpaAllowancesDetails();
            String deductionDetails = jipa.getIpaDeductionDetails();
            String isHousingProvided = jipa.getHousingProvided();
            String remark = jipa.getIpaRemarks();
            java.util.Date ipadate = jipa.getIpaApplicationDate();
        %>  

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Workpass specified in IPA</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=type%>">
                </div>
                <div class='form-group' id='ipapassType_other_div' >
                    <label for='nworkpassTypeMore' class="control-label">Explain if above is 'Other'</label>
                    <br/>
                    <input class="form-control" type='text' name="nworkpassTypeMore" 
                           value="<%=(typeMore == null) ? "" : typeMore%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">IPA application date</label>
                    <br/>
                    <input class="form-control" type='text' name="nappDate" value="<%=(ipadate == null) ? "" : sdf.format(ipadate)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA employer name</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=empName%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA agent name</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=agentName%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA industry</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=industry%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA occupation</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=occupation%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA period of pass(years)</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(periods == 0) ? "" : df.format(periods)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA basic monthly salary (S$)</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(basicSalary == 0) ? "" : df.format(basicSalary)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA total allowance(S$)</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(totalAllowance == 0) ? "" : df.format(totalAllowance)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA allowance details</label>
                    <br/>
                    <textarea class="form-control" name="nallowanceDetails" rows="3" ><%=(allowanceDetails == null) ? "" : allowanceDetails%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA total Deduction(S$)</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(deduction == 0) ? "" : df.format(deduction)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">IPA Deduction details</label>
                    <br/>
                    <textarea class="form-control" name="ndeductionDetails" rows="3" ><%=(deductionDetails == null) ? "" : deductionDetails%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Housing Provided?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=isHousingProvided%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about IPA</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#ipa_pop_up", "job", "Edit IPA Pass details");'>Edit</button>
                <!--<button type='button' class="btn btn-blue modal_btn " onclick='add("#ipa_pop_up", "job", "Add A New IPA Pass");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='workpassType' class="control-label"><span style="color: red">*</span> Workpass specified in IPA</label>
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
                       value="<%=(typeMore == null) ? "" : typeMore%>">
            </div>

            <div class='form-group'>
                <label for='appDate' class="control-label">IPA application date</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="appDate" style="width:90%" value="<%=(ipadate == null) ? "" : sdf.format(ipadate)%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
<br/><br/>
            </div>
            <div class='form-group'>
                <label for='empName' class="control-label">IPA employer name</label>
                <br/>
                <input class="form-control" type='text' name="empName" value="<%=empName%>">
            </div>

            <div class='form-group'>
                <label for='agentName' class="control-label">IPA agent name</label>
                <br/>
                <input class="form-control" type='text' name="agentName" value="<%=agentName%>">
            </div>

            <div class='form-group'>
                <label for='industry' class="control-label">IPA Industry</label>
                <br/>
                <input class="form-control" type='text' name="industry" value="<%=industry%>">
            </div>
            <div class='form-group'>
                <label for='ipaoccupation' class="control-label">IPA Occupation</label>
                <br/>
                <input class="form-control" type='text' name="ipaoccupation" value="<%=occupation%>">
            </div>
            <div class='form-group'>
                <label for='periods' class="control-label">IPA period of pass(years)</label>
                <br/>
                <input class="form-control" type='text' name="periods" value="<%=(periods == 0) ? "" : df.format(periods)%>">
            </div>
            <div class='form-group'>
                <label for='basicSalary' class="control-label">IPA basic monthly salary (S$)</label>
                <br/>
                <input class="form-control" type='text' name="basicSalary" value="<%=(basicSalary == 0) ? "" : df.format(basicSalary)%>">
            </div>
            <div class='form-group'>
                <label for='totalAllowance' class="control-label">IPA total allowance(S$)</label>
                <br/>
                <input class="form-control" type='text' name="totalAllowance" value="<%=(totalAllowance == 0) ? "" : df.format(totalAllowance)%>">
            </div>
            <div class='form-group'>
                <label for='allowanceDetails' class="control-label">IPA allowance details</label>
                <br/>
                <textarea class="form-control" name="nallowanceDetails" rows="3" ><%=(allowanceDetails == null) ? "" : allowanceDetails%></textarea>
            </div>
            <div class='form-group'>
                <label for='deduction' class="control-label">IPA total deduction(S$)</label>
                <br/>
                <input class="form-control" type='text' name="totalDeduction" value="<%=(deduction == 0) ? "" : df.format(deduction)%>">
            </div>
            <div class='form-group'>
                <label for='deductionDetails' class="control-label">IPA deduction details</label>
                <br/>
                <textarea class="form-control" name="ndeductionDetails" rows="3" ><%=(deductionDetails == null) ? "" : deductionDetails%></textarea>
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
                <label for='remark' class="control-label">Remarks about IPA</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="IPA"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp">Save</button>
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

        $('.view_comp').show();
        $('.edit_comp').hide();
        $('.add_comp').hide();
        $('.complement_detailed_form').attr("action", "");
    });

    $('.cancel_btn').click(function() {
        $('#pop_up_content').dialog("destroy");
        $('#pop_up_content').empty();
    });


    function editComplement(div_id, category, title) {
        $('#pop_up_content').dialog('option', 'title', title);
        $(div_id).prop("action", "addJobComplement.do");
        $(div_id + " .edit_comp").show();
        $(div_id + " .view_comp").hide();
        $(div_id + " .add_comp").hide();
        $(div_id + " .add_comp input").prop('disabled', true);

    }

    function add(div_id, category, title) {
        $('#pop_up_content').dialog('option', 'title', title);
        $(div_id).prop("action", "addJobComplement.do");
        $(div_id + " .add_comp").show();
        $(div_id + " .edit_comp").hide();
        $(div_id + " .view_comp").hide();
        $(div_id + " .view_comp input").prop('disabled', true);
    }


</script>