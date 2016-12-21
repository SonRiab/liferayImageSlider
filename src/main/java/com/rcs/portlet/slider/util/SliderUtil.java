/**
 * Copyright (C) Rotterdam Community Solutions B.V. http://www.rotterdam-cs.com
 *
 ***********************************************************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.rcs.portlet.slider.util;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.ArrayUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.rcs.portlet.slider.model.Slide;
import org.jsoup.Jsoup;

import javax.portlet.*;
import java.util.*;

/**
 * @author Rajesh
 *
 */
public class SliderUtil {

    private static Log _LOG = LogFactoryUtil.getLog(SliderUtil.class);

    public static List<Slide> getSlides(PortletRequest request,
            PortletResponse response)
            throws PortalException, SystemException {

        return getSlidesByComparator(request, response,
                new OrderComparator());
    }

    public static int getLastSlide(ActionRequest request,
            ActionResponse response)
            throws PortalException, SystemException {

        List<Slide> slidesByOrder = getSlides(request, response);
        if (slidesByOrder != null && slidesByOrder.size() > 0) {
            Slide slide = slidesByOrder.get(slidesByOrder.size() - 1);
            if (slide != null) {
                return slide.getOrder() + 1;
            }
        }

        return 0;
    }

    public static List<Slide> getSlidesByComparator(PortletRequest request,
            PortletResponse response,
            Comparator<Slide> comparator)
            throws PortalException, SystemException {

        String portletResource = ParamUtil.getString(request,
                "portletResource");

        PortletPreferences portletPreferences = request.getPreferences();

        List<Slide> slides = new ArrayList<Slide>();
        Enumeration<String> prefMap = portletPreferences.getNames();

        while (prefMap.hasMoreElements()) {
            String slideId = prefMap.nextElement();
            if (slideId.startsWith("slides_")) {
                String[] values = portletPreferences.getValues(
                        slideId, null);
                if (Validator.isNotNull(values)) {
                    Slide slide = getSlide(slideId, values);
                    slides.add(slide);
                }
            }
        }

        Collections.sort(slides, comparator);

        return slides;
    }

    /**
     *
     * @param request
     * @param portletResource
     * @return
     * @throws PortalException
     * @throws SystemException
     * @deprecated since Liferay 6.2.5 this method throws NPE
     */
    @Deprecated
    public static PortletPreferences getPreference(PortletRequest request,
            String portletResource)
            throws PortalException, SystemException {

        if (portletResource == null
                || portletResource.trim().equals("")) {
            ThemeDisplay themeDisplay = (ThemeDisplay) request
                    .getAttribute("THEME_DISPLAY");
            portletResource = themeDisplay.getPortletDisplay()
                    .getId();
        }

        return PortletPreferencesFactoryUtil.getPortletSetup(request,
                portletResource);
    }

    public static String buildSlides(PortletRequest renderRequest,
            PortletResponse renderResponse)
            throws PortalException, SystemException {

        List<Slide> slides = SliderUtil.getSlides(renderRequest,
                renderResponse);

        StringBuilder slidesBuilder = new StringBuilder();
        for (Slide slide : slides) {
            slidesBuilder.append("<div class=\"rcs-slide\" id=\"slide").append(slide.getId()).append("\">");

            if (Validator.isNotNull(slide.getLink())) {
                slidesBuilder.append("<a href=\"").append(slide.getLink());
                if (Validator.isNotNull(slide.getTitle())) {
                    slidesBuilder.append("\" title=\"").append(slide.getTitle());
                }
                slidesBuilder.append("\">");
            }

            slidesBuilder.append("<img src=\"").append(slide.getImageUrl());
            if (Validator.isNotNull(slide.getTitle())) {
                slidesBuilder.append("\" title=\"").append(slide.getTitle());
            }
            if (Validator.isNotNull(slide.getDesc())) {
                slidesBuilder.append("\" alt=\"")
                        .append(Jsoup.parse(slide.getDesc()).text());
            }
            slidesBuilder.append("\" />");

            if (Validator.isNotNull(slide.getLink())) {
                slidesBuilder.append("</a>");
            }

            slidesBuilder.append("</div>");
        }// end slides for

        return slidesBuilder.toString();
    }

