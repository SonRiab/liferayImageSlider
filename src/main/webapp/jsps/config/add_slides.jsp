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
    long plid = themeDisplay.getPlid();
    String portletId = themeDisplay.getPortletDisplay().getId();
    String doAsUserId = String.valueOf(themeDisplay.getUserId());
    String doAsGroupId = String.valueOf(themeDisplay.getScopeGroupId());

    String connectorURL = themeDisplay.getURLPortal()
            + "/html/js/editor/ckeditor/editor/filemanager/browser/liferay/browser.html?Connector=";

    String resourceSelectorParam = "/c/portal/fckeditor?p_l_id=" + plid 
            + "&p_p_id=" + HttpUtil.encodeURL(portletId)
            + "&userId=" + HttpUtil.encodeURL(doAsUserId)
            + "&doAsGroupId=" + HttpUtil.encodeURL(doAsGroupId);

    connectorURL += HttpUtil.encodeURL(resourceSelectorParam);

    String slideId = request.getParameter("slideParamId") != null ? request.getParameter("slideParamId") : "";

    String slideImage = "";				
    Slide slide = null;
    if(Validator.isNotNull(slideId)) {
        slide = SliderUtil.getSlide(renderRequest, slideId);
        slideImage = slide.getImageUrl();
    } else {
        slide = new Slide();
    }
%>

<aui:model-context bean="<%= slide %>" model="<%= Slide.class %>" />

<liferay-portlet:actionURL portletConfiguration="true" var="actionURL" />

<aui:form action="<%=actionURL.toString()%>" method="post" name="fm">

    <aui:input name="slideId" type="hidden" value="<%=slideId%>" />
    <aui:input name="<%=SliderConstants.CMD%>" type="hidden" value="<%=SliderConstants.UPDATE%>" />
    <aui:input name="image" id="slideImage" type="hidden" value="<%=slideImage%>" />

    <aui:fieldset label="label-slide-detail">
        <aui:layout>
            <aui:column columnWidth="50">

                <aui:input cssClass="input-text" type="text" name="title" label="label-slide-title" />
                <aui:input cssClass="input-text" type="text" name="link" label="label-slide-link" />
                <aui:input type="hidden" name="desc" />
                
            </aui:column>

            <aui:column columnWidth="50">
                <label class="aui-field-label"><liferay-ui:message key="label-slide-image-preview" /></label>
                <img id="imagePreview" src="<%=slideImage%>" width="170" 
                        height="100" style="display:block; margin: 3px 0px; border: 1px solid gray"/>
            </aui:column>
            
            <aui:column columnWidth="100" >
                <aui:field-wrapper label="label-slide-text">
                    <liferay-ui:input-editor toolbarSet="email" initMethod="initEditor" width="200" />
                    <aui:script>
                        function <portlet:namespace />initEditor() { 
                            return document.<portlet:namespace />fm.<portlet:namespace />desc.value; 
                        }
                        
                        function sliderEditSubmit() { 
                            var message = window.<portlet:namespace />editor.getHTML();
                            document.<portlet:namespace />fm.<portlet:namespace />desc.value = message;
                            submitForm(document.<portlet:namespace />fm);
                        }
                    </aui:script>
                </aui:field-wrapper>
                <aui:button-row>
                    <aui:button name="imageButton" type="button" value="button-choose-image" onClick="selectImage()" />
                    <aui:button name="saveButton" cssClass="save-btn" type="submit" value="save" onClick="sliderEditSubmit();" />
                </aui:button-row>
            </aui:column>
        </aui:layout>
    </aui:fieldset>
</aui:form>

<aui:script>
    var VIEWER = {
        tools: {
            callFunction: function(funcNum, fileUrl) {
                $('#imagePreview').attr('src', fileUrl);
                $('#<portlet:namespace/>slideImage').val(fileUrl);
            }
        }
    };
    function selectImage() {
        window.open('<%=connectorURL%>', "mywindow", "scroll=1,status=1,menubar=1,width=700,height=550");
    }
</aui:script>
