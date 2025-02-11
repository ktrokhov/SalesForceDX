'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

/*

 StateService
 Saving the application state

 */

(function () {

    StateService.$inject = ['$q', 'sfdcService', 'userSettingsManager'];

    angular.module('serviceExpert').factory('StateService', StateService);

    function StateService($q, sfdcService, userSettingsManager) {

        var ganttOpenedTerritories = {};

        // sticky settings from user settings
        if (userSettingsManager.GetUserSettingsProperty('Toggled_Territories__c')) {
            var ganttOpenedTerritoriesSettings = JSON.parse(userSettingsManager.GetUserSettingsProperty('Toggled_Territories__c'));

            for (var key in ganttOpenedTerritoriesSettings) {
                ganttOpenedTerritories[key] = ganttOpenedTerritoriesSettings[key];
            }
        }

        var defferedObjects = {
            policies: $q.defer()
        };

        function areCrewsSupported() {
            return true;
        }

        // are contractors supported
        function areContractorsSupported() {
            return contractorSupport;
        }

        // is map enabled
        function isMapEnabled() {
            return mapMode;
        }

        // lang attribute on the app (html)
        var lang = userLocale ? userLocale.split('_')[0] : 'en';

        // are we in console
        var isInConsole = function isInConsole() {
            return typeof sforce !== "undefined" ? sforce.console.isInConsole() : null;
        };

        // list of available policies
        var policies = [],
            selectedPolicyId = null;

        // return true if we are on a mac
        function isOSX() {
            return window.navigator.userAgent.indexOf('Mac OS X') != -1;
        }

        // do we have bulk action running?
        var bulkActionRunning = false;

        function setBulkActionRunning() {
            var open = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : true;

            bulkActionRunning = open;
        }

        function isBulkActionRunning() {
            return bulkActionRunning;
        }

        // get policies
        sfdcService.getPolicies().then(function (sfdcPolicies) {
            policies.push.apply(policies, _toConsumableArray(sfdcPolicies));

            if (policies.length > 0) {
                defferedObjects.policies.resolve(policies);
            } else {
                defferedObjects.policies.reject('no policies found');
            }
        }).catch(function (err) {
            defferedObjects.policies.reject(err);
        });

        // call this when openning a lightbox
        var lightboxStateOpen = false;

        function setLightBoxStatus() {
            var open = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : true;

            lightboxStateOpen = open;
        }

        function isLightboxOpened() {
            return lightboxStateOpen;
        }

        // currently loading new locations
        var isLoadingNewLocations = false;

        // is auto schedule running
        var schedulingRunningFor = {},
            isScheduleRunning = false;

        var ActivateStreamingNotifications = false;

        function setStreamingActiveState(ActivateStreamingNotificationsParam) {
            ActivateStreamingNotifications = ActivateStreamingNotificationsParam;
        }

        function getStreamingActiveState() {
            return ActivateStreamingNotifications;
        }

        //min and max dates for delta
        var DeltaDates = { minDate: null, maxDate: null };

        function setDeltaDates(newMin, newMax) {

            var datesArray = [moment(newMin), moment(newMax)];

            if (DeltaDates.minDate) {
                datesArray.push(moment(DeltaDates.minDate));
                datesArray.push(moment(DeltaDates.maxDate));
            }

            DeltaDates.minDate = moment.min(datesArray).toDate();
            DeltaDates.maxDate = moment.max(datesArray).toDate();
        }

        function getDeltaDates() {

            if (DeltaDates.minDate !== null && DeltaDates.maxDate !== null) {
                return { minDate: DeltaDates.minDate.getTime(), maxDate: DeltaDates.maxDate.getTime() };
            } else {
                return { minDate: null, maxDate: null };
            }
        }

        // This will be our state
        return {
            isOptimizationEnabled: isOptimizationEnabled,
            lang: lang,
            isOSX: isOSX,
            isInConsole: isInConsole,
            policies: policies,
            selectedPolicyId: selectedPolicyId,
            areContractorsSupported: areContractorsSupported,
            isMapEnabled: isMapEnabled,
            setLightBoxStatus: setLightBoxStatus,
            isLightboxOpened: isLightboxOpened,
            setBulkActionRunning: setBulkActionRunning,
            isBulkActionRunning: isBulkActionRunning,
            schedulingRunningFor: schedulingRunningFor,
            isScheduleRunning: isScheduleRunning,
            ganttOpenedTerritories: ganttOpenedTerritories,
            areCrewsSupported: areCrewsSupported,
            getStreamingActiveState: getStreamingActiveState,
            setStreamingActiveState: setStreamingActiveState,
            setDeltaDates: setDeltaDates,
            getDeltaDates: getDeltaDates,
            promises: {
                policies: function policies() {
                    return defferedObjects.policies.promise;
                }
            }
        };
    }
})();