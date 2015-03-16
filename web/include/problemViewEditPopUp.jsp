<%-- 
    Document   : problemViewEditPopUp
    Created on : Nov 6, 2014, 5:12:37 PM
    Author     : Nyein Su
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>

<script>
    $(document).ready(function() {
        //----initialize datepicker----//
        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true
        });

        //----validation for start date and end date----//
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

    //----problem form validation----//
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
                            message: 'Remarks must be less than 200 characters.'
                        }
                    }
                },
                nNWICAremark: {
                    valudators: {
                        stringLength: {
                            max: 1000,
                            message: 'Remarks must be less than 1000 characters.'
                        }
                    }
                },
                NWICAremark: {
                    valudators: {
                        stringLength: {
                            max: 1000,
                            message: 'Remarks must be less than 1000 characters.'
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
                nhowinjury: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
                        }
                    }
                },
                howinjury: {
                    validators: {
                        stringLength: {
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
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
                            message: 'Remarks: must be less than 200 characters.'
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
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
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
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
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
                        notEmpty: {
                            message: 'Reference number cannot be empty.'
                        },
                        stringLength: {
                            max: 30,
                            message: 'Reference number must not exceed 30 characters.'
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
                            max: 30,
                            message: 'Insurance policy no must be less than 30 characters.'
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
                            max: 30,
                            message: 'Insurance policy no must be less than 30 characters.'
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
                npoliceReportPerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Accompanying person name must be less than 200 characters.'
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
                policeReportPerson: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Accompanying person name must be less than 200 characters.'
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
                complaintWhoMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                complaintModeMore: {
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
                ncomplaintWhoMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                ncomplaintModeMore: {
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
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
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
                internalRemarks: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Remarks must be less than 500 characters.'
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
                            max: 1000,
                            message: 'This field must be less than 1000 characters.'
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
                ninternalRemarks: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Remarks must be less than 500 characters.'
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
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                r2rOut: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
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
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                wicaDollars: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
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
                ttrremark: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Remarks must be less than 500 characters.'
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
                nttrremark: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'Remarks must be less than 500 characters.'
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
                        regexp: {
                            //regexp: /[1-9](?:\d{0,2})(?:,\d{3})*(?:\.\d*[1-9])?|0?\.\d*[1-9]|0/,
                            //regexp: /^(\d+)?,+?(\d{3})*(\.[0-9]{1,2})?$/,
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
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
                naggravLoss: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
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
                basicSal: {
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
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                oneYearLoss: {
                    validators: {
                        regexp: {
                            regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                },
                nbasicSal: {
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

</script>
<style>
    button{
        width : 6vw;
    }
</style>

<%
    /* data collection */
    //worker complement passed data
    String worker_fin = request.getParameter("workerFin");
    String jobKey = request.getParameter("jobkey");
    String probKey = request.getParameter("probkey");

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
    String nonWICAClaimId = request.getParameter("nonwicaclaim");
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
    java.util.Date today = new java.util.Date();
    DecimalFormat df = new DecimalFormat("#,###,###.00");
%>

<%
    if (injuryCaseId != null) {
        int id = Integer.parseInt(injuryCaseId);
        ProblemInjury pinjury = ProblemComplementsDAO.retrieveProblemInjuryById(id);
%>

<!------------------>
<!--injury history-->
<!------------------>
<form method="POST" id='injurycase_pop_up' class="form complement_detailed_form problem_pop_up"  >

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

<!--view-->
        <div class="view_comp" >
            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Date of injury</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(injuryDate == null) ? ""
                                   : sdf.format(injuryDate)%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Approx time of injury</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(injuryTime == null) ? "" : injuryTime%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Location of incident </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryLocation == null) ? "" : injuryLocation%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Did death ensure?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryDeath == null) ? "" : injuryDeath%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Body part(s) injured</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(injuryBodyPart == null) ? "" : injuryBodyPart%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">How injury happened</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=injuryHow%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Was worker conveyed to hospital in ambulance?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryAmbulance == null) ? "" : injuryAmbulance%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Where (clinic/hospital) initially treated</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryInitialTreatment == null) ? "" : injuryInitialTreatment%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Does worker consider incident work-related?</label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(injuryWorkRelated == null) ? "" : injuryWorkRelated%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about Injury history</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(injuryRemark == null) ? "" : injuryRemark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn view_comp" onclick='editComplement("#injurycase_pop_up", "problem", "Edit Injury history Details")'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn view_comp' onclick='add("#injurycase_pop_up", "problem", "Add A New Injury history")'>Add</button>-->                  
                <button type='button' class="btn view_comp cancel_btn">Cancel</button>
            </div>
        </div>
<!--edit-->
        <div class='edit_comp'>
            <div class='form-group'>
                <label for='date' class="control-label">Date of injury</label>
                <br/>
                <input class="form-control dateInput" type='text' name="date" 
                       value="<%=(injuryDate == null) ? ""
                               : sdf.format(injuryDate)%>" >
            </div>
            <div class='form-group'>
                <label for='time' class="control-label">Approx time of injury</label>
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
                <label for='howinjury' class="control-label">How injury happened</label>
                <br/>
                <textarea class="form-control" name="howinjury" rows="3"><%=(injuryHow == null) ? "" : injuryHow%></textarea>
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
                <label for='treatment' class="control-label">Where (clinic/hospital) initially treated</label>
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
                <label for='remark' class="control-label">Remarks about injury history</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(injuryRemark == null) ? "" : injuryRemark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="injurycase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-- --------------- -->
<!-- illness history -->
<!-- --------------- -->
<%
    }
    if (illnessCaseId != null) {
        int id = Integer.parseInt(illnessCaseId);
        ProblemIllness pillness = ProblemComplementsDAO.retrieveProblemIllnesseById(id);
%>

<form method="POST" id='illnesscase_pop_up' class="form complement_detailed_form problem_pop_up"  >

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
                    <label for='name' class="control-label">When illness began</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(startTime == null) ? "" : startTime%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">When illness diagnosed</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(diagnoseTime == null) ? "" : diagnoseTime%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Who (doctor/hospital name) diagnosed</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(diagnoseWho == null) ? "" : diagnoseWho%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Nature of illness </label>
                    <br/>
                    <input class="form-control" type='text' name="remark" value="<%=(nature == null) ? "" : nature%>">
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
                    <label for='remark' class="control-label">Remarks about illness history</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#illnesscase_pop_up", "problem", "Edit illness history  Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#illnesscase_pop_up", "problem", "Add A illness history Details");'>Add</button>-->                  
                <button type='button' class="btn cancel_btn">Cancel</button>
            </div>
        </div>


        <div class='edit_comp'>
            <div class='form-group'>
                <label for='startTime' class="control-label"><span style="color: red">*</span> When illness Began</label>
                <br/>
                <input class="form-control" type='text' name="startTime" value="<%=(startTime == null) ? "" : startTime%>">
            </div>
            <div class='form-group'>
                <label for='diagnoseTime' class="control-label">When illness diagnosed</label>
                <br/>
                <input class="form-control" type='text' name="diagnoseTime" value="<%=(diagnoseTime == null) ? "" : diagnoseTime%>">
            </div>
            <div class='form-group'>
                <label for='diagnosePerson' class="control-label">Who (doctor/hospital name) Diagnosed</label>
                <br/>
                <input class="form-control" type='text' name="diagnosePerson" value="<%=(diagnoseWho == null) ? "" : diagnoseWho%>">
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
                    <% 
                }
                    %>
                </select>
            </div>
            <div class="form-group" id="workRelatedYes_div">
                <label for="workRelatedYes" class="control-label">If worker thinks work-related, why?</label>
                <br/>
                <textarea class="form-control" name="workRelatedYes" rows="3"><%=(why == null) ? "" : why%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about illness history</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="illnesscase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------------------------------> 
<!--Details & history of other Problems-->   
<!---------------------------------------> 
<%
    }
    if (otherCaseId != null) {
        int id = Integer.parseInt(otherCaseId);
        ProblemOtherProblems pother = ProblemComplementsDAO.retrieveProblemOtherProblemsById(id);
%>

<form method="POST" id='othercase_pop_up' class="form complement_detailed_form problem_pop_up"  >

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
                    <input class="form-control" type='text' name="name" value="<%=(loss == 0.0) ? "" : df.format(loss)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about history of other problems</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>
            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#othercase_pop_up", "problem", "Edit Details & history of Other Problems");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#othercase_pop_up", "problem", "Add Details & history of Other Problems");'>Add</button>-->                  
                <button type='button' class="btn cancel_btn">Cancel</button>
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
                <input class="form-control" type='text' name="loss" value="<%=(loss == 0.0) ? "" : df.format(loss)%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about history of other problems</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="othercase"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------->
<!--Salary Calim-->
<!---------------->
<%
    }
    if (salaryClaimId != null) {
        int id = Integer.parseInt(salaryClaimId);
        ProblemSalaryClaim psalaryClaim = ProblemComplementsDAO.retrieveProblemSalaryClaimById(id);
%>

<form method="POST" id='salarycalim_pop_up' class="form complement_detailed_form problem_pop_up"  >

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
                    <input class="form-control" type='text' name="name" value="<%=(loss == 0.0) ? "" : df.format(loss)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Describe basis for amount claimed</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(basis == null) ? "" : basis%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#salarycalim_pop_up", "problem", "Edit Salary Claim Lodged Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#salarycalim_pop_up", "problem", "Add Salary Claim Lodged");'>Add</button>-->                  
                <button type='button' class="btn cancel_btn">Cancel</button>
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
                <input class="form-control" type='text' name="loss" value="<%=(loss == 0.0) ? "" : df.format(loss)%>">
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
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form> 

<!--------------------->
<!--wica claim lodged-->
<!--------------------->
<%
    }
    if (wicaClaimId != null) {
        int id = Integer.parseInt(wicaClaimId);
        ProblemWicaClaim pwicaClaim = ProblemComplementsDAO.retrieveProblemWicaClaimById(id);
%>

<form method="POST" id="wicaclaim_pop_up" class="form complement_detailed_form problem_pop_up"  >

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
                           value="<%=(date == null) ? "" :sdf.format(date)%>">
                </div>
                <div class='form-group'>
                    <label for='refNumber' class="control-label"><span style="color: red">*</span> WICA reference number</label>
                    <br/>
                    <input class="form-control" type='text' name="refNumber" value="<%=(refNumber == null) ? "" : refNumber%>">
                </div>
                <div class='form-group'>
                    <label for='insurer' class="control-label">WICA insurance company</label>
                    <br/>
                    <input class="form-control" type='text' name="insurer" value="<%=(insurer == null) ? "" : insurer%>">
                </div>
                <div class='form-group'>
                    <label for='policyNumber' class="control-label">WICA insurance policy</label>
                    <br/>
                    <input class="form-control" type='text' name="policyNumber" value="<%=(policyNumber == null) ? "" : policyNumber%>">
                </div>
                <div class='form-group'>
                    <label for='reason' class="control-label">State whether initially lodged by lawyer, worker or TWC2</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(reason == null) ? "" : reason%></textarea>
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about WICA Claim</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#wicaclaim_pop_up", "problem", "Edit WICA Claim Lodged Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#wicaclaim_pop_up", "problem", "Add WICA Claim Lodged Details")'>Add</button>-->                  
                <button type='button' class="btn cancel_btn">Cancel</button>
            </div>
        </div>

        <div class='edit_comp'>

            <div class='form-group'>
                <label for='date' class="control-label">Date claim lodged at MOM</label>
                <br/>
                <input class="form-control dateInput" type='text' name="dateWica" 
                       value="<%=(date == null) ? "":sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='refNumber' class="control-label"><span style="color: red">*</span> WICA reference number</label>
                <br/>
                <input class="form-control" type='text' name="refNumber" value="<%=(refNumber == null) ? "" : refNumber%>">
            </div>
            <div class='form-group'>
                <label for='insurer' class="control-label">WICA insurance company</label>
                <br/>
                <input class="form-control" type='text' name="insurer" value="<%=(insurer == null) ? "" : insurer%>">
            </div>
            <div class='form-group'>
                <label for='policyNumber' class="control-label">WICA insurance policy</label>
                <br/>
                <input class="form-control" type='text' name="policyNumber" value="<%=(policyNumber == null) ? "" : policyNumber%>">
            </div>
            <div class='form-group'>
                <label for='reason' class="control-label">State whether initially lodged by lawyer, worker or TWC2</label>
                <br/>
                <textarea class="form-control" name="reason" rows="3"><%=(reason == null) ? "" : reason%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about WICA Claim</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="wicaclaim"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------------------------->
<!--non wica claim lodged-->
<!------------------------->
<%
    }
    if (nonWICAClaimId != null) {
        int id = Integer.parseInt(nonWICAClaimId);
        ProblemNonWicaClaim pnonWicaClaim = ProblemComplementsDAO.retrieveProblemNonWicaClaimById(id);
%>

<form method="POST" id='nonwicaclaim_pop_up' class="form complement_detailed_form problem_pop_up"  >


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
                <input class="form-control" type='text' name="name" value="<%=(loss == 0.0) ? "" : df.format(loss)%>">
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
                <label for='remark' class="control-label">Remarks about medical claim</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#nonwicaclaim_pop_up", "problem", "Edit Non-WICA Claim Lodged Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#nonwicaclaim_pop_up", "problem", "Add Non-WICA Claim Details");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
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
            <input class="form-control" type='text' name="loss" value="<%=(loss == 0.0) ? "" : df.format(loss)%>">
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
            <label for='remark' class="control-label">Remarks about medical claim</label>
            <br/>
            <textarea class="form-control" name="NWICAremark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="nonwicaclaim"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!------------------------>
<!--police report lodged-->
<!------------------------>
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


    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='policeReportDate' class="control-label">Date police report made</label>
                <br/>
                <input class="form-control" type='text' name="policeReportDate" 
                       value="<%=(report.getPoliceReportDate() == null) ? "" : sdf.format(report.getPoliceReportDate())%>">
            </div>
            <div class='form-group'>
                <label for='policeReportStation' class="control-label">Police station where report lodged</label>
                <br/>
                <input class="form-control" type='text' name="policeReportStation" value="<%=(station == null) ? "" : station%>">
            </div>
            <div class='form-group'>
                <label for='policeReportPerson' class="control-label">Accompanying TWC2 person</label>
                <br/>
                <input class="form-control" type='text' name="policeReportPerson" value="<%=(person == null) ? "" : person%>">
            </div>
            <div class='form-group'>
                <label for='policeReportRefereneNumber' class="control-label">Police report ref number</label>
                <br/>
                <input class="form-control" type='text' name="policeReportRefereneNumber" value="<%=(refNum == null) ? "" : refNum%>">
            </div>
            <div class='form-group'>
                <label for='policeReportDetails' class="control-label">Details of police report</label>
                <br/>
                <textarea class="form-control" name="policeReportDetails" rows="3"><%=(details == null) ? "" : details%></textarea>
            </div>
            <div class='form-group'>
                <label for='policeReportRemark' class="control-label">Remarks about police report</label>
                <br/>
                <textarea class="form-control" name="policeReportRemark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#policareport_pop_up", "problem", "Edit Police Report Lodged Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#policareport_pop_up", "problem", "Add A New Police Report Lodged");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date police report made</label>
            <br/>
            <input class="form-control dateInput" 
                   value="<%=(report.getPoliceReportDate() == null) ? "" : sdf.format(report.getPoliceReportDate())%>" 
                   type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Police station where report lodged</label>
            <br/>
            <input class="form-control" value='<%= (station == null) ? "" : station%>' 
                   type='text' name="policeReportStation" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Accompanying TWC2 person</label>
            <br/>
            <input class="form-control" value='<%= (person == null) ? "" : person%>' 
                   type='text' name="policeReportPerson" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Police report ref number</label>
            <br/>
            <input class="form-control" value='<%=(refNum == null) ? "" : refNum%>' 
                   type='text' name="policeReportRefNumber" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Details of police report</label>
            <br/>
            <textarea class="form-control" name="policeReportDetails" rows="3"><%=(details == null) ? "" : details%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remarks about police report</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="policareport"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!-------------------------->
<!--other complaint lodged-->
<!-------------------------->
<%
    }
    if (othercomplaintId != null) {

        int id = Integer.parseInt(othercomplaintId);
        ProblemOtherComplaint complaint = ProblemComplementsDAO.retrieveProblemOtherComplaintById(id);
        ArrayList<String> complaintWho = DropdownDAO.retrieveAllDropdownListOfComplaint();
        ArrayList<String> complaintMode = DropdownDAO.retrieveAllDropdownListOfComplaintMode();

%>

<form method="POST" id='othercomplaint_pop_up' class="form complement_detailed_form problem_pop_up"  >


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
                <label for='complaintDate' class="control-label">Date other complaint lodged</label>
                <br/>
                <input class="form-control" type='text' name="complaintDate" 
                       value="<%=date == null ? "" : sdf.format(date)%>">
            </div>
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">Agency/authority to whom complaint addressed</label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=(agency == null) ? "" : agency%>">
            </div>
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">This complaint is lodged by</label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=who%>">
            </div>
            
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">If TWC2 or third party, name of person lodging complaint</label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=(whoMore == null) ? "" : whoMore%>">
            </div>
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">Mode of lodging complaint</label>
                <br/>
                <input class="form-control" type='text' name="complaintAgency" value="<%=mode%>">
            </div>   
            <div class='form-group'>
                <label for='complaintAgency' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="complaintAgency" rows="3"><%=(modeMore == null) ? "" : modeMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='complaintDetails' class="control-label">Details of complaint lodged</label>
                <br/>
                <textarea class="form-control" name="policeReportRemark" rows="3"><%=(detail == null) ? "" : detail%></textarea>
            </div>
            <div class='form-group'>
                <label for='complaintRemark' class="control-label">Remarks about this complaint</label>
                <br/>
                <textarea class="form-control" name="policeReportRemark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#othercomplaint_pop_up", "problem", "Edit Other Complaint Lodged Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#othercomplaint_pop_up", "problem", "Add A New Other Complaint Lodged");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date other complaint lodged </label>
            <input class="form-control dateInput" 
                   value="<%=date == null ? "" : sdf.format(date)%>"
                   type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Agency/authority to whom complaint addressed</label>
            <input class="form-control" value='<%= (agency == null) ? "" : agency%>' 
                   type='text' name="complaintAgency" >
        </div>
        <div class='form-group'>
            <label for='isProvided' class="control-label"><span style="color: red">*</span> This complaint is lodged by</label>
            <br/>
            <select class="form-control" id="complaintTypeView" name="complaintWho" >
                <%
                    for (String complaintT : complaintWho) {
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
        
        <div class='form-group'>
            <label for='complaintAgency' class="control-label">If TWC2 or third party, name of person lodging complaint</label>
            <br/>
            <input class="form-control" type='text' name="complaintAgency" value="<%=(whoMore == null) ? "" : whoMore%>">
        </div>
        <div class='form-group'>
            <label for='complaintMode' class="control-label">Mode of lodging complaint</label>
            <br/>
            <select class="form-control" id="complaintModeView" name="complaintMode" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String complaintM : complaintMode) {
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
            <label for='location' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="complaintModeMore" rows="3"><%=(whoMore == null) ? "" : whoMore%></textarea>
        </div>

        <div class='form-group'>
            <label for='' class="control-label">Details of complaint lodged</label>
            <br/>
            <textarea class="form-control" name="complaintDetails" rows="3"><%=(detail == null) ? "" : detail%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remarks about this complaint</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="othercomplaint"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!------------------->
<!--case discussion-->
<!------------------->
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

        ArrayList<String> locations = DropdownDAO.retrieveAllDropdownListOfDiscussWhere();

%>

<form method="POST" id='casediscussion_pop_up' class="form complement_detailed_form  problem_pop_up"  >

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>
            <div class='form-group'>
                <label for='discussionDate' class="control-label">Date of discussion, assistance or information-receipt</label>
                <br/>
                <input class="form-control" type='text' name="discussionDate" 
                       value="<%=(dDate == null) ? ""
                               : sdf.format(dDate)%>">
            </div>
            <div class='form-group'>
                <label for='discussionTime' class="control-label">Approx time of event</label>
                <br/>
                <input class="form-control" type='text' name="discussionTime" value="<%=dTime%>">
            </div>
            <div class='form-group'>
                <label for='discussionWhere' class="control-label">Mode/Location of discussion, assistance or information-receipt</label>
                <br/>
                <input class="form-control" type='text' name="discussionWhere" value="<%=dWhere%>">
            </div>
            <div class='form-group' id="discussionWhere_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="discussionWhereOther" rows="3"><%=(dWhereMore == null) ? "" : dWhereMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='discussionWorkerPresent' class="control-label">Was worker participating?</label>
                <br/>
                <input class="form-control" type='text' name="discussionWorkerPresent" value="<%=workerPresent%>">
            </div>
            <div class='form-group'>
                <label for='discussionTWCP1' class="control-label">TWC2 person consulted, assisting or Informed</label>
                <br/>
                <input class="form-control" type='text' name="discussionTWCP1" value="<%=twcP1%>">
            </div>
            <div class='form-group'>
                <label for='discussionTWCP2' class="control-label">Names of other TWC2 persons present</label>
                <br/>
                <input class="form-control" type='text' name="discussionTime" value="<%=twcP2%>">
            </div>
            <div class='form-group'>
                <label for='discussionOtherP' class="control-label">Names of other persons present</label>
                <br/>
                <input class="form-control" type='text' name="discussionOtherP" value="<%=otherP%>">
            </div>
            <div class='form-group'>
                <label for='discussionTranslator' class="control-label">Name of translator(s) present</label>
                <br/>
                <input class="form-control" type='text' name="discussionTranslator" value="<%=translator%>">
            </div>
            <div class='form-group'>
                <label for='discussionTopic' class="control-label">Topic of discussion/information Received</label>
                <br/>
                <input class="form-control" type='text' name="discussionTopic" value="<%=topic%>">
            </div>
            <div class='form-group'>
                <label for='discussionGist' class="control-label">Gist of discussion or new information received</label>
                <br/>
                <textarea class="form-control" name="remark" rows="4"><%=gist%></textarea>
            </div>
            <div class='form-group'>
                <label for='discussionAssist' class="control-label">Immediate Assistance or Referral provided</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=assist%></textarea>
            </div>
            <div class='form-group'>
                <label for='discussionCal' class="control-label">Updated calculation of claim value</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=cal%></textarea>
            </div>
            <div class='form-group'>
                <label for='discussionAction' class="control-label">Action to follow</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=action%></textarea>
            </div>
            <div class='form-group'>
                <label for='discussionRemark' class="control-label">Internal remarks about discussion</label>
                <br/>
                <textarea class="form-control" name="internalRemarks" rows="3"><%=remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#casediscussion_pop_up", "problem", "Edit Case Discussion Details");'>Edit</button>
            <!--<!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#casediscussion_pop_up", "problem", "Add A New Case Discussion");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date of discussion, assistance or information-receipt</label>
            <input class="form-control dateInput" 
                   value="<%=(dDate == null) ? ""
                           : sdf.format(dDate)%>" type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Approx time of event</label>
            <input class="form-control" value='<%=dTime%>' type='text' name="discussionTime" >
        </div>
        <div class='form-group'>
            <label for='discussionWhere' class="control-label"><span style="color: red">*</span> Mode/Location of discussion, assistance or information-receipt</label>
            <br/>
            <select class="form-control" id="discussionWhere" name="discussionWhere" >

                <%
                    for (String location : locations) {
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
            <label for='location' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="discussionWhereMore" rows="3"><%=(dWhereMore == null) ? "" : dWhereMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Was worker participating?</label>

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
            <label for='' class="control-label"><span style="color: red">*</span> TWC2 person consulted, assisting or informed</label>
            <input class="form-control" value='<%=(twcP1 == null) ? "" : twcP1%>' type='text' name="discussionTWC2P1" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Names of other TWC2 persons present</label>
            <input class="form-control" value='<%=(twcP2 == null) ? "" : twcP2%>' type='text' name="discussionTWC2P2" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Names of other persons present</label>
            <input class="form-control" value='<%=otherP%>' type='text' name="discussionOtherPerson" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Name of translator(s) present</label>
            <input class="form-control" value='<%=translator%>' type='text' name="discussionTranslator" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Topic of discussion/information received</label>
            <input class="form-control" value="<%=topic%>" type='text' name="discussionTopic" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Gist of discussion or new information received</label>
            <textarea class="form-control" name="discussionGist" rows="4"><%=gist%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Immediate assistance or referral provided</label>
            <textarea class="form-control" name="discussionAssist" rows="3"><%=assist%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Updated calculation of claim value</label>
            <textarea class="form-control" name="discussionCal" rows="3"><%=cal%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Action to follow</label>
            <textarea class="form-control" name="discussionAction" rows="3"><%=action%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Internal remarks about discussion</label>
            <textarea class="form-control" name="internalRemarks" rows="3"><%=remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="casediscussion"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------>
<!--hospital-->
<!------------>
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
        ArrayList<String> names = DropdownDAO.retrieveAllDropdownListOfHosipital();

%>

<form method="POST" id='hospital_pop_up' class="form complement_detailed_form  problem_pop_up"  >


    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='hospitalUpdate' class="control-label">Date of update</label>
                <br/>
                <input class="form-control" type='text' name="hospitalUpdate" 
                       value="<%=(hospUpdate == null) ? ""
                               : sdf.format(hospUpdate)%>">
            </div>
            <div class='form-group'>
                <label for='hospitalName' class="control-label">Current hospital</label>
                <br/>
                <input class="form-control" type='text' name="hospitalName" value="<%=hospName%>">
            </div>
            <div class='form-group' id="hospName_other_div" >
                <label for='location' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="hospNameMore" rows="3"><%=(hospNameMore == null) ? "" : hospNameMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='hospitalDoctor' class="control-label">Department/doctor name</label>
                <br/>
                <input class="form-control" type='text' name="hospitalDoctor" value="<%=hospDoctor%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about hospital</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#hospital_pop_up", "problem", "Edit Hospital Providing Treatment Details");'>Edit</button>
            <!--<!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#hospital_pop_up", "problem", "Add A New Hospital Providing Treatment");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" 
                   value="<%=(hospUpdate == null) ? ""
                           : sdf.format(hospUpdate)%>" type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='discussionWhere' class="control-label"><span style="color: red">*</span> Current hospital</label>
            <br/>
            <select class="form-control" id="hospName" name="hospName" >
                <%
                    for (String name : names) {
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
            <label for='location' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="hospNameMore" rows="3"><%=(hospNameMore == null) ? "" : hospNameMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Department/Doctor</label>
            <br/>
            <input class="form-control" value='<%=hospDoctor%>' type='text' name="hospDoctor" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remarks about hospital</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="hospital"/>   
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>


</form>

<!------------->
<!--mc stauts-->
<!------------->
<%
    }
    if (mcId != null) {
        int id = Integer.parseInt(mcId);
        ProblemMCStatus mcStatus = ProblemComplementsDAO.retrieveProblemMCStatusById(id);

        java.util.Date mcUpdate = mcStatus.getMCUpdate();
        String status = mcStatus.getMCStatus();
        String statusMore = mcStatus.getMCStatusMore();
        java.util.Date exp = mcStatus.getMCExpDate();
        int cum = mcStatus.getMCDaysCumul();
        String mcRem = mcStatus.getMCRem();

        ArrayList<String> statusList = DropdownDAO.retrieveAllDropdownListOfMCStatus();

%>

<form method="POST" id='mc_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='mcUpdate' class="control-label">Date of update</label>
                <br/>
                <input class="form-control" type='text' name="mcUpdate"
                       value="<%=(mcUpdate == null) ? ""
                               : sdf.format(mcUpdate)%>">
            </div>
            <div class='form-group'>
                <label for='mcStatus' class="control-label">Current MC/Light duty status</label>
                <br/>
                <input class="form-control" type='text' name="mcStatus" value="<%=status%>">
            </div>
            <div class='form-group'>
                <label for='mcExpDate' class="control-label">Latest known expiry date</label>
                <br/>
                <input class="form-control" type='text' name="mcExpDate" 
                       value="<%=(exp == null) ? ""
                               : sdf.format(exp)%>">
            </div>
            <div class='form-group'>
                <label for='mcDaysCum' class="control-label">Cumulative MC days so far</label>
                <br/>
                <input class="form-control" type='text' name="mcDaysCum" value="<%=cum%>">
            </div>
            <div class='form-group'>
                <label for='mcRem' class="control-label">Remarks about MC status</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=mcRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#mc_pop_up", "problem", "Edit MC/Light Duty Status Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#mc_pop_up", "problem", "Add A New MC/Light Duty Status");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='' class="control-label"><span style="color: red">*</span> Date of update</label>
            <input class="form-control dateInput" value="<%=(mcUpdate == null) ? ""
                    : sdf.format(mcUpdate)%>" type='text' name="date" >
        </div>
        <div class='form-group'>
            <label for='status' class="control-label"><span style="color: red">*</span> Current MC/Light duty status</label>
            <br/>
            <select class="form-control" id="status" name="mcStatus" >
                <%
                    for (String statusObj : statusList) {
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
            <label for='location' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="mcStatusMore" rows="3"><%= (statusMore == null) ? "" : statusMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Latest known MC expiry date</label>
            <br/>
            <input class="form-control dateInput" value="<%=(exp == null) ? ""
                    : sdf.format(exp)%>"  type='text' name="expDate" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Cumulative MC days so far</label>
            <br/>
            <input class="form-control" value='<%=cum%>' type='text' name="expCum" >
        </div>
        <div class='form-group'>
            <label for='' class="control-label">Remarks about MC status</label>
            <textarea class="form-control" name="remark" rows="3"><%=mcRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="mc"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!------------------->
<!--r2r Appointment-->
<!------------------->
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

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='r2rDate' class="control-label">Date of appointment</label>
                <br/>
                <input class="form-control" type='text' name="date" 
                       value="<%=(r2rDate == null) ? "" : sdf.format(r2rDate)%>">
            </div>
            <div class='form-group'>
                <label for='r2rTime' class="control-label">Time of appointment</label>
                <br/>
                <input class="form-control" type='text' name="r2rTime" value="<%=r2rTime%>">
            </div>
            <div class='form-group'>
                <label for='r2rHosp' class="control-label">Hospital for appointment</label>
                <br/>
                <input class="form-control" type='text' name="r2rHosp" value="<%=hosp%>">
            </div>
            <div class='form-group'>
                <label for='r2rDept' class="control-label">Department/doctor for appointment</label>
                <br/>
                <input class="form-control" type='text' name="r2rDept" value="<%=dept%>">
            </div>
            <div class='form-group'>
                <label for='r2r1' class="control-label">R2R first volunteer</label>
                <br/>
                <input class="form-control" type='text' name="r2r1" value="<%=r2r1%>">
            </div>
            <div class='form-group'>
                <label for='r2r2' class="control-label">R2R second volunteer</label>
                <br/>
                <input class="form-control" type='text' name="r2r2" value="<%=r2r2%>">
            </div>
            <div class='form-group'>
                <label for='r2rPurpose' class="control-label">Purpose of appointment</label>
                <br/>
                <input class="form-control" type='text' name="r2rPurpose" value="<%=purpose%>">
            </div>
            <div class='form-group'>
                <label for='r2rPreApptNotes' class="control-label">Pre-appointment notes</label>
                <br/>
                <textarea class="form-control" name="r2rPreApptNotes" rows="3"><%=pre%></textarea>
            </div>
            <div class='form-group'>
                <label for='r2rPostApptNotes' class="control-label">Post-appointment notes</label>
                <br/>
                <textarea class="form-control" name="r2rPostApptNotes" rows="3"><%=(post == null) ? "" : post%></textarea>
            </div>
            <div class='form-group'>
                <label for='r2rFeedback' class="control-label">Feedback</label>
                <br/>
                <textarea class="form-control" name="r2rFeedback" rows="3"><%=(feedback == null) ? "" : feedback%></textarea>
            </div>
            <div class='form-group'>
                <label for='r2rMed' class="control-label">Medical cost of this appt(S$)</label>
                <br/>
                <input class="form-control" type='text' name="r2rMed" value="<%=(med == 0.0) ? "" : df.format(med)%>">
            </div>
            <div class='form-group'>
                <label for='r2rOut' class="control-label">How much paid by volunteer(S$)</label>
                <br/>
                <input class="form-control" type='text' name="r2rOut" value="<%=(outlay == 0.0) ? "" : df.format(outlay)%>">
            </div>
        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#r2r_pop_up", "problem", "Edit R2R Appointment Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#r2r_pop_up", "problem", "Add A New R2R Appointment");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='r2rDate' class="control-label"><span style="color: red">*</span> Date of appointment</label></label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(r2rDate == null) ? "" : sdf.format(r2rDate)%>">
        </div>
        <div class='form-group'>
            <label for='r2rTime' class="control-label">Time of appointment</label>
            <br/>
            <input class="form-control" type='text' name="r2rTime" value="<%=r2rTime%>">
        </div>
        <div class='form-group'>
            <label for='r2rHosp' class="control-label"><span style="color: red">*</span> Hospital for appointment</label>
            <br/>
            <input class="form-control" type='text' name="r2rHosp" value="<%=hosp%>">
        </div>
        <div class='form-group'>
            <label for='r2rDept' class="control-label">Department/doctor for appointment</label>
            <br/>
            <input class="form-control" type='text' name="r2rDept" value="<%=dept%>">
        </div>
        <div class='form-group'>
            <label for='r2r1' class="control-label">R2R first volunteer</label>
            <br/>
            <input class="form-control" type='text' name="r2r1" value="<%=r2r1%>">
        </div>
        <div class='form-group'>
            <label for='r2r2' class="control-label">R2R second volunteer</label>
            <br/>
            <input class="form-control" type='text' name="r2r2" value="<%=r2r2%>">
        </div>
        <div class='form-group'>
            <label for='r2rPurpose' class="control-label">Purpose</label>
            <br/>
            <input class="form-control" type='text' name="r2rPurpose" value="<%=purpose%>">
        </div>
        <div class='form-group'>
            <label for='r2rPreApptNotes' class="control-label">Pre-appointment notes</label>
            <br/>
            <textarea class="form-control" name="r2rPreApptNotes" rows="3"><%=pre%></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rPostApptNotes' class="control-label">Post-appointment notes</label>
            <br/>
            <textarea class="form-control" name="r2rPostApptNotes" rows="3"><%=(post == null) ? "" : post%></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rFeedback' class="control-label">Feedback</label>
            <br/>
            <textarea class="form-control" name="r2rFeedback" rows="3"><%=(feedback == null) ? "" : feedback%></textarea>
        </div>
        <div class='form-group'>
            <label for='r2rMed' class="control-label">Medical cost of this appt(S$)</label>
            <br/>
            <input class="form-control" type='text' name="r2rMed" value="<%=(med == 0.0) ? "" : df.format(med)%>">
        </div>
        <div class='form-group'>
            <label for='r2rOut' class="control-label">How much paid by volunteer(S$)</label>
            <br/>
            <input class="form-control" type='text' name="r2rOut" value="<%=(outlay == 0.0) ? "" : df.format(outlay)%>">
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="r2r"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--------------->
<!--WICA status-->
<!--------------->
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

        ArrayList<String> wicaList = DropdownDAO.retrieveAllDropdownListOfWica();

%>

<form method="POST" id='wica_pop_up' class="form complement_detailed_form problem_pop_up"  >


    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='wicaUpdate' class="control-label">Date of update</label>
                <br/>
                <input class="form-control" type='text' name="wicaUpdate" 
                       value="<%=(wUpdate == null) ? "" : sdf.format(wUpdate)%>">
            </div>
            <div class='form-group'>
                <label for='wicaStatus' class="control-label">WICA status</label>
                <br/>
                <input class="form-control" type='text' name="wicaStatus" value="<%=wStatus%>">
            </div>
            <div class='form-group' id="wicaStatus_other_div" >
                <label for='wicaStatusMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="wicaStatusMore" rows="3"><%=(wStatusMore == null) ? "" : wStatusMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='wicaPoints' class="control-label">WICA Points</label>
                <br/>
                <input class="form-control" type='text' name="wicaPoints" value="<%=(wPoints == 0.0) ? "" : df.format(wPoints)%>">
            </div>
            <div class='form-group'>
                <label for='wicaDollars' class="control-label"> WICA S$ compensation</label>
                <br/>
                <input class="form-control" type='text' name="wicaDollars" value="<%=(wDollars == 0.0) ? "" : df.format(wDollars)%>">
            </div>
            <div class='form-group'>
                <label for='wicaRemarks' class="control-label">Remarks about WICA status </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(wRemarks == null) ? "" : wRemarks%></textarea>
            </div>

        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#wica_pop_up", "problem", "Edit WICA Status Details");'>Edit</button>
            <!--<!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#wica_pop_up", "problem", "Add A New WICA Status");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='wicaUpdate' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(wUpdate == null) ? "" : sdf.format(wUpdate)%>">
        </div>
        <div class='form-group'>
            <label for='wicaStatus' class="control-label"><span style="color: red">*</span> WICA status</label>
            <br/>
            <select class="form-control" id="wicaStatus" name="wicaStatus" >
                <%
                    for (String tempStatus : wicaList) {
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
            <label for='wicaStatusMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="wicaStatusMore" rows="3"><%=(wStatusMore == null) ? "" : wStatusMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='wicaPoints' class="control-label">WICA points</label>
            <br/>
            <input class="form-control" type='text' name="wicaPoints" value="<%=(wPoints == 0.0) ? "" : df.format(wPoints)%>">
        </div>
        <div class='form-group'>
            <label for='wicaDollars' class="control-label">WICA S$ compensation</label>
            <br/>
            <input class="form-control" type='text' name="wicaDollars" value="<%=(wDollars == 0.0) ? "" : df.format(wDollars)%>">
        </div>
        <div class='form-group'>
            <label for='wicaRemarks' class="control-label">Remarks about WICA status</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%= (wRemarks == null) ? "" : wRemarks%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="wica"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------------->
<!--law Firm Status-->
<!------------------->
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
        ArrayList<String> lawFirmNameList = DropdownDAO.retrieveAllDropdownListOfLawFirms();
%>

<form method="POST" id='lawyer_pop_up' class="form complement_detailed_form problem_pop_up"  >


    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='lawyerUpdate' class="control-label">Date of update</label>
                <br/>
                <input class="form-control dateInput" type='text' name="lawyerUpdate" 
                       value="<%=(update == null) ? "" : sdf.format(update)%>">
            </div>
            <div class='form-group'>
                <label for='lawyerFirm' class="control-label">Current law firm</label>
                <br/>
                <input class="form-control" type='text' name="lawyerFirm" value="<%=firm%>">
            </div>
            <div class='form-group'>
                <label for='lawyerFirmMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="lawyerFirmMore" rows="3"><%=(firmMore == null) ? "" : firmMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='lawyerName' class="control-label">Name of lawyer or assistant</label>
                <br/>
                <input class="form-control" type='text' name="lawyerName" value="<%=lawyerName%>">
            </div>
            <div class='form-group'>
                <label for='lawyerRemark' class="control-label">Remarks: re lawyer law firm status</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#lawyer_pop_up", "problem", "Edit Law Firm Status Details");'>Edit</button>
            <!--<!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#lawyer_pop_up", "problem", "Add A New Law Firm Status");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='lawyerUpdate' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(update == null) ? "" : sdf.format(update)%>">
        </div>
        <div class='form-group'>
            <label for='lawyerFirm' class="control-label"><span style="color: red">*</span> Current law dirm</label>
            <br/>
            <select class="form-control" id="nlawyerFirm" name="lawyerFirm" >
                <%
                    for (String lawFirmName : lawFirmNameList) {
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
            <label for='lawyerFirmMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="lawyerFirmMore" rows="3"><%=(firmMore == null) ? "" : firmMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='lawyerName' class="control-label">Name of lawyer or assistant</label>
            <br/>
            <input class="form-control" type='text' name="lawyerName" value="<%=lawyerName%>">
        </div>
        <div class='form-group'>
            <label for='lawyerRemark' class="control-label">Remarks: re lawyer law firm status</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="lawyer"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!-------------------------->
<!--non criminal milestone-->
<!-------------------------->
<%

    }
    if (ncmilestoneId != null) {

        int id = Integer.parseInt(ncmilestoneId);
        ProblemCaseMilestoneNC nc = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCById(id);

        java.util.Date ncDate = nc.getMilesNCDate();
        String ncReached = nc.getMilesNCReached();
        String ncReachedMore = nc.getMilesNCReachedMore();
        String ncRem = nc.getMilesNCRem();

        ArrayList<String> ncList = DropdownDAO.retrieveAllDropdownListOfMilestoneNonCriminal();

%>

<form method="POST" id='milestonenc_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='milestoneNCDate' class="control-label">Date milestone reached</label>
                <br/>
                <input class="form-control" type='text' name="milestoneNCDate" 
                       value="<%=(ncDate == null) ? "" : sdf.format(ncDate)%>">
            </div>
            <div class='form-group'>
                <label for='milestoneNCReached' class="control-label">Milestone reached</label>
                <br/>
                <input class="form-control" type='text' name="milestoneNCReached" value="<%=ncReached%>">
            </div>

            <div class='form-group' id="ncReached_other_div" >
                <label for='milestoneNCReachedMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="milestoneNCReachedMore" rows="3"><%=(ncReachedMore == null) ? "" : ncReachedMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='milestoneNCRem' class="control-label">Remarks re milestone reached</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(ncRem== null ) ? "" : ncRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#milestonenc_pop_up", "problem", "Edit Case Milestone (Non-Criminal) Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#milestonenc_pop_up", "problem", "Add A New Case Milestone (Non-Criminal)");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='milestoneNCDate' class="control-label"><span style="color: red">*</span> Date milestone reached</label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(ncDate == null) ? "" : sdf.format(ncDate)%>">
        </div>
        <div class='form-group'>
            <label for='milestoneNCReached' class="control-label"><span style="color: red">*</span> Milestone reached</label>
            <br/>
            <select class="form-control" id="ncReached" name="milestoneNCReached" >
                <%
                    for (String reached : ncList) {
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
            <label for='milestoneNCReachedMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="milestoneNCReachedMore" rows="3"><%=(ncReachedMore == null) ? "" : ncReachedMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneNCRem' class="control-label">Remarks re milestone reached</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=(ncRem== null ) ? "" : ncRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="ncmilestone"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!---------------------->
<!--criminal milestone-->
<!---------------------->
<%

    }
    if (cmilestoneId != null) {

        int id = Integer.parseInt(cmilestoneId);
        ProblemCaseMilestoneCR cr = ProblemComplementsDAO.retrieveProblemCaseMilestoneCRById(id);

        java.util.Date crDate = cr.getMilesCRDate();
        String crReached = cr.getMilesCRReached();
        String crReachedMore = cr.getMilesCRReachedMore();
        String crCharges = cr.getMilesCRCharges();
        String crSentence = cr.getMilesCRSentence();
        String crRem = cr.getMilesCRRem();

        ArrayList<String> crList = DropdownDAO.retrieveAllDropdownListOfMilestoneCriminal();

%>

<form method="POST" id='milestonecr_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='milestoneCRDate' class="control-label">Date milestone reached</label>
                <br/>
                <input class="form-control" type='text' name="milestoneCRDate" 
                       value="<%=(crDate == null) ? "" : sdf.format(crDate)%>">
            </div>
            <div class='form-group'>
                <label for='milestoneCRReached' class="control-label">Milestone reached</label>
                <br/>
                <input class="form-control" type='text' name="milestoneCRReached" value="<%=crReached%>">
            </div>
            <div class='form-group' id="crReached_other_div" >
                <label for='milestoneCRReachedMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="milestoneCRReachedMore" rows="3"><%= (crReachedMore == null) ? "" : crReachedMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='milestoneCRCharge' class="control-label">Details of charges</label>
                <br/>
                <textarea class="form-control" name="milestoneCRCharges" rows="3"><%=crCharges%></textarea>
            </div>
            <div class='form-group'>
                <label for='milestoneCRSentence' class="control-label">Details of Sentence</label>
                <br/>
                <textarea class="form-control" name="milestoneCRSentence" rows="3"><%=crSentence%></textarea>
            </div>
            <div class='form-group'>
                <label for='milestoneCRRem' class="control-label">Remarks: re milestone reached</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=crRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#milestonecr_pop_up", "problem", "Edit Case Milestone (Criminal) Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#milestonecr_pop_up", "problem", "Add A New Case Milestone (Criminal)");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>


    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='milestoneCRDate' class="control-label"><span style="color: red">*</span> Date milestone reached</label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(crDate == null) ? "" : sdf.format(crDate)%>">
        </div>
        <div class='form-group'>
            <label for='milestoneCRReached' class="control-label"><span style="color: red">*</span> Milestone reached</label>
            <br/>
            <select class="form-control" id="crReached" name="milestoneCRReached" >
                <%
                    for (String reached : crList) {
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
            <label for='milestoneCRReachedMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="milestoneCRReachedMore" rows="3"><%= (crReachedMore == null) ? "" : crReachedMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRCharges' class="control-label">Details of charges</label>
            <br/>
            <textarea class="form-control" name="milestoneCRCharges" rows="3"><%=crCharges%></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRSentence' class="control-label">Details of sentence</label>
            <br/>
            <textarea class="form-control" name="milestoneCRSentence" rows="3"><%=crSentence%></textarea>
        </div>
        <div class='form-group'>
            <label for='milestoneCRRem' class="control-label">Remarks: re milestone reached</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=crRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="cmilestone"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!------->
<!--TTR-->
<!------->
<%
    }
    if (ttrId != null) {

        int id = Integer.parseInt(ttrId);
        ProblemTTR ttr = ProblemComplementsDAO.retrieveProblemTTRById(id);

        java.util.Date update = ttr.getTTRUpdate();
        String status = ttr.getTTRStatus();
        String ttrStatusMore = ttr.getTTRStatusMore();
        String departureDate = ttr.getDepartureDate();
        String employerName = ttr.getNewEmployerName();
        String job = ttr.getNewJob();
        String ttrRem = ttr.getTTRRem();

        ArrayList<String> ttrList = DropdownDAO.retrieveAllDropdownListOfTTRStatus();
%>

<form method="POST" id='ttr_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <!--view-->
    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='ttrUpdate' class="control-label"><span style="color: red">*</span> Date of update</label>
                <br/>
                <input class="form-control" type='text' name="date" 
                       value="<%=(update == null) ? "" : sdf.format(update)%>">
            </div>
            <div class='form-group'>
                <label for='ttrStatus' class="control-label"><span style="color: red">*</span> Transfer, TJS or repatriation status</label>
                <br/>
                <input class="form-control" type='text' name="ttrStatus" value="<%=status%>">
            </div>
            <div class='form-group' id="ttrStatus_other_div" >
                <label for='ttrStatusMore' class="control-label">Explain if above is 'Other'</label>
                <br/>
                <textarea class="form-control" name="ttrstatusMore" rows="3"><%= (ttrStatusMore == null) ? "" : ttrStatusMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='ttrDepartureDate' class="control-label">Date of departure from Singapore</label>
                <br/>
                <input class="form-control" type='text' name="ttrDepartureDate" 
                       value="<%=(departureDate == null) ? "" : departureDate%>">
            </div>
            <div class='form-group'>
                <label for='ttrEmployerName' class="control-label">Name of TJS or new employer</label>
                <br/>
                <input class="form-control" type='text' name="ttrEmployerName" value="<%=(employerName == null) ? "" : employerName%>">
            </div>
            <div class='form-group'>
                <label for='ttrJob' class="control-label">Description of TJS or new job </label>
                <br/>
                <textarea class="form-control" name="ttrJob" rows="3"><%=(job == null) ? "" : job %></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about transfer, TJS or repatriation</label>
                <br/>
                <textarea class="form-control" name="ttrremark" rows="3"><%=(ttrRem == null) ? "" : ttrRem%></textarea>
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#ttr_pop_up", "problem", "Edit Transfer, TJS & Repatriation Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#ttr_pop_up", "problem", "Add A New Transfer, TJS & Repatriation");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!--edit-->
    <div class='edit_comp'>

        <div class='form-group'>
            <label for='ttrUpdate' class="control-label"><span style="color: red">*</span> Date of update</label>
            <br/>
            <input class="form-control dateInput" type='text' name="date" 
                   value="<%=(update == null) ? "" : sdf.format(update)%>">
        </div>
        <div class='form-group'>
            <label for='ttrStatus' class="control-label"><span style="color: red">*</span> Transfer, TJS or repatriation status</label>
            <br/>
            <select class="form-control" id="ttrStatus" name="ttrStatus" >
                <%
                    for (String tempStatus : ttrList) {
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
            <label for='ttrStatusMore' class="control-label">Explain if above is 'Other'</label>
            <br/>
            <textarea class="form-control" name="ttrstatusMore" rows="3"><%= (ttrStatusMore == null) ? "" : ttrStatusMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='ttrDepartureDate' class="control-label">Date of departure from Singapore</label>
            <br/>
            <input class="form-control" type='text' name="ttrDepartureDate" 
                   value="<%=(departureDate == null) ? "" : departureDate%>">
        </div>
        <div class='form-group'>
            <label for='ttrEmployerName' class="control-label">Name of TJS or new employer</label>
            <br/>
            <input class="form-control" type='text' name="ttrEmployerName" value="<%=(employerName == null) ? "" : employerName%>">
        </div>
        <div class='form-group'>
            <label for='ttrJob' class="control-label">Description of TJS or new job </label>
            <br/>
            <textarea class="form-control" name="ttrJob" rows="3"><%=(job == null) ? "" : job%></textarea>
        </div>
        <div class='form-group'>
            <label for='remark' class="control-label">Remarks about transfer, TJS or repatriation</label>
            <br/>
            <textarea class="form-control" name="ttrremark" rows="3"><%=(ttrRem == null) ? "" : ttrRem%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="ttr"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!--------------------->
<!--aggravating Issue-->
<!--------------------->
<%

    }
    if (aggravIssueId != null) {
        int id = Integer.parseInt(aggravIssueId);
        ProblemAggravatingIssue issue = ProblemComplementsDAO.retrieveProblemAggravatingIssueById(id);
        ArrayList<String> problemTypes = DropdownDAO.retrieveAllDropdownListOfProblems();
%>
<form method="POST" id='aggravIssue_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>

        <%
            String type = issue.getAggravatingIssue();

            String typeMore = issue.getAggravatingIssueMore();
            double loss = issue.getAggravatingLoss();

            String remark = issue.getAggravatingRemark();

            if (remark == null) {
                remark = "";
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
                    <label for='name' class="control-label">Explain if above is other</label>
                    <br/>
                    <textarea class="form-control" name="name" rows="3"><%=typeMore%></textarea>
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Monetary loss/value of this aggravating issue S$</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=(loss == 0) ? "" : df.format(loss)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">Remarks about aggravating issue</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn view_comp" onclick='editComplement("#aggravIssue_pop_up", "problem", "Edit Aggravating Issue Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn view_comp' onclick='add("#aggravIssue_pop_up", "problem", "Add A New Aggravating Issue");'>Add</button>-->                  
                <button type='button' class="btn cancel_btn">Cancel</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='aggravissueType' class="control-label"><span style="color: red">*</span> Aggravating issue</label>
                <br/>
                <select class="form-control" id="aggravissueType" name="aggravissueType" >
                    <%
                        for (String provided : problemTypes) {
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
                <textarea class="form-control" name="aggravissueTypeMore" rows="3"><%=typeMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='aggravLoss' class="control-label">Monetary loss/value of this aggravating issue S$</label>
                <br/>
                <input class="form-control" type='text' name="aggravLoss" value="<%=(loss == 0.0) ? "" : df.format(loss)%>">
            </div>
            <div class='form-group'>
                <label for='aggravRemark' class="control-label">Remarks about aggravating issue</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="aggravissue"/>
            <input type="hidden" name="Id" value="<%=id%>"/>

            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!--Lead Case Worker--> 
<!-------------------->
<%
    }
    if (leadCaseworkerId != null) {
        int id = Integer.parseInt(leadCaseworkerId);
        ProblemLeadCaseWorker leadCaseWorker = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById(id);
        ArrayList<String> leadCaseWorkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>
<form method="POST" id='leadcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >

    <div class='form-group'>
        <%
            String name = leadCaseWorker.getLeadCaseWorker();
            java.util.Date startDate = leadCaseWorker.getLeadStart();
            java.util.Date endDate = leadCaseWorker.getLeadEnd();
        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Lead caseworker</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='name' class="control-label">Start date</label>
                    <br/>
                    <input class="form-control" type='text' name="name" 
                           value="<%=(startDate == null) ? "" : sdf.format(startDate)%>">
                </div>
                <div class='form-group'>
                    <label for='remark' class="control-label">End date</label>
                    <br/>
                    <input class="form-control" type='text' name="remark"
                           value="<%=(endDate == null) ? "" : sdf.format(endDate)%>">
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#leadcaseworker_pop_up", "problem", "Edit Lead Caseworker");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#leadcaseworker_pop_up", "problem");'>Add</button>-->                  
                <button type='button' class="btn cancel_btn">Cancel</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='leadCaseWorker' class="control-label"><span style="color: red">*</span> Lead caseworker</label>
                <br/>
                <select class="form-control" id="leadCaseWorker" name="leadCaseWorkerName">
                    <%
                        for (String providname : leadCaseWorkerNameList) {
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
            <div class='form-group'>
                <label for='startDate' class="control-label">Start date</label>
                <br/>
                <input class="form-control col-md-9 startDate startdateToRemove" type='text' name="startDate" style="width: 90%;" value="<%=(startDate == null) ? "" : sdf.format(startDate)%>"/>
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="start" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>
            </div>
            <div class='form-group'>
                <label for='endDate' class="control-label">End date</label>
                <br/>
                <input class="form-control endDate enddateToRemove col-md-9" type='text' name="endDate" style="width:90%"  value='<%=(endDate == null) ? "" : sdf.format(endDate)%>'>
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="end" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="complementName" value="leadcaseworker"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
<br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------------------------->
<!--Auxiliary Case Worker-->   
<!------------------------->
<%
    }
    if (auxCaseworkerId != null) {
        int id = Integer.parseInt(auxCaseworkerId);
        ProblemAuxiliaryCaseWorker auxiliaryCaseworker = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerById(id);
        ArrayList<String> auxiliaryCaseworkerNameList = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
%>
<form method="POST" id='auxcaseworker_pop_up' class="form complement_detailed_form problem_pop_up"  >


    <%
        String name = auxiliaryCaseworker.getAuxName();
        java.util.Date startDate = auxiliaryCaseworker.getAuxStart();
        java.util.Date endDate = auxiliaryCaseworker.getAuxEnd();
    %>

    <div class="view_comp">

        <fieldset disabled>
            <div class='form-group'>
                <label for='name' class="control-label">Auxiliary caseworker</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=name%>">
            </div>
            <div class='form-group'>
                <label for='name' class="control-label">Start date</label>
                <br/>
                <input class="form-control col-md-9" type='text' name="nendDate" value="<%=(startDate == null) ? "" : sdf.format(startDate)%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">End date</label>
                <br/>
                <input class="form-control col-md-9" type='text' name="nendDate" value="<%=(endDate == null) ? "" : sdf.format(endDate)%>"/>

            </div>
        </fieldset>
        <br/>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#auxcaseworker_pop_up", "problem", "Edit Auxiliary Caseworker Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#auxcaseworker_pop_up", "problem", "Add A New Auxiliary Caseworker");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <div class='edit_comp'>
        <div class='form-group'>
            <label for='auxiliaryCaseWorker' class="control-label"><span style="color: red">*</span> Auxiliary caseworker</label>
            <br/>
            <select class="form-control" id="auxiliaryCaseWorker" name="auxiliaryCaseWorkerName">
                <%
                    for (String providname : auxiliaryCaseworkerNameList) {
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
        <div class='form-group'>
            <label for='startDate' class="control-label">Start date</label>
            <br/>
            <input class="form-control col-md-9 startDate startdateToRemove" type='text' name="startDate" value="<%=sdf.format(today)%>" style="width: 90%;" value="<%=(startDate == null) ? "" : sdf.format(startDate)%>"/>
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="start" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>

        </div>
        <div class='form-group'>
            <label for='endDate' class="control-label">End date</label>
            <br/>
            <input class="form-control endDate enddateToRemove col-md-9" type='text' name="endDate" style="width:90%"  value='<%=(endDate == null) ? "" : sdf.format(endDate)%>'>
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="end" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="auxcaseworker"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

</form>

<!---------------------------->
<!--Salary & Related history-->
<!---------------------------->
<%
    }

    if (salaryCaseId != null) {
        int id = Integer.parseInt(salaryCaseId);
        ProblemSalaryRelatedHistory psalary = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryById(id);
        ArrayList<String> modeOfPayment = DropdownDAO.retrieveAllDropdownListOfSalaryMode();
%>
<form method="POST" id='salaryhistory_pop_up' class="form complement_detailed_form problem_pop_up"  >




    <%
        String mode = psalary.getSalMode();
        String modeMore = psalary.getSalModeMore();
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
                <label for='name' class="control-label">Describe complaint about basic salary incorrect or not paid</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=basic%></textarea>
            </div>
            <div class='form-group'>
                <label for='name' class="control-label">Describe complaint about overtime incorrect or not paid</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=overtime%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Describe complaint about allowance incorrect or not paid</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=allowance%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Describe complaint about deductions</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=deduction%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Describe complaint about kickbacks</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=kickbacks%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Other related details</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=other%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Mode of salary payment</label>
                <br/>
                <input class="form-control" type='text' name="remark" value="<%=(mode == null)? "": mode%>">
            </div>
            <div class='form-group' id='mode_other_div' >
            <label for='modeMore' class="control-label">Explain if above is other</label><br/>
            <textarea class="form-control" name="modeMore" rows="3"><%=(modeMore==null)?"":modeMore%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Estimated total value of claim (S$)</label>
                <br/>
                <input class="form-control" type='text' name="remark" value="<%=(totalValue == 0.0) ? "" : df.format(totalValue)%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Estimated 12 months' value of claim (S$)</label>
                <br/>
                <input class="form-control" type='text' name="remark" value="<%=(oneYearValue == 0.0) ? "" : df.format(oneYearValue)%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks about salary & related history</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
            </div>
        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#salaryhistory_pop_up", "problem", "Edit Salary & Related history Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#salaryhistory_pop_up", "problem", "Add New Salary & Related history Details");'>Add</button>-->                  
            <button type='button' class="btn cancel_btn">Cancel</button>
        </div>
    </div>

    <!-- edit -->
    <div class='edit_comp'>
        <div class='form-group'>
            <label for='basic' class="control-label"><span style="color: red">*</span> Describe complaint about basic salary incorrect or not paid</label>
            <br/>
            <textarea class="form-control" name="basicSal" rows="3"><%=basic%></textarea>
        </div>
        <div class='form-group'>
            <label for='overtime' class="control-label">Describe complaint about overtime incorrect or not paid</label>
            <br/>
            <textarea class="form-control" name="overtime" rows="3"><%=overtime%></textarea>
        </div>
        <div class='form-group'>
            <label for='allowance' class="control-label">Describe complaint about allowance incorrect or not paid</label>
            <br/>
            <textarea class="form-control" name="allowance" rows="3"><%=allowance%></textarea>
        </div>
        <div class='form-group'>
            <label for='deduction' class="control-label">Describe complaint about deductions</label>
            <br/>
            <textarea class="form-control" name="deduction" rows="3"><%=deduction%></textarea>
        </div>
        <div class='form-group'>
            <label for='kickbacks' class="control-label">Describe complaint about kickbacks</label>
            <br/>
            <textarea class="form-control" name="kickbacks" rows="3"><%=kickbacks%></textarea>
        </div>
        <div class='form-group'>
            <label for='other' class="control-label">Other related details</label>
            <br/>
            <textarea class="form-control" name="otherSal" rows="3"><%=other%></textarea>
        </div>
        <div class='form-group'>
            <label for='mode' class="control-label">Mode of salary payment</label>
            <br/>
            <select class="form-control" id="mode" name="mode" >
                <option value="" selected>Select from list...</option>
                <%
                    for (String provided : modeOfPayment) {
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
            <textarea class="form-control" name="modeMore" rows="3"><%=modeMore%></textarea>
        </div>
        <div class='form-group'>
            <label for='totalValue' class="control-label">Estimated total value of claim (S$)</label>
            <br/>
            <input class="form-control" type='text' name="totalLoss" value="<%=(totalValue == 0.0) ? "" : df.format(totalValue)%>">
        </div>
        <div class='form-group'>
            <label for='oneYearValue' class="control-label">Estimated 12 months' value of claim (S$)</label>
            <br/>
            <input class="form-control" type='text' name="oneYearLoss" value="<%=(oneYearValue == 0.0) ? "" : df.format(oneYearValue)%>">
        </div>
        <div class='form-group'>
            <label for='remark' class="control-label">Remarks about salary & related history</label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=remark%></textarea>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="salaryhistory"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
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

    function editComplement(div_id, category, title) {
        $('#pop_up_content').dialog('option', 'title', title);
        $(div_id).attr("action", "addProblemComplement.do");
        $(div_id + " .edit_comp").show();
        $(div_id + " .view_comp").hide();
        $(div_id + " .add_comp").hide();
        $(div_id + " .add_comp input").prop('disabled', true);
    }

    function add(div_id, category, title) {
        if (category === "worker") {
            $(div_id).attr("action", "addWorkerComplement.do");
        } else if (category === "job") {
            $(div_id).attr("action", "addJobComplement.do");
        } else if (category === "problem") {
            $(div_id).attr("action", "addProblemComplement.do");
        }
        $('#pop_up_content').dialog('option', 'title', title);
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