    public static String buildCaption(PortletRequest renderRequest,
            PortletResponse renderResponse)
            throws PortalException, SystemException {

        List<Slide> slides = SliderUtil.getSlides(renderRequest,
                renderResponse);

        StringBuilder captionBuilder = new StringBuilder();
        for (Slide slide : slides) {
            captionBuilder.append("<div class=\"rcs-slide-desc\" id=\"slide-desc").append(slide.getId()).append("\">");
            if (Validator.isNotNull(slide.getDesc())) {
                captionBuilder.append(slide.getDesc());
            }
            captionBuilder.append("</div>");
        }// end slides for
        return captionBuilder.toString();
    }

    /**
     *
     * @param namespace
     * @param wrapperWidth
     * @param wrapperHeight
     * @param itemWidth
     * @param itemHeight
     * @param effectSelected
     * @param animationSpeed
     * @param pauseTime
     * @param startSlide
     * @param randomSlide
     * @param directionNav
     * @param controlNav
     * @param keyboardNav
     * @param pauseOnHover
     * @param manualAdvance
     * @param synchronise
     * @param synchroniseOptions
     * @return
     */
    private static String buildSettings(
            String  namespace,
            String  wrapperWidth,
            String  wrapperHeight,
            String  numberItems,
            String  itemWidth,
            String  itemHeight,
            String  numberAnimate,
            String  effectSelected,
            String  animationSpeed,
            String  pauseTime,
            String  startSlide,
            String  randomSlide,
            String  directionNav,
            String  controlNav,
            String  keyboardNav,
            String  pauseOnHover,
            String  manualAdvance,
            boolean synchronise,
            String  synchroniseOptions,
            boolean enableSwipe) {

        StringBuilder settings = new StringBuilder();
        String replaceThis = "";

        // parse boolean values first
        boolean useDirectNav = false;
        if(Validator.isNotNull(directionNav)
                && ("true".equalsIgnoreCase(directionNav)
                    || "false".equalsIgnoreCase(directionNav))) {
            useDirectNav = Boolean.parseBoolean(directionNav);
        }

        boolean useKeyboardNav = false;
        if (Validator.isNotNull(keyboardNav)
                && ("true".equalsIgnoreCase(keyboardNav)
                    || "false".equalsIgnoreCase(keyboardNav))) {
            useKeyboardNav = Boolean.parseBoolean(keyboardNav);
        }

        boolean useControlNav = false;
        if (Validator.isNotNull(controlNav)
                && ("true".equalsIgnoreCase(controlNav)
                    || "false".equalsIgnoreCase(controlNav))) {
            useControlNav = Boolean.parseBoolean(controlNav);
        }

        boolean doPauseOnHover = false;
        if (Validator.isNotNull(pauseOnHover)
                && ("true".equalsIgnoreCase(pauseOnHover)
                    || "false".equalsIgnoreCase(pauseOnHover))) {
            doPauseOnHover = Boolean.parseBoolean(pauseOnHover);
        }

        boolean doRandomSlide = false;
        if (Validator.isNotNull(randomSlide)
                && ("true".equalsIgnoreCase(randomSlide)
                    || "false".equalsIgnoreCase(pauseOnHover))) {
            doRandomSlide = Boolean.parseBoolean(randomSlide);
        }

        boolean manualNavOnly = false;
        if (Validator.isNotNull(manualAdvance)
                && ("true".equalsIgnoreCase(manualAdvance)
                    || "false".equalsIgnoreCase(manualAdvance))) {
            manualNavOnly = Boolean.parseBoolean(manualAdvance);
        }

        // build the settings string

        /* The width of the carousel. If null, the width will be calculated.
         * Use "variable" to automatically resize the carousel when scrolling
         * items with variable widths.  Use "auto" to measure the widthest item.
         * Use a percentage value (e.g.: "90%") to automatically resize
         * (and re-configurate) the carousel onWindowResize.
         */
        if (Validator.isNotNull(wrapperWidth)) {
            if (Validator.isNumber(wrapperWidth)) {
                settings.append("width:").append(wrapperWidth);
            } else {
                settings.append("width:'").append(wrapperWidth).append("'");
            }
        } else {
            // even if this is the default value we append it to have a well defined beginning
            settings.append("width:null");
        }

        /* The height of the carousel. If null, the height will be calculated.
         * Use "variable" to automatically resize the carousel when scrolling
         * items with variable heights.  Use "auto" to measure the heightest item.
         * Use a percentage value (e.g.: "90%") to automatically resize
         * (and re-configurate) the carousel onWindowResize.
         */
        settings.append(", ");
        if (Validator.isNotNull(wrapperHeight)) {
            if (Validator.isNumber(wrapperHeight)) {
                settings.append("height:").append(wrapperHeight);
            } else {
                settings.append("height:'").append(wrapperHeight).append("'");
            }
        } else {
            settings.append("height:null");
        }

        /**
         * Use an JS string as selector for the carousel to synchronise.
	 * Or use an JS array as selector and options for the carousel to synchronise:
         * [string selector, boolean inheritOptions, boolean sameDirection, number deviation]
         * For example: ["#foo2", true, true, 0]
	 * Or use an JS array as a collection of arrays.
         */
        if(synchronise) {
            settings.append(", ");
            settings.append("synchronise:").append(synchroniseOptions).append("");
        }

        /* A map of the configuration for the items */
        settings.append(", items:{");
        {
            /* Number of visilbe items. If null, the number will be calculated.
             *
             */
            if (Validator.isNotNull(numberItems)) {
                if(Validator.isNumber(numberItems)) {
                    settings.append("visible:").append(numberItems);
                } else {
                    settings.append("visible:'").append(numberItems).append("'");
                }
            } else {
                // even if this is the default value we append it to have a well defined beginning
                settings.append("visible:null");
            }


           /* The nth item to start the carousel. Hint: This can also be a negative number.
            * Use "random" to let the plugin pick a randon item to start the carousel.
            */
            if (Validator.isNotNull(startSlide)) {
                settings.append(", ");
                if(doRandomSlide) {
                    settings.append("start:'random'");
                } else if(Validator.isNumber(startSlide)) {
                    settings.append("start:").append(startSlide);
                }
            }


            // TODO change this to a new setting
            /* The width of the items. If null, the width will be measured.
             * "variable" creates a carousel that supports variable item-widths.
             * Use a percentage value (e.g.: "90%") to automatically resize
             * (and re-configurate) the carousel onWindowResize.
             */
            if (Validator.isNotNull(itemWidth)) {
                settings.append(", ");
                if (Validator.isNumber(itemWidth)) {
                    settings.append("width:").append(itemWidth);
                } else {
                    settings.append("width:'").append(itemWidth).append("'");
                }
            }

            // TODO change this to a new setting
            /* The height of the items. If null, the height will be measured.
             * "variable" creates a carousel that supports variable item-heights.
             * Use a percentage value (e.g.: "90%") to automatically resize
             * (and re-configurate) the carousel onWindowResize.
             */
            if (Validator.isNotNull(itemHeight)) {
                settings.append(", ");
                if (Validator.isNumber(itemHeight)) {
                    settings.append("height:").append(itemHeight);
                } else {
                    settings.append("height:'").append(itemHeight).append("'");
                }
            }
        }
        settings.append("}");

        /* A map of the configuration used for general scrolling */
        settings.append(", scroll:{");
        {
            /* Number of items to scroll. If null, the number of visible items is used. */
            if (Validator.isNotNull(numberAnimate) && Validator.isNumber(numberAnimate)) {
                settings.append("items:").append(numberAnimate);
            } else {
                // even if this is the default value we append it to have a well defined beginning
                settings.append("items:null");
            }

            /* Indicates which effect to use for the transition.
             * Possible values: "none", "scroll", "directscroll", "fade",
             * "crossfade", "cover", "cover-fade", "uncover" or "uncover-fade".
             */
            if (Validator.isNotNull(effectSelected)) {
                settings.append(", ");
                settings.append("fx:'").append(effectSelected).append("'");
            }

            /* Indicates which easing function to use for the transition.
             * jQuery defaults: "linear" and "swing", built in: "quadratic", "
             * cubic" and "elastic"
             */
            if (Validator.isNotNull(replaceThis)) {
                settings.append(", ");
                settings.append("easing:'").append(replaceThis).append("'");
            }

            /* Determines the duration of the transition in milliseconds. */
            if (Validator.isNotNull(animationSpeed) &&
                    Validator.isNumber(animationSpeed)) {
                settings.append(", ");
                settings.append("duration:").append(animationSpeed);
            }

            /* Determines whether the timeout between transitions should be paused "onMouseOver".
             * Use "resume" to let the timeout resume instead of restart "onMouseOut".
             * Use "immediate" to immediately stop "onMouseOver" and resume "onMouseOut" a scrolling carousel.
             * Use "immediate-resume" for both the options above.
             */
            if (doPauseOnHover) {
                settings.append(", ");
                settings.append("pauseOnHover:").append(pauseOnHover);
            } else if (Validator.isNotNull(pauseOnHover)) {
                settings.append(", ");
                settings.append("pauseOnHover:'").append(pauseOnHover).append("'");
            }

        }
        settings.append("}");

        /* A map of the configuration used for automatic scrolling */
        settings.append(", auto:{");
        {
            /* Determines whether the carousel should scroll automatically or not. */
            if (manualNavOnly) {
                settings.append("play:false");
            } else {
                settings.append("play:true");
            }

            /* Determines whether the carousel should scroll automatically or not. */
            if (Validator.isNotNull(pauseTime) &&
                    Validator.isNumber(pauseTime)) {
                settings.append(", ");
                settings.append("timeoutDuration:").append(pauseTime);
            }

            /* Determines whether the carousel should scroll automatically or not. */
            if (Validator.isNotNull(pauseTime) &&
                    Validator.isNumber(pauseTime)) {
                settings.append(", ");
                settings.append("delay:").append(pauseTime);
            }
        }
        settings.append("}");

        if(useDirectNav) {
            /* A map of the configuration used for scrolling backwards using the "previous"
             * button or key
             */
            settings.append(", prev:{");
            {
                settings.append("button:'#").append(namespace).append("directionNav > .prevNav'");
                if(useKeyboardNav) {
                    settings.append(", ");
                    settings.append("key:'left'");
                }
            }
            settings.append("}");

            /* A map of the configuration used for scrolling forward using the "next"
             * button or key
             */
            settings.append(", next:{");
            {
                settings.append("button:'#").append(namespace).append("directionNav > .nextNav'");
                if(useKeyboardNav) {
                    settings.append(", ");
                    settings.append("key:'right'");
                }
            }
            settings.append("}");
        }

        if (useControlNav) {
            /* A map of the configuration used for scrolling via the "pagination"
             * buttons/bullets or keys
             */
            settings.append(", pagination:{");
            {
                settings.append("container:'#").append(namespace).append("pagination'");
                if(useKeyboardNav) {
                    settings.append(", ");
                    settings.append("key:").append(keyboardNav);
                }
            }
            settings.append("}");
        }

        if(enableSwipe) {
            /* A map of the configuration used for scrolling via swiping (on touch-devices)
             * or dragging (using a mouse)
             */
            settings.append(", swipe:{");
            {
                settings.append("onTouch:true");
                settings.append(", ");
                settings.append("onMouse:true");
            }
            settings.append("}");
        }

        _LOG.debug(settings);

        return settings.toString();
    }

