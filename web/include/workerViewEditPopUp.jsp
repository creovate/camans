
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="camans.entity.*"%>
<%@page import="camans.dao.*"%>
<%@page import="java.util.HashMap"%>

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
                            message: 'The nickname must not exceed 50 characters.'
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
                passportNum: {
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
                passportCountry: {
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
                sgPhNum: {
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
                phNum: {
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
                phOwner: {
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
                address: {
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
                            message: 'Owner of Contact must not exceed 50 characters.'
                        }
                    }
                },
                nRemark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must not exceed 200 characters.'
                        }
                    }
                },
                digitalContactType: {
                    validators: {
                        notEmpty: {
                            message: 'Contact Type cannot be empty.'
                        }
                    }
                },
                digitalMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Contact Type must not exceed 50 characters.'
                        }
                    }
                },
                digitalDetails: {
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
                digitalOwner: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Owner of Contact must not exceed 50 characters.'
                        }
                    }
                },
                remark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Remark must not exceed 200 characters.'
                        }
                    }
                },
                //nok & family & friends
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
                relation: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Relationship must not exceed 50 characters.'
                        }
                    }
                },
                docReference: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Identity docs/references must not exceed 200 characters.'
                        }
                    }
                },
                digitalContact: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Contact Details must not exceed 200 characters.'
                        }
                    }
                },
                proofDoc: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'Attesting Documents must not exceed 200 characters.'
                        }
                    }
                },
                nokphNum: {
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
                nokaddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must not exceed 300 characters.'
                        }
                    }
                },
                //Family Member
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
                            max: 300,
                            message: 'Address must not exceed 300 characters.'
                        }
                    }
                },
                familyphNum: {
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
                familyAddress: {
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
                friendPhNum: {
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
                            message: 'Spoken English standard cannot be empty.'
                        }
                    }
                },
                mainLanguage: {
                    validators: {
                        notEmpty: {
                            message: 'Language cannot be empty.'
                        }
                    }
                },
                languageMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Others must not exceed 50 characters.'
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
                },
                bankAcctNum: {
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
                bankName: {
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
                bankBranch: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank branch must not exceed 50 characters.'
                        }
                    }
                },
                bankBranchCode: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank branch code must not exceed 50 characters.'
                        }
                    }
                },
                bankBranchAddress: {
                    validators: {
                        stringLength: {
                            max: 300,
                            message: 'Address must not exceed 300 characters.'
                        }
                    }
                },
                bankSwift: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'Bank Swift must not exceed 50 characters.'
                        }
                    }
                }
            }
        });

    });

