<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="camans.entity.Dropdown"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <style>
        ul#sortable
{
	margin: 0;
	padding: 0;
	width: 15em;
	float: left;
}

ul#sortable li
{
	border: 0;
	padding: 0.2em;
	margin-bottom: 0.2em;
	border: 1px solid #CCC;
	list-style-type: none;
	cursor: move;
}

ul#sortable li.clone
{
	background: rgba(255, 212, 170, 0.3);
}

div#tools
{
	float: left;
	margin-left: 1em;
}

img#loading
{
	display: none;
}
        </style>
<head>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/mootools/1.2.4/mootools-yui-compressed.js"></script>
	<!-- Please put this on your own server when you use it! It's Sortables from "MooTools More" -->
	<script type="text/javascript" src="http://stuff.dan.cx/common/mootools-1.2.4.4-more-sortables.js"></script>
	<script type="text/javascript" src="scripts.js"></script>
	<link rel="stylesheet" href="styles.css" type="text/css" />
</head>

<body>
                            <form id="editRank" method="post" action="#">
                                
                            <div class="row">
                                <div class="col-xs-12">
                                   <div id="messageBox">Waiting for sortation submission...</div>
                            <ul id="sortable">
                                <!--<div class="list-group">-->
                                <%
                                ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
                                    for (String str: nationalityList) {
                                        Dropdown dropdown = DropdownDAO.retrieveDropdownItem("Nationality_type", str);
                                        int rank = dropdown.getDisplayRank();
                                        int id = dropdown.getId();
                                %>
                                <li id="item-<%=id%>"><%=str%></li>
                                <%  }   %>
                                <!--</div>-->
                            </ul>
   
                                    </div>
                            </div>
                            <button id="save">Save changes</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            </form>
<script>
            var mySortables;

            // Initialisation function
            window.addEvent('domready', function()
            {
                    // When "save changes" clicked, save!
                    $('save').addEvent('click', saveChanges);

                    // Create a new Sortables instance. Pass this the ID of your list
                    mySortables = new Sortables('sortable',
                    {
                            // Make a clone when dragging (element "floats" from the list_
                            clone: true,
                            // Do fancy animation when dragging has finished
                            revert: true,
                            // Called when we start dragging the element
                            onStart: function(element, clone)
                            {
                                    element.setStyle('visibility', 'hidden');
                                    clone.addClass('clone');
                            }
                    });
            });
            
            function saveChanges()
            {
                    //$('loading').setStyle('display', 'inline');
                    //$('save').set('html', 'Saving...');
                    //$('save').disabled = true;
                    // Get list of item order
                    // Get list of item order
                    var items = 'items=' + mySortables.serialize(false, function(element, index)
                    {
                            return element.get('id');
                    }).join(',');
                    alert(items);

                    // Send the AJAX request
                    var myRequest = new Request(
                    {
                        
                            method: "POST",
                            url: 'processDropDownOrder',
                            data: items,
                            onRequest: function() {
                                messageBox.set('text','Updating the sort order in the database.');
		}           ,onSuccess: function() {
                               
                                messageBox.set('text','Database has been updated.');
                }
                ,onFailure: function() {
                    alert("Fail");
                    messageBox.set('text', 'Failed');
                }
                    
                    
                    }).send();
            }

</script>
    </body>
</html>