    /**
     * Build the settings needed for the carousel/slider
     *
     * @param renderRequest
     * @param renderResponse
     * @return The settings for the carousel
     * @throws PortalException
     * @throws SystemException
     */
    public static String buildSliderSettings(PortletRequest renderRequest,
            PortletResponse renderResponse)
            throws PortalException, SystemException {

        /*
         * http://caroufredsel.dev7studios.com/configuration.php
         */
        PortletPreferences preferences = renderRequest.getPreferences();

        String syncOptions = new StringBuilder("['#")
                .append(renderResponse.getNamespace())
                .append("caption', false, true, 0]").toString();

        String disableCaption = preferences.getValue(SliderParamUtil.SETTINGS_DISABLE_CAPTION, "false");
        boolean synchronise = true;
        if(Validator.isNotNull(disableCaption)
                && ("true".equalsIgnoreCase(disableCaption)
                    || "false".equalsIgnoreCase(disableCaption))) {
            synchronise = !Boolean.parseBoolean(disableCaption);
        }

        return buildSettings(
                renderResponse.getNamespace(),
                preferences.getValue(SliderParamUtil.SETTINGS_SLIDER_WIDTH, null),
                preferences.getValue(SliderParamUtil.SETTINGS_SLIDER_HEIGHT, null),
                preferences.getValue(SliderParamUtil.SETTINGS_NUMBER_SLIDES, null),
                preferences.getValue(SliderParamUtil.SETTINGS_SLIDER_ITEM_WIDTH, null),
                preferences.getValue(SliderParamUtil.SETTINGS_SLIDER_ITEM_HEIGHT, null),
                preferences.getValue(SliderParamUtil.SETTINGS_NUMBER_ANIMATE, null),
                preferences.getValue(SliderParamUtil.SETTINGS_EFFECT, "random"),
                preferences.getValue(SliderParamUtil.SETTINGS_ANIMATION_SPEED, "500"),
                preferences.getValue(SliderParamUtil.SETTINGS_PAUSE_TIME, "3000"),
                preferences.getValue(SliderParamUtil.SETTINGS_START_SLIDE, "0"),
                preferences.getValue(SliderParamUtil.SETTINGS_RANDOM_SLIDE, "false"),
                preferences.getValue(SliderParamUtil.SETTINGS_DIRECTION_NAV, "true"),
                preferences.getValue(SliderParamUtil.SETTINGS_CONTROL_NAV, "true"),
                preferences.getValue(SliderParamUtil.SETTINGS_KEYBOARD_NAV, "true"),
                preferences.getValue(SliderParamUtil.SETTINGS_PAUSE_ONHOVER, "true"),
                preferences.getValue(SliderParamUtil.SETTINGS_MANUAL_ADVANCE, "false"),
                synchronise,
                syncOptions,
                true);
    }

