<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@ include file="/init.jsp"%>

<%

    String portletResource = ParamUtil.getString(renderRequest, "portletResource");

    PortletPreferences preferences = SliderUtil.getPreference(renderRequest, portletResource);

    //Slides Animation
    String effectSelectedValue = preferences.getValue(SliderParamUtil.SETTINGS_EFFECT, "random");
    String slicesValue = preferences.getValue(SliderParamUtil.SETTINGS_SLICES, "15");
    String boxColumnValue = preferences.getValue(SliderParamUtil.SETTINGS_BOX_COLUMN, "8");
    String animationSpeedValue = preferences.getValue(SliderParamUtil.SETTINGS_ANIMATION_SPEED, "500");
    String pauseTimeValue = preferences.getValue(SliderParamUtil.SETTINGS_PAUSE_TIME, "3000");
    String startSlideValue = preferences.getValue(SliderParamUtil.SETTINGS_START_SLIDE, "0");
    String randomSlideValue = preferences.getValue(SliderParamUtil.SETTINGS_RANDOM_SLIDE, "false");

    //Slides Navigation
    String directionNav = preferences.getValue(SliderParamUtil.SETTINGS_DIRECTION_NAV, "true");
    String prevTextValue = preferences.getValue(SliderParamUtil.SETTINGS_PREVIOUS_TEXT, "Prev");
    String nextTextValue = preferences.getValue(SliderParamUtil.SETTINGS_NEXT_TEXT, "Next");
    String autoHideNav = preferences.getValue(SliderParamUtil.SETTINGS_AUTO_HIDE_NAV, "false");
    String controlNavValue = preferences.getValue(SliderParamUtil.SETTINGS_CONTROL_NAV, "true");
    String keyboardNavValue = preferences.getValue(SliderParamUtil.SETTINGS_KEYBOARD_NAV, "true");
    String pauseOnHoverValue = preferences.getValue(SliderParamUtil.SETTINGS_PAUSE_ONHOVER, "true");
    String manualAdvanceValue = preferences.getValue(SliderParamUtil.SETTINGS_MANUAL_ADVANCE, "false");

    //Slides Themes
    String themeValue = preferences.getValue(SliderParamUtil.SETTINGS_THEME, "default");
    String opacityValue = preferences.getValue(SliderParamUtil.SETTINGS_OPACTIY, "0.8");
    String addCssClassValue = preferences.getValue(SliderParamUtil.SETTINGS_ADDITIONAL_CSS_CLASS, "");

    StringBuilder settings = new StringBuilder(); 
    settings.append("effect:").append(effectSelectedValue);
    settings.append(", slices:").append(slicesValue);
    settings.append(", boxCols:").append(boxColumnValue);
    settings.append(", animSpeed:").append(animationSpeedValue);
    settings.append(", pauseTime:").append(pauseTimeValue);
    settings.append(", startSlide=").append(startSlideValue);
    settings.append(", directionNav=").append(directionNav);
    settings.append(", directionNavHide=").append(autoHideNav);
    settings.append(", prevText=").append(prevTextValue);
    settings.append(", nextText=").append(nextTextValue);
    settings.append(", controlNav=").append(controlNavValue);
    settings.append(", keyboardNav=").append(keyboardNavValue);
    settings.append(", pauseOnHover=").append(pauseOnHoverValue);
    settings.append(", manualAdvance=").append(nextTextValue);
    settings.append(", captionOpacity=").append(manualAdvanceValue);
%>
