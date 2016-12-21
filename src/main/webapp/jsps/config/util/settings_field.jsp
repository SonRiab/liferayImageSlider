<%@include file="/init.jsp" %>

<%
    String fieldName = (String)request.getAttribute("slide-name");
    String fieldValue = (String)request.getAttribute("slide-value");
    String property = (String)request.getAttribute("slide-property");
    String desc  = "desc-"  + fieldName;
    String label = "label-" + fieldName;
%>

<aui:layout cssClass="slide-field-wrapper">
    <aui:column columnWidth="20" first="true">
        <liferay-ui:message key="<%=label%>" />
    </aui:column>

    <aui:column columnWidth="35">
        <% if(property != null && !property.trim().equals("")) { %>
        <aui:select name="<%=fieldName%>" label="">
            <%
                String[] options = PortletProps.getArray(property);
                for (String option: options) {
                    String value = option.replace("option-settings-effect-", "")
                            .replace("yes","true").replace("no","false").trim();
            %>
            <aui:option value="<%= value %>" label="<%= option.trim() %>"
                selected="<%= (value.equals(fieldValue)) %>" />
            <%
                }
            %>
        </aui:select>
        <% } else { %>
        <aui:input name="<%=fieldName%>" label="" value="<%=fieldValue%>" />
        <% } %>
    </aui:column>
    <aui:column columnWidth="45" last="true">
        <liferay-ui:message key="<%=desc%>" />
    </aui:column>
</aui:layout>

<%
    request.removeAttribute("slide-name");
    request.removeAttribute("slide-value");
    request.removeAttribute("slide-property");
%>

