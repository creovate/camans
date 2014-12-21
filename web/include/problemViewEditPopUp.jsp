<%-- 
    Document   : problemViewEditPopUp
    Created on : Nov 6, 2014, 5:12:37 PM
    Author     : Nyein Su
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>

<script>
    $(function() {
        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0
        });

    });
    
    //start date & end date
    $(function() {
    $( ".startDate" ).datepicker({
        dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
      onClose: function( selectedDate ) {
        $( ".endDate" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( ".endDate" ).datepicker({
        dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
      onClose: function( selectedDate ) {
          
        $( ".startDate" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  });
    
//disable manual input in date fields
    $(document).ready(function() {

        $('.dateInput').focus(function() {

            $('.dateInput').blur();

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
                            message: 'Date cannot be empty.'
                        }
                    }
                },
                time: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'The Approx time must be less than 20 characters.'
                        }
                    }
                },
                location: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Location must be less than 200 characters.'
                        }
                    }
                },
                bodyPart: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Body part(s) must be less than 500 characters.'
                        }
                    }
                },
                how: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'Body part(s) must be less than 1000 characters.'
                        }
                    }
                },
                treatment: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
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
                            message: 'Date cannot be empty.'
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
                diagnoseTime: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                diagnosePerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Doctor/hospital must be less than 200 characters.'
                        }
                    }
                },
                nature: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Nature of illness must be less than 200 characters.'
                        }
                    }
                },
                workRelatedYes: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Doctor/hospital must be less than 500 characters.'
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
                            message: 'Salary must be a number'
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
                        }
                    },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
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

    
</script>
<style>
    h4{
        color: #AF4454;
    }

</style>

