importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyDX1N02gRDf5Yy8JrofzvS9QsAhq3_KhDM",
    authDomain: "techtimeapp-bd92e.firebaseapp.com",
    projectId: "techtimeapp-bd92e",
    storageBucket: "techtimeapp-bd92e.appspot.com",
    messagingSenderId: "130178803668",
    appId: "1:130178803668:web:a1e2b34ca8755c951d1841",
    measurementId: "G-524FD4FQBL"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});