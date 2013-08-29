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
<%@ include file="/init.jsp"%>
<%		
    String slidesBuilder = SliderUtil.buildSlides(renderRequest, renderResponse);
    String buildSettings = SliderUtil.buildSettings(renderRequest, renderResponse);
    boolean displaySlide = (slidesBuilder != null && !slidesBuilder.trim().equals(""));

    //Slides Themes
    PortletPreferences preferences = SliderUtil.getPreference(renderRequest, null);

    String themeValue = preferences.getValue(SliderParamUtil.SETTINGS_THEME, "default");
    String addCssClassValue = preferences.getValue(SliderParamUtil.SETTINGS_ADDITIONAL_CSS_CLASS, "");
    String widthValue = preferences.getValue(SliderParamUtil.SETTINGS_SLIDE_WIDTH, "618");
    String heightValue = preferences.getValue(SliderParamUtil.SETTINGS_SLIDE_HEIGHT, "246");

    if(Validator.isNull(widthValue))
        widthValue = "618px";
    if(Validator.isNull(heightValue))
        heightValue = "246px";
    themeValue = themeValue.toLowerCase();
    
    if(displaySlide) { 
        String inlineStyle = new StringBuilder("margin:0 auto;")
                .append("width: ").append(widthValue).append(";")
                .append("height: ").append(heightValue).append(";").toString();
%>
<div class="slider-wrapper theme-<%=themeValue%> <%=addCssClassValue%>">
    <div class="ribbon"></div>
    <div id="slider" class="nivoSlider" style="<%= inlineStyle %>">
        <%=slidesBuilder%>
    </div>
</div>
<%  } else { %>
<center><b><liferay-ui:message key="message-no-slides-configured"></liferay-ui:message></b></center>
<%  } %>

<link rel="stylesheet" href="<%=renderRequest.getContextPath()%>/css/<%=themeValue%>/<%=themeValue%>.css" type="text/css" media="screen" />

<aui:script>
    $(document).ready(function() {
        $('#slider').nivoSlider({<%=buildSettings%>});
    });
</aui:script>