    public static String buildCaptionSettings(PortletRequest renderRequest,
            PortletResponse renderResponse)
            throws PortalException, SystemException {

        /*
         * http://caroufredsel.dev7studios.com/configuration.php
         */
        PortletPreferences preferences = renderRequest.getPreferences();

        return buildSettings(
                renderResponse.getNamespace(),
                preferences.getValue(SliderParamUtil.SETTINGS_CAPTION_WIDTH, null),
                preferences.getValue(SliderParamUtil.SETTINGS_CAPTION_HEIGHT, null),
                preferences.getValue(SliderParamUtil.SETTINGS_NUMBER_SLIDES, null),
                preferences.getValue(SliderParamUtil.SETTINGS_CAPTION_ITEM_WIDTH, null),
                preferences.getValue(SliderParamUtil.SETTINGS_CAPTION_ITEM_HEIGHT, null),
                preferences.getValue(SliderParamUtil.SETTINGS_NUMBER_ANIMATE, null),
                "crossfade",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "true",
                false,
                "",
                false);
    }

    public static Slide getSlide(PortletRequest request, String slideId)
            throws PortalException, SystemException {

        String portletResource = ParamUtil.getString(request,
                "portletResource");
        PortletPreferences portletPreferences = request.getPreferences();

        String[] values = portletPreferences.getValues(slideId, null);

        if (ArrayUtil.isNotEmpty(values)) {
            return getSlide(slideId, values);
        }

        return new Slide();
    }

    public static Long getSlideId(String slideId) {

        if (Validator.isNotNull(slideId)) {
            slideId = slideId.replaceAll("slides_", "");

            return Long.parseLong(slideId);
        }

        return null;
    }

    public static Slide getSlide(String slideId, String[] values) {

        String title = values[0];
        String link = values[1];
        String desc = values[2];
        String imageUrl = values[3];
        String timeMillis = values[4];
        String order = values[5];

        Slide slide = new Slide(slideId, title, link, imageUrl, desc,
                timeMillis, Integer.parseInt(order));
        return slide;
    }
}
