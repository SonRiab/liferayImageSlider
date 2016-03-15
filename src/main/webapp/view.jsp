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

<portlet:defineObjects />

<%  
    PortletPreferences preferences = SliderUtil.getPreference(renderRequest, null);
    boolean isSignedIn = themeDisplay.isSignedIn();
    boolean hasViewPermission = false;
    
    String viewPermission = preferences.getValue(SliderParamUtil.SETTINGS_VIEW_PERMISSION, "both");
    
    if(Validator.equals(viewPermission, "both") 
            || (Validator.equals(viewPermission, "user-only") && isSignedIn)
            || (Validator.equals(viewPermission, "guest-only") && !isSignedIn)) {
        hasViewPermission = true;
    }
    
    if(hasViewPermission) {
%>
    <jsp:include page="/jsps/slider/build_slider_view.jsp"></jsp:include>
<%  } else if(!themeDisplay.getPermissionChecker().isCompanyAdmin()) { %>
    <aui:script>
        AUI().ready('node', function(A) {
            console.log('p_p_id<portlet:namespace />');
            A.one('#p_p_id<portlet:namespace />').hide();
        });
    </aui:script>
<%  } %>