package com.rcs.portlet.slider.util;

public interface SliderParamUtil {
    /* animation */
    String SETTINGS_EFFECT               = "settings-effect";
    String SETTINGS_ANIMATION_SPEED      = "settings-animation-speed";
    String SETTINGS_PAUSE_TIME           = "settings-pause-time";
    String SETTINGS_START_SLIDE          = "settings-start-slide";
    String SETTINGS_RANDOM_SLIDE         = "settings-random-slide";
    String SETTINGS_NUMBER_ANIMATE       = "settings-number-animate";//<<
    
    /* look and feel */
    String SETTINGS_THEME                = "settings-theme";
    String SETTINGS_ADDITIONAL_CSS_CLASS = "settings-addition-css-class";
    String SETTINGS_NUMBER_SLIDES        = "settings-number-slides";//<<
    String SETTINGS_SLIDER_WIDTH         = "settings-slider-width";
    String SETTINGS_SLIDER_HEIGHT        = "settings-slider-height";
    String SETTINGS_SLIDER_ITEM_WIDTH    = "settings-slider-item-width";
    String SETTINGS_SLIDER_ITEM_HEIGHT   = "settings-slider-item-height";
    String SETTINGS_DISABLE_CAPTION      = "settings-disable-catpion";//<<
    String SETTINGS_CAPTION_WIDTH        = "settings-caption-width";
    String SETTINGS_CAPTION_HEIGHT       = "settings-caption-height";
    String SETTINGS_CAPTION_ITEM_WIDTH   = "settings-caption-item-width";
    String SETTINGS_CAPTION_ITEM_HEIGHT  = "settings-caption-item-height";
    
    /* navigation */
    String SETTINGS_DIRECTION_NAV        = "settings-direction-naviation";
    String SETTINGS_PREVIOUS_TEXT        = "settings-previous-text";
    String SETTINGS_NEXT_TEXT            = "settings-next-text";
    // need some extra work
    String SETTINGS_AUTO_HIDE_NAV        = "settings-auto-hide-nav";
    // 
    String SETTINGS_CONTROL_NAV          = "settings-control-nav";
    String SETTINGS_KEYBOARD_NAV         = "settings-keyboard-nav";
    String SETTINGS_PAUSE_ONHOVER        = "settings-pause-onhover";
    String SETTINGS_MANUAL_ADVANCE       = "settings-manual-advance";
}
