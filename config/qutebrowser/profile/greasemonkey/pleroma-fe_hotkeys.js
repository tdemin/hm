// ==UserScript==
// @name         Pleroma-FE Hotkeys
// @namespace    https://tdem.in/
// @version      0.0.2
// @description  Adds hotkeys to Pleroma main frontend
// @author       Timur Demin <me@tdem.in>
// @match        https://udongein.xyz/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    const log = (data) => console.log(`hotkeys: ${data}`);
    let timeline;
    let notifications;
    let postForm;
    let runScript = () => {
        document.addEventListener("keydown", (event) => {
            if (!["textarea", "text"].includes(document.activeElement.type)) {
                switch (event.key) {
                    case "n":
                        event.preventDefault();
                        postForm.focus();
                        break;
                    case "r": {
                        event.preventDefault();
                        const readButton = document.querySelector(".read-button");
                        if (readButton) {
                            readButton.focus();
                        }
                        break;
                    }
                    case "1":
                        timeline.focus();
                        break;
                    case "2":
                        notifications.focus();
                        break;
                }
            }
        });
    };
    // check whether Pleroma's frontend has created the DOM elements
    // we attach to every 100 ms
    const interval = setInterval(() => {
        timeline = document.querySelector(".main");
        notifications = document.querySelector(".sidebar-scroller");
        postForm = document.querySelector(".form-post-body");
        for (let i of [timeline, notifications, postForm]) {
            if (!i) {
                log("still loading...");
                return;
            }
        }
        log("all elements found, attaching listeners...");
        clearInterval(interval);
        runScript();
        log("hotkeys loaded!");
    }, 100);
})();