<%
    /* data collection */
    //worker complement passed data
    String worker_fin = request.getParameter("workerFin");
    String jobKey = request.getParameter("jobkey");
    String probKey = request.getParameter("problemKey");

    //problem complement passed data
    String aggravIssueId = request.getParameter("aggravissue");
    String leadCaseworkerId = request.getParameter("leadcaseworker");
    String auxCaseworkerId = request.getParameter("auxcaseworker");
    String salaryCaseId = request.getParameter("salaryhistory");
    String injuryCaseId = request.getParameter("injurycase");
    String illnessCaseId = request.getParameter("illnesscase");
    String otherCaseId = request.getParameter("othercase");
    String traffickingId = request.getParameter("trafficking");
    String salaryClaimId = request.getParameter("salarycalim");
    String wicaClaimId = request.getParameter("wicaclaim");
    String nonWicaClaimId = request.getParameter("nonwicaclaim");
    String policeReportId = request.getParameter("policareport");
    String othercomplaintId = request.getParameter("othercomplaint");
    String caseDiscussionId = request.getParameter("casediscussion");
    String hospitalId = request.getParameter("hospital");
    String mcId = request.getParameter("mc");
    String r2rId = request.getParameter("r2r");
    String wicaId = request.getParameter("wica");
    String lawyerId = request.getParameter("lawyer");
    String ncmilestoneId = request.getParameter("ncmilestone");
    String cmilestoneId = request.getParameter("cmilestone");
    String ttrId = request.getParameter("ttr");

    //end of data collection
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
%>
<%
    if (injuryCaseId != null) {
        int id = Integer.parseInt(injuryCaseId);
        ProblemInjury pinjury = ProblemComplementsDAO.retrieveProblemInjuryById(id);
%>

<!--injury-->
<form method="POST" id='injurycase_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Injury History Details</h4>
    <h4 class='add_comp'>Add A Injury History Accommodation </h4>
    <h4 class='edit_comp'>Edit Injury History  Details</h4>
    <div class='form-group'>

        <%
            java.util.Date injuryDate = pinjury.getInjuryDate();
            String injuryTime = pinjury.getInjuryTime();
            String injuryLocation = pinjury.getInjuryLocation();
            String injuryDeath = pinjury.getInjuryDeath();
            String injuryBodyPart = pinjury.getInjuryBodyPart();
            String injuryHow = pinjury.getInjuryHow();
            String injuryAmbulance = pinjury.getInjuryAmbulance();
            String injuryInitialTreatment = pinjury.getInitialTreatment();
            String injuryWorkRelated = pinjury.getInjuryWorkRelated();
            String injuryRemark = pinjury.getInjuryRemarks();
        %>  

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Date of injury</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(injuryDate == null) ? ""
                                   : sdf.format(injuryDate)%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Approximate time of injury</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(injuryTime == null) ? "" : injuryTime%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Location of Incident </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryLocation == null) ? "" : injuryLocation%>">
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Did death ensure?:</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryDeath == null) ? "" : injuryDeath%>">
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Body Part(s) Injured</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(injuryBodyPart == null) ? "" : injuryBodyPart%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">How Injury Happened</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=injuryHow%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Was worker conveyed to hospital in ambulance?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryAmbulance == null) ? "" : injuryAmbulance%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where initially treated:</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryInitialTreatment == null) ? "" : injuryInitialTreatment %>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Does worker consider incident work-related?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryWorkRelated == null) ? "" : injuryWorkRelated%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(injuryRemark == null) ? "" : injuryRemark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#injurycase_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#injurycase_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>

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

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="injurycase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>

            <div class='form-group'>
                <label for='date' class="control-label">Date of Injury:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="date" 
                       value="<%=(injuryDate == null) ? ""
                               : sdf.format(injuryDate)%>" >
            </div>
            <div class='form-group'>
                <label for='time' class="control-label">Approximate time of injury </label>
                <br/>
                <input class="form-control" type='text' name="time" value="<%=(injuryTime == null) ? "" : injuryTime%>">
            </div>
            <div class='form-group'>
                <label for='location' class="control-label">Location of incident</label>
                <br/>
                <input class="form-control" type='text' name="location" value="<%=(injuryLocation == null) ? "" : injuryLocation%>">
            </div>

            <div class='form-group'>
                <label for='death' class="control-label">Did death ensue?</label>
                <br/>
                <select class="form-control" id="injuryDeath" name="death" >
                    <%
                        if (injuryDeath.equals("Yes")) {
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
                <label for='bodyPart' class="control-label">Body part(s) injured</label>
                <br/>
                <textarea class="form-control" name="bodyPart" rows="3"><%=(injuryBodyPart == null) ? "" : injuryBodyPart%></textarea>
            </div>

            <div class='form-group'>
                <label for='how' class="control-label">How injury happened</label>
                <br/>
                <textarea class="form-control" name="how" rows="3"><%=(injuryHow == null) ? "" : injuryHow%></textarea>
            </div>

            <div class='form-group'>
                <label for='ambulance' class="control-label">Was worker conveyed to hospital in ambulance?</label>
                <br/>
                <select class="form-control" id="injuryAmbulance" name="ambulance" >
                    <%
                        if (injuryAmbulance.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Don't know</option>
                    <%                    } else if (injuryAmbulance.equals("No")) {
                    %>
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Don't know</option>
                    <%                        } else {
                    %>
                    <option selected>Don't know</option>
                    <option>Yes</option>
                    <option>No</option>
                    <% }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <label for='treatment' class="control-label">Where initially treated</label>
                <br/>
                <input class="form-control" type='text' name="treatement" value="<%=injuryInitialTreatment%>">
            </div>

            <div class='form-group'>
                <label for='workRelated' class="control-label">Does worker consider incident work-related?</label>
                <br/>
                <select class="form-control" id="injuryWorkRelated" name="workRelated" >
                    <%
                        if (injuryWorkRelated.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Don't know</option>
                    <%                    } else if (injuryWorkRelated.equals("No")) {
                    %>
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Don't know</option>
                    <%                        } else {
                    %>
                    <option selected>Don't know</option>
                    <option>Yes</option>
                    <option>No</option>
                    <% }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <label for='remark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(injuryRemark == null) ? "" : injuryRemark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="injurycase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--illness-->
<%
    }
    if (illnessCaseId != null) {
        int id = Integer.parseInt(illnessCaseId);
        ProblemIllness pillness = ProblemComplementsDAO.retrieveProblemIllnesseById(id);
%>

<form method="POST" id='illnesscase_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Illness History Details</h4>
    <h4 class='add_comp'>Add A Illness History Accommodation </h4>
    <h4 class='edit_comp'>Edit Illness History  Details</h4>
    <div class='form-group'>

        <%
            String startTime = pillness.getIllnessStart();
            String diagnoseTime = pillness.getIllnessDiagWhen();
            String diagnoseWho = pillness.getIllnessDiagWho();
            String nature = pillness.getIllnessNature();
            String workRelated = pillness.getIllnessWorkRelated();
            String why = pillness.getIllnessWhy();
            String remark = pillness.getIllnessRemark();
        %>  

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Illness Start Time</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(startTime == null) ? "" : startTime%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Illness Diagnosed Time</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(diagnoseTime == null) ? "" : diagnoseTime%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Illness Diagnosed Person</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(diagnoseWho == null) ? "" : diagnoseWho%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Nature of illness </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(nature  == null) ? "" : nature%>">
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Does worker consider illness work-related?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=workRelated%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">If worker thinks work-related, why?</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(why == null) ? "" : why%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remark</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#illnesscase_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#illnesscase_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


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
            <div class='form-group' id='workRelatedYes_div'>
                <label for='nworkRelatedYes' class='control-label'>If worker thinks work-related, why?</label>
                <br/>
                <textarea class="form-control" name="nworkRelatedYes" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="illnesscase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>

            <div class='form-group'>
                <label for='startTime' class="control-label">Illness start time</label>
                <br/>
                <input class="form-control" type='text' name="startTime" value="<%=(startTime == null) ? "" : startTime%>">
            </div>
            <div class='form-group'>
                <label for='diagnoseTime' class="control-label">Illness diagnosed time</label>
                <br/>
                <input class="form-control" type='text' name="diagnoseTime" value="<%=(diagnoseTime == null) ? "" : diagnoseTime%>">
            </div>
            <div class='form-group'>
                <label for='diagnosePerson' class="control-label">Illness diagnosed person</label>
                <br/>
                <input class="form-control" type='text' name="diagnosePerson" value="<%=(diagnoseWho == null) ? "" :diagnoseWho%>">
            </div>

            <div class='form-group'>
                <label for='nature' class="control-label">Nature of illness</label>
                <br/>
                <input class="form-control" type='text' name="nature" value="<%=(nature == null) ? "" : nature%>">
            </div>

            <div class='form-group'>
                <label for='workRelated' class="control-label">Does worker consider illness work-related?</label>
                <br/>
                <select class="form-control" id="injuryDeath" name="workRelated" >
                    <%
                        if (workRelated.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Don't know</option>
                    <%                    } else if (workRelated.equals("No")) {
                    %>
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Don't know</option>
                    <%                        } else {
                    %>
                    <option selected>Don't know</option>
                    <option>Yes</option>
                    <option>No</option>
                    <% }
                    %>
                </select>
            </div>
            <div class='form-group' id='workRelatedYes_div' >
                <label for='workRelatedYes' class='control-label'>If worker thinks work-related, why?</label>
                <br/>
                <textarea class="form-control" name="workRelatedYes" rows="3"><%=why%></textarea>
            </div>

            <div class='form-group'>
                <label for='remark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="illnesscase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--other case-->            
<%
    }
    if (otherCaseId != null) {
        int id = Integer.parseInt(otherCaseId);
        ProblemOtherProblems pother = ProblemComplementsDAO.retrieveProblemOtherProblemsById(id);
%>

<form method="POST" id='othercase_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Details & history of other problems</h4>
    <h4 class='add_comp'>Add Details & history of other problems </h4>
    <h4 class='edit_comp'>Edit Details & history of other problems</h4>
    <div class='form-group'>

        <%
            String description = pother.getOtherProblemDesc();
            double loss = pother.getOtherProblemLoss();
            String remark = pother.getOtherProblemRemark();
        %>  

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Details of problem if it's not salary/injury/illness</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(description == null) ? "" : description%></textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Estimated value of claim S$</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(loss == 0.0) ? "" : loss%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remark</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#othercase_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#othercase_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


        <div class='add_comp'>
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

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="othercase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>

            <div class='form-group'>
                <label for='other' class="control-label">Details of problem if it's not salary/injury/illness</label>
                <br/>
                <textarea class="form-control" name="other" rows="3"><%=(description == null) ? "" : description%></textarea>
            </div>
            <div class='form-group'>
                <label for='loss' class="control-label">Estimated value of claim S$</label>
                <br/>
                <input class="form-control" type='text' name="loss" value="<%=(loss == 0.0) ? "" : loss%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark  == null) ? "" : remark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="othercase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--trafficking-->
<%
    }
    if (traffickingId != null) {
        int id = Integer.parseInt(traffickingId);
        ProblemTraffickingIndicator ptrafficking = ProblemComplementsDAO.retrieveProblemTraffickingIndicatorById(id);
%>

<form method="POST" id='trafficking_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Trafficking Indicators Details</h4>
    <h4 class='add_comp'>Add Trafficking Indicators </h4>
    <h4 class='edit_comp'>Edit Trafficking Indicators  Details</h4>
    <div class='form-group'>

        <%
            java.util.Date date = ptrafficking.getTipiAssessDate();
            String name = ptrafficking.getTipiAssessName();
            String tipi21 = ptrafficking.getTipi21();
            String tipi22 = ptrafficking.getTipi22();
            String tipi23 = ptrafficking.getTipi23();
            String tipi24 = ptrafficking.getTipi24();
            String tipi25 = ptrafficking.getTipi25();
            String tipi26 = ptrafficking.getTipi26();
            String tipi27 = ptrafficking.getTipi27();
            String tipi28 = ptrafficking.getTipi28();

            String tipi41 = ptrafficking.getTipi41();
            String tipi42 = ptrafficking.getTipi42();
            String tipi43 = ptrafficking.getTipi43();
            String tipi44 = ptrafficking.getTipi44();
            String tipi45 = ptrafficking.getTipi45();
            String tipi46 = ptrafficking.getTipi46();
            String tipi47 = ptrafficking.getTipi47();
            String tipi48 = ptrafficking.getTipi48();
            String tipi49 = ptrafficking.getTipi49();
            String tipi50 = ptrafficking.getTipi50();
            String tipi51 = ptrafficking.getTipi51();

            String tipi61 = ptrafficking.getTipi61();
            String tipi62 = ptrafficking.getTipi62();
            String tipi63 = ptrafficking.getTipi63();
            String tipi64 = ptrafficking.getTipi64();
            String tipi65 = ptrafficking.getTipi65();
            String tipi66 = ptrafficking.getTipi66();
            String tipi67 = ptrafficking.getTipi67();

            String tipi81 = ptrafficking.getTipi81();
            String tipi82 = ptrafficking.getTipi82();
        %>  

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Date of assessment</label>
                    <br/>
                    <input class="form-control" type='text' name="date" 
                           value="<%=(date == null) ? ""
                                   : sdf.format(date)%>">>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Name of person making assessment</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Feel unable to negotiate terms of contract/employment</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=tipi21%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Received little or no payment though entitled</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi22%>">
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Deductions not pre-agreed</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi23%>">
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">No access to earnings</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi24%>">
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Excessively long hours over long periods</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi25%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">No days off</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi26%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Lack protective equipment though work conditions call for them</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi27%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Disciplined through fines</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi28%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Movement restricted or under surveillance</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi41%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Communication restricted or under surveillance</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi42%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Threat of violence against worker or family</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi43%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Threat of trouble with authorities</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi44%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Seizure/retention of personal identity documents</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi45%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Poor/substandard accommodation, no option to leave</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi46%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">No access to medical care</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi47%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">No privacy</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi48%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Feel victimised by misrepresentation</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi49%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Feel loss of autonomy through debt or heavy sunk cost</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi50%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Subject to insults, abuse, violence</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi51%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Found in location associated with confinement/exploitation</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi61%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Allow others to speak for them when addressed directly</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi62%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Act as if instructed by someone else</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi63%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Escorted wherever they go</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi64%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Unable to show personal identity documents</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi65%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Have association with, or clothes of a kind associated with sex work</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi66%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Have injuries that appear to be associated with assault or application of control measures</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=tipi67%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe other indicators of trafficking complained of</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=tipi81%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe other indicators of trafficking observed</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=tipi82%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#trafficking_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#trafficking_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


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

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="trafficking"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>

            <div class='form-group'>
                <label for='date' class="control-label">Date of assessment</label>
                <br/>
                <input class="form-control dateInput" type='text' name="date" 
                       value="<%=(date == null) ? ""
                               : sdf.format(date)%>">>
            </div>

            <div class='form-group'>
                <label for='person' class="control-label">Person Making this assessment</label>
                <br/>
                <input class="form-control" type='text' name="person" value="<%=name%>">
            </div>

            <div class='form-group'>
                <lable for='tipi21' class='control-label'>Feel unable to negotiate terms of contract/employment</lable>
                <br/>
                <select class="form-control" id="ntipi21" name="tipi21" >
                    <%
                        if (tipi21.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi21.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi21.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi21.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>	
                </select>
            </div>

            <div class='form-group'>
                <lable for='tipi22' class='control-label'>Received little or no payment though entitled</lable>
                <br/>
                <select class="form-control" id="ntipi22" name="tipi22" >
                    <%
                        if (tipi22.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi22.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi22.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi22.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <lable for='tipi23' class='control-label'>Deductions not pre-agreed</lable>
                <br/>
                <select class="form-control" id="ntipi23" name="tipi23" >
                    <%
                        if (tipi23.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi23.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi23.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi23.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <lable for='tipi24' class='control-label'>No access to earnings</lable>
                <br/>
                <select class="form-control" id="ntipi24" name="tipi24" >
                    <%
                        if (tipi24.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi24.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi24.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi24.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <lable for='tipi25' class='control-label'>Excessively long hours over long periods</lable>
                <br/>
                <select class="form-control" id="ntipi25" name="tipi25">
                    <%
                        if (tipi25.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi25.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi25.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi25.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <lable for='tipi26' class='control-label'>No days off</lable>
                <br/>
                <select class="form-control" id="tipi26" name="ntipi26">
                    <%
                        if (tipi26.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi26.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi26.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi26.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <lable for='tipi27' class='control-label'>Lack protective equipment though work conditions call for them</lable>
                <br/>
                <select class="form-control" id="tipi27" name="ntipi27">
                    <%
                        if (tipi27.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi27.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi27.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi27.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi28' class='control-label'>Disciplined through fines</lable>
                <br/>
                <select class="form-control" id="ntipi28" name="tipi28">
                    <%
                        if (tipi28.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi28.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi28.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi28.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='ntipi41' class='control-label'>Movement restricted or under surveillance</lable>
                <br/>
                <select class="form-control" id="ntipi41" name="tipi41">
                    <%
                        if (tipi41.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi41.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi41.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi41.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi42' class='control-label'>Communication restricted or under surveillance</lable>
                <br/>
                <select class="form-control" id="ntipi42" name="tipi42">
                    <%
                        if (tipi42.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi42.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi42.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi42.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi43' class='control-label'>Threat of violence against worker or family</lable>
                <br/>
                <select class="form-control" id="tipi43" name="ntipi43">
                    <%
                        if (tipi43.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi43.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi43.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi43.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi44' class='control-label'>Threat of trouble with authorities</lable>
                <br/>
                <select class="form-control" id="tipi44" name="tipi44">
                    <%
                        if (tipi44.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi44.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi44.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi44.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi45' class='control-label'>Seizure/retention of personal identity documents</lable>
                <br/>
                <select class="form-control" id="tipi45" name="tipi45">
                    <%
                        if (tipi45.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi45.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi45.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi45.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi46' class='control-label'>Poor/substandard accommodation, no option to leave</lable>
                <br/>
                <select class="form-control" id="tipi46" name="tipi46">
                    <%
                        if (tipi46.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi46.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi46.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi46.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi47' class='control-label'>No access to medical care</lable>
                <br/>
                <select class="form-control" id="tipi47" name="tipi47">
                    <%
                        if (tipi47.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi47.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi47.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi47.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi48' class='control-label'>No privacy</lable>
                <br/>
                <select class="form-control" id="tipi48" name="tipi48">
                    <%
                        if (tipi48.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi48.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi48.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi48.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi49' class='control-label'>Feel victimised by misrepresentation</lable>
                <br/>
                <select class="form-control" id="tipi49" name="tipi49">
                    <%
                        if (tipi49.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi49.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi49.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi49.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi50' class='control-label'>Feel loss of autonomy through debt or heavy sunk cost</lable>
                <br/>
                <select class="form-control" id="tipi50" name="tipi50">
                    <%
                        if (tipi50.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi50.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi50.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi50.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi51' class='control-label'>Subject to insults, abuse, violence</lable>
                <br/>
                <select class="form-control" id="tipi51" name="tipi51">
                    <%
                        if (tipi51.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi51.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi51.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi51.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi61' class='control-label'>Found in location associated with confinement/exploitation</lable>
                <br/>
                <select class="form-control" id="tipi61" name="tipi61">
                    <%
                        if (tipi61.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi61.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi61.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi61.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi62' class='control-label'>Allow others to speak for them when addressed directly</lable>
                <br/>
                <select class="form-control" id="tipi62" name="tipi62">
                    <%
                        if (tipi62.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi62.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi62.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi62.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi63' class='control-label'>Act as if instructed by someone else</lable>
                <br/>
                <select class="form-control" id="ntipi63" name="tipi63">
                    <%
                        if (tipi63.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi63.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi63.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi63.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi64' class='control-label'>Escorted wherever they go</lable>
                <br/>
                <select class="form-control" id="tipi64" name="tipi64">
                    <%
                        if (tipi64.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi64.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi64.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi64.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi65' class='control-label'>Unable to show personal identity documents</lable>
                <br/>
                <select class="form-control" id="ntipi65" name="tipi65">
                    <%
                        if (tipi65.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi65.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi65.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi65.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi66' class='control-label'>Have association with, or clothes of a kind associated with sex work</lable>
                <br/>
                <select class="form-control" id="tipi66" name="tipi66">
                    <%
                        if (tipi66.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi66.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi66.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi66.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>
            <div class='form-group'>
                <lable for='tipi67' class='control-label'>Have injuries that appear to be associated with assault or application of control measures</lable>
                <br/>
                <select class="form-control" id="tipi67" name="tipi67">
                    <%
                        if (tipi67.equals("Yes")) {
                    %>
                    <option selected>Yes</option>
                    <option>No</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                        } else if (tipi67.equals("No")) {
                    %>	
                    <option selected>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option>Not Asked</option>
                    <%                                            } else if (tipi67.equals("Unclear")) {
                    %>	
                    <option >No</option>
                    <option>Yes</option>
                    <option selected>Unclear</option>
                    <option>Not Asked</option>
                    <%                    } else if (tipi67.equals("Not Asked")) {
                    %>	
                    <option>No</option>
                    <option>Yes</option>
                    <option>Unclear</option>
                    <option selected>Not Asked</option>
                    <%                        }
                    %>
                </select>
            </div>

            <div class='form-group'>
                <label for='tipi81' class='control-label'>Describe other indicators of trafficking complained of</label>
                <br/>
                <textarea class="form-control" name="tipi81" rows="3"><%=tipi81%></textarea>
            </div>

            <div class='form-group'>
                <label for='tipi82' class='control-label'>Describe other indicators of trafficking observed</label>
                <br/>
                <textarea class="form-control" name="tipi82" rows="3"><%=tipi82%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="trafficking"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--salary claim-->            
<%
    }
    if (salaryClaimId != null) {
        int id = Integer.parseInt(salaryClaimId);
        ProblemSalaryClaim psalaryClaim = ProblemComplementsDAO.retrieveProblemSalaryClaimById(id);
%>

<form method="POST" id='salarycalim_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Salary Claim Details</h4>
    <h4 class='add_comp'>Add Salary Claim Details</h4>
    <h4 class='edit_comp'>Edit Salary Claim Details</h4>
    <div class='form-group'>

        <%
            java.util.Date date = psalaryClaim.getSalaryClaimDate();
            double loss = psalaryClaim.getSalaryClaimLoss();
            String basis = psalaryClaim.getSalaryClaimBasis();
        %>  

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Date claim lodged at MOM</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(date == null) ? ""
                                   : sdf.format(date)%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Initial value of claim S$</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(loss == 0.0) ? "" : loss%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe basis for amount claimed</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(basis == null) ? "" : basis%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#salarycalim_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#salarycalim_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


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

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="salarycalim"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>

            <div class='form-group'>
                <label for='date' class="control-label">Date claim lodged at MOM</label>
                <br/>
                <input class="form-control dateInput" type='text' name="date" 
                       value="<%=(date == null) ? ""
                               : sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='loss' class="control-label">Initial value of claim S$</label>
                <br/>
                <input class="form-control" type='text' name="loss" value="<%=(loss == 0.0) ? "" : loss%>">
            </div>
            <div class='form-group'>
                <label for='basis' class="control-label">Describe basis for amount claimed</label>
                <br/>
                <textarea class="form-control" name="basis" rows="3"><%=(basis == null) ? "" : basis%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="salarycalim"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form> 

<!--wica-->
<%
    }
    if (wicaClaimId != null) {
        int id = Integer.parseInt(wicaClaimId);
        ProblemWicaClaim pwicaClaim = ProblemComplementsDAO.retrieveProblemWicaClaimById(id);
%>

<form method="POST" id='wicaclaim_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Wica Claim Details</h4>
    <h4 class='add_comp'>Add Wica Claim Details</h4>
    <h4 class='edit_comp'>Edit Wica Claim Details</h4>
    <div class='form-group'>

        <%
            java.util.Date date = pwicaClaim.getWicaClaimDate();
            String refNumber = pwicaClaim.getWicaReferenceNumber();
            String insurer = pwicaClaim.getWicaInsurer();
            String policyNumber = pwicaClaim.getWicaPolicyNumber();
            String reason = pwicaClaim.getWicaClaimReason();
            String remark = pwicaClaim.getWicaClaimRemark();


        %>  

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='date' class="control-label">Date claim lodged at MOM</label>
                    <br/>
                    <input class="form-control" type='text' name="date" 
                           value="<%=(date == null) ? ""
                                   : sdf.format(date)%>">
                </div>
                <div class='form-group'>
                    <label for='refNumber' class="control-label">Reference number</label>
                    <br/>
                    <input class="form-control" type='text' name="refNumber" value="<%=(refNumber == null) ? "" : refNumber%>">
                </div>
                <div class='form-group'>
                    <label for='insurer' class="control-label">Insurance company</label>
                    <br/>
                    <input class="form-control" type='text' name="insurer" value="<%=(insurer == null) ? "" : insurer%>">
                </div>
                <div class='form-group'>
                    <label for='reason' class="control-label">State whether this claim is for compensation, MC wages, expense reimbursement, etc</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(reason == null) ? "" : reason%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remark</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#wicaclaim_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#wicaclaim_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>

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

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="wicaclaim"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

        <div class='edit_comp'>

            <div class='form-group'>
                <label for='date' class="control-label">Date claim lodged at MOM</label>
                <br/>
                <input class="form-control dateInput" type='text' name="date" 
                       value="<%=(date == null) ? ""
                               : sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='refNumber' class="control-label">Reference number</label>
                <br/>
                <input class="form-control" type='text' name="refNumber" value="<%=(refNumber == null) ? "" : refNumber%>">
            </div>
            <div class='form-group'>
                <label for='insurer' class="control-label">Insurance company</label>
                <br/>
                <input class="form-control" type='text' name="insurer" value="<%=(insurer == null) ? "" : insurer%>">
            </div>
            <div class='form-group'>
                <label for='policyNumber' class="control-label">Insurance policy</label>
                <br/>
                <input class="form-control" type='text' name="policyNumber" value="<%=(policyNumber == null) ? "" : policyNumber%>">
            </div>
            <div class='form-group'>
                <label for='reason' class="control-label">State whether this claim is for compensation, MC wages, expense reimbursement, etc</label>
                <br/>
                <textarea class="form-control" name="reason" rows="3"><%=(reason == null) ? "" : reason%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="wicaclaim"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--non wica-->
<%
    }
    if (nonWicaClaimId != null) {
        int id = Integer.parseInt(nonWicaClaimId);
        ProblemNonWicaClaim pnonWicaClaim = ProblemComplementsDAO.retrieveProblemNonWicaClaimById(id);
%>

<form method="POST" id='nonwicaclaim_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Non-Wica Claim Details</h4>
    <h4 class='add_comp'>Add Non-Wica Claim Details</h4>
    <h4 class='edit_comp'>Edit Non-Wica Claim Details</h4>
    <div class='form-group'>

        <%
            java.util.Date date = pnonWicaClaim.getMedicalClaimDate();
            double loss = pnonWicaClaim.getMedicalClaimLoss();
            String insurer = pnonWicaClaim.getMedicalClaimInsurer();
            String policyNumber = pnonWicaClaim.getMedicalClaimPolicyNumber();
            String basis = pnonWicaClaim.getMedicalClaimBasis();
            String remark = pnonWicaClaim.getRemark();
        %>  

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Date MOM notified</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(date == null) ? ""
                                   : sdf.format(date)%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Initial value of claim S$</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(loss == 0.0) ? "" : loss%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Insurance company</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(insurer == null) ? "" : insurer%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Insurance policy number</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(policyNumber == null) ? "" : policyNumber%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe basis for amount claimed</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(basis == null) ? "" : basis%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remark</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#nonwicaclaim_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#nonwicaclaim_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>


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
                <textarea class="form-control" name="nremark" rows="3"><%=remark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="nonwicaclaim"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>

            <div class='form-group'>
                <label for='date' class="control-label">Date MOM notified</label>
                <br/>
                <input class="form-control dateInput" type='text' name="date" 
                       value="<%=(date == null) ? ""
                               : sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='loss' class="control-label">Initial value of claim S$</label>
                <br/>
                <input class="form-control" type='text' name="loss" value="<%=(loss == 0.0) ? "" : loss%>">
            </div>
            <div class='form-group'>
                <label for='insurer' class="control-label">Insurance company</label>
                <br/>
                <input class="form-control" type='text' name="insurer" value="<%=(insurer == null) ? "" : insurer%>">
            </div>
            <div class='form-group'>
                <label for='policyNumber' class="control-label">Insurance policy number</label>
                <br/>
                <input class="form-control" type='text' name="policyNumber" value="<%=(policyNumber == null) ? "" : policyNumber%>">
            </div>
            <div class='form-group'>
                <label for='basis' class="control-label">Describe basis for amount claimed</label>
                <br/>
                <textarea class="form-control" name="basis" rows="3"><%=(basis == null) ? "" : basis%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="nonwicaclaim"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--police report-->
<%
    }
    if (policeReportId != null) {
        int id = Integer.parseInt(policeReportId);

        ProblemPoliceReport report = ProblemComplementsDAO.retrieveProblemPoliceReportById(id);
        String station = report.getPoliceReportStation();
        String person = report.getPoliceReportPerson();
        String refNum = report.getPoliceReportReferenceNumber();
        String details = report.getPoliceReportDetails();
        String remark = report.getPoliceReportRemark();

%>

<form method="POST" id='policareport_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Police Report Details</h4>
    <h4 class='add_comp'>Add A New Police Report</h4>
    <h4 class='edit_comp'>Edit Police Report Details</h4>

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='policeReportDate' class="control-label">Date: </label>
                <br/>
                <input class="form-control" type='text' name="policeReportDate" 
                       value="<%=(report.getPoliceReportDate() == null) ? "" : sdf.format(report.getPoliceReportDate())%>">
            </div>
            <div class='form-group'>
                <label for='policeReportStation' class="control-label">Station: </label>
                <br/>
                <input class="form-control" type='text' name="policeReportStation" value="<%=(station == null) ? "" : station%>">
            </div>
            <div class='form-group'>
                <label for='policeReportPerson' class="control-label">Person: </label>
                <br/>
                <input class="form-control" type='text' name="policeReportPerson" value="<%=(person == null) ? "" : person%>">
            </div>
            <div class='form-group'>
                <label for='policeReportRefereneNumber' class="control-label">Reference Number : </label>
                <br/>
                <input class="form-control" type='text' name="policeReportRefereneNumber" value="<%=(refNum == null) ? "" : refNum%>">
            </div>
            <div class='form-group'>
                <label for='policeReportDetails' class="control-label">Details of police report: </label>
                <br/>
                <textarea class="form-control" name="policeReportDetails" rows="3"><%=(details == null) ? "" : details%></textarea>
            </div>
            <div class='form-group'>
                <label for='policeReportRemark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="policeReportRemark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#policareport_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#policareport_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Date police report made<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" 
                   value="<%=(report.getPoliceReportDate() == null) ? "" : sdf.format(report.getPoliceReportDate())%>" 
                   type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Police station where report lodged: </label>
            <br/>
            <input class="form-control" value='<%= (station == null) ? "" : station%>' 
                   type='text' name="policeReportStation" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Accompanyign TWC2 person: </label>
            <br/>
            <input class="form-control" value='<%= (person == null) ? "" : person%>' 
                   type='text' name="person" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Details of police report: </label>
            <br/>
            <input class="form-control" value='<%=(refNum == null) ? "" : refNum%>' 
                   type='text' name="policeReportRefNumber" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Details of police report: </label>
            <br/>
            <textarea class="form-control" name="policeReportDetails" rows="3"><%=(details == null) ? "" : details%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remark: </label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" :remark%></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="policareport"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="policareport"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>

<!--other complaint-->
<%
    }
    if (othercomplaintId != null) {

        int id = Integer.parseInt(othercomplaintId);
        ProblemOtherComplaint complaint = ProblemComplementsDAO.retrieveProblemOtherComplaintById(id);
        HashMap<Integer, String> complaintWho = DropdownDAO.retrieveAllDropdownListOfComplaint();
        HashMap<Integer, String> complaintMode = DropdownDAO.retrieveAllDropdownListOfComplaintMode();

%>

<form method="POST" id='othercomplaint_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Other Complaint Details</h4>
    <h4 class='add_comp'>Add A New Other Complaint</h4>
    <h4 class='edit_comp'>Edit Other Complaint Details</h4>

    <%
        java.util.Date date = complaint.getOtherComplaintDate();
        String agency = complaint.getOtherComplaintAgency();
        String who = complaint.getOtherComplaintWho();
        String whoMore = complaint.getOtherComplaintWhoMore();
        String mode = complaint.getOtherComplaintMode();
        String modeMore = complaint.getOtherComplaintModeMore();
        String detail = complaint.getOtherComplaintDetails();
        String remark = complaint.getOtherComplaintRemark();
    %>

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='complaintDate' class="control-label">Date other complaint lodged: </label>
                <br/>
                <input class="form-control" type='text' name="complaintDate" 
                       value="<%=date == null ? "" : sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">Agency/authority to whom complaint addressed: </label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=(agency == null) ? "" : agency%>">
            </div>
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">This complaint is lodged by:</label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=who%>">
            </div>
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">If TWC2 or third party, name of person lodging complaint:</label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=(whoMore == null) ? "" : whoMore%>">
            </div>
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">Mode of lodging complaint: </label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=mode%>">
            </div>    
            <div class='form-group'>
                <label for='complaintDetails' class="control-label">Details of complaint lodged: </label>
                <br/>
                <textarea class="form-control" name="policeReportRemark" rows="3"><%=(detail == null) ? "" : detail%></textarea>
            </div>
            <div class='form-group'>
                <label for='complaintRemark' class="control-label">Remarks : </label>
                <br/>
                <textarea class="form-control" name="policeReportRemark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#othercomplaint_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#othercomplaint_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Date other complaint lodged <span style="color: red">*</span>: </label>
            <input class="form-control dateInput" 
                   value="<%=date == null ? "" : sdf.format(date)%>"
                   type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Agency/authority to whom complaint addressed<span style="color: red">*</span>: </label>
            <input class="form-control" value='<%= (agency == null) ? "" : agency%>' 
                   type='text' name="complaintAgency" >
        </div>
        <div class='form-group'>
            <label for='isProvided' class="control-label">This complaint is lodged by<span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="complaintTypeView" name="complaintWho" onchange="displayOther(this.id);">
                <%
                    for (String complaintT : complaintWho.values()) {
                        if (who.equals(complaintT)) {

                %>
                <option selected><%=complaintT%></option>
                <%
                } else {

                %>
                <option><%=complaintT%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="complaintTypeView_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="complaintWhoMore" value="<%=(whoMore == null) ? "" : whoMore%>">
        </div>

        <div class='form-group'>
            <label for='complaintMode' class="control-label">Complaint Mode:</label>
            <br/>
            <select class="form-control" id="complaintModeView" name="complaintMode" onchange="displayOther(this.id);">
                <%
                    for (String complaintM : complaintMode.values()) {
                        if (mode.equals(complaintM)) {

                %>
                <option selected><%=complaintM%></option>
                <%
                } else {

                %>
                <option><%=complaintM%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="complaintModeView_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="complaintModeMore" value="<%=(modeMore == null) ? "" : modeMore%>">
        </div>

        <div class='form-group'>
            <label for='' class="control-label">Details of complaint lodged: </label>
            <br/>
            <textarea class="form-control" name="complaintDetails" rows="3"><%=(detail == null) ? "" : detail%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remark:</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="othercomplaint"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
                <%

                    }
                %>  
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
            <select class="form-control" id="complaintMode" name="ncomplaintMode">
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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="othercomplaint"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>

<!--case discussion-->
<%

    }
    if (caseDiscussionId != null) {

        int id = Integer.parseInt(caseDiscussionId);
        ProblemCaseDiscussion discussion = ProblemComplementsDAO.retrieveProblemCaseDiscussionById(id);

        java.util.Date dDate = discussion.getCaseDiscussionDate();
        String dTime = discussion.getCaseDiscussionTime();
        String dWhere = discussion.getCaseDiscussionWhere();
        String dWhereMore = discussion.getCaseDiscussionWhereMore();
        String workerPresent = discussion.getCaseDiscussionWorkerPresent();
        String twcP1 = discussion.getCaseDiscussionTWC2Person1();
        String twcP2 = discussion.getCaseDiscussionTWC2Person2();
        String otherP = discussion.getCaseDiscussionOtherPerson();
        String translator = discussion.getCaseDiscussionTranslator();
        String topic = discussion.getCaseDiscussionTopic();
        String gist = discussion.getCaseDiscussionGist();
        String assist = discussion.getCaseDiscussionAssist();
        String cal = discussion.getCaseDiscussionCalculate();
        String action = discussion.getCaseDiscussionAction();
        String remark = discussion.getCaseDiscussionRemark();

        HashMap<Integer, String> locations = DropdownDAO.retrieveAllDropdownListOfDiscussWhere();

%>

<form method="POST" id='casediscussion_pop_up' class="form complement_detailed_form  problem_pop_up"  >

    <h4 class='view_comp'>View Case Discussion Details</h4>
    <h4 class='add_comp'>Add A New Case Discussion</h4>
    <h4 class='edit_comp'>Edit Case Discussion Details</h4>


    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='discussionDate' class="control-label">Discussion Date: </label>
                <br/>
                <input class="form-control" type='text' name="discussionDate" 
                       value="<%=(dDate == null) ? ""
                               : sdf.format(dDate)%>">
            </div>
            <div class='form-group'>
                <label for='discussionTime' class="control-label">Approx time of discussion: </label>
                <br/>
                <input class="form-control" type='text' name="discussionTime" value="<%=dTime%>">
            </div>
            <div class='form-group'>
                <label for='discussionWhere' class="control-label">Location/Mode of Discussion: </label>
                <br/>
                <input class="form-control" type='text' name="discussionWhere" value="<%=dWhere%>">
            </div>
            <div class='form-group'>
                <label for='discussionWorkerPresent' class="control-label">Was worker participating?: </label>
                <br/>
                <input class="form-control" type='text' name="discussionWorkerPresent" value="<%=workerPresent%>">
            </div>
            <div class='form-group'>
                <label for='discussionTWCP1' class="control-label">TWC2 Person 1: </label>
                <br/>
                <input class="form-control" type='text' name="discussionTWCP1" value="<%=twcP1%>">
            </div>
            <div class='form-group'>
                <label for='discussionTWCP2' class="control-label">TWC2 Person 2: </label>
                <br/>
                <input class="form-control" type='text' name="discussionTime" value="<%=twcP2%>">
            </div>
            <div class='form-group'>
                <label for='discussionOtherP' class="control-label">Other Person presented: </label>
                <br/>
                <input class="form-control" type='text' name="discussionOtherP" value="<%=otherP%>">
            </div>
            <div class='form-group'>
                <label for='discussionTranslator' class="control-label">Translator: </label>
                <br/>
                <input class="form-control" type='text' name="discussionTranslator" value="<%=translator%>">
            </div>
            <div class='form-group'>
                <label for='discussionTopic' class="control-label">Topic: </label>
                <br/>
                <input class="form-control" type='text' name="discussionTopic" value="<%=topic%>">
            </div>
            <div class='form-group'>
                <label for='discussionGist' class="control-label">Gist: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="4"><%=gist%></textarea>
            </div>
            <div class='form-group'>
                <label for='discussionAssist' class="control-label">Assistance/referral provided: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=assist%></textarea>
            </div>
            <div class='form-group'>
                <label for='discussionCal' class="control-label">Updated calculation of claim value: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=cal%></textarea>
            </div><div class='form-group'>
                <label for='discussionAction' class="control-label">Action: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=action%></textarea>
            </div><div class='form-group'>
                <label for='discussionRemark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#casediscussion_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#casediscussion_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Discussion Date: <span style="color: red">*</span>: </label>
            <input class="form-control dateInput" 
                   value="<%=(dDate == null) ? ""
                           : sdf.format(dDate)%>" type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Approx time of dicussion: <span style="color: red">*</span>: </label>
            <input class="form-control" value='<%=dTime%>' type='text' name="discussionTime" >
        </div>
        <div class='form-group'>
            <label for='discussionWhere' class="control-label">Location:</label>
            <br/>
            <select class="form-control" id="discussionWhere" name="discussionWhere" onchange="displayOther(this.id);">
                <%
                    for (String location : locations.values()) {
                        if (dWhere.equals(location)) {

                %>
                <option selected><%=location%></option>
                <%
                } else {

                %>
                <option><%=location%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="discussionWhere_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="discussionWhereOther" value=<%=dWhereMore%>>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Was worker participating?: </label>
            
            <select class="form-control" id="discussionWhere" name="discussionWorkerPresent">
                <%
                    if (workerPresent == "Yes") {
                %>
                <option selected>Yes</option>
                <option>No</option>
                <%                } else {
                %>
                <option selected>No</option>
                <option>Yes</option>
                <%                            }
                %>
            </select>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">TWC2 Person 1<span style="color: red">*</span>: </label>
            <input class="form-control" value='<%=twcP1%>' type='text' name="discussionTWC2P1" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">TWC2 Person 2:</label>
            <input class="form-control" value='<%=twcP2%>' type='text' name="discussionTWC2P2" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Other Person presented: </label>
            <input class="form-control" value='<%=otherP%>' type='text' name="discussionOtherPerson" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Translator:  </label>
            <input class="form-control" value='<%=translator%>' type='text' name="discussionTranslator" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Topic<span style="color: red">*</span>:</label>
            <input class="form-control" value='<%=topic%>' type='text' name="discussionTopic" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Gist:  </label>
            <textarea class="form-control" name="discussionGist" rows="4"><%=gist%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Assistance/referral provided: </label>
            <textarea class="form-control" name="discussionAssist" rows="3"><%=assist%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Updated calculation of claim value: </label>
            <textarea class="form-control" name="discussionCal" rows="3"><%=cal%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Action to follow: </label>
            <textarea class="form-control" name="discussionAction" rows="3"><%=action%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Enter New Remark:</label>
            <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="casediscussion"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
            <label for='' class="control-label">Location<span style="color: red">*</span></label>
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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="casediscussion"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>

<!--hospital-->
<%

    }
    if (hospitalId != null) {

        int id = Integer.parseInt(hospitalId);
        ProblemHospital hosp = ProblemComplementsDAO.retrieveProblemHospitalById(id);
        java.util.Date hospUpdate = hosp.getHospitalUpdate();
        String hospName = hosp.getHospitalName();
        String hospNameMore = hosp.getHospitalNameMore();
        String hospDoctor = hosp.getHospitalDoctor();
        String remark = hosp.getHospitalRemark();
        HashMap<Integer, String> names = DropdownDAO.retrieveAllDropdownListOfHosipital();

%>

<form method="POST" id='hospital_pop_up' class="form complement_detailed_form  problem_pop_up"  >

    <h4 class='view_comp'>View Hospital Providing Treatment Details</h4>
    <h4 class='add_comp'>Add A New Hospital Providing Treatment</h4>
    <h4 class='edit_comp'>Edit Hospital Providing Treatment Details</h4>

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='hospitalUpdate' class="control-label">Date of update: </label>
                <br/>
                <input class="form-control" type='text' name="hospitalUpdate" 
                       value="<%=(hospUpdate == null) ? ""
                               : sdf.format(hospUpdate)%>">
            </div>
            <div class='form-group'>
                <label for='hospitalName' class="control-label">Hospital Name: </label>
                <br/>
                <input class="form-control" type='text' name="hospitalName" value="<%=hospName%>">
            </div>
            <div class='form-group'>
                <label for='hospitalDoctor' class="control-label">Department/doctor name: </label>
                <br/>
                <input class="form-control" type='text' name="hospitalDoctor" value="<%=hospDoctor%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark:</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#hospital_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#hospital_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Date of update: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" 
                   value="<%=(hospUpdate == null) ? ""
                           : sdf.format(hospUpdate)%>" type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='discussionWhere' class="control-label">Hospital Name: <span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="hospName" name="hospName" onchange="displayOther(this.id);">
                <%
                    for (String name : names.values()) {
                        if (hospName.equals(name)) {

                %>
                <option selected><%=name%></option>
                <%
                } else {

                %>
                <option><%=name%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="hospName_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="hospNameMore" value="<%=hospNameMore%>">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Department/Doctor: </label>
            <br/>
            <input class="form-control" value='<%=hospDoctor%>' type='text' name="hospDoctor" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remark:</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="hospital"/>   
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="hospital"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>


<!--mc-->
<%
    }
    if (mcId != null) {
        int id = Integer.parseInt(mcId);
        ProblemMCStatus mcStatus = ProblemComplementsDAO.retrieveProblemMCStatusById(id);

        java.util.Date mcUpdate = mcStatus.getMCUpdate();
        String status = mcStatus.getMCStatus();
        java.util.Date exp = mcStatus.getMCExpDate();
        int cum = mcStatus.getMCDaysCumul();
        String mcRem = mcStatus.getMCRem();

        HashMap<Integer, String> statusList = DropdownDAO.retrieveAllDropdownListOfMCStatus();

%>

<form method="POST" id='mc_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='view_comp'>View MC/Light Duty Status Details</h4>
    <h4 class='add_comp'>Add A New MC/Light Duty Status</h4>
    <h4 class='edit_comp'>Edit MC/Light Duty Status Details</h4>

    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='mcUpdate' class="control-label">Date of Update: </label>
                <br/>
                <input class="form-control" type='text' name="mcUpdate"
                       value="<%=(mcUpdate == null) ? ""
                               : sdf.format(mcUpdate)%>">
            </div>
            <div class='form-group'>
                <label for='mcStatus' class="control-label">Status: </label>
                <br/>
                <input class="form-control" type='text' name="mcStatus" value="<%=status%>">
            </div>
            <div class='form-group'>
                <label for='mcExpDate' class="control-label">Expiry Date: </label>
                <br/>
                <input class="form-control" type='text' name="mcExpDate" 
                       value="<%=(exp == null) ? ""
                               : sdf.format(exp)%>">
            </div>
            <div class='form-group'>
                <label for='mcDaysCum' class="control-label">Cumulative Days: </label>
                <br/>
                <input class="form-control" type='text' name="mcDaysCum" value="<%=cum%>">
            </div>
            <div class='form-group'>
                <label for='mcRem' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=mcRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#mc_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#mc_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label">Date of Update<span style="color: red">*</span>: </label>
            <input class="form-control dateInput" value="<%=(mcUpdate == null) ? ""
                           : sdf.format(mcUpdate)%>" type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='status' class="control-label">MC Status<span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="status" name="mcStatus" onchange="displayOther(this.id);">
                <%
                    for (String statusObj : statusList.values()) {
                        if (status.equals(statusObj)) {

                %>
                <option selected><%=statusObj%></option>
                <%
                } else {

                %>
                <option><%=statusObj%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="status_other_div" >
            <label for='location' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="mcStatusMore">
        </div>
        <div class='form-group'>
            <label for='' class="control-label">MC Expiry Date:</label>
            <br/>
                   <input class="form-control dateInput" value="<%=(exp == null) ? ""
                    : sdf.format(exp)%>"  type='text' name="expDate" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Number of Cumulative Days: </label>
            <br/>
            <input class="form-control" value='<%=cum%>' type='text' name="expCum" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remark: </label>
            <textarea class="form-control" name="remark" rows="3"><%=mcRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="mc"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
            <select class="form-control" id="nmcStatus" name="nmcStatus" onchange="displayOther(this.id);">
                <%
                    for (String statusObj : statusList.values()) {
                %>
                <option><%=statusObj%></option>
                <%

                    }
                %>  
            </select>
        </div>

        <div class='form-group' class="nmcStatus_other_div" >
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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="mc"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>



</form>


<!---------------------------------->
<!-------Edit Starts Here----------->
<!---------------------------------->

<!--r2r-->
<%
    }
    if (r2rId != null) {
        int id = Integer.parseInt(r2rId);
        ProblemR2R r2r = ProblemComplementsDAO.retrieveProblemR2RById(id);

        java.util.Date r2rDate = r2r.getR2RDate();
        String r2rTime = r2r.getR2RTime();
        String hosp = r2r.getR2RHosp();
        String dept = r2r.getR2RDept();
        String r2r1 = r2r.getR2R1();
        String r2r2 = r2r.getR2R2();
        String purpose = r2r.getR2RPurpose();
        String pre = r2r.getR2RPreApptNotes();
        String post = r2r.getR2RPostApptNotes();
        String feedback = r2r.getR2RFeedback();
        double med = r2r.getR2RMedCost();
        double outlay = r2r.getR2ROutlay();

%>

<form method="POST" id='r2r_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View R2R Appointment Details</h4>
    <h4 class='add_comp'>Add A New R2R Appointment</h4>
    <h4 class='edit_comp'>Edit R2R Appointment Details</h4>

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='r2rDate' class="control-label">Date of Appointment: </label>
                <br/>
                <input class="form-control" type='text' name="date" 
                       value="<%=(r2rDate == null) ? "" : sdf.format(r2rDate)%>">
            </div>
            <div class='form-group'>
                <label for='r2rTime' class="control-label">Time of Appointment: </label>
                <br/>
                <input class="form-control" type='text' name="r2rTime" value="<%=r2rTime%>">
            </div>
            <div class='form-group'>
                <label for='r2rHosp' class="control-label">Hospital for appointment: </label>
                <br/>
                <input class="form-control" type='text' name="r2rHosp" value="<%=hosp%>">
            </div>
            <div class='form-group'>
                <label for='r2rDept' class="control-label">Department/doctor for appointment: </label>
                <br/>
                <input class="form-control" type='text' name="r2rDept" value="<%=dept%>">
            </div>
            <div class='form-group'>
                <label for='r2r1' class="control-label">R2R First Volunteer: </label>
                <br/>
                <input class="form-control" type='text' name="r2r1" value="<%=r2r1%>">
            </div>
            <div class='form-group'>
                <label for='r2r2' class="control-label">R2R Second Volunteer: </label>
                <br/>
                <input class="form-control" type='text' name="r2r2" value="<%=r2r2%>">
            </div>
            <div class='form-group'>
                <label for='r2rPurpose' class="control-label">Purpose of Appointment: </label>
                <br/>
                <input class="form-control" type='text' name="r2rPurpose" value="<%=purpose%>">
            </div>
            <div class='form-group'>
                <label for='r2rPreApptNotes' class="control-label">Pre-appointment Notes: </label>
                <br/>
                <textarea class="form-control" name="r2rPreApptNotes" rows="3"><%=pre%></textarea>
            </div>
            <div class='form-group'>
                <label for='r2rPostApptNotes' class="control-label">Post-appointment Notes: </label>
                <br/>
                <textarea class="form-control" name="r2rPostApptNotes" rows="3"><%=post%></textarea>
            </div>
            <div class='form-group'>
                <label for='r2rFeedback' class="control-label">Feedback: </label>
                <br/>
                <textarea class="form-control" name="r2rFeedback" rows="3"><%=feedback%></textarea>
            </div>
            <div class='form-group'>
                <label for='r2rMed' class="control-label">Medical Cost of this Appt: </label>
                <br/>
                <input class="form-control" type='text' name="r2rMed" value="<%=med%>">
            </div>
            <div class='form-group'>
                <label for='r2rOut' class="control-label">How much paid by volunteer: </label>
                <br/>
                <input class="form-control" type='text' name="r2rOut" value="<%=outlay%>">
            </div>
        </fieldset>

        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#r2r_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#r2r_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='r2rDate' class="control-label">Date of Appointment: <span style="color: red">*</span>:: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(r2rDate == null) ? "" : sdf.format(r2rDate)%>">
        </div>
        <div class='form-group'>
            <label for='r2rTime' class="control-label">Time of Appointment: </label>
            <br/>
            <input class="form-control" type='text' name="r2rTime" value="<%=r2rTime%>">
        </div>
        <div class='form-group'>
            <label for='r2rHosp' class="control-label">Hospital for Appointment: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control" type='text' name="r2rHosp" value="<%=hosp%>">
        </div>
        <div class='form-group'>
            <label for='r2rDept' class="control-label">Department/doctor for Appointment: </label>
            <br/>
            <input class="form-control" type='text' name="r2rDept" value="<%=dept%>">
        </div>
        <div class='form-group'>
            <label for='r2r1' class="control-label">R2R first volunteer: </label>
            <br/>
            <input class="form-control" type='text' name="r2r1" value="<%=r2r1%>">
        </div>
        <div class='form-group'>
            <label for='r2r2' class="control-label">R2R second volunteer: </label>
            <br/>
            <input class="form-control" type='text' name="r2r2" value="<%=r2r2%>">
        </div>
        <div class='form-group'>
            <label for='r2rPurpose' class="control-label">Purpose: </label>
            <br/>
            <input class="form-control" type='text' name="r2rPurpose" value="<%=purpose%>">
        </div>
        <div class='form-group'>
            <label for='r2rPreApptNotes' class="control-label">Pre-appointment Notes: </label>
            <br/>
            <textarea class="form-control" name="r2rPreApptNotes" rows="3"><%=pre%></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rPostApptNotes' class="control-label">Post-appointment Notes: </label>
            <br/>
            <textarea class="form-control" name="r2rPostApptNotes" rows="3"><%=post%></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rFeedback' class="control-label">Feedback: </label>
            <br/>
            <textarea class="form-control" name="r2rFeedback" rows="3"><%=feedback%></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rMed' class="control-label">Medical Cost of this appt: </label>
            <br/>
            <input class="form-control" type='text' name="r2rMed" value="<%=med%>">
        </div>
        <div class='form-group'>
            <label for='r2rOut' class="control-label">How much paid by volunteer: </label>
            <br/>
            <input class="form-control" type='text' name="r2rOut" value="<%=outlay%>">
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="r2r"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="r2r"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--Wica status-->
<%
    }
    if (wicaId != null) {

        int id = Integer.parseInt(wicaId);
        ProblemWica wica = ProblemComplementsDAO.retrieveProblemWicaById(id);

        java.util.Date wUpdate = wica.getWicaMonthlyUpdate();
        String wStatus = wica.getWicaMonthlyStatus();
        String wStatusMore = wica.getWicaMonthlyStatusMore();
        double wPoints = wica.getWicaMonthlyPoints();
        double wDollars = wica.getWicaMonthlyDollars();
        String wRemarks = wica.getWicaMonthlyRemarks();

        HashMap<Integer, String> wicaList = DropdownDAO.retrieveAllDropdownListOfWica();

%>

<form method="POST" id='wica_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='view_comp'>View Wica Status Details</h4>
    <h4 class='add_comp'>Add A New Wica Status</h4>
    <h4 class='edit_comp'>Edit Wica Status Details</h4>

    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='wicaUpdate' class="control-label">Date of Update: </label>
                <br/>
                <input class="form-control" type='text' name="wicaUpdate" 
                       value="<%=(wUpdate == null) ? "" : sdf.format(wUpdate)%>">
            </div>
            <div class='form-group'>
                <label for='wicaStatus' class="control-label">Wica Status: </label>
                <br/>
                <input class="form-control" type='text' name="wicaStatus" value="<%=wStatus%>">
            </div>
            <div class='form-group'>
                <label for='wicaPoints' class="control-label">Wica Points: </label>
                <br/>
                <input class="form-control" type='text' name="wicaPoints" value="<%=wPoints%>">
            </div>
            <div class='form-group'>
                <label for='wicaDollars' class="control-label"> Wica S$ compensation: </label>
                <br/>
                <input class="form-control" type='text' name="wicaDollars" value="<%=wDollars%>">
            </div>
            <div class='form-group'>
                <label for='wicaRemarks' class="control-label">Remarks re Wica Status : </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=wRemarks%></textarea>
            </div>

        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#wica_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#wica_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='wicaUpdate' class="control-label">Date of Update<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(wUpdate == null) ? "" : sdf.format(wUpdate)%>">
        </div>
        <div class='form-group'>
            <label for='wicaStatus' class="control-label">Wica Status: <span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="wicaStatus" name="wicaStatus" onchange="displayOther(this.id);">
                <%
                    for (String tempStatus : wicaList.values()) {
                        if (wStatus.equals(tempStatus)) {

                %>
                <option selected><%=tempStatus%></option>
                <%
                } else {

                %>
                <option><%=tempStatus%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="wicaStatus_other_div" >
            <label for='wicaStatusMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <textarea class="form-control" name="wicaStatusMore" rows="3"><%=wStatusMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='wicaPoints' class="control-label">Wica Points: </label>
            <br/>
            <input class="form-control" type='text' name="wicaPoints" value="<%=wPoints%>">
        </div>
        <div class='form-group'>
            <label for='wicaDollars' class="control-label">Wica S$ Compensation: </label>
            <br/>
            <input class="form-control" type='text' name="wicaDollars" value="<%=wDollars%>">
        </div>
        <div class='form-group'>
            <label for='wicaRemarks' class="control-label">Remarks re Wica Status: </label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=wRemarks%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="wica"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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

        <div class='form-group' id="nwicaStatus_other_div" >
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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="wica"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--lawyer-->
<%
    }

    if (lawyerId != null) {

        int id = Integer.parseInt(lawyerId);
        ProblemLawyer lawyer = ProblemComplementsDAO.retrieveProblemLawyerById(id);

        java.util.Date update = lawyer.getLawyerUpdate();
        //String have = lawyer.getLawyerHave();
        String firm = lawyer.getLawyerFirm();
        String firmMore = lawyer.getLawyerFirmMore();
        String lawyerName = lawyer.getLawyerName();
        String remark = lawyer.getLawyerRemarks();
        HashMap<Integer, String> lawFirmNameList = DropdownDAO.retrieveAllDropdownListOfLawFirms();
%>

<form method="POST" id='lawyer_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='view_comp'>View Law Firm Details</h4>
    <h4 class='add_comp'>Add A New Law Firm for Worker</h4>
    <h4 class='edit_comp'>Edit Law Firm Details</h4>

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='lawyerUpdate' class="control-label">Date of Update: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="lawyerUpdate" 
                       value="<%=(update == null) ? "" : sdf.format(update)%>">
            </div>
            <div class='form-group'>
                <label for='lawyerFirm' class="control-label">Current Law Firm: </label>
                <br/>
                <input class="form-control" type='text' name="lawyerFirm" value="<%=firm%>">
            </div>
            <div class='form-group'>
                <label for='lawyerFirmMore' class="control-label">Explain if above is 'Other': </label>
                <br/>
                <input class="form-control" type='text' name="lawyerFirmMore" value="<%=firmMore%>">
            </div>
            <div class='form-group'>
                <label for='lawyerName' class="control-label">Name of lawyer or assistant: </label>
                <br/>
                <input class="form-control" type='text' name="lawyerName" value="<%=lawyerName%>">
            </div>
            <div class='form-group'>
                <label for='lawyerRemark' class="control-label">Remarks re lawyer law firm status: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#lawyer_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#lawyer_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='lawyerUpdate' class="control-label">Date of Update<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(update == null) ? "" : sdf.format(update)%>">
        </div>
        <div class='form-group'>
            <label for='lawyerFirm' class="control-label">Current Law Firm<span style="color: red">*</span>: </label>
            <br/>
            <select class="form-control" id="nlawyerFirm" name="lawyerFirm" onchange="displayOther(this.id);">
                <%
                    for (String lawFirmName : lawFirmNameList.values()) {
                        if (lawFirmName.equals(firm)) {
                %>
                <option selected><%=lawFirmName%></option>
                <%
                } else {
                %>            
                <option><%=lawFirmName%></option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        <div class='form-group' id="nlawyerFirm_other_div" >
            <label for='lawyerFirmMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <textarea class="form-control" name="lawyerFirmMore" rows="3"><%=firmMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='lawyerName' class="control-label">Name of lawyer or assistant: </label>
            <br/>
            <input class="form-control" type='text' name="lawyerName" value="<%=lawyerName%>">
        </div>
        <div class='form-group'>
            <label for='lawyerRemark' class="control-label">Remarks re lawyer law firm status: </label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="lawyer"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="lawyer"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--non criminal milestone-->
<%

    }
    if (ncmilestoneId != null) {

        int id = Integer.parseInt(ncmilestoneId);
        ProblemCaseMilestoneNC nc = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCById(id);

        java.util.Date ncDate = nc.getMilesNCDate();
        String ncReached = nc.getMilesNCReached();
        String ncRem = nc.getMilesNCRem();

        HashMap<Integer, String> ncList = DropdownDAO.retrieveAllDropdownListOfMilestoneNonCriminal();

%>

<form method="POST" id='milestonenc_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='view_comp'>View Case Milestone (Non-Criminal) Details</h4>
    <h4 class='add_comp'>Add A New Case Milestone (Non-Criminal)</h4>
    <h4 class='edit_comp'>Edit Case Milestone (Non-Criminal) Details</h4>
    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='milestoneNCDate' class="control-label">Date Milestone Reached: </label>
                <br/>
                <input class="form-control" type='text' name="milestoneNCDate" 
                       value="<%=(ncDate == null) ? "" : sdf.format(ncDate)%>">
            </div>
            <div class='form-group'>
                <label for='milestoneNCReached' class="control-label">Milestone Reached: </label>
                <br/>
                <input class="form-control" type='text' name="milestoneNCReached" value="<%=ncReached%>">
            </div>
            <div class='form-group'>
                <label for='milestoneNCRem' class="control-label">Remark re Milestone Reached: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=ncRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#milestonenc_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#milestonenc_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='milestoneNCDate' class="control-label">Date Milestone Reached: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(ncDate == null) ? "" : sdf.format(ncDate)%>">
        </div>
        <div class='form-group'>
            <label for='milestoneNCReached' class="control-label">Milestone Reached: <span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="ncReached" name="milestoneNCReached" onchange="displayOther(this.id);">
                <%
                    for (String reached : ncList.values()) {
                        if (ncReached.equals(reached)) {

                %>
                <option selected><%=reached%></option>
                <%
                } else {

                %>
                <option><%=reached%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="ncReached_other_div" >
            <label for='milestoneNCReachedMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="milestoneNCReachedMore">
        </div>
        <div class='form-group'>
            <label for='milestoneNCRem' class="control-label">Remark re Milestone Reached: </label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=ncRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="ncmilestone"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="ncmilestone"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--criminal milestone-->
<%

    }
    if (cmilestoneId != null) {

        int id = Integer.parseInt(cmilestoneId);
        ProblemCaseMilestoneCR cr = ProblemComplementsDAO.retrieveProblemCaseMilestoneCRById(id);

        java.util.Date crDate = cr.getMilesCRDate();
        String crReached = cr.getMilesCRReached();
        String crCharges = cr.getMilesCRCharges();
        String crSentence = cr.getMilesCRSentence();
        String crRem = cr.getMilesCRRem();

        HashMap<Integer, String> crList = DropdownDAO.retrieveAllDropdownListOfMilestoneCriminal();

%>

<form method="POST" id='milestonecr_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <h4 class='view_comp'>View Case Milestone (Criminal) Details</h4>
    <h4 class='add_comp'>Add A New Case Milestone (Criminal)</h4>
    <h4 class='edit_comp'>Edit Case Milestone (Criminal) Details</h4>

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='milestoneCRDate' class="control-label">Date Milestone Reached: </label>
                <br/>
                <input class="form-control" type='text' name="milestoneCRDate" 
                       value="<%=(crDate == null) ? "" : sdf.format(crDate)%>">
            </div>
            <div class='form-group'>
                <label for='milestoneCRReached' class="control-label">Milestone Reached: </label>
                <br/>
                <input class="form-control" type='text' name="milestoneCRReached" value="<%=crReached%>">
            </div>
            <div class='form-group'>
                <label for='milestoneCRCharge' class="control-label">Details of Charges: </label>
                <br/>
                <textarea class="form-control" name="milestoneCRCharges" rows="3"><%=crCharges%></textarea>
            </div>
            <div class='form-group'>
                <label for='milestoneCRSentence' class="control-label">Details of Sentence: </label>
                <br/>
                <textarea class="form-control" name="milestoneCRSentence" rows="3"><%=crSentence%></textarea>
            </div>
            <div class='form-group'>
                <label for='milestoneCRRem' class="control-label">Remark re Milestone Reached: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=crRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#milestonecr_pop_up", "problem");'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#milestonecr_pop_up", "problem");'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>


    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='milestoneCRDate' class="control-label">Date Milestone Reached: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(crDate == null) ? "" : sdf.format(crDate)%>">
        </div>
        <div class='form-group'>
            <label for='milestoneCRReached' class="control-label">Milestone Reached: <span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="crReached" name="milestoneCRReached" onchange="displayOther(this.id);">
                <%
                    for (String reached : crList.values()) {
                        if (crReached.equals(reached)) {

                %>
                <option selected><%=reached%></option>
                <%
                } else {

                %>
                <option><%=reached%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="crReached_other_div" >
            <label for='milestoneCRReachedMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="milestoneCRReachedMore">
        </div>
        <div class='form-group'>
            <label for='milestoneCRCharges' class="control-label">Details of Charges: </label>
            <br/>
            <input class="form-control" type='text' name="milestoneCRCharges" value="<%=crCharges%>">
            <textarea class="form-control" name="remark" rows="3"><%=crRem%></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRSentence' class="control-label">Details of Sentence: </label>
            <br/>
            <textarea class="form-control" name="milestoneCRSentence" rows="3"><%=crSentence%></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRRem' class="control-label">Remark re Milestone Reached: </label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=crRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="cmilestone"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>


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
            <select class="form-control" id="ncReached" name="nmilestoneCRReached" onchange="displayOther(this.id);">
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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="cmilestone"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--TTR-->
<%
    }
    if (ttrId != null) {

        int id = Integer.parseInt(ttrId);
        ProblemTTR ttr = ProblemComplementsDAO.retrieveProblemTTRById(id);

        java.util.Date update = ttr.getTTRUpdate();
        String status = ttr.getTTRStatus();
        java.util.Date departureDate = ttr.getDepartureDate();
        String employerName = ttr.getNewEmployerName();
        String job = ttr.getNewJob();
        String ttrRem = ttr.getTTRRem();

        HashMap<Integer, String> ttrList = DropdownDAO.retrieveAllDropdownListOfTTRStatus();
%>

<form method="POST" id='ttr_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Transfer, TJS & Repatriation Details</h4>
    <h4 class='add_comp'>Add A New Transfer, TJS & Repatriation</h4>
    <h4 class='edit_comp'>Edit Transfer, TJS & Repatriation Details</h4>
    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='ttrUpdate' class="control-label">Date of Update: <span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="date" 
                       value="<%=(update == null) ? "" : sdf.format(update)%>">
            </div>
            <div class='form-group'>
                <label for='ttrStatus' class="control-label">Transfer, TJS or Repatriation Status<span style="color: red">*</span>: </label>
                <br/>
                <input class="form-control" type='text' name="ttrStatus" value="<%=status%>">
            </div>
            <div class='form-group'>
                <label for='ttrDepartureDate' class="control-label">Date of Departure from Singapore: </label>
                <br/>
                <input class="form-control" type='text' name="ttrDepartureDate" 
                       value="<%=(departureDate == null) ? "" : sdf.format(departureDate)%>">
            </div>
            <div class='form-group'>
                <label for='ttrEmployerName' class="control-label">Name of TJS or New Employer: </label>
                <br/>
                <input class="form-control" type='text' name="ttrEmployerName" value="<%=employerName%>">
            </div>
            <div class='form-group'>
                <label for='ttrJob' class="control-label">Description of TJS or new job : </label>
                <br/>
                <input class="form-control" type='text' name="ttrJob" value="<%=job%>">
                <textarea class="form-control" name="ttrJob" rows="3"><%=job%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark re Transfer, TJS or Repatriation: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=ttrRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group view_comp">
            <button type='button' class="btn modal_btn " onclick='editComplement("#ttr_pop_up", "problem")'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn ' onclick='add("#ttr_pop_up", "problem")'>Add</button>                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='ttrUpdate' class="control-label">Date of Update: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(update == null) ? "" : sdf.format(update)%>">
        </div>
        <div class='form-group'>
            <label for='ttrStatus' class="control-label">Transfer, TJS or Repatriation Status: <span style="color: red">*</span></label>
            <br/>
            <select class="form-control" id="ttrStatus" name="ttrStatus" onchange="displayOther(this.id);">
                <%
                    for (String tempStatus : ttrList.values()) {
                        if (status.equals(tempStatus)) {

                %>
                <option selected><%=tempStatus%></option>
                <%
                } else {

                %>
                <option><%=tempStatus%></option>
                <%

                        }
                    }
                %>  
            </select>
        </div>

        <div class='form-group' id="ttrStatus_other_div" >
            <label for='ttrStatusMore' class="control-label">Explain if above is 'Other': </label>
            <br/>
            <input class="form-control" type='text' name="ttrstatusMore">
        </div>
        <div class='form-group'>
            <label for='ttrDepartureDate' class="control-label">Date of Departure from Singapore: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ttrDepartureDate" 
                   value="<%=(departureDate == null) ? "" : sdf.format(departureDate)%>">
        </div>
        <div class='form-group'>
            <label for='ttrEmployerName' class="control-label">Name of TJS or New Employer: </label>
            <br/>
            <input class="form-control" type='text' name="ttrEmployerName" value="<%=employerName%>">
        </div>
        <div class='form-group'>
            <label for='ttrJob' class="control-label">Description of TJS or New Job : </label>
            <br/>
            <textarea class="form-control" name="ttrJob" rows="3"><%=job%></textarea>
        </div>
        <div class='form-group'>
            <label for='remark' class="control-label">Remark re Transfer, TJS or Repatriation: </label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=ttrRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="ttr"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

    <!--add-->
    <div class='add_comp'>

        <div class='form-group'>
            <label for='ttrUpdate' class="control-label">Date of Update: <span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control dateInput" type='text' name="ndate">
        </div>
        <div class='form-group'>
            <label for='nttrStatus' class="control-label">Transfer, TJS or Repatriation Status<span style="color: red">*</span>:</label>
            <br/>
            <select class="form-control" id="nttrStatus" name="nttrStatus" onchange="displayOther(this.id);">
                <%
                    for (String tempStatus : ttrList.values()) {
                %>
                <option><%=tempStatus%></option>
                <%

                    }
                %>  
            </select>
        </div>
        <div class='form-group' id="nttrStatus_other_div" >
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
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="ttr"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp ">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>
<!---------------------------------->
<!------------Edit Ends------------->
<!---------------------------------->

<!--aggrav Issue-->
<%

    }
    if (aggravIssueId != null) {
        int id = Integer.parseInt(aggravIssueId);
        ProblemAggravatingIssue issue = ProblemComplementsDAO.retrieveProblemAggravatingIssueById(id);
        HashMap<Integer, String> problemTypes = DropdownDAO.retrieveAllDropdownListOfProblems();
%>
<form method="POST" id='aggravIssue_pop_up' class="form complement_detailed_form problem_pop_up"  >


    <h4 class='view_comp'>View Aggravating Issue Details</h4>
    <h4 class='add_comp'>Add A New Aggravating Issue </h4>
    <h4 class='edit_comp'>Edit Aggravating Issue  Details</h4>
    <div class='form-group'>

        <%
            String type = issue.getAggravatingIssue();
            if (type.equals("other")) {
                type = issue.getAggravatingIssueMore();
            }

            double loss = 0.00;
            String lossStr = issue.getAggravatingLoss();
            if (lossStr != null || lossStr.trim().length() > 0) {
                loss = Double.parseDouble(lossStr);
            }
            String remark = issue.getAggravatingRemark();

            if (remark == null) {
                remark = "-";
            }
        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Aggravating issue</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=type%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Monetary loss/value S$</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=loss%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remark</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null)? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#aggravIssue_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#aggravIssue_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>

        <div class='add_comp'>
            <div class='form-group'>
                <label for='naggravissueType' class="control-label">Aggravating issue<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="naggravissueType" name="naggravissueType" onchange="displayOther(this.id);">
                    <%
                        for (String aggravissueType : problemTypes.values()) {
                    %>
                    <option><%=aggravissueType%></option>
                    <%

                        }
                    %>  
                </select>

            </div>

            <div class='form-group' id='naggravissueType_other_div' >
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
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="aggravissue"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='aggravissueType' class="control-label">Aggravating issue<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="aggravissueType" name="aggravissueType" onchange="displayOther(this.id);">
                    <%
                        for (String provided : problemTypes.values()) {
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

            <div class='form-group' id='aggravissueType_other_div' >
                <label for='aggravissueTypeMore' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="aggravissueTypeMore">
            </div>
            <div class='form-group'>
                <label for='aggravLoss' class="control-label">Monetary loss/value S$</label>
                <br/>
                <input class="form-control" type='text' name="aggravLoss" value="<%=loss%>">
            </div>
            <div class='form-group'>
                <label for='aggravRemark' class="control-label">Remark </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "": remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="aggravissue"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--Lead Case Worker-->            
<%
    }
    if (leadCaseworkerId != null) {
        int id = Integer.parseInt(leadCaseworkerId);
        ProblemLeadCaseWorker leadCaseWorker = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById(id);
        HashMap<Integer, String> leadCaseWorkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>
<form method="POST" id='leadcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Lead Caseworker Details</h4>
    <h4 class='add_comp'>Add A New Lead Caseworker </h4>
    <h4 class='edit_comp'>Edit Lead Caseworker  Details</h4>
    <div class='form-group'>
        <%
            String name = leadCaseWorker.getLeadCaseWorker();
            java.util.Date startDate = leadCaseWorker.getLeadStart();
            java.util.Date endDate = leadCaseWorker.getLeadEnd();
        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Lead Caseworker</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Lead Start Date</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(startDate == null) ? "" : sdf.format(startDate)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Lead End Date </label>
                    <br/>
                    <input class="form-control" type='text' name="remark"
                           value="<%=(endDate == null) ? "" : sdf.format(endDate)%>">
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#leadcaseworker_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#leadcaseworker_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>

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
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="leadcaseworker"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='leadCaseWorker' class="control-label">Lead Caseworker
                    <span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="leadCaseWorker" name="leadCaseWorkerName">
                    <%
                        for (String providname : leadCaseWorkerNameList.values()) {
                            if (name.equals(providname)) {
                    %>
                    <option selected><%=providname%></option>
                    <%
                    } else {

                    %>
                    <option><%=providname%></option>
                    <%
                            }
                        }
                    %>  
                </select>
            </div>
            <!--
            <div class='form-group' id='leadCaseWorkerOther' >
                <label for='leadCaseWorkerOther' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="leadCaseWorkerOther">
            </div>-->
            <div class='form-group'>
                <label for='startDate' class="control-label">Lead Start Date:</label>
                <br/>
                <input class="form-control startDate" type='text' name="startDate" 
                       value="<%=(startDate == null) ? "" : sdf.format(startDate)%>">
            </div>
            <div class='form-group'>
                <label for='endDate' class="control-label">Lead End Date: </label>
                <br/>
                <input class="form-control endDate" type='text' name="endDate" 
                       value="<%=(endDate == null) ? "" : sdf.format(endDate)%>">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="leadcaseworker"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--Auxiliary Case Worker -->            
<%
    }
    if (auxCaseworkerId != null) {
        int id = Integer.parseInt(auxCaseworkerId);
        ProblemAuxiliaryCaseWorker auxiliaryCaseworker = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerById(id);
        HashMap<Integer, String> auxiliaryCaseworkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>
<form method="POST" id='auxcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Auxiliary Caseworker Details</h4>
    <h4 class='add_comp'>Add A New Auxiliary Caseworker </h4>
    <h4 class='edit_comp'>Edit Auxiliary Caseworker  Details</h4>
    <div class='form-group'>
        <%
            String name = auxiliaryCaseworker.getAuxName();
            java.util.Date startDate = auxiliaryCaseworker.getAuxStart();
            java.util.Date endDate = auxiliaryCaseworker.getAuxEnd();
        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Auxiliary Caseworker</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Auxiliary Start Date</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(startDate == null) ? "" : sdf.format(startDate)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Auxiliary End Date </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" 
                           value="<%=(endDate == null) ? "" : sdf.format(endDate)%>">
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#auxcaseworker_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#auxcaseworker_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>

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
                <input class="form-control dateInput" type='text' name="nstartDate">
            </div>
            <div class='form-group'>
                <label for='nendDate' class="control-label">Auxiliary End Date: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="nendDate">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="auxcaseworker"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='auxiliaryCaseWorker' class="control-label">Auxiliary Caseworker<span style="color: red">*</span></label>
                <br/>
                <select class="form-control" id="auxiliaryCaseWorker" name="auxiliaryCaseWorkerName">
                    <%
                        for (String providname : auxiliaryCaseworkerNameList.values()) {
                            if (name.equals(providname)) {
                    %>
                    <option selected><%=providname%></option>
                    <%
                    } else {

                    %>
                    <option><%=providname%></option>
                    <%
                            }
                        }
                    %>  
                </select>
            </div>

            <!--div class='form-group' id='auxiliaryCaseWorkerOther' >
                <label for='auxiliaryCaseWorkerOther' class="control-label">Explain if above is other</label>
                <br/>
                <input class="form-control" type='text' name="auxiliaryCaseWorkerOther">
            </div-->
            <div class='form-group'>
                <label for='startDate' class="control-label">Auxiliary Start Date:</label>
                <br/>
                <input class="form-control dateInput" type='text' name="startDate" 
                       value="<%=(startDate == null) ? "" : sdf.format(startDate)%>">
            </div>
            <div class='form-group'>
                <label for='endDate' class="control-label">Auxiliary End Date: </label>
                <br/>
                <input class="form-control dateInput" type='text' name="endDate" 
                       value="<%=(endDate == null) ? "" : sdf.format(endDate)%>">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="auxcaseworker"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!--Salary Related History --> 
<%
    }

    if (salaryCaseId != null) {
        int id = Integer.parseInt(salaryCaseId);
        ProblemSalaryRelatedHistory psalary = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryById(id);
        HashMap<Integer, String> modeOfPayment = DropdownDAO.retrieveAllDropdownListOfSalaryMode();
%>
<form method="POST" id='salaryhistory_pop_up' class="form complement_detailed_form problem_pop_up"  >
    <h4 class='view_comp'>View Salary & Related History Details</h4>
    <h4 class='add_comp'>Add A New Salary & Related History </h4>
    <h4 class='edit_comp'>Edit Salary & Related History  Details</h4>
    <div class='form-group'>


        <%
            String mode = psalary.getSalMode();
            if (mode.equals("other")) {
                mode = psalary.getSalModeMore();
            }
            String basic = psalary.getSalHistBasic();
            String overtime = psalary.getSalHistOt();
            String allowance = psalary.getSalHistAllowances();
            String deduction = psalary.getSalHistDeductions();
            String kickbacks = psalary.getSalHistKickbacks();
            String other = psalary.getSalHistOther();
            double totalValue = psalary.getSalLossTotal();
            double oneYearValue = psalary.getSalLoss1Year();
            String remark = psalary.getSalHisRemarks();
        %>  
        <!--view -->
        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Describe complaint about basic salary incorrect or not paid:</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=basic%></textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Describe complaint about overtime incorrect or not paid:</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=overtime%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe complaint about allowance incorrect or not paid:</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=allowance%></textarea>
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Describe complaint about deductions:</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=deduction%></textarea>
                </div>

                <div class='form-group'>
                    <label for='remark' class="control-label">Describe complaint about kickbacks:</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=kickbacks%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Other Related Details: </label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=other%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Mode of Salary Payment</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=mode%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Estimated Total Value of Claim (S$):</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=totalValue%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Estimated 12 Months' Value of Claim (S$):</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=oneYearValue%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remark:</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group">
                <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#salaryhistory_pop_up", "problem")'>Edit</button>
                <div class='pull-right'>
                    <button type='button' class='btn modal_btn view_comp' onclick='add("#salaryhistory_pop_up", "problem")'>Add</button>                  
                    <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
                </div>
            </div>
        </div>

        <!--add-->
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
                <select class="form-control" id="nmode" name="nmode" onchange="displayOther(this.id);">
                    <%
                        for (String pmode : modeOfPayment.values()) {
                    %>
                    <option><%=pmode%></option>
                    <%

                        }
                    %>  
                </select>
            </div>

            <div class='form-group' id='nmode_other_div' >
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
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="salaryhistory"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn add_comp">Save</button>
                <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
            </div>
        </div>

        <!-- edit -->
        <div class='edit_comp'>
            <div class='form-group'>
                <label for='basic' class="control-label">Describe complaint about basic salary incorrect or not paid<span style="color: red">*</span>:</label>
                <br/>
                <textarea class="form-control" name="basicSal" rows="3"><%=basic%></textarea>
            </div>
            <div class='form-group'>
                <label for='overtime' class="control-label">Describe complaint about overtime incorrect or not paid:</label>
                <br/>
                <textarea class="form-control" name="overtime" rows="3"><%=overtime%></textarea>
            </div>

            <div class='form-group'>
                <label for='allowance' class="control-label">Describe complaint about allowance incorrect or not paid:</label>
                <br/>
                <textarea class="form-control" name="allowance" rows="3"><%=allowance%></textarea>
            </div>

            <div class='form-group'>
                <label for='deduction' class="control-label">Describe complaint about deductions:</label>
                <br/>
                <textarea class="form-control" name="deduction" rows="3"><%=deduction%></textarea>
            </div>
            <div class='form-group'>
                <label for='kickbacks' class="control-label">Describe complaint about kickbacks:</label>
                <br/>
                <textarea class="form-control" name="kickbacks" rows="3"><%=kickbacks%></textarea>
            </div>
            <div class='form-group'>
                <label for='other' class="control-label">Other Related Details:</label>
                <br/>
                <textarea class="form-control" name="otherSal" rows="3"><%=other%></textarea>
            </div>
            <div class='form-group'>
                <label for='mode' class="control-label">Mode of Salary Payment</label>
                <br/>
                <select class="form-control" id="mode" name="mode" onchange="displayOther(this.id);">
                    <%
                        for (String provided : modeOfPayment.values()) {
                            if (mode.equals(provided)) {

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

            <div class='form-group' id='mode_other_div' >
                <label for='modeMore' class="control-label">Explain if above is other</label><br/>
                <input class="form-control" type='text' name="modeMore">
            </div>
            <div class='form-group'>
                <label for='totalValue' class="control-label">Estimated Total Value of Claim (S$):</label>
                <br/>
                <input class="form-control" type='text' name="totalLoss" value="<%=totalValue%>">
            </div>
            <div class='form-group'>
                <label for='oneYearValue' class="control-label">Estimated 12 Months' Value of Claim(S$):</label>
                <br/>
                <input class="form-control" type='text' name="oneYearLoss" value="<%=oneYearValue%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="salaryhistory"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>
<%}%>

<script>
    $(document).ready(function() {
        $("#pop_up_content").dialog({
            create: function(event, ui) {
                var widget = $(this).dialog("widget");
                $(".ui-dialog-titlebar-close span", widget)
                        .removeClass("ui-icon-closethick")
                        .addClass("ui-icon-close");
            }
        });
    });

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

    function editComplement(div_id, category) {
        $(div_id).attr("action", "editProblemComplement.do");
        $(div_id + " .edit_comp").show();
        $(div_id + " .view_comp").hide();
        $(div_id + " .add_comp").hide();
        $(div_id + " .add_comp input").prop('disabled', true);
    }

    function add(div_id, category) {
        if (category === "worker") {
            $(div_id).attr("action", "addWorkerComplement.do");
        } else if (category === "job") {
            $(div_id).attr("action", "addJobComplement.do");
        } else if (category === "problem") {
            $(div_id).attr("action", "addProblemComplement.do");
        }
        $(div_id + " .add_comp").show();
        $(div_id + " .edit_comp").hide();
        $(div_id + " .view_comp").hide();
        $(div_id + " .view_comp input").prop('disabled', true);
    }

    //to reset all the fields whenever the modal is opened [***need to resolve for picture]
    $('.problem_pop_up').on('shown.bs.modal', function() {
        $('.problem_pop_up').bootstrapValidator('resetForm', true);
    });


</script>