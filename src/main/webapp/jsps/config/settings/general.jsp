<%--
/**
 * Copyright (C) [j]karef GmbH
 * http://jkaref.com
 *
 ***********************************************************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */
--%>

<%@include file="/init.jsp" %>

<%
    String portletResource = ParamUtil.getString(renderRequest, "portletResource");

    PortletPreferences preferences = SliderUtil.getPreference(renderRequest, portletResource);

    String viewPermission = preferences.getValue(SliderParamUtil.SETTINGS_VIEW_PERMISSION, "both");
%>

<liferay-portlet:actionURL portletConfiguration="true" var="actionURL" />
<aui:form action="<%=actionURL.toString()%>" method="post" name="fm">
    <aui:input name="<%=SliderConstants.CMD%>" type="hidden" 
            value="<%=SliderConstants.UPDATE_SETTINGS%>" />
    <aui:input name="tab" type="hidden" 
            value="<%=SliderConstants.TAB_GENERAL%>" />
    <%
        request.setAttribute("slide-name", SliderParamUtil.SETTINGS_VIEW_PERMISSION);
        request.setAttribute("slide-value", viewPermission);
        request.setAttribute("slide-property", "slider-view-permission");
    %>	
    <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>
        
    <aui:button-row>
        <aui:button name="saveButton" cssClass="save-btn" type="submit" value="save" />				
    </aui:button-row>
</aui:form>
