pref("toolkit.defaultChromeURI", "chrome://desktopuploader/content/main.xul");
pref("toolkit.defaultChromeFeatures", "chrome,resizable=yes,dialog=no,centerscreen=yes");
// suppress external-load warning for standard browser schemes
pref("network.protocol-handler.warn-external.http", false);
pref("network.protocol-handler.warn-external.https", false);


/* debugging prefs */
pref("browser.dom.window.dump.enabled", true);
pref("javascript.options.showInConsole", true);
pref("javascript.options.strict", true);
pref("nglayout.debug.disable_xul_cache", true);
pref("nglayout.debug.disable_xul_fastload", true);
pref("security.warn_viewing_mixed", false);

pref("browser.download.useDownloadDir", true);
pref("browser.download.defaultFolder", "/tmp");
pref("browser.download.folderList", 1);
pref("browser.download.manager.showAlertOnComplete", false);
pref("browser.download.manager.showAlertInterval", 2000);
pref("browser.download.manager.retention", 0);
pref("browser.download.manager.showWhenStarting", false);
pref("browser.download.manager.useWindow", false);
pref("browser.download.manager.closeWhenDone", true);
pref("browser.download.manager.openDelay", 0);
pref("browser.download.manager.focusWhenStarting", false);
pref("browser.download.manager.flashCount", 0);

pref("alerts.slideIncrement", 1);
pref("alerts.slideIncrementTime", 10);
pref("alerts.totalOpenTime", 4000);
pref("alerts.height", 50);