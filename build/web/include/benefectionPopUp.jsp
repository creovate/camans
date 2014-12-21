<%-- 
    Document   : benefectionPopUp
    Created on : Dec 5, 2014, 12:55:01 PM
    Author     : Nyein Su
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="camans.entity.Benefit"%>
<%@page import="camans.dao.BenefitDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="camans.entity.User"%>
<%@page import="java.util.HashMap"%>


<style>
    h4{
        color: #AF4454;
    }

</style>
<script>
    $(function() {
        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0
        });

    });

    //for date inputs
    $(document).ready(function(){

        $('.dateInput').focus(function(){

        $('.dateInput').blur();

        });

    });
    
    $(document).ready(function() {
        $("").dialog({
            create: function(event, ui) {
                var widget = $(this).dialog("widget");
                $(".ui-dialog-titlebar-close span", widget)
                        .removeClass("ui-icon-closethick")
                        .addClass("ui-icon-close");
            }
        });
    });


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
        //alert(div_id);
        $(div_id).attr("action", "addBenefit.do");
        $(div_id + " .edit_comp").show();
        //alert("edit");
        $(div_id + " .view_comp").hide();
        $(div_id + " .add_comp").hide();
        $(div_id + " .add_comp input").prop('disabled', true);
        $(div_id + " .add_comp textarea").prop('disabled', true);
        //alert("final check");

    }

    function add(div_id, category) {
        $(div_id).attr("action", "addBenefit.do");

        $(div_id + " .add_comp").show();
        $(div_id + " .edit_comp").hide();
        $(div_id + " .view_comp").hide();
        $(div_id + " .view_comp input").prop('disabled', true);
        $(div_id + " .view_comp textarea").prop('disabled', true);
    }

    //form validation 
    $(document).ready(function() {
        $('.complement_detailed_form')
                .bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                isDate: {
                    validators: {
                        notEmpty: {
                            message: 'Date given cannot be empty.'
                        }
                    }
                },
                benetype: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                sernum: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'This field must be less than 30 characters.'
                        }
                    }
                },
                remark: {
                    validators: {
                        stringLength: {
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                purpose: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                },
                value: {
                    validators: {
                        numeric: {
                            message: 'Salary must be a number'
                        },
                        regexp: {
                            regexp: /^[0-9]+(\.[0-9]{1,2})?$/,
                            message: 'This value must have maximum 2 decimal place.'
                        }
                    }
                }
               }
        }); 
                
 
     //form validation 
    $(document).ready(function() {
        $('#add_benefit_pop_up')
                .bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                nisDate: {
                    validators: {
                        notEmpty: {
                            message: 'Date given cannot be empty.'
                        }
                    }
                },
                nbenetype: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                nsernum: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: 'This field must be less than 30 characters.'
                        }
                    }
                },
                npurpose: {
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
                            max: 500,
                            message: 'This field must be less than 500 characters.'
                        }
                    }
                },
                nvalue: {
                    validators: {
                        numeric: {
                            message: 'Salary must be a number'
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
                .revalidateField('nisDate');                // Revalidate it

    });
    $('.dateInput').on('change', function() {
        $('.complement_detailed_form')
                .data('bootstrapValidator')             // Get the validator instance
                .revalidateField('isDate');                // Revalidate it

    });
    
</script>

<%
    /* data collection */
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    
    String worker_fin = request.getParameter("workerFin");
    String jobKey = request.getParameter("jobkey");
    String probKey = request.getParameter("problemKey");

    String foodbeneId = request.getParameter("foodbene");
    String transpobeneId = request.getParameter("transpobene");
    String medibeneId = request.getParameter("medibene");
    String roofbeneId = request.getParameter("roofbene");
    String otherbeneId = request.getParameter("otherbene");

    String action = request.getParameter("action");
    //end of data collection
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    //general dropdownlist
    //HashMap<Integer, String> meal = DropdownDAO.retrieveAllDropdownListOfSalaryMode();

    ArrayList<String> dropdownList = new ArrayList<String>();
    if (foodbeneId != null) {
        //get the food benefit dropdown list
        dropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Food");
    } else if (transpobeneId != null) {
        //get transportation benefit dropdown list
        dropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Transport");
    } else if (medibeneId != null) {
        dropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Medical & Karunya");
    } else if (roofbeneId != null) {
        dropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Roof");
    } else if (otherbeneId != null) {
        dropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Other");
    }
%>
<!---- View Edit ---->
<%
    if (action.equals("viewedit")) {
        Benefit benefit = null;
        if (foodbeneId != null) {
            int id = Integer.parseInt(foodbeneId);
            benefit = BenefitDAO.retrieveBenefitById(id);
        } else if (transpobeneId != null) {
            int id = Integer.parseInt(transpobeneId);
            benefit = BenefitDAO.retrieveBenefitById(id);
        } else if (medibeneId != null) {
            int id = Integer.parseInt(medibeneId);
            benefit = BenefitDAO.retrieveBenefitById(id);
        } else if (roofbeneId != null) {
            int id = Integer.parseInt(roofbeneId);
            benefit = BenefitDAO.retrieveBenefitById(id);
        } else if (otherbeneId != null) {
            int id = Integer.parseInt(otherbeneId);
            benefit = BenefitDAO.retrieveBenefitById(id);
        }
               
 %>

<form method="POST" id='benefit_pop_up' class="form complement_detailed_form" action="addBenefit.do"  style="height:100%">
    <!--h4 class='view_comp'>View Benefit Details</h4>
    <h4 class='add_comp'>Add A New Benefit </h4>
    <h4 class='edit_comp'>Edit Benefit Details</h4-->

    <%
        String issueDate = sdf.format(benefit.getIssueDate());
        String benefitGiver = benefit.getBenefitGiver();
        String benefitType = benefit.getBenefitType();
        String benefitTypeMore = benefit.getBenefitTypeMore();
        String benefitSerial = benefit.getBenefitSerial();
        String benefitPurpose = benefit.getBenefitPurpose();
        String benefitRemark = benefit.getBenefitRemark();
        double benefitValue = benefit.getBenefitValue();
    %> 

    <div class="view_comp">

        <fieldset disabled>
            <div class='form-group'>
                <label for='isDate' class="control-label">Issued Date: </label>
                <br/>
                <input class="form-control" type='text' name="isDate" value="<%=(issueDate == null) ? "" : issueDate%>">
            </div>
            <div class='form-group'>
                <label for='givenby' class="control-label">Given By: </label>
                <br/>
                <input class="form-control" type='text' name="givenby" value="<%=(benefitGiver == null) ? "" : benefitGiver%>">
            </div>
            <div class='form-group'>
                <label for='benetype' class="control-label">Benefit Type: </label>
                <br/>
                <input class="form-control" type='text' name="benetype" value="<%=(benefitType == null) ? "" : benefitType%>">
            </div>
            <div class='form-group'>
                <label for='sernum' class="control-label">Serial Number: </label>
                <br/>
                <input class="form-control" type='text' name="sernum" value="<%=(benefitSerial == null) ? "" : benefitSerial%>">
            </div>
            <div class='form-group'>
                <label for='purpose' class="control-label">Purpose/Reason: </label>
                <br/>
                <input class="form-control" type='text' name="purpose" value="<%=(benefitPurpose == null) ? "" : benefitPurpose%>">
            </div>
            <div class='form-group'>
                <label for='remark' class="control-label">Remarks/Conditions or Time Frame attached to benefit: </label>
                <br/>
                <textarea class="form-control" name="remark" rows="3"><%=(benefitRemark == null) ? "" : benefitRemark%></textarea>
            </div>
            <div class='form-group'>
                <label for='value' class="control-label">Value of Benefit/Refund (S$): </label>
                <br/>
                <input class="form-control" type='text' name="value" value="<%=(benefitValue == 0) ? "" : benefitValue%>">
            </div>
        </fieldset>

        <div class="form-group btn_group">
            <button type='button' class="btn modal_btn view_comp" onclick='editComplement("#benefit_pop_up", "worker");'>Edit</button>
            <div class='pull-right'>
                <button type='button' class='btn modal_btn view_comp' onclick='add("#benefit_pop_up", "benefit");'>Add</button>                  
                <button type='button' class="btn modal_btn view_comp cancel_btn">Close</button>
            </div>
        </div>
    </div>

    <div class='add_comp'>

        <div class='form-group '>
            <div class='form-group'>
                <label for='nisDate' class="control-label">Issued Date<span style="color: red">*</span>: </label>
                <br/>
                <input class="form form-control date dateInput" 
                       type='text' id="nisDate" name="nisDate" required>
            </div>
            <div class='form-group'>
                <label for='ngivenby' class="control-label" >Given By: </label>
                <br/>
                <input class="form-control no_change" type='text' name="ngivenby" value="<%=userLogin.getUsername()%>"/>
            </div>
            <div class='form-group'>
                <label for='nbenetype' class="control-label">Benefit Type: </label>
                <br/>
                <select class="form-control" id="ipapassType" name="nbenetype">
                    <%
                        for (String dropdownItem : dropdownList) {
                    %>
                    <option><%=dropdownItem%></option>
                    <%

                        }
                    %>  
                </select>
            </div>
            <div class='form-group'>
                <label for='nsernum' class="control-label">Serial Number: </label>
                <br/>
                <input class="form-control" type='text' name="nsernum">
            </div>
            <div class='form-group'>
                <label for='npurpose' class="control-label">Purpose/Reason: </label>
                <br/>
                <input class="form-control" type='text' name="npurpose">
            </div>
            <div class='form-group'>
                <label for='nremark' class="control-label">Remarks/Conditions or Time Frame attached to benefit: </label>
                <br/>
                <textarea class="form-control" name="nremark" rows="3"></textarea>
            </div>
            <div class='form-group'>
                <label for='nvalue' class="control-label">Value of Benefit/Refund (S$): </label>
                <br/>
                <input class="form-control" type='text' name="nvalue">
            </div>
            <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
            <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
            <input type="hidden" name="probKey" value="<%=probKey%>"/>
            <input type="hidden" name="action" value="add"/>

        </div>
        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn add_comp">Save</button>
            <button type='button' class='btn modal_btn add_comp cancel_btn'>Cancel</button>
        </div>
    </div>


    <div class='edit_comp'>
        <div class='form-group'>
            <label for='isDate' class="control-label">Issued Date<span style="color: red">*</span>: </label>
            <br/>
            <input class="form form-control input-append date dateInput" 
                   type='text' id="isDate" name="isDate" value="<%=(issueDate == null) ? "" : issueDate%>" required>
        </div>
        <div class='form-group'>
            <label for='givenby' class="control-label" >Given By: </label>
            <br/>
            <input class="form-control" type='text' name="givenby" value="<%=userLogin.getUsername()%>" readonly="readonly"/>
        </div>
        <div class='form-group'>
            <label for='benetype' class="control-label">Benefit Type: </label>
            <br/>
            <select class="form-control" id="ipapassType" name="benetype">
                <%
                    for (String dropdownItem : dropdownList) {
                        if (dropdownItem.equals("benefitType")) {
                %>
                <option selected> <%=dropdownItem%></option>        
                <%
                } else {
                %>
                <option><%=dropdownItem%></option>
                <%
                        }
                    }
                %>  
            </select>
        </div>
        <div class='form-group'>
            <label for='sernum' class="control-label">Serial Number: </label>
            <br/>
            <input class="form-control" type='text' name="sernum" value="<%=(benefitSerial == null) ? "" : benefitSerial%>">
        </div>
        <div class='form-group'>
            <label for='purpose' class="control-label">Purpose/Reason: </label>
            <br/>
            <input class="form-control" type='text' name="purpose" value="<%=(benefitPurpose == null) ? "" : benefitPurpose%>">
        </div>
        <div class='form-group'>
            <label for='remark' class="control-label">Remarks/Conditions or Time Frame attached to benefit: </label>
            <br/>
            <textarea class="form-control" name="remark" rows="3"><%=(benefitRemark == null) ? "" : benefitRemark%></textarea>
        </div>
        <div class='form-group'>
            <label for='value' class="control-label">Value of Benefit/Refund (S$): </label>
            <br/>
            <input class="form-control" type='text' name="value" value="<%=(benefitValue == 0) ? "" : benefitValue%>">
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="Id" value="<%=benefit.getId()%>"/>
        <input type="hidden" name="action" value="edit"/>

        <div class="form-group btn_group">
            <button type='submit' class="btn modal_btn edit_comp ">Save</button>
            <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        </div>
    </div>
</form>
<!---- adding from outside ---->
<%
} else {
%>

<form method="POST" id='benefit_pop_up' class="form" action="addBenefit.do"  style="height:100%">
    <!--h4 class='view_comp'>View Benefit Details</h4>
    <h4 class='add_comp'>Add A New Benefit </h4>
    <h4 class='edit_comp'>Edit Benefit Details</h4-->


    <div class='form-group '>
        <div class='form-group'>
            <label for='nisDate' class="control-label">Issued Date<span style="color: red">*</span>: </label>
            <br/>
            <input class="form-control input-append date dateInput" id="nisDate" type='text' name="nisDate" >
        </div>
        <div class='form-group'>
            <label for='ngivenby' class="control-label" >Given By: </label>
            <br/>
            <input class="form-control" type='text' name="ngivenby" value="<%=userLogin.getUsername()%>" readonly="readonly"/>
        </div>
        <div class='form-group'>
            <label for='nbenetype' class="control-label">Benefit Type: </label>
            <br/>
            <select class="form-control" id="ipapassType" name="nbenetype">
                <%
                    for (String dropdownItem : dropdownList) {
                %>
                <option><%=dropdownItem%></option>
                <%

                    }
                %>  
            </select>
        </div>


        <div class='form-group'>
            <label for='nsernum' class="control-label">Serial Number: </label>
            <br/>
            <input class="form-control" type='text' name="nsernum">
        </div>
        <div class='form-group'>
            <label for='npurpose' class="control-label">Purpose/Reason: </label>
            <br/>
            <input class="form-control" type='text' name="npurpose">
        </div>
        <div class='form-group'>
            <label for='nremark' class="control-label">Remarks/Conditions or Time Frame attached to benefit: </label>
            <br/>
            <textarea class="form-control" name="nremark" rows="3"></textarea>
        </div>
        <div class='form-group'>
            <label for='nvalue' class="control-label">Value of Benefit/Refund (S$): </label>
            <br/>
            <input class="form-control" type='text' name="nvalue">
        </div>
        <input type="hidden" name="workerFinNum" value="<%=worker_fin%>"/>
        <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
        <input type="hidden" name="probKey" value="<%=probKey%>"/>
        <input type="hidden" name="action" value="add"/>

    </div>
    <div class="form-group btn_group">
        <button type='submit' class="btn modal_btn">Save</button>
        <button type='button' class='btn modal_btn cancel_btn'>Cancel</button>
    </div>


</form>
<%
    }
%>