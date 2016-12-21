<%--
/**
 * Copyright (C) Rotterdam Community Solutions B.V.
 * http://www.rotterdam-cs.com
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

    String directionNav = portletPreferences.getValue(SliderParamUtil.SETTINGS_DIRECTION_NAV, "false");
    String prevTextValue = portletPreferences.getValue(SliderParamUtil.SETTINGS_PREVIOUS_TEXT, "Prev");
    String nextTextValue = portletPreferences.getValue(SliderParamUtil.SETTINGS_NEXT_TEXT, "Next");
    String autoHideNav = portletPreferences.getValue(SliderParamUtil.SETTINGS_AUTO_HIDE_NAV, "false");
    String controlNavValue = portletPreferences.getValue(SliderParamUtil.SETTINGS_CONTROL_NAV, "true");
    String keyboardNavValue = portletPreferences.getValue(SliderParamUtil.SETTINGS_KEYBOARD_NAV, "true");
    String pauseOnHoverValue = portletPreferences.getValue(SliderParamUtil.SETTINGS_PAUSE_ONHOVER, "true");
    String manualAdvanceValue = portletPreferences.getValue(SliderParamUtil.SETTINGS_MANUAL_ADVANCE, "false");

%>

<liferay-portlet:actionURL portletConfiguration="true" var="actionURL" />

<aui:fieldset label="tab-slide-navigation">

    <aui:form action="<%=actionURL.toString()%>" method="post" name="fm">

        <aui:input name="<%=SliderConstants.CMD%>" type="hidden"
                value="<%=SliderConstants.UPDATE_SETTINGS%>" />
        <aui:input name="tab" type="hidden"
                value="<%=SliderConstants.TAB_SLIDES_NAVIGATION%>" />

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_DIRECTION_NAV);
            request.setAttribute("slide-value", directionNav);
            request.setAttribute("slide-property", "slider-option-true-false");
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_PREVIOUS_TEXT);
            request.setAttribute("slide-value", prevTextValue);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_NEXT_TEXT);
            request.setAttribute("slide-value", nextTextValue);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%--
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_AUTO_HIDE_NAV);
            request.setAttribute("slide-value", autoHideNav);
            request.setAttribute("slide-property", "slider-option-true-false");
        --%>
        <%--<jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>--%>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_CONTROL_NAV);
            request.setAttribute("slide-value", controlNavValue);
            request.setAttribute("slide-property", "slider-option-true-false");
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_KEYBOARD_NAV);
            request.setAttribute("slide-value", keyboardNavValue);
            request.setAttribute("slide-property", "slider-option-true-false");
        %>

        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_PAUSE_ONHOVER);
            request.setAttribute("slide-value", pauseOnHoverValue);
            request.setAttribute("slide-property", "slider-option-true-false");
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_MANUAL_ADVANCE);
            request.setAttribute("slide-value", manualAdvanceValue);
            request.setAttribute("slide-property", "slider-option-true-false");
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <aui:button-row>
            <aui:button name="saveButton" cssClass="save-btn" type="submit" value="save" />
        </aui:button-row>
    </aui:form>
</aui:fieldset>
