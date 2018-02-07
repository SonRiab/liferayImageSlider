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

<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@include file="/init.jsp" %>

<aui:fieldset label="tab-slides" cssClass="slides">
    <%
        List<Slide> slides = SliderUtil.getSlides(renderRequest, resourceResponse);

        String title = LanguageUtil.get(pageContext, "title"),
            order = LanguageUtil.get(pageContext, "order"),
            action = LanguageUtil.get(pageContext, "action");

    %>
    <liferay-ui:search-container var="sliderContainer"
                                 deltaConfigurable="<%= Boolean.FALSE %>"
                                 delta="<%= slides.size() %>"
                                 total="<%= slides.size() %>">
        <liferay-ui:search-container-results results="<%= slides %>"/>
        <liferay-ui:search-container-row className="com.rcs.portlet.slider.model.Slide" modelVar="slide">
            <liferay-ui:search-container-column-text name="<%= title %>">
                ${slide.title}
            </liferay-ui:search-container-column-text>
            <liferay-ui:search-container-column-text name="<%= order %>">
                ${slide.order}
            </liferay-ui:search-container-column-text>
            <liferay-ui:search-container-column-text name="<%= action %>">
                <liferay-portlet:renderURL portletConfiguration="true" var="slideUpURL" >
                    <liferay-portlet:param name="slideId" value="slides_${slide.id}" />
                    <liferay-portlet:param name="<%=SliderConstants.CMD %>" value="<%=SliderConstants.SLIDE_MOVE_UP%>" />
                    <liferay-portlet:param name="tab" value="<%=SliderConstants.TAB_SLIDES%>" />
                </liferay-portlet:renderURL>

                <liferay-ui:icon image="top" message="alt-slide-up" url="<%= slideUpURL %>" />

                <liferay-portlet:renderURL portletConfiguration="true" var="slideDownURL" >
                    <liferay-portlet:param name="slideId" value="slides_${slide.id}" />
                    <liferay-portlet:param name="<%=SliderConstants.CMD %>" value="<%=SliderConstants.SLIDE_MOVE_DOWN%>" />
                    <liferay-portlet:param name="tab" value="<%=SliderConstants.TAB_SLIDES%>" />
                </liferay-portlet:renderURL>

                <liferay-ui:icon image="bottom" message="alt-slide-down" url="<%= slideDownURL %>" />

                <liferay-portlet:renderURL portletConfiguration="true" var="updateURL" >
                    <liferay-portlet:param name="slideParamId" value="slides_${slide.id}" />
                </liferay-portlet:renderURL>

                <liferay-ui:icon image="edit" url="<%= updateURL %>" />

                <liferay-portlet:renderURL portletConfiguration="true" var="deleteURL" >
                    <liferay-portlet:param name="slideId" value="slides_${slide.id}" />
                    <liferay-portlet:param name="<%=SliderConstants.CMD %>" value="<%=SliderConstants.DELETE%>" />
                    <liferay-portlet:param name="tab" value="<%=SliderConstants.TAB_SLIDES%>" />
                </liferay-portlet:renderURL >

                <liferay-ui:icon-delete url="<%= deleteURL %>"/>

            </liferay-ui:search-container-column-text>
        </liferay-ui:search-container-row>
        <liferay-ui:search-iterator searchContainer="${sliderContainer}" paginate="false" />
    </liferay-ui:search-container>


    <liferay-portlet:renderURL portletConfiguration="true" var="addSlideURL"/>

    <aui:button-row>
        <aui:button href="<%=addSlideURL%>" value="button-add-slide"/>
    </aui:button-row>

</aui:fieldset>
