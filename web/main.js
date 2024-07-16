// main.js
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.6.7/firebase-app.js";
import { getFirestore, collection, query, where, getDocs, limit } from "https://www.gstatic.com/firebasejs/9.6.7/firebase-firestore.js";


// Tải tệp JSON từ URL
fetch('connectfirebase.json')
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(firebaseConfig => {
        // Khởi tạo Firebase với cấu hình từ tệp JSON
        const firebaseApp = initializeApp(firebaseConfig);;
        const db = getFirestore(firebaseApp);
        var currentURL = window.location.href;
        // Reference to your Firestore collection
        const partnersCollection = collection(db, 'partners');
        const partnersQuery = query(partnersCollection, where("link_web", "array-contains", currentURL), limit(1));

        getDocs(partnersQuery).then((querySnapshot) => {
            let name;
            let icon;
            let favicon;
            let manifestURL;
            querySnapshot.forEach((doc) => {
                name = doc.data()?.name ?? undefined;
                icon = doc.data()?.iconapp ?? undefined;
                favicon = doc.data()?.favicon ?? undefined;
            });
            console.log(name, icon, favicon);
            if (name != undefined && icon != undefined) {
                document.getElementById("metaContent").setAttribute("content", name);
                var newManifest = {
                    "name": name,
                    "short_name": name,
                    "start_url": currentURL,
                    "display": "standalone",
                    "background_color": "#0175C2",
                    "theme_color": "#0175C2",
                    "description": "The cutting edge PMS for all.",
                    "orientation": "portrait-primary",
                    "prefer_related_applications": false,
                    "icons": [
                        {
                            "src": icon,
                            "sizes": "192x192",
                            "type": "image/png"
                        }
                    ]
                };

                // Chuyển đổi đối tượng manifest thành JSON
                var manifestContent = JSON.stringify(newManifest);

                // Tạo một blob từ nội dung manifest JSON
                var blob = new Blob([manifestContent], { type: 'application/json' });
                manifestURL = URL.createObjectURL(blob);
                console.log("done All IN");
            }

            var faviconLink = document.createElement('link');
            faviconLink.rel = "shortcut icon"
            faviconLink.type = "image/png";
            faviconLink.href = favicon ?? "favicon.png";
            document.head.appendChild(faviconLink);


            var iconLink = document.createElement('link');
            iconLink.rel = "apple-touch-icon";
            iconLink.href = icon ?? "icons/Icon-192.png";
            document.head.appendChild(iconLink);

            var titleNew = document.createElement('title');
            titleNew.textContent = name ?? 'OnePMS';
            document.head.appendChild(titleNew);

            var newLink = document.createElement('link');
            newLink.rel = 'manifest';
            newLink.href = manifestURL ?? 'manifest.json';
            document.head.appendChild(newLink);
            console.log("done ALL OUT");
        }).catch((error) => {
            console.error("Error fetching data: ", error);
            document.getElementById('data-container').innerText = `Error fetching data: ${error.message}`;
        });

    })
    .catch(error => console.error('Error fetching Firebase config:', error));