</script>
<%
    /* data collection */
    //worker complement passed data
    String worker_fin = request.getParameter("workerFin");
    String nicknameId = request.getParameter("nickname"); //nickname
    String passportId = request.getParameter("passport");  //passport number
    String sgPhoneId = request.getParameter("sgphone");  //phone number
    String homePhoneId = request.getParameter("homephone"); //phone number : home country ph no
    String sgAddId = request.getParameter("sgadd");  //address
    String homeAddId = request.getParameter("homeadd"); //address : home country address
    String digiId = request.getParameter("digcontact"); //email/qq address
    String nokId = request.getParameter("nok"); //nok name
    String familyMemId = request.getParameter("familymember"); //family member name
    String sgFriId = request.getParameter("sgfri"); //sg friend name
    String languageId = request.getParameter("language"); //language
    String bankAccId = request.getParameter("bankacc"); //bank account no
    String complement = request.getParameter("complement");

    //to keep track of the chosen job and problem
    String jobKey = request.getParameter("jobkey");
    String probKey = request.getParameter("probkey");
    //end of data collection
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    DecimalFormat df = new DecimalFormat("#,###,###.00");

    if (nicknameId != null) {
        int id = Integer.parseInt(nicknameId);



        String nickname = "";
        if (id > 0) {
            WorkerNickname n = WorkerComplementsDAO.retrieveWorkerNicknameById(id);
            nickname = n.getNickname();
        }

%>

<!------------>
<!--nickname-->
<!------------>
<form method="POST" id='nickname_pop_up'  class="form complement_detailed_form worker_pop_up"  >

    <div class="view_comp">
        <fieldset disabled>

            <div class='form-group'>
                <label for='nickName' class="control-label">Nickname</label>
                <br/>
                <input class="form-control" type='text' name="nickName" value="<%=nickname%>">
            </div>
        </fieldset>
        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#nickname_pop_up", "worker", "Edit Nickname");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#nickname_pop_up", "worker", "Add A New Nickname");'>Add</button>-->                  
            <button type='button' class="btn modal_btn cancel_btn">Close</button>
        </div>
    </div>

    <div class='edit_comp'>

        <div class='form-group'>
            <label for='nickName' class="control-label"><span style="color: red">*</span> Nickname</label>
            <input class="form-control" value='<%= nickname%>' type='text' name="nickName" required>
        </div>

        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
        <input type="hidden" name="selectedProb" value="<%=probKey%>"/>

        <input type="hidden" name="complementName" value="WorkerNickname"/>
        <input type="hidden" name="Id" value="<%=id%>"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>

    <div class='add_comp'>
        <div class='form-group '>
            <label for='nickName' class="control-label"><span style="color: red">*</span> Nickname</label>
            <br/>
            <input class="form-control" type='text' name="nNickName" required>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="complementName" value="WorkerNickname"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------>
<!--Passport-->
<!------------>
<%
    }

    if (passportId != null) {
        int id = Integer.parseInt(passportId);
        WorkerPassportDetails passportdetails = WorkerComplementsDAO.retrieveWorkerPassportDetailsById(id);

%>

<form method="POST" id='passport_pop_up' class="form complement_detailed_form worker_pop_up"  >


    <!--Get passport data using passport name-->
    <%
        String passportNo = passportdetails.getPassportNumber();
        String passportCountry = passportdetails.getPassportCountry();


    %>

    <div class="view_comp">

        <fieldset disabled>
            <div class='form-group'>
                <label for='passportNo' class="control-label">Passport No</label>
                <br/>
                <input class="form-control" type='text' name="passportNo" value="<%=passportNo%>">
            </div>
            <div class='form-group'>
                <label for='passportCountry' class="control-label">Passport Country</label>
                <br/>
                <input class="form-control" type='text' name="passportCountry" value="<%=passportCountry%>">
            </div>
            <div class='form-group'>
                <label for='passportIsDate' class="control-label">Passport Issue Date</label>
                <br/>
                <input class="form-control input-append date dateInput" type='text' 
                       name="passportIsDate" value="<%=(passportdetails.getPassportIssueDate() == null) ? ""
                               : sdf.format(passportdetails.getPassportIssueDate())%>">
            </div>
            <div class='form-group'>
                <label for='passportExpDate' class="control-label">Passport Expiry Date</label>
                <br/>
                <input class="form-control" type='text' 
                       name="passportExpDate" value="<%=(passportdetails.getPassportExpirtyDate() == null) ? ""
                               : sdf.format(passportdetails.getPassportExpirtyDate())%>">
            </div>


        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#passport_pop_up", "worker", "Edit Passport Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#passport_pop_up", "worker", "Add A New Passport Details");'>Add</button> -->                 
            <button type='button' class="btn modal_btn  cancel_btn">Close</button>
        </div>
    </div>



    <div class='edit_comp'>
        <div class='form-group'>
            <label for='passportNum' class="control-label"><span style="color: red">*</span> Passport number</label>
            <br/>
            <input class="form-control" type='text' name="passportNum" value="<%=passportNo%>" required>
        </div>
        <div class='form-group'>
            <label for='passportCountry' class="control-label"><span style="color: red">*</span> Passport country</label>
            <br/>
            <input class="form-control" type='text' name="passportCountry" value="<%=passportCountry%>" required>
        </div>
        <div class='form-group'>
            <label for='passportIssueDate' class="control-label">Passport issue date</label>
            <br/>
            <input class="form-control col-md-9 startDate startdateToRemove" type='text' name="passportIssueDate"style="width: 90%;" value="<%=(passportdetails.getPassportIssueDate() == null) ? ""
                           : sdf.format(passportdetails.getPassportIssueDate())%>"/>
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="start" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>
            <br/><br/>
        </div>
        <div class='form-group'>
            <label for='passportExpiryDate' class="control-label">Passport expiry date</label>
            <br/>
                   <input class="form-control endDate enddateToRemove col-md-9" type='text' name="passportExpiryDate" style="width:90%" value="<%=(passportdetails.getPassportExpirtyDate() == null) ? ""
                    : sdf.format(passportdetails.getPassportExpirtyDate())%>">
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="end" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
        <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="WorkerPassportDetails"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------>
<!--Sg Phone-->
<!------------>
<%
    }
    if (sgPhoneId != null) {
        int id = Integer.parseInt(sgPhoneId);

        if (id > 0) {
            WorkerSgPhNum sgPhNum = WorkerComplementsDAO.retrieveWorkerSgPhNumById(id);
            String phnum = sgPhNum.getPhNumber();

%>

<form method="POST" id='sgphonenum_pop_up' class="form complement_detailed_form worker_pop_up"  >


    <div class="view_comp">
        <fieldset disabled>
            <div class='form-group'>
                <label for='phNum' class="control-label">SG phone number</label>
                <br/>
                <input class="form-control" type='text' name="phNum" value="<%=phnum%>">
            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control" type='text' name="obseleteDate" 
                       value="<%=(sgPhNum.getObseleteDate() == null) ? ""
                               : sdf.format(sgPhNum.getObseleteDate())%>">
            </div>

        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#sgphonenum_pop_up", "worker", "Edit Singapore Phone number Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#sgphonenum_pop_up", "worker", "Add A New Singapore Phone number ");'>Add</button>-->               
            <button type='button' class="btn modal_btn  cancel_btn">Close</button>
        </div>
    </div>

    <div class='edit_comp'>
        <div class='form-group'>
            <label for='phNum' class="control-label"><span style="color: red">*</span> SG phone number</label>
            <br/>
            <input class="form-control" type='text' name="sgPhNum" value="<%=phnum%>" required>
        </div>

        <div class='form-group'>
            <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
            <br/>
            <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(sgPhNum.getObseleteDate() == null) ? ""
                           : sdf.format(sgPhNum.getObseleteDate())%>">
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>
        </div>

        <input type="hidden" name="complementName" value="WorkerSgPhNum"/>
        <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
        <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!---------------------->
<!--Home Country Phone--> 
<!---------------------->
<%
        }
    }


    if (homePhoneId != null) {
        int id = Integer.parseInt(homePhoneId);

        String homeCountryPhNo = "";
        if (id > 0) {
            WorkerHomeCountryPhNum homeCountryPhNum = WorkerComplementsDAO.retrieveWorkerHomeCountryPhNumById(id);
            String phnum = homeCountryPhNum.getPhNumber();
            String phOwner = homeCountryPhNum.getPhOwner();

%>

<form method="POST" id='homephonenum_pop_up' class="form complement_detailed_form worker_pop_up"  >


    <div class="view_comp">
        <fieldset disabled>
            <div class='form-group'>
                <label for='phNum' class="control-label">Home country telephone number</label>
                <br/>
                <input class="form-control" type='text' name="phNum" value="<%=phnum%>" >
            </div>
            <div class='form-group'>
                <label for='phOwner' class="control-label">Owner of this number</label>
                <br/>
                <input class="form-control" type='text' name="phOwner" value="<%=phOwner%>">
            </div>
            <div class='form-group'>
                <label for='homephobdate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control " type='text' name="homephobdate" 
                       value="<%=(homeCountryPhNum.getObseleteDate() == null) ? ""
                               : sdf.format(homeCountryPhNum.getObseleteDate())%>">
            </div>


        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#homephonenum_pop_up", "worker", "Edit Home Country Phone number Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#homephonenum_pop_up", "worker", "Add A New Home Country Phone number");'>Add</button>-->                  
            <button type='button' class="btn modal_btn  cancel_btn">Close</button>
        </div>
    </div>

    <div class='edit_comp'>
        <div class='form-group'>
            <label for='phNum' class="control-label"><span style="color: red">*</span> Home country telephone number</label>
            <br/>
            <input class="form-control" type='text' name="phNum" value="<%=phnum%>" required>
        </div>
        <div class='form-group'>
            <label for='phOwner' class="control-label">Owner of this number</label>
            <br/>
            <input class="form-control" type='text' name="phOwner" value="<%=phOwner%>">
        </div>
        <div class='form-group'>
            <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
            <br/>
            <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(homeCountryPhNum.getObseleteDate() == null) ? ""
                           : sdf.format(homeCountryPhNum.getObseleteDate())%>">
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
        <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="WorkerHomeCountryPhNum"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!-------------->
<!--sg Address-->
<!-------------->
<%
        }
    }

    if (sgAddId != null) {
        int id = Integer.parseInt(sgAddId);
        WorkerSgAddress sgAddress = WorkerComplementsDAO.retrieveWorkerSgAddressById(id);
        String address = sgAddress.getAddress();
%>

<form method="POST" id='sgAdd_pop_up' class="form complement_detailed_form worker_pop_up"  >


    <div class="view_comp">
        <fieldset disabled>
            <div class='form-group'>
                <label for='address' class="control-label">Worker address in Singapore</label>
                <br/>
                <textarea class="form-control"name="address" rows="3" ><%=address%></textarea>
            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>

                <input class="form-control" type='text' name="obseleteDate" 
                       value="<%=(sgAddress.getObseleteDate() == null) ? ""
                               : sdf.format(sgAddress.getObseleteDate())%>">
            </div>

        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#sgAdd_pop_up", "worker", "Edit Singapore Address Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#sgAdd_pop_up", "worker", "Add A New Singapore Address");'>Add</button>-->                  
            <button type='button' class="btn modal_btn  cancel_btn">Close</button>
        </div>
    </div>

    <div class='edit_comp'>
        <div class='form-group'>
            <label for='address' class="control-label"><span style="color: red">*</span> Worker address in Singapore</label>
            <br/>
            <textarea class="form-control"name="address" rows="3"  required><%=address%></textarea>
        </div>
        <div class='form-group'>
            <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
            <br/>
                   <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(sgAddress.getObseleteDate() == null) ? ""
                           : sdf.format(sgAddress.getObseleteDate())%>">
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
        <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="WorkerSgAddress"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!---------------->
<!--Home Country Address-->
<!---------------->
<%
    }

    if (homeAddId != null) {
        int id = Integer.parseInt(homeAddId);
        WorkerHomeCountryAddress homeCountryAddress = WorkerComplementsDAO.retrieveWorkerHomeCountryAddressById(id);
        String address = homeCountryAddress.getAddress();
%>

<form method="POST" id='homeAdd_pop_up' class="form complement_detailed_form worker_pop_up"  >


    <div class="view_comp">
        <fieldset disabled>
            <div class='form-group'>
                <label for='address' class="control-label">Worker address in Home Country</label>
                <br/>
                <textarea class="form-control"name="address" rows="3"  required><%=address%></textarea>

            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control" type='text' name="obseleteDate" value="<%=(homeCountryAddress.getObseleteDate() == null) ? "" : sdf.format(homeCountryAddress.getObseleteDate())%>">
            </div>
        </fieldset>

        <div class="form-group btn_group pull-right">
            <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#homeAdd_pop_up", "worker", "Edit Home Country Address Details");'>Edit</button>
            <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#homeAdd_pop_up", "worker", "Add A New Home Country Address");'>Add</button>-->                 
            <button type='button' class="btn modal_btn  cancel_btn">Close</button>
        </div>
    </div>

    <div class='edit_comp'>
        <div class='form-group'>
            <label for='address' class="control-label"><span style="color: red">*</span> Worker address in Home Country</label>
            <br/>
            <textarea class="form-control"name="address" rows="3" required><%=address%></textarea>
        </div>
        <div class='form-group'>
            <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
            <br/>
                   <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(homeCountryAddress.getObseleteDate() == null) ? ""
                           : sdf.format(homeCountryAddress.getObseleteDate())%>">
            <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                <span class="glyphicon glyphicon-remove"></span>
            </div>

        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
        <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
        <input type="hidden" name="complementName" value="WorkerHomeCountryAddress"/>
        <input type="hidden" name="Id" value="<%=id%>"/>
        <br/><br/>
        <div class="form-group btn_group">
            <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>

<!------------------->
<!--Digital contact-->
<!------------------->
<%
    }

    if (digiId != null) {

        int id = Integer.parseInt(digiId);
        WorkerDigitalContact digitalContact = WorkerComplementsDAO.retrieveWorkerDigitalContactById(id);
        ArrayList<String> digitalContactList = DropdownDAO.retrieveAllDropdownListOfDigitalContactType();
%>

<form method="POST" id='digi_pop_up' class="form complement_detailed_form worker_pop_up"  >

    <div class='form-group'>

        <!--Get nok data using  name-->
        <%
            String digiType = digitalContact.getContactType();
            String digiMore = digitalContact.getContactTypeMore();
            String digiAdd = digitalContact.getContactInfo();
            String digiOwner = digitalContact.getOwner();
            String digiRemark = digitalContact.getRemark();

        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='digitalContactType' class="control-label">Type of digital contact</label>
                    <br/>
                    <input class="form-control" type='text' name="digitalContactType" value="<%=digiType%>">
                </div>
                <div class="form-group" id="digitalContactType_other_div">
                    <label for="nDigitalMore" class="control-label">Explain if above is 'Other'</label><br/>
                    <input class="form-control" type='text' name="nDigitalMore" value="<%=(digiMore == null) ? "" : digiMore%>">
                </div>
                <div class='form-group'>
                    <label for='digiAdd' class="control-label">Email/QQ Address or other details</label>
                    <br/>
                    <input class="form-control" type='text' name="digiAdd" value="<%=digiAdd%>">
                </div>
                <div class='form-group'>
                    <label for='digiOwner' class="control-label">Owner of electronic contact</label>
                    <br/>
                    <input class="form-control" type='text' name="digiOwner" value="<%=digiOwner%>">
                </div>
                <div class='form-group'>
                    <label for='digiRemark' class="control-label">Remark about digital contact</label>
                    <br/>
                    <textarea class="form-control"name="digiRemark" rows="3" ><%=digiRemark%></textarea>
                </div>
                <div class='form-group'>
                    <label for='digiObDate' class="control-label">Date discovered to be obsolete</label>
                    <br/>

                    <input class="form-control" type='text' name="digiObDate" value="<%=(digitalContact.getObseleteDate() == null) ? "" : sdf.format(digitalContact.getObseleteDate())%>">
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn" onclick='editComplement("#digi_pop_up", "worker", "Edit Digital Contact Address Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn' onclick='add("#digi_pop_up", "worker", "Add A New Digital Contact Address");'>Add</button> -->                 
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='digitalContactType' class="control-label"><span style="color: red">*</span> Type of digital contact</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="digitalContactType" required>
                    <%
                        for (String contactType : digitalContactList) {
                            if (digitalContact.getContactType().equals(contactType)) {

                    %>
                    <option selected><%=contactType%></option>
                    <%
                    } else {

                    %>
                    <option><%=contactType%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>

            <div class="form-group" id="digitalContactType_other_div">
                <label for="nDigitalMore" class="control-label">Explain if above is 'Other'</label><br/>
                <input class="form-control" type='text' name="digitalMore" value="<%=(digiMore == null) ? "" : digiMore%>">
            </div>

            <div class='form-group'>
                <label for='digitalDetails' class="control-label"><span style="color: red">*</span> Email/QQ address or other details</label>
                <br/>
                <input class="form-control" type='text' name="digitalDetails" value="<%=digiAdd%>" >
            </div>
            <div class='form-group'>
                <label for='digitalOwner' class="control-label">Owner of electronic contact</label>
                <br/>
                <input class="form-control" type='text' name="digitalOwner" value="<%=digiOwner%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark about digital contact</label>

                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=digiRemark%></textarea>
            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                       <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(digitalContact.getObseleteDate() == null) ? ""
                        : sdf.format(digitalContact.getObseleteDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerDigitalContact"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!------->
<!--nok-->
<!------->
<%
    }
    if (nokId!= null) {
        int id = Integer.parseInt(nokId);
        WorkerNextOfKin nextOfKin = WorkerComplementsDAO.retrieveWorkerNextOfKinById(id);

%>

<form method="POST" id='nok_pop_up' class="form complement_detailed_form worker_pop_up"  >

    <div class='form-group'>

        <!--Get nok data using passport name-->
        <%
            String nokName = nextOfKin.getName();
            String nokRelationship = nextOfKin.getRelation();
            String nokAddress = nextOfKin.getAddress();
            String nokIdDoc = nextOfKin.getDocument();
            String nokPhone = nextOfKin.getPhoneNumber();
            String nokDigital = nextOfKin.getDigital();
            String nokProof = nextOfKin.getProof();
            String nokRemark = nextOfKin.getRemark();

        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='name' class="control-label">Name of next of kin</label>
                    <br/>
                    <input class="form-control" type='text' name="name" value="<%=nokName%>">
                </div>
                <div class='form-group'>
                    <label for='relation' class="control-label">Relationship of next of kin to worker</label>
                    <br/>
                    <input class="form-control" type='text' name="relation" value="<%=nokRelationship%>">
                </div>
                <div class='form-group'>
                    <label for='nokIdDoc' class="control-label">Identity docs/references of next of kin</label>
                    <br/>
                    <textarea class="form-control" name="nokIdDoc" rows="3" ><%=(nokIdDoc == null) ? "" : nokIdDoc%></textarea>
                </div>
                <div class='form-group'>
                    <label for='nokContactNo' class="control-label">Phone number  of next of kin</label>
                    <br/>
                    <input class="form-control" type='text' name="nokContactNo" value="<%=(nokPhone == null) ? "" : nokPhone%>">
                </div>
                <div class='form-group'>
                    <label for='nokOtherContact' class="control-label">Other contact details of next of kin</label>
                    <br/>
                    <textarea class="form-control" name="nokOtherContact" rows="3" ><%=(nokDigital == null) ? "" : nokDigital%></textarea>
                </div>
                <div class='form-group'>
                    <label for='nokAddress' class="control-label">Address of next of kin</label>
                    <br/>
                    <textarea class="form-control" name="nokAddress" rows="3" ><%=(nokAddress == null) ? "" : nokAddress%></textarea>
                </div>
                <div class='form-group'>
                    <label for='nokProof' class="control-label">What docs attesting next of kin?</label>
                    <br/>
                    <textarea class="form-control" name="nokProof" rows="3" ><%=(nokProof == null) ? "" : nokProof%></textarea>
                </div>
                <div class='form-group'>
                    <label for='nokRemark' class="control-label">Remark about next of kin:  </label>
                    <br/>
                    <textarea class="form-control" name="nRemark" rows="3" ><%=nokRemark%></textarea>
                </div>
                <div class='form-group'>
                    <label for='nokObDate' class="control-label">Date discovered to be obsolete</label>
                    <br/>
                    <input class="form-control" type='text' name="nokObDate" 
                           value="<%=(nextOfKin.getObseleteDate() == null) ? ""
                                   : sdf.format(nextOfKin.getObseleteDate())%>">
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#nok_pop_up", "worker", "Edit next of kin Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#nok_pop_up", "worker", "Add A New next of kin");'>Add</button>-->                  
                <button type='button' class="btn modal_btn cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='name' class="control-label"><span style="color: red">*</span> Name of next of kin</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=nokName%>" required>
            </div>
            <div class='form-group'>
                <label for='relation' class="control-label">Relationship of next of kin to worker</label>
                <br/>
                <input class="form-control" type='text' name="relation" value="<%=nokRelationship%>">
            </div>
            <div class='form-group'>
                <label for='docReference' class="control-label">Identity docs/references of next of kin</label>
                <br/>
                <textarea class="form-control" name="docReference" rows="3" ><%=(nokIdDoc == null) ? "" : nokIdDoc%></textarea>
            </div>
            <div class='form-group'>
                <label for='phNum' class="control-label">Phone number of next of kin</label>
                <br/>
                <input class="form-control" type="text" name="nokphNum" value="<%=(nokPhone == null) ? "" : nokPhone%>">
            </div>
            <div class='form-group'>
                <label for='digitalContact' class="control-label">Other contact details of next of kin</label>
                <br/>
                <textarea class="form-control" name="digitalContact" rows="3"><%=(nokDigital == null) ? "" : nokDigital%></textarea>
            </div>
            <div class='form-group'>
                <label for='address' class="control-label">Address of next of kin</label>
                <br/>
                <textarea class="form-control" name="nokaddress" rows="3" ><%=(nokAddress == null) ? "" : nokAddress%></textarea>
            </div>
            <div class='form-group'>
                <label for='proofDoc' class="control-label">What docs attesting next of kin?</label>
                <br/>
                <textarea class="form-control" name="proofDoc" rows="3" ><%=(nokProof == null) ? "" : nokProof%></textarea>            
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark about next of kin:  </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=nokRemark%></textarea>
            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                       <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(nextOfKin.getObseleteDate() == null) ? ""
                        : sdf.format(nextOfKin.getObseleteDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>

            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerNextOfKin"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
<br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------------->
<!-- 9 family Member-->
<!-------------------->
<%
    }
    if (familyMemId != null) {
        int id = Integer.parseInt(familyMemId);
        WorkerFamilyMember familyMember = WorkerComplementsDAO.retrieveWorkerFamilyMemberById(id);


%>

<form method="POST" id='fm_pop_up' class="form complement_detailed_form worker_pop_up"  >

    <div class='form-group'>


        <%
            String name = familyMember.getName();
            String relationship = familyMember.getRelation();
            String address = familyMember.getAddress();
            String contactNum = familyMember.getPhoneNumber();
            String contactAdd = familyMember.getDigital();
            String remark = familyMember.getRemark();

        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='fname' class="control-label">Name of family member</label>
                    <br/>
                    <input class="form-control" type='text' name="fname" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='frelation' class="control-label">Relationship of family member to worker</label>
                    <br/>
                    <input class="form-control" type='text' name="frelation" value="<%=relationship%>">
                </div>
                <div class='form-group'>
                    <label for='faddress' class="control-label">Is the family member in Singapore?</label>
                    <br/>
                    <input class="form-control" type='text' name="faddress" value="<%=(address == null) ? "" : address%>">
                </div>
                <div class='form-group'>
                    <label for='fcontactNo' class="control-label">Phone number of family member</label>
                    <br/>
                    <input class="form-control" type='text' name="fcontactNo" value="<%=contactNum%>">
                </div>
                <div class='form-group'>
                    <label for='fdigital' class="control-label">Other contact details of family member</label>
                    <br/>
                    <textarea class="form-control" name="digitalContact" rows="3" ><%=(contactAdd == null) ? "" : contactAdd%></textarea>
                </div>

                <div class='form-group'>
                    <label for='fremark' class="control-label">Remark about family member</label>
                    <br/>

                    <textarea class="form-control" name="fremark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
                </div>
                <div class='form-group'>
                    <label for='nokObDate' class="control-label">Date discovered to be obsolete</label>
                    <br/>
                    <input class="form-control" type='text' name="nokObDate" 
                           value="<%=(familyMember.getObseleteDate() == null) ? ""
                                   : sdf.format(familyMember.getObseleteDate())%>">
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#fm_pop_up", "worker", "Edit family member Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#fm_pop_up", "worker", "Add A New family member");'>Add</button>-->                  
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='name' class="control-label"><span style="color: red">*</span> Name of family member</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=name%>" required>
            </div>
            <div class='form-group'>
                <label for='relation' class="control-label">Relationship of family member to worker</label>
                <br/>
                <input class="form-control" type='text' name="relation" value="<%=relationship%>">
            </div>
            <div class='form-group'>
                <label for='nAddress' class="control-label">Is the family member in Singapore?</label>
                <br/>
                <input class="form-control" type='text' name="familyAddress" value="<%=(address == null) ? "" : address%>">
            </div>
            <div class='form-group'>
                <label for='phNum' class="control-label">Phone number of family member</label>
                <br/>
                <input class="form-control" type="text" name="familyphNum" value="<%=contactNum%>">
            </div>
            <div class='form-group'>
                <label for='digitalContact' class="control-label">Other contact details of family member</label>
                <br/>
                <textarea class="form-control" name="digitalContact" rows="3" ><%=(contactAdd == null) ? "" : contactAdd%></textarea>
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark about family member</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=remark%></textarea>
            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(familyMember.getObseleteDate() == null) ? ""
                        : sdf.format(familyMember.getObseleteDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
                
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerFamilyMember"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
<br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!-------------->
<!-- 10 sg fri-->
<!-------------->
<%
    }

    if (sgFriId != null) {
        int id = Integer.parseInt(sgFriId);
        WorkerFriend friend = WorkerComplementsDAO.retrieveWorkerFriendById(id);
%>

<form method="POST" id='sgFri_pop_up' class="form complement_detailed_form worker_pop_up"  >

    <div class='form-group'>


        <%
            String name = friend.getName();
            String relationship = friend.getRelation();
            String contactNum = friend.getPhone();
            String remark = friend.getRemark();

        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='fname' class="control-label">Name of friend in Singapore</label>
                    <br/>
                    <input class="form-control" type='text' name="fname" value="<%=name%>">
                </div>
                <div class='form-group'>
                    <label for='fcontactNo' class="control-label">Phone number of friend</label>
                    <br/>
                    <input class="form-control" type='text' name="fcontactNo" value="<%=contactNum%>">
                </div>
                <div class='form-group'>
                    <label for='frelation' class="control-label">Relationship to worker</label>
                    <br/>
                    <input class="form-control" type='text' name="frelation" value="<%=relationship%>">
                </div>
                <div class='form-group'>
                    <label for='fremark' class="control-label">Remark about friend</label>
                    <br/>
                    <textarea class="form-control" name="remark" rows="3" ><%=remark%></textarea>
                </div>
                <div class='form-group'>
                    <label for='nokObDate' class="control-label">Date discovered to be obsolete</label>
                    <br/>
                    <input class="form-control" type='text' name="ObDate" 
                           value="<%=(friend.getObseleteDate() == null) ? ""
                                   : sdf.format(friend.getObseleteDate())%>">
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#sgFri_pop_up", "worker", "Edit Details of friend in Singapore");'>Edit</button>
                <!--<button type='button' class='btn btn-blue modal_btn ' onclick='add("#sgFri_pop_up", "worker", "Add A New friend in Singapore");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='name' class="control-label"><span style="color: red">*</span> Name of friend in Singapore</label>
                <br/>
                <input class="form-control" type='text' name="name" value="<%=name%>" required>
            </div>
            <div class='form-group'>
                <label for='phNum' class="control-label">Phone number of friend</label>
                <br/>
                <input class="form-control" type="text" name="friendPhNum" value="<%=contactNum%>">
            </div>
            <div class='form-group'>
                <label for='relation' class="control-label">Relationship to worker</label>
                <br/>
                <input class="form-control" type='text' name="relation" value="<%=relationship%>">
            </div>

            <div class='form-group'>
                <label for='remark' class="control-label">Remark about friend</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=remark%></textarea>
            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(friend.getObseleteDate() == null) ? ""
                        : sdf.format(friend.getObseleteDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerFriend"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>
</form>

<!---------------->
<!-- 11 language-->
<!---------------->
<%
    }

    if (languageId != null) {

        int id = Integer.parseInt(languageId);
        WorkerLanguage workerLanguage = WorkerComplementsDAO.retrieveWorkerLanguageById(id);
        ArrayList<String> languageList = DropdownDAO.retrieveAllDropdownListOfLanguage();
        ArrayList<String> spokenEnglishList = DropdownDAO.retrieveAllDropdownListOfSpokenEnglish();
%>

<form method="POST" id='language_pop_up' class="form complement_detailed_form worker_pop_up"  >

    <div class='form-group'>
        <%
            String remark = workerLanguage.getRemark();
            String mainLan = workerLanguage.getMainLanguage();
        %>

        <div class="view_comp">
            <fieldset disabled>
                <div class='form-group'>
                    <label for='mainLanguage' class="control-label">Worker's main language</label>
                    <br/>
                    <input class="form-control" type='text' name="mainLanguage" value="<%=mainLan%>">
                </div>
                <div class="form-group" id="languageType_other_div" >
                    <label for="languageMore" class="control-label">Explain if above is 'Other'</label>
                    <br/>
                    <input class="form-control" type='text' name="nLanguageMore" 
                           value="<%=(workerLanguage.getMainLangaugeMore() == null) ? "" : workerLanguage.getMainLangaugeMore()%>">
                </div>
                <div class='form-group'>
                    <label for='englishStandard' class="control-label">Spoken English standard</label>
                    <br/>
                    <input class="form-control" type='text' value="<%=workerLanguage.getSpokenLanguageStandard()%>">
                </div>
                <div class='form-group'>
                    <label for='fremark' class="control-label">Remark about language</label>
                    <br/>
                    <textarea class="form-control" name="fremark" rows="3"><%=(remark == null) ? "" : remark%></textarea>
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue  modal_btn " onclick='editComplement("#language_pop_up", "worker", "Edit Details of worker Language");'>Edit</button>
                <!--<button type='button' class='btn btn-blue  modal_btn ' onclick='add("#language_pop_up", "worker", "Add A New worker Language");'>Add</button>-->                  
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>            
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='mainLanguage' class="control-label"><span style="color: red">*</span> Worker's main language</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="mainLanguage">
                    <%
                        for (String languageType : languageList) {
                            if (workerLanguage.getMainLanguage().equals(languageType)) {

                    %>
                    <option selected><%=languageType%></option>
                    <%
                    } else {

                    %>
                    <option><%=languageType%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class="form-group" id="languageType_other_div" >
                <label for="languageMore" class="control-label">Explain if above is 'Other'</label>
                <br/>
                <input class="form-control" type='text' name="languageMore" 
                       value="<%=(workerLanguage.getMainLangaugeMore() == null) ? "" : workerLanguage.getMainLangaugeMore()%>">
            </div>
            <div class='form-group'>
                <label for='englishStandard' class="control-label"><span style="color: red">*</span> Spoken English standard</label>
                <br/>
                <select class="form-control" id="digitalContactType" name="englishStandard">
                    <%
                        for (String engStd : spokenEnglishList) {
                            if (workerLanguage.getSpokenLanguageStandard().equals(engStd)) {

                    %>
                    <option selected><%=engStd%></option>
                    <%
                    } else {

                    %>
                    <option><%=engStd%></option>
                    <%

                            }
                        }
                    %>  
                </select>
            </div>
            <div class='form-group'>
                <label for='fremark' class="control-label">Remark about language</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=(remark == null) ? "" : remark%></textarea>
            </div>

            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerLanguage"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn">Save</button>
                <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
            </div>
        </div>
    </div>

</form>

<!---------------->
<!-- 12 bank acc-->
<!---------------->
<%
    }

    if (bankAccId != null) {
        int id = Integer.parseInt(bankAccId);
        WorkerBankAcct workerBankAcc = WorkerComplementsDAO.retrieveBankAccountDetailsById(id);

%>

<form method="POST" id='bk_pop_up' class="form complement_detailed_form worker_pop_up"  >


    <div class='form-group'>


        <%
            String bankaccName = workerBankAcc.getBankAcctName();
            String bankaccNum = workerBankAcc.getBankAcctNumber();
            String bankName = workerBankAcc.getBankName();
            String bankBranch = workerBankAcc.getBankBranchName();
            String branchAdd = workerBankAcc.getBankBranchAddress();
            String branchCode = workerBankAcc.getBankBranchCode();
            String swift = workerBankAcc.getBankSwiftCode();
            String remark = workerBankAcc.getRemark();

        %>

        <div class="view_comp">

            <fieldset disabled>
                <div class='form-group'>
                    <label for='accname' class="control-label">Bank account name</label>
                    <br/>
                    <input class="form-control" type='text' name="accname" value="<%=bankaccName%>">
                </div>
                <div class='form-group'>
                    <label for='accno' class="control-label">Bank account number</label>
                    <br/>
                    <input class="form-control" type='text' name="accno" value="<%=bankaccNum%>">
                </div>
                <div class='form-group'>
                    <label for='bkname' class="control-label">Bank name</label>
                    <br/>
                    <input class="form-control" type='text' name="bkname" value="<%=bankName%>">
                </div>
                <div class='form-group'>
                    <label for='bkbrch' class="control-label">Bank branch name</label>
                    <br/>
                    <input class="form-control" type='text' name="bkbrch" value="<%=bankBranch%>">
                </div>
                <div class='form-group'>
                    <label for='bhcode' class="control-label">Bank branch code</label>
                    <br/>
                    <input class="form-control" type='text' name="bhcode" value="<%=branchCode%>">
                </div>
                <div class='form-group'>
                    <label for='bhad' class="control-label">Bank branch address</label>
                    <br/>
                    <textarea class="form-control" name="bhad" rows="3"><%=branchAdd%></textarea>
                </div>
                <div class='form-group'>
                    <label for='bs' class="control-label">Bank swift code</label>
                    <br/>
                    <input class="form-control" type='text' name="bs" value="<%=swift%>">
                </div>
                <div class='form-group'>
                    <label for='bremark' class="control-label">Remark about bank account</label>
                    <br/>
                    <textarea class="form-control" name="bremark" rows="3"><%=remark%></textarea>
                        <!--input class="form-control" type='text' name="bremark" value="<%=remark%>"-->
                </div>
                <div class='form-group'>
                    <label for='bkObDate' class="control-label">Date discovered to be obsolete</label>
                    <br/>
                    <input class="form-control dateInput" type='text' name="bkObDate" 
                           value="<%=(workerBankAcc.getObseleteDate() == null) ? ""
                                   : sdf.format(workerBankAcc.getObseleteDate())%>">
                </div>
            </fieldset>

            <div class="form-group btn_group pull-right">
                <button type='button' class="btn btn-blue modal_btn " onclick='editComplement("#bk_pop_up", "worker", "Edit Bank account Details");'>Edit</button>
                <!--<button type='button' class='btn btn-blue  modal_btn ' onclick='add("#bk_pop_up", "worker", "Add A New Bank account Details");'>Add</button> -->                 
                <button type='button' class="btn modal_btn  cancel_btn">Close</button>
            </div>
        </div>

        <div class='edit_comp'>
            <div class='form-group'>
                <label for='bankAcctName' class="control-label"><span style="color: red">*</span> Bank account name</label>
                <br/>
                <input class="form-control" type='text' name="bankAcctName" value="<%=bankaccName%>" required>
            </div>
            <div class='form-group'>
                <label for='bankAcctNum' class="control-label"><span style="color: red">*</span> Bank account number</label>
                <br/>
                <input class="form-control" type='text' name="bankAcctNum" value="<%=bankaccNum%>" required>
            </div>
            <div class='form-group'>
                <label for='bankName' class="control-label"><span style="color: red">*</span> Bank name</label>
                <br/>
                <input class="form-control" type='text' name="bankName" value="<%=bankName%>" required>
            </div>
            <div class='form-group'>
                <label for='bankBranch' class="control-label">Bank branch name</label>
                <br/>
                <input class="form-control" type='text' name="bankBranch" value="<%=bankBranch%>">
            </div>
            <div class='form-group'>
                <label for='bankBranchCode' class="control-label">Bank branch code</label>
                <br/>
                <input class="form-control" type='text' name="bankBranchCode" value="<%=branchCode%>">
            </div>
            <div class='form-group'>
                <label for='bankBranchAddress' class="control-label">Bank branch address</label>
                <br/>
                <textarea class="form-control" name="bankBranchAddress" rows="3" ><%=branchAdd%></textarea>
            </div>
            <div class='form-group'>
                <label for='bankSwift' class="control-label">Bank swift code</label>
                <br/>
                <input class="form-control" type='text' name="bankSwift" value="<%=swift%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remark about bank account</label>
                <br/>
                <textarea class="form-control" name="remark" rows="3" ><%=remark%></textarea>
            </div>
            <div class='form-group'>
                <label for='obseleteDate' class="control-label">Date discovered to be obsolete</label>
                <br/>
                <input class="form-control dateInput dateToRemove col-md-9" type='text' name="obseleteDate" style="width:90%" value="<%=(workerBankAcc.getObseleteDate() == null) ? ""
                        : sdf.format(workerBankAcc.getObseleteDate())%>">
                <div class="input-group-addon col-md-1 removeBtn" title="Remove date" data-field="" style="width:10%;">
                    <span class="glyphicon glyphicon-remove"></span>
                </div>
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
            <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
            <input type="hidden" name="complementName" value="WorkerBankAcct"/>
            <input type="hidden" name="Id" value="<%=id%>"/>
            <br/><br/>
            <div class="form-group btn_group">
                <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
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
        $(div_id).attr("action", "addWorkerComplement.do");
        $(div_id + " .edit_comp").show();
        $(div_id + " .view_comp").hide();
        $(div_id + " .add_comp").hide();
        $(div_id + " .add_comp input").prop('disabled', true);
        $(div_id + " .add_comp textarea").prop('disabled', true);
        //alert("final check");

    }

    function add(div_id, category, title) {
        $('#pop_up_content').dialog('option', 'title', title);
        $(div_id).attr("action", "addWorkerComplement.do");
        $(div_id + " .add_comp").show();
        $(div_id + " .edit_comp").hide();
        $(div_id + " .view_comp").hide();
        $(div_id + " .view_comp input").prop('disabled', true);
        $(div_id + " .view_comp textarea").prop('disabled', true);
    }


</script>
