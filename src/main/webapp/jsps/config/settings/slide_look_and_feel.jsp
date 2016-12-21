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

    String sliderTheme = portletPreferences.getValue(SliderParamUtil.SETTINGS_THEME, "default");
    String addCssClass = portletPreferences.getValue(SliderParamUtil.SETTINGS_ADDITIONAL_CSS_CLASS, "");
    String numberSlides = portletPreferences.getValue(SliderParamUtil.SETTINGS_NUMBER_SLIDES, "");
    String sliderWidth = portletPreferences.getValue(SliderParamUtil.SETTINGS_SLIDER_WIDTH, "618");
    String sliderHeight = portletPreferences.getValue(SliderParamUtil.SETTINGS_SLIDER_HEIGHT, "246");
    String sliderItemWidth = portletPreferences.getValue(SliderParamUtil.SETTINGS_SLIDER_ITEM_WIDTH, "618");
    String sliderItemHeight = portletPreferences.getValue(SliderParamUtil.SETTINGS_SLIDER_ITEM_HEIGHT, "246");
    String disableCaption = portletPreferences.getValue(SliderParamUtil.SETTINGS_DISABLE_CAPTION, "false");
    String captionWidth = portletPreferences.getValue(SliderParamUtil.SETTINGS_CAPTION_WIDTH, "618");
    String captionHeight = portletPreferences.getValue(SliderParamUtil.SETTINGS_CAPTION_HEIGHT, "246");
    String captionItemWidth = portletPreferences.getValue(SliderParamUtil.SETTINGS_CAPTION_ITEM_WIDTH, "618");
    String captionItemHeight = portletPreferences.getValue(SliderParamUtil.SETTINGS_CAPTION_ITEM_HEIGHT, "246");

%>

<liferay-portlet:actionURL portletConfiguration="true" var="actionURL" />

<aui:fieldset label="tab-slide-look-and-feel">

    <aui:form action="<%=actionURL.toString()%>" method="post" name="fm">

        <aui:input name="<%=SliderConstants.CMD%>" type="hidden"
        value="<%=SliderConstants.UPDATE_SETTINGS%>" />
        <aui:input name="tab" type="hidden"
        value="<%=SliderConstants.TAB_SLIDES_LOOK_AND_FEEL%>" />

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_THEME);
            request.setAttribute("slide-value", sliderTheme);
            request.setAttribute("slide-property", "slider-theme");
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_ADDITIONAL_CSS_CLASS);
            request.setAttribute("slide-value", addCssClass);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_NUMBER_SLIDES);
            request.setAttribute("slide-value", numberSlides);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_SLIDER_WIDTH);
            request.setAttribute("slide-value", sliderWidth);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_SLIDER_HEIGHT);
            request.setAttribute("slide-value", sliderHeight);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_SLIDER_ITEM_WIDTH);
            request.setAttribute("slide-value", sliderItemWidth);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_SLIDER_ITEM_HEIGHT);
            request.setAttribute("slide-value", sliderItemHeight);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_DISABLE_CAPTION);
            request.setAttribute("slide-value", disableCaption);
            request.setAttribute("slide-property", "slider-option-true-false");
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_CAPTION_WIDTH);
            request.setAttribute("slide-value", captionWidth);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_CAPTION_HEIGHT);
            request.setAttribute("slide-value", captionHeight);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_CAPTION_ITEM_WIDTH);
            request.setAttribute("slide-value", captionItemWidth);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <%
            request.setAttribute("slide-name", SliderParamUtil.SETTINGS_CAPTION_ITEM_HEIGHT);
            request.setAttribute("slide-value", captionItemHeight);
        %>
        <jsp:include page="/jsps/config/util/settings_field.jsp"></jsp:include>

        <aui:button-row>
            <aui:button name="saveButton" cssClass="save-btn" type="submit" value="save" />
        </aui:button-row>
    </aui:form>
</aui:fieldset>